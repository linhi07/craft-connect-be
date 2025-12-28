package com.example.demo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Response for connection eligibility check.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ConnectionEligibilityResponse {

    private boolean eligible;
    private String reason;

    // Message counts for each party
    private long requesterMessageCount;
    private long receiverMessageCount;

    // Threshold required
    private int requiredMessageCount;

    // If already connected/pending
    private boolean alreadyConnected;
    private boolean pendingRequest;
}
