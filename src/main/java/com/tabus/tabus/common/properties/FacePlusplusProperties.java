package com.tabus.tabus.common.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "tabus.faceplusplus")
public class FacePlusplusProperties {
    private String apiKey;
    private String api_secret;
    private String apiUrl;
}
