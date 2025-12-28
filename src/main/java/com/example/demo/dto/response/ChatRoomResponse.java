package com.example.demo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Response DTO for a chat room (conversation).
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatRoomResponse {

    private UUID roomId;

    // Designer info
    private Integer designerId;
    private String designerName;

    // Village info
    private Integer villageId;
    private String villageName;

    // Other participant (the one current user is chatting with)
    private String otherParticipantName;
    private String otherParticipantType; // "DESIGNER" or "VILLAGE"

    // Last message preview
    private String lastMessageContent;
    private String lastMessageType;
    private LocalDateTime lastMessageAt;
    private String lastMessageSenderName;

    // Unread count for current user
    private long unreadCount;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
