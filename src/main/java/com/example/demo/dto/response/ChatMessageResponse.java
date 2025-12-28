package com.example.demo.dto.response;

import com.example.demo.enums.MessageType;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Response DTO for a chat message.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatMessageResponse {

    private UUID messageId;
    private UUID roomId;

    // Sender info - using senderId to match frontend
    @JsonProperty("senderId")
    private Integer senderUserId;
    private String senderName;
    private String senderType; // "DESIGNER" or "VILLAGE"

    private String content;
    private MessageType messageType;
    private LocalDateTime createdAt;

    /**
     * Whether the current user is the sender.
     */
    @JsonProperty("isOwnMessage")
    private boolean isOwnMessage;

    // File metadata
    private String fileUrl;
    private String fileName;
    private Long fileSize;
    private String fileType;
    private String thumbnailUrl;
}
