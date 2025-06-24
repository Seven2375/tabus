package com.tabus.tabus.utils;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 腾讯混元AI客户端（严格遵循API文档规范）
 */
@Component
public class HunyuanAIClient {
    private static final Logger log = LoggerFactory.getLogger(HunyuanAIClient.class);
    private static final String API_URL = "https://open.hunyuan.tencent.com/openapi/v1/agent/chat/completions";
    
    @Value("${tabus.ai.hunyuan.api-key}")
    private String apiKey;
    
    @Value("${tabus.ai.hunyuan.assistant-id}")
    private String assistantId;
    
    private final HttpClientUtil httpClientUtil;

    public HunyuanAIClient(HttpClientUtil httpClientUtil) {
        this.httpClientUtil = httpClientUtil;
    }

    /**
     * 发送文本消息并获取响应（非流式）
     */
    public String chat(String userId, List<Message> messages) throws IOException {
        return chat(userId, messages, false, null, null);
    }

    /**
     * 发送消息并获取响应
     */
    public String chat(String userId, List<Message> messages, boolean stream, Integer version, String chatType) throws IOException {
        // 验证消息格式（role必须交替出现）
        validateMessages(messages);
        
        // 构建请求体
        JSONObject requestBody = new JSONObject();
        requestBody.put("assistant_id", assistantId);
        requestBody.put("user_id", userId);
        requestBody.put("stream", stream);
        
        if (version != null) {
            requestBody.put("version", version);
        }
        
        if (chatType != null) {
            requestBody.put("chat_type", chatType);
        }
        
        JSONArray messagesArray = new JSONArray();
        for (Message message : messages) {
            messagesArray.add(message.toJson());
        }
        requestBody.put("messages", messagesArray);
        
        // 打印请求日志
        log.info("请求腾讯混元AI:\n{}", requestBody.toJSONString());
        
        // 构建请求头
        Map<String, String> headers = new HashMap<>();
        headers.put("Authorization", "Bearer " + apiKey);
        headers.put("Content-Type", "application/json");
        
        try {
            // 发送带请求头的POST请求
            String response = httpClientUtil.postJsonWithHeaders(API_URL, requestBody.toJSONString(), headers);
            
            // 打印响应日志
            log.info("腾讯混元AI响应:\n{}", response);
            return response;
        } catch (IOException e) {
            handleIOException(e, requestBody);
            throw e;
        }
    }

    /**
     * 以流式方式发送消息并处理响应
     */
    public void chatStream(String userId, List<Message> messages, StreamResponseListener listener) throws IOException {
        chatStream(userId, messages, null, null, listener);
    }

    /**
     * 以流式方式发送消息并处理响应
     */
    public void chatStream(String userId, List<Message> messages, Integer version, String chatType, StreamResponseListener listener) throws IOException {
        // 验证消息格式
        validateMessages(messages);
        
        // 构建请求体
        JSONObject requestBody = new JSONObject();
        requestBody.put("assistant_id", assistantId);
        requestBody.put("user_id", userId);
        requestBody.put("stream", true);
        
        if (version != null) {
            requestBody.put("version", version);
        }
        
        if (chatType != null) {
            requestBody.put("chat_type", chatType);
        }
        
        JSONArray messagesArray = new JSONArray();
        for (Message message : messages) {
            messagesArray.add(message.toJson());
        }
        requestBody.put("messages", messagesArray);
        
        // 构建请求头
        Map<String, String> headers = new HashMap<>();
        headers.put("Authorization", "Bearer " + apiKey);
        headers.put("Content-Type", "application/json");
        
        // 发送流式请求
        httpClientUtil.postJsonStream(API_URL, requestBody.toJSONString(), headers, new HttpClientUtil.StreamResponseListener() {
            @Override
            public void onData(String data) {
                if (listener != null) {
                    listener.onData(data);
                }
            }

            @Override
            public void onError(IOException e) {
                if (listener != null) {
                    listener.onError(e);
                }
            }

            @Override
            public void onComplete() {
                if (listener != null) {
                    listener.onComplete();
                }
            }
        });
    }

    /**
     * 验证消息格式（role必须交替出现）
     */
    private void validateMessages(List<Message> messages) {
        if (messages == null || messages.isEmpty()) {
            throw new IllegalArgumentException("messages不能为空");
        }
        
        for (int i = 0; i < messages.size(); i++) {
            Message message = messages.get(i);
            if (i % 2 == 0 && !"user".equals(message.getRole())) {
                throw new IllegalArgumentException("奇数位置的message角色必须为user");
            }
            if (i % 2 == 1 && !"assistant".equals(message.getRole())) {
                throw new IllegalArgumentException("偶数位置的message角色必须为assistant");
            }
        }
    }

    /**
     * 处理IOException，打印详细错误信息
     */
    private void handleIOException(IOException e, JSONObject requestBody) {
        if (e.getMessage().contains("Unexpected code 400")) {
            log.error("腾讯混元AI返回400错误，请检查请求格式和参数");
            log.error("请求体:\n{}", requestBody.toJSONString());
        }
        log.error("调用腾讯混元AI接口异常", e);
    }

    /**
     * 消息类（严格遵循API文档格式）
     */
    public static class Message {
        private final String role;
        private final List<Content> content;

        public Message(String role, List<Content> content) {
            this.role = role;
            this.content = content;
        }

        public JSONObject toJson() {
            JSONObject json = new JSONObject();
            json.put("role", role);
            
            JSONArray contentArray = new JSONArray();
            for (Content item : content) {
                contentArray.add(item.toJson());
            }
            json.put("content", contentArray);
            
            return json;
        }

        public static Message userTextMessage(String text) {
            List<Content> content = new ArrayList<>();
            content.add(Content.textContent(text));
            return new Message("user", content);
        }
        
        public static Message assistantTextMessage(String text) {
            List<Content> content = new ArrayList<>();
            content.add(Content.textContent(text));
            return new Message("assistant", content);
        }
        
        /**
         * 创建系统消息（注意：API文档未明确说明system角色是否支持，使用前请确认）
         */
        public static Message systemMessage(String text) {
            List<Content> content = new ArrayList<>();
            content.add(Content.textContent(text));
            return new Message("system", content);
        }

        // Getters for validation
        public String getRole() {
            return role;
        }
    }

    /**
     * 消息内容类
     */
    public static class Content {
        private final String type;
        private final String text;
        private final FileUrl fileUrl;

        private Content(String type, String text, FileUrl fileUrl) {
            this.type = type;
            this.text = text;
            this.fileUrl = fileUrl;
        }

        public JSONObject toJson() {
            JSONObject json = new JSONObject();
            if (type != null) {
                json.put("type", type);
            }
            
            if (text != null) {
                json.put("text", text);
            }
            
            if (fileUrl != null) {
                json.put("file_url", fileUrl.toJson());
            }
            
            return json;
        }

        public static Content textContent(String text) {
            return new Content("text", text, null);
        }
        
        public static Content fileUrlContent(String fileType, String url) {
            return new Content("file_url", null, new FileUrl(fileType, url));
        }
    }

    /**
     * 文件URL类
     */
    public static class FileUrl {
        private final String type;
        private final String url;

        public FileUrl(String type, String url) {
            this.type = type;
            this.url = url;
        }

        public JSONObject toJson() {
            JSONObject json = new JSONObject();
            json.put("type", type);
            json.put("url", url);
            return json;
        }
    }

    /**
     * 流式响应监听器接口
     */
    public interface StreamResponseListener {
        void onData(String data);
        void onError(Exception e);
        void onComplete();
    }
}