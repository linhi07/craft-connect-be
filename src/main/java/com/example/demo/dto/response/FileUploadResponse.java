package com.example.demo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Response DTO after file upload.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FileUploadResponse {
    
    private String fileUrl;
    private String fileName;
    private Long fileSize;
    private String fileType;
    private String thumbnailUrl; // Only for images
}
