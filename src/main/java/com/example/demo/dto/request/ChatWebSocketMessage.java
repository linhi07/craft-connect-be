package com.example.demo.dto.request;

import com.example.demo.enums.MessageType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * WebSocket message request for sending chat messages in real-time.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatWebSocketMessage {

    private UUID roomId;
    private String content;

    @Builder.Default
    private MessageType messageType = MessageType.TEXT;

    // File metadata
    private String fileUrl;
    private String fileName;
    private Long fileSize;
    private String fileType;
    private String thumbnailUrl;
}
