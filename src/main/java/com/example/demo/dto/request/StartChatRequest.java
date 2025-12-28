package com.example.demo.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Request to start a new chat or get existing chat room.
 * Either villageId (for designer) or designerId (for village) should be
 * provided.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StartChatRequest {

    /**
     * Village ID to chat with (used when designer initiates chat).
     */
    private Integer villageId;

    /**
     * Designer ID to chat with (used when village initiates chat).
     */
    private Integer designerId;
}
