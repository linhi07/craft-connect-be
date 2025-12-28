package com.example.demo.dto.response;

import com.example.demo.enums.ConnectionStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Response DTO for a connection.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ConnectionResponse {

    private UUID connectionId;
    private UUID chatRoomId;

    // Requester info
    private Integer requesterUserId;
    private String requesterName;
    private String requesterType; // DESIGNER or VILLAGE

    // Receiver info
    private Integer receiverUserId;
    private String receiverName;
    private String receiverType;

    // Other party (for list display)
    private String otherPartyName;
    private String otherPartyType;

    private ConnectionStatus status;
    private String message;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /**
     * Whether current user is the requester.
     */
    private boolean isRequester;
}
