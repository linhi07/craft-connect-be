package com.example.demo.controller;

import com.example.demo.dto.request.SendConnectionRequest;
import com.example.demo.dto.response.ConnectionEligibilityResponse;
import com.example.demo.dto.response.ConnectionResponse;
import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.ConnectionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST API Controller for connection functionality.
 */
@RestController
@RequestMapping("/api/connections")
@RequiredArgsConstructor
public class ConnectionController {

    private final ConnectionService connectionService;
    private final UserRepository userRepository;

    /**
     * Send a connection request.
     * 
     * POST /api/connections
     * Body: { "roomId": "uuid", "message": "optional message" }
     */
    @PostMapping
    public ResponseEntity<ConnectionResponse> sendConnectionRequest(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestBody SendConnectionRequest request) {

        Integer userId = getCurrentUserId(userDetails);
        ConnectionResponse response = connectionService.sendConnectionRequest(userId, request);
        return ResponseEntity.ok(response);
    }

    /**
     * Check if user is eligible to send a connection request in a chat room.
     * 
     * GET /api/connections/eligibility/{roomId}
     */
    @GetMapping("/eligibility/{roomId}")
    public ResponseEntity<ConnectionEligibilityResponse> checkEligibility(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID roomId) {

        Integer userId = getCurrentUserId(userDetails);
        ConnectionEligibilityResponse response = connectionService.checkEligibility(userId, roomId);
        return ResponseEntity.ok(response);
    }

    /**
     * Get all accepted connections for current user.
     * 
     * GET /api/connections
     */
    @GetMapping
    public ResponseEntity<List<ConnectionResponse>> getConnections(
            @AuthenticationPrincipal UserDetails userDetails) {

        Integer userId = getCurrentUserId(userDetails);
        List<ConnectionResponse> connections = connectionService.getConnections(userId);
        return ResponseEntity.ok(connections);
    }

    /**
     * Get pending connection requests received by current user.
     * 
     * GET /api/connections/pending/received
     */
    @GetMapping("/pending/received")
    public ResponseEntity<List<ConnectionResponse>> getPendingReceived(
            @AuthenticationPrincipal UserDetails userDetails) {

        Integer userId = getCurrentUserId(userDetails);
        List<ConnectionResponse> connections = connectionService.getPendingReceived(userId);
        return ResponseEntity.ok(connections);
    }

    /**
     * Get pending connection requests sent by current user.
     * 
     * GET /api/connections/pending/sent
     */
    @GetMapping("/pending/sent")
    public ResponseEntity<List<ConnectionResponse>> getPendingSent(
            @AuthenticationPrincipal UserDetails userDetails) {

        Integer userId = getCurrentUserId(userDetails);
        List<ConnectionResponse> connections = connectionService.getPendingSent(userId);
        return ResponseEntity.ok(connections);
    }

    /**
     * Accept a connection request.
     * 
     * PUT /api/connections/{connectionId}/accept
     */
    @PutMapping("/{connectionId}/accept")
    public ResponseEntity<ConnectionResponse> acceptConnection(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID connectionId) {

        Integer userId = getCurrentUserId(userDetails);
        ConnectionResponse response = connectionService.acceptConnection(userId, connectionId);
        return ResponseEntity.ok(response);
    }

    /**
     * Reject a connection request.
     * 
     * PUT /api/connections/{connectionId}/reject
     */
    @PutMapping("/{connectionId}/reject")
    public ResponseEntity<ConnectionResponse> rejectConnection(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID connectionId) {

        Integer userId = getCurrentUserId(userDetails);
        ConnectionResponse response = connectionService.rejectConnection(userId, connectionId);
        return ResponseEntity.ok(response);
    }

    // ============ Helper methods ============

    private Integer getCurrentUserId(UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));
        return user.getUserId();
    }
}
