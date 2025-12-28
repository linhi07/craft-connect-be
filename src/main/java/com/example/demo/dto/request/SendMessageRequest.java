package com.example.demo.dto.request;

import com.example.demo.enums.MessageType;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Request to send a new message in a chat room.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SendMessageRequest {

    private String content;

    /**
     * Type of message. Defaults to TEXT if not provided.
     */
    @Builder.Default
    private MessageType messageType = MessageType.TEXT;

    // File metadata (populated after upload)
    private String fileUrl;
    private String fileName;
    private Long fileSize;
    private String fileType;
    private String thumbnailUrl;
}
