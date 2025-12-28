package com.example.demo.controller;

import com.example.demo.dto.request.SendMessageRequest;
import com.example.demo.dto.request.StartChatRequest;
import com.example.demo.dto.response.ChatListResponse;
import com.example.demo.dto.response.ChatMessageResponse;
import com.example.demo.dto.response.ChatRoomResponse;
import com.example.demo.dto.response.FileUploadResponse;
import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.ChatService;
import com.example.demo.service.FileStorageService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

/**
 * REST API Controller for Designer-Village chat functionality.
 */
@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {

    private final ChatService chatService;
    private final UserRepository userRepository;
    private final FileStorageService fileStorageService;

    /**
     * Start a new chat or get existing chat room.
     * 
     * POST /api/chat/rooms
     * Body: { "villageId": 1 } (for designer) or { "designerId": 1 } (for village)
     */
    @PostMapping("/rooms")
    public ResponseEntity<ChatRoomResponse> startOrGetChat(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestBody StartChatRequest request) {

        Integer userId = getCurrentUserId(userDetails);
        ChatRoomResponse response = chatService.startOrGetChat(userId, request);
        return ResponseEntity.ok(response);
    }

    /**
     * List all chat rooms for the current user.
     * 
     * GET /api/chat/rooms?page=0&size=10
     */
    @GetMapping("/rooms")
    public ResponseEntity<ChatListResponse> getUserChats(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        Integer userId = getCurrentUserId(userDetails);
        ChatListResponse response = chatService.getUserChats(userId, page, size);
        return ResponseEntity.ok(response);
    }

    /**
     * Get a specific chat room by ID.
     * 
     * GET /api/chat/rooms/{roomId}
     */
    @GetMapping("/rooms/{roomId}")
    public ResponseEntity<ChatRoomResponse> getChatRoom(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID roomId) {

        Integer userId = getCurrentUserId(userDetails);
        ChatRoomResponse response = chatService.getChatRoom(userId, roomId);
        return ResponseEntity.ok(response);
    }

    /**
     * Get paginated messages for a chat room.
     * 
     * GET /api/chat/rooms/{roomId}/messages?page=0&size=50
     */
    @GetMapping("/rooms/{roomId}/messages")
    public ResponseEntity<Page<ChatMessageResponse>> getMessages(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID roomId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "50") int size) {

        Integer userId = getCurrentUserId(userDetails);
        Page<ChatMessageResponse> messages = chatService.getMessages(userId, roomId, page, size);
        return ResponseEntity.ok(messages);
    }

    /**
     * Send a new message in a chat room.
     * 
     * POST /api/chat/rooms/{roomId}/messages
     * Body: { "content": "Hello!", "messageType": "TEXT" }
     */
    @PostMapping("/rooms/{roomId}/messages")
    public ResponseEntity<ChatMessageResponse> sendMessage(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID roomId,
            @Valid @RequestBody SendMessageRequest request) {

        Integer userId = getCurrentUserId(userDetails);
        ChatMessageResponse response = chatService.sendMessage(userId, roomId, request);
        return ResponseEntity.ok(response);
    }

    /**
     * Mark all messages in a room as read.
     * 
     * PUT /api/chat/rooms/{roomId}/read
     */
    @PutMapping("/rooms/{roomId}/read")
    public ResponseEntity<Void> markAsRead(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID roomId) {

        Integer userId = getCurrentUserId(userDetails);
        chatService.markAsRead(userId, roomId);
        return ResponseEntity.ok().build();
    }

    /**
     * Upload a file for chat messages.
     * 
     * POST /api/chat/upload
     * Content-Type: multipart/form-data
     * Body: file (binary)
     */
    @PostMapping("/upload")
    public ResponseEntity<FileUploadResponse> uploadFile(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam("file") MultipartFile file) {

        try {
            FileUploadResponse response = fileStorageService.uploadFile(file);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().build();
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    // ============ Helper methods ============

    private Integer getCurrentUserId(UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));
        return user.getUserId();
    }
}
