package com.tabus.tabus.controller;

import com.alibaba.fastjson.JSON;
import com.tabus.tabus.service.IEmotionRecordService;
import com.tabus.tabus.utils.HunyuanAIClient;
import jakarta.servlet.AsyncContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyEmitter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;

@RestController
@RequestMapping("/ai-api")
@RequiredArgsConstructor
public class AIController {

    // 线程池，记得在类中定义并初始化
    private final IEmotionRecordService service;
    private final HunyuanAIClient hunyuanAIClient;


    @GetMapping("/chat/stream/{courseId}")
    public void chatWithAIStream(
            @PathVariable Long courseId,
            HttpServletRequest request,
            @RequestParam(required = false,name = "message") String message) {
        System.out.println("message -> "+message);
        AsyncContext asyncContext = request.startAsync();
        asyncContext.setTimeout(0);

        asyncContext.start(() -> {
            HttpServletResponse resp = (HttpServletResponse) asyncContext.getResponse();
            resp.setContentType("text/event-stream");
            resp.setCharacterEncoding("UTF-8");
            resp.setHeader("Cache-Control", "no-cache");
            resp.setHeader("Connection", "keep-alive");
            List<HunyuanAIClient.Message> messages;
            if (message != null && !message.isEmpty()){
                System.out.println("用户发送问题！！！！");
                messages = Arrays.asList(
                        HunyuanAIClient.Message.userTextMessage(message)
                );
            } else {
                System.out.println("初始化智能体数据！！！！");
                Map<String, Object> analysisData = service.getAnalysisByCourseId(courseId);
                StringBuffer buffer = new StringBuffer("以下是课程ID为");
                buffer.append(courseId);
                buffer.append("的课程上课时采集到的情绪数据，");
                buffer.append("emotionStats是情绪统计，");
                buffer.append("dominantEmotion是主导情绪，");
                buffer.append("outliers是异常值，");
                buffer.append(JSON.toJSONString(analysisData));
                buffer.append("请你根据该参数分析当前课程的质量，并给出建议");

                messages = Arrays.asList(
                        HunyuanAIClient.Message.userTextMessage(buffer.toString())
                );
            }



            // 用CountDownLatch等待回调结束
            CountDownLatch latch = new CountDownLatch(1);

            try {
                hunyuanAIClient.chatStream("user_" + courseId, messages, new HunyuanAIClient.StreamResponseListener() {
                    @Override
                    public void onData(String data) {
                        try {
                            resp.getWriter().write("data: " + data + "\n\n");
                            resp.getWriter().flush();
                        } catch (IOException e) {
                            onError(e);
                        }
                    }

                    @Override
                    public void onError(Exception e) {
                        try {
                            resp.getWriter().write("event: error\n");
                            resp.getWriter().write("data: " + e.getMessage() + "\n\n");
                            resp.getWriter().flush();
                        } catch (IOException ignored) {
                        } finally {
                            latch.countDown();
                        }
                    }

                    @Override
                    public void onComplete() {
                        try {
                            resp.getWriter().write("event: complete\n");
                            resp.getWriter().write("data: [DONE]\n\n");
                            resp.getWriter().flush();
                        } catch (IOException ignored) {
                        } finally {
                            latch.countDown();
                        }
                    }
                });

                // 阻塞当前线程，直到 onComplete 或 onError 触发
                latch.await();

            } catch (Exception e) {
                try {
                    resp.getWriter().write("event: error\n");
                    resp.getWriter().write("data: " + e.getMessage() + "\n\n");
                    resp.getWriter().flush();
                } catch (IOException ignored) {
                }
            } finally {
                asyncContext.complete();
            }
        });
    }


//    @GetMapping(value = "/chat/stream/{courseId}/")
//    public void streamChat(HttpServletRequest request, @PathVariable String message, @PathVariable Long courseId) {
//        AsyncContext asyncContext = request.startAsync();
//        asyncContext.setTimeout(0);
//        asyncContext.start(() -> {
//            HttpServletResponse resp = (HttpServletResponse) asyncContext.getResponse();
//            resp.setContentType("text/event-stream");
//            resp.setCharacterEncoding("UTF-8");
//            resp.setHeader("Cache-Control", "no-cache");
//            resp.setHeader("Connection", "keep-alive");
//            List<HunyuanAIClient.Message> messages = Arrays.asList(
//                    HunyuanAIClient.Message.userTextMessage(message)
//            );
//
//            // 用CountDownLatch等待回调结束
//            CountDownLatch latch = new CountDownLatch(1);
//
//            try {
//                hunyuanAIClient.chatStream("user_" + courseId, messages, new HunyuanAIClient.StreamResponseListener() {
//                    @Override
//                    public void onData(String data) {
//                        try {
//                            resp.getWriter().write("data: " + data + "\n\n");
//                            resp.getWriter().flush();
//                        } catch (IOException e) {
//                            onError(e);
//                        }
//                    }
//
//                    @Override
//                    public void onError(Exception e) {
//                        try {
//                            resp.getWriter().write("event: error\n");
//                            resp.getWriter().write("data: " + e.getMessage() + "\n\n");
//                            resp.getWriter().flush();
//                        } catch (IOException ignored) {
//                        } finally {
//                            latch.countDown();
//                        }
//                    }
//
//                    @Override
//                    public void onComplete() {
//                        try {
//                            resp.getWriter().write("event: complete\n");
//                            resp.getWriter().write("data: [DONE]\n\n");
//                            resp.getWriter().flush();
//                        } catch (IOException ignored) {
//                        } finally {
//                            latch.countDown();
//                        }
//                    }
//                });
//
//                // 阻塞当前线程，直到 onComplete 或 onError 触发
//                latch.await();
//
//            } catch (Exception e) {
//                try {
//                    resp.getWriter().write("event: error\n");
//                    resp.getWriter().write("data: " + e.getMessage() + "\n\n");
//                    resp.getWriter().flush();
//                } catch (IOException ignored) {
//                }
//            } finally {
//                asyncContext.complete();
//            }
//        });
//    }


}
