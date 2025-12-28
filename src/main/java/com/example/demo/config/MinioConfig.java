package com.example.demo.config;

import io.minio.MinioClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * MinIO client configuration.
 */
@Configuration
@RequiredArgsConstructor
@Slf4j
public class MinioConfig {

    private final FileUploadProperties fileUploadProperties;

    @Bean
    public MinioClient minioClient() {
        log.info("Initializing MinIO client with endpoint: {}", fileUploadProperties.getEndpoint());
        
        return MinioClient.builder()
                .endpoint(fileUploadProperties.getEndpoint())
                .credentials(fileUploadProperties.getAccessKey(), fileUploadProperties.getSecretKey())
                .build();
    }
}
