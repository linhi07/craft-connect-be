package com.example.demo.controller;

import com.example.demo.dto.request.ChatWebSocketMessage;
import com.example.demo.dto.request.SendMessageRequest;
import com.example.demo.dto.response.ChatMessageResponse;
import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.ChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.security.Principal;

/**
 * WebSocket controller for real-time chat messaging.
 * 
 * Clients connect to: /ws/chat
 * Clients subscribe to: /topic/room/{roomId}
 * Clients send to: /app/chat.send
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class ChatWebSocketController {

    private final ChatService chatService;
    private final UserRepository userRepository;
    private final SimpMessagingTemplate messagingTemplate;

    /**
     * Handle incoming chat messages from WebSocket clients.
     * 
     * Client sends to: /app/chat.send
     * Message is broadcast to: /topic/room/{roomId}
     */
    @MessageMapping("/chat.send")
    public void sendMessage(@Payload ChatWebSocketMessage message, Principal principal) {
        if (principal == null) {
            log.warn("Received message from unauthenticated user");
            return;
        }

        try {
            // Get user from principal
            User user = userRepository.findByEmail(principal.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));

            // Create and save message via service
            SendMessageRequest request = SendMessageRequest.builder()
                    .content(message.getContent())
                    .messageType(message.getMessageType())
                    .fileUrl(message.getFileUrl())
                    .fileName(message.getFileName())
                    .fileSize(message.getFileSize())
                    .fileType(message.getFileType())
                    .thumbnailUrl(message.getThumbnailUrl())
                    .build();

            ChatMessageResponse response = chatService.sendMessage(
                    user.getUserId(),
                    message.getRoomId(),
                    request);

            // Broadcast to all subscribers of this room
            String destination = "/topic/room/" + message.getRoomId();
            messagingTemplate.convertAndSend(destination, response);

            log.debug("Message sent to room {}: {}", message.getRoomId(), message.getContent());

        } catch (Exception e) {
            log.error("Error processing WebSocket message", e);
        }
    }

    /**
     * Handle user typing indicator.
     * 
     * Client sends to: /app/chat.typing
     * Broadcast to: /topic/room/{roomId}/typing
     */
    @MessageMapping("/chat.typing")
    public void userTyping(@Payload TypingIndicator indicator, Principal principal) {
        if (principal == null)
            return;

        try {
            User user = userRepository.findByEmail(principal.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));

            indicator.setUserId(user.getUserId());
            indicator.setUserName(principal.getName());

            String destination = "/topic/room/" + indicator.getRoomId() + "/typing";
            messagingTemplate.convertAndSend(destination, indicator);

        } catch (Exception e) {
            log.error("Error processing typing indicator", e);
        }
    }

    /**
     * Typing indicator DTO.
     */
    @lombok.Data
    @lombok.NoArgsConstructor
    @lombok.AllArgsConstructor
    public static class TypingIndicator {
        private java.util.UUID roomId;
        private Integer userId;
        private String userName;
        private boolean typing;
    }
}
