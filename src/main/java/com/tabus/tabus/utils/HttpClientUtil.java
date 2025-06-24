package com.tabus.tabus.utils;

import okhttp3.*;
import okio.BufferedSource;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * HTTP请求工具类（完整版本，支持流式响应）
 */
public class HttpClientUtil {
    private static final MediaType JSON = MediaType.get("application/json; charset=utf-8");
    final OkHttpClient client;

    public HttpClientUtil() {
        this.client = new OkHttpClient.Builder()
                .connectTimeout(10, TimeUnit.SECONDS)
                .readTimeout(30, TimeUnit.SECONDS)
                .writeTimeout(30, TimeUnit.SECONDS)
                .build();
    }

    public HttpClientUtil(OkHttpClient client) {
        this.client = client;
    }

    public String get(String url) throws IOException {
        return get(url, new HashMap<>());
    }

    public String get(String url, Map<String, String> params) throws IOException {
        HttpUrl.Builder httpUrlBuilder = HttpUrl.parse(url).newBuilder();
        for (Map.Entry<String, String> param : params.entrySet()) {
            httpUrlBuilder.addQueryParameter(param.getKey(), param.getValue());
        }
        Request request = new Request.Builder()
                .url(httpUrlBuilder.build())
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);
            return response.body().string();
        }
    }

    public String postJson(String url, String json) throws IOException {
        return postJsonWithHeaders(url, json, new HashMap<>());
    }

    /**
     * 发送带请求头的POST请求（JSON格式）
     */
    public String postJsonWithHeaders(String url, String json, Map<String, String> headers) throws IOException {
        RequestBody body = RequestBody.create(json, JSON);
        Request.Builder requestBuilder = new Request.Builder()
                .url(url)
                .post(body);
                
        for (Map.Entry<String, String> header : headers.entrySet()) {
            requestBuilder.addHeader(header.getKey(), header.getValue());
        }
        
        Request request = requestBuilder.build();
        
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response + ", body: " + response.body().string());
            return response.body().string();
        }
    }

    public String postForm(String url, Map<String, String> params) throws IOException {
        FormBody.Builder formBuilder = new FormBody.Builder();
        for (Map.Entry<String, String> param : params.entrySet()) {
            formBuilder.add(param.getKey(), param.getValue());
        }
        RequestBody body = formBuilder.build();
        return sendRequest(url, body, "POST", new HashMap<>());
    }

    public String putJson(String url, String json) throws IOException {
        return putJsonWithHeaders(url, json, new HashMap<>());
    }

    public String putJsonWithHeaders(String url, String json, Map<String, String> headers) throws IOException {
        RequestBody body = RequestBody.create(json, JSON);
        return sendRequest(url, body, "PUT", headers);
    }

    public String delete(String url) throws IOException {
        Request request = new Request.Builder()
                .url(url)
                .delete()
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);
            return response.body().string();
        }
    }

    private String sendRequest(String url, RequestBody body, String method, Map<String, String> headers) throws IOException {
        Request.Builder requestBuilder = new Request.Builder()
                .url(url);

        switch (method.toUpperCase()) {
            case "POST":
                requestBuilder.post(body);
                break;
            case "PUT":
                requestBuilder.put(body);
                break;
            case "DELETE":
                requestBuilder.delete(body);
                break;
            default:
                throw new IllegalArgumentException("Unsupported HTTP method: " + method);
        }
        
        for (Map.Entry<String, String> header : headers.entrySet()) {
            requestBuilder.addHeader(header.getKey(), header.getValue());
        }

        Request request = requestBuilder.build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);
            return response.body().string();
        }
    }



    public void close() {
        if (client.dispatcher() != null) {
            client.dispatcher().executorService().shutdown();
        }
        if (client.connectionPool() != null) {
            client.connectionPool().evictAll();
        }
        if (client.cache() != null) {
            try {
                client.cache().close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    /**
     * 发送POST请求（JSON格式，支持流式响应）
     */
    public void postJsonStream(String url, String json, Map<String, String> headers, StreamResponseListener listener) throws IOException {
        MediaType JSON = MediaType.get("application/json; charset=utf-8");
        RequestBody body = RequestBody.create(json, JSON);

        Request.Builder requestBuilder = new Request.Builder()
                .url(url)
                .post(body);

        // 添加请求头
        for (Map.Entry<String, String> header : headers.entrySet()) {
            requestBuilder.addHeader(header.getKey(), header.getValue());
        }

        Request request = requestBuilder.build();
        Call call = client.newCall(request);

        call.enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                if (listener != null) {
                    listener.onError(e);
                }
            }

            @Override
            public void onResponse(Call call, Response response) {
                if (!response.isSuccessful()) {
                    if (listener != null) {
                        listener.onError(new IOException("Unexpected code " + response));
                    }
                    return;
                }

                try (ResponseBody responseBody = response.body()) {
                    if (responseBody == null) {
                        if (listener != null) {
                            listener.onComplete();
                        }
                        return;
                    }

                    BufferedSource source = responseBody.source();
                    String line;
                    while ((line = source.readUtf8Line()) != null) {
                        if (line.startsWith("data: ")) {
                            String data = line.substring(6);
                            if (!data.equals("[DONE]")) {
                                if (listener != null) {
                                    listener.onData(data);
                                }
                            }
                        }
                    }
                    if (listener != null) {
                        listener.onComplete();
                    }
                } catch (IOException e) {
                    if (listener != null) {
                        listener.onError(e);
                    }
                } catch (Exception e) {
                    // 处理非IO异常
                    if (listener != null) {
                        listener.onError(new IOException("Unexpected error: " + e.getMessage(), e));
                    }
                }
            }
        });
    }

    /**
     * 流式响应监听器接口
     */
    public interface StreamResponseListener {
        void onData(String data);
        void onError(IOException e);
        void onComplete();
    }
}