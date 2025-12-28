package com.example.demo.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * Configuration properties for MinIO file storage.
 */
@Configuration
@ConfigurationProperties(prefix = "minio")
@Data
public class FileUploadProperties {
    
    private String endpoint;
    private String accessKey;
    private String secretKey;
    private String bucketName;
    
    private FileSettings file = new FileSettings();
    
    @Data
    public static class FileSettings {
        private Long maxSize;
        private List<String> allowedTypes;
    }
}
