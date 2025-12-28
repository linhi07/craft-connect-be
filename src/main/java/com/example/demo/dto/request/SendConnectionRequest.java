package com.example.demo.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Request to send a connection request.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SendConnectionRequest {

    /**
     * The chat room ID where the conversation happened.
     */
    private UUID roomId;

    /**
     * Optional message to include with the connection request.
     */
    private String message;
}
