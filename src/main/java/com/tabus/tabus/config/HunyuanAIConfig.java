package com.tabus.tabus.config;

import com.tabus.tabus.utils.HttpClientUtil;
import com.tabus.tabus.utils.HunyuanAIClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import okhttp3.OkHttpClient;
import java.util.concurrent.TimeUnit;

@Configuration
public class HunyuanAIConfig {
    @Value("${tabus.ai.hunyuan.api-key}")
    private String apiKey;

    @Value("${tabus.ai.hunyuan.assistant-id}")
    private String assistantId;

    @Bean
    public OkHttpClient okHttpClient() {
        return new OkHttpClient.Builder()
                .connectTimeout(10, TimeUnit.SECONDS)
                .readTimeout(30, TimeUnit.SECONDS)
                .writeTimeout(30, TimeUnit.SECONDS)
                .build();
    }

    @Bean
    public HttpClientUtil httpClientUtil(OkHttpClient okHttpClient) {
        return new HttpClientUtil(okHttpClient);
    }

    @Bean
    public HunyuanAIClient hunyuanAIClient(HttpClientUtil httpClientUtil) {
        return new HunyuanAIClient(httpClientUtil);
    }
}