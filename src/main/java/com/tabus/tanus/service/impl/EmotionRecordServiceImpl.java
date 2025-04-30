package com.tabus.tanus.service.impl;

import cn.hutool.json.ObjectMapper;
import com.google.gson.Gson;
import com.tabus.tanus.pojo.dto.EmotionResponseDTO;
import com.tabus.tanus.pojo.entity.EmotionRecord;
import com.tabus.tanus.mapper.EmotionRecordMapper;
import com.tabus.tanus.pojo.vo.EmotionRecordVO;
import com.tabus.tanus.properties.FacePlusplusProperties;
import com.tabus.tanus.service.IEmotionRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author tabus
 * @since 2025-04-24
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class EmotionRecordServiceImpl extends ServiceImpl<EmotionRecordMapper, EmotionRecord> implements IEmotionRecordService {
    private final EmotionRecordMapper recordMapper;
    private final OkHttpClient httpClient = new OkHttpClient();
    private final Gson gson = new Gson();
    private final FacePlusplusProperties properties;

    @Override
    public List<EmotionRecordVO> recognize(@NotNull MultipartFile image) {
        try {

            RequestBody formBody = new MultipartBody.Builder()
                    .setType(MultipartBody.FORM)
                    .addFormDataPart("api_key", properties.getApiKey())
                    .addFormDataPart("api_secret", properties.getApi_secret())
                    //emotion:情绪识别结果。返回值包含以下字段。每个字段的值都是一个浮点数，
                    // 范围 [0,100]，小数点后 3 位有效数字。每个字段的返回值越大，
                    // 则该字段代表的状态的置信度越高。字段值的总和等于 100。
                    .addFormDataPart("return_attributes", "emotion")
                    .addFormDataPart(
                            "image_file",
                            image.getOriginalFilename(),
                            RequestBody.create(image.getBytes(), MediaType.parse("application/octet-stream"))
                    )
                    .build();

            Request request = new Request.Builder()
                    .url(properties.getApiUrl())
                    .post(formBody)
                    .build();

            Response response = httpClient.newCall(request).execute();
            if (!response.isSuccessful()) {
                throw new RuntimeException("旷世API调用失败: " + response.code());
            }
            String jsonResponse = response.body() != null ? response.body().string() : null;
            log.info("Emotion API response: {}", jsonResponse);

            EmotionResponseDTO respDto = gson.fromJson(jsonResponse, EmotionResponseDTO.class);

            // 持久化并转换为 VO
            return respDto.getFaces().stream().map(face -> {
                EmotionRecord entity = new EmotionRecord();
                entity.setRequestId(respDto.getRequest_id());
                entity.setImageId(respDto.getImage_id());
                entity.setFaceToken(face.getFace_token());
                entity.setAnger(face.getAttributes().getEmotion().getAnger());
                entity.setDisgust(face.getAttributes().getEmotion().getDisgust());
                entity.setFear(face.getAttributes().getEmotion().getFear());
                entity.setHappiness(face.getAttributes().getEmotion().getHappiness());
                entity.setNeutral(face.getAttributes().getEmotion().getNeutral());
                entity.setSadness(face.getAttributes().getEmotion().getSadness());
                entity.setSurprise(face.getAttributes().getEmotion().getSurprise());
                entity.setCreatedAt(LocalDateTime.now());
                recordMapper.insert(entity);

                return getEmotionRecordVO(entity);
            }).collect(Collectors.toList());

        } catch (IOException e) {
            log.error("Emotion recognition failed", e);
            throw new RuntimeException("情绪识别失败", e);
        }
    }

    private static @NotNull EmotionRecordVO getEmotionRecordVO(@NotNull EmotionRecord entity) {
        EmotionRecordVO vo = new EmotionRecordVO();
        vo.setId(entity.getId());
        vo.setAnger(entity.getAnger());
        vo.setDisgust(entity.getDisgust());
        vo.setFear(entity.getFear());
        vo.setHappiness(entity.getHappiness());
        vo.setNeutral(entity.getNeutral());
        vo.setSadness(entity.getSadness());
        vo.setSurprise(entity.getSurprise());
        vo.setTimestamp(entity.getCreatedAt());
        return vo;
    }
}
