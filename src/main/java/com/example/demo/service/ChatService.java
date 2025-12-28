package com.example.demo.service;

import com.example.demo.dto.request.SendMessageRequest;
import com.example.demo.dto.request.StartChatRequest;
import com.example.demo.dto.response.ChatListResponse;
import com.example.demo.dto.response.ChatMessageResponse;
import com.example.demo.dto.response.ChatRoomResponse;
import com.example.demo.entity.*;
import com.example.demo.enums.MessageType;
import com.example.demo.enums.UserType;
import com.example.demo.repository.*;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class ChatService {

    private final ChatRoomRepository chatRoomRepository;
    private final ChatMessageRepository chatMessageRepository;
    private final ChatReadReceiptRepository chatReadReceiptRepository;
    private final UserRepository userRepository;
    private final DesignerRepository designerRepository;
    private final CraftVillageRepository craftVillageRepository;

    /**
     * Start a new chat or get existing chat room between designer and village.
     */
    public ChatRoomResponse startOrGetChat(Integer currentUserId, StartChatRequest request) {
        User currentUser = userRepository.findById(currentUserId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        Designer designer;
        CraftVillage village;

        if (currentUser.getUserType() == UserType.DESIGNER) {
            // Designer initiating chat with village
            if (request.getVillageId() == null) {
                throw new IllegalArgumentException("Village ID is required for designer to start chat");
            }
            designer = designerRepository.findByUserUserId(currentUserId)
                    .orElseThrow(() -> new EntityNotFoundException("Designer profile not found"));
            village = craftVillageRepository.findById(request.getVillageId())
                    .orElseThrow(() -> new EntityNotFoundException("Village not found"));
        } else if (currentUser.getUserType() == UserType.VILLAGE) {
            // Village initiating chat with designer
            if (request.getDesignerId() == null) {
                throw new IllegalArgumentException("Designer ID is required for village to start chat");
            }
            village = craftVillageRepository.findByUserUserId(currentUserId)
                    .orElseThrow(() -> new EntityNotFoundException("Village profile not found"));
            designer = designerRepository.findById(request.getDesignerId())
                    .orElseThrow(() -> new EntityNotFoundException("Designer not found"));
        } else {
            throw new IllegalArgumentException("Only designers and villages can start chats");
        }

        // Find existing room or create new one
        ChatRoom room = chatRoomRepository
                .findByDesignerDesignerIdAndVillageVillageId(designer.getDesignerId(), village.getVillageId())
                .orElseGet(() -> {
                    ChatRoom newRoom = ChatRoom.builder()
                            .designer(designer)
                            .village(village)
                            .build();
                    return chatRoomRepository.save(newRoom);
                });

        return mapToRoomResponse(room, currentUserId);
    }

    /**
     * Send a message in a chat room.
     */
    public ChatMessageResponse sendMessage(Integer currentUserId, UUID roomId, SendMessageRequest request) {
        ChatRoom room = chatRoomRepository.findById(roomId)
                .orElseThrow(() -> new EntityNotFoundException("Chat room not found"));

        // Verify user is a participant
        if (!chatRoomRepository.isUserParticipant(roomId, currentUserId)) {
            throw new IllegalArgumentException("User is not a participant in this chat room");
        }

        User sender = userRepository.findById(currentUserId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        ChatMessage message = ChatMessage.builder()
                .room(room)
                .sender(sender)
                .content(request.getContent() != null ? request.getContent() : "")
                .messageType(request.getMessageType() != null ? request.getMessageType() : MessageType.TEXT)
                .fileUrl(request.getFileUrl())
                .fileName(request.getFileName())
                .fileSize(request.getFileSize())
                .fileType(request.getFileType())
                .thumbnailUrl(request.getThumbnailUrl())
                .build();

        message = chatMessageRepository.save(message);
        
        // Debug logging
        log.debug("Saved message - ID: {}, CreatedAt: {}", message.getMessageId(), message.getCreatedAt());

        // Update room's updated_at timestamp
        room.setUpdatedAt(LocalDateTime.now());
        chatRoomRepository.save(room);

        ChatMessageResponse response = mapToMessageResponse(message, currentUserId);
        log.debug("Mapped response - CreatedAt: {}", response.getCreatedAt());
        
        return response;
    }

    /**
     * Get paginated messages for a chat room.
     */
    @Transactional(readOnly = true)
    public Page<ChatMessageResponse> getMessages(Integer currentUserId, UUID roomId, int page, int size) {
        // Verify user is a participant
        if (!chatRoomRepository.isUserParticipant(roomId, currentUserId)) {
            throw new IllegalArgumentException("User is not a participant in this chat room");
        }

        Pageable pageable = PageRequest.of(page, size);
        Page<ChatMessage> messages = chatMessageRepository.findByRoomRoomIdOrderByCreatedAtDesc(roomId, pageable);

        return messages.map(msg -> mapToMessageResponse(msg, currentUserId));
    }

    /**
     * Mark messages as read in a chat room.
     */
    public void markAsRead(Integer currentUserId, UUID roomId) {
        // Verify user is a participant
        if (!chatRoomRepository.isUserParticipant(roomId, currentUserId)) {
            throw new IllegalArgumentException("User is not a participant in this chat room");
        }

        ChatReadReceiptId receiptId = ChatReadReceiptId.builder()
                .roomId(roomId)
                .userId(currentUserId)
                .build();

        // Try to find existing receipt first
        Optional<ChatReadReceipt> existingReceipt = chatReadReceiptRepository.findById(receiptId);

        ChatReadReceipt receipt;
        if (existingReceipt.isPresent()) {
            // Update existing receipt
            receipt = existingReceipt.get();
        } else {
            // Create new receipt
            ChatRoom room = chatRoomRepository.findById(roomId)
                    .orElseThrow(() -> new EntityNotFoundException("Chat room not found"));
            User user = userRepository.findById(currentUserId)
                    .orElseThrow(() -> new EntityNotFoundException("User not found"));

            receipt = ChatReadReceipt.builder()
                    .id(receiptId)
                    .room(room)
                    .user(user)
                    .build();
        }

        receipt.setLastReadAt(LocalDateTime.now());
        chatReadReceiptRepository.save(receipt);
    }

    /**
     * Get all chat rooms for a user.
     */
    @Transactional(readOnly = true)
    public ChatListResponse getUserChats(Integer currentUserId, int page, int size) {
        List<ChatRoom> allRooms = chatRoomRepository.findAllByUserId(currentUserId);

        // Manual pagination
        int start = page * size;
        int end = Math.min(start + size, allRooms.size());

        List<ChatRoomResponse> roomResponses;
        if (start >= allRooms.size()) {
            roomResponses = List.of();
        } else {
            roomResponses = allRooms.subList(start, end).stream()
                    .map(room -> mapToRoomResponse(room, currentUserId))
                    .collect(Collectors.toList());
        }

        int totalPages = (int) Math.ceil((double) allRooms.size() / size);

        return ChatListResponse.builder()
                .rooms(roomResponses)
                .currentPage(page)
                .totalPages(totalPages)
                .totalElements(allRooms.size())
                .size(size)
                .build();
    }

    /**
     * Get a single chat room by ID.
     */
    @Transactional(readOnly = true)
    public ChatRoomResponse getChatRoom(Integer currentUserId, UUID roomId) {
        // Verify user is a participant
        if (!chatRoomRepository.isUserParticipant(roomId, currentUserId)) {
            throw new IllegalArgumentException("User is not a participant in this chat room");
        }

        ChatRoom room = chatRoomRepository.findById(roomId)
                .orElseThrow(() -> new EntityNotFoundException("Chat room not found"));

        return mapToRoomResponse(room, currentUserId);
    }

    // ============ Private helper methods ============

    private ChatRoomResponse mapToRoomResponse(ChatRoom room, Integer currentUserId) {
        Designer designer = room.getDesigner();
        CraftVillage village = room.getVillage();

        // Determine the other participant
        boolean isDesigner = designer.getUser().getUserId().equals(currentUserId);
        String otherName = isDesigner ? village.getVillageName() : designer.getDesignerName();
        String otherType = isDesigner ? "VILLAGE" : "DESIGNER";

        // Get last message
        Optional<ChatMessage> lastMessage = chatMessageRepository
                .findFirstByRoomRoomIdOrderByCreatedAtDesc(room.getRoomId());

        // Calculate unread count
        long unreadCount = getUnreadCount(room.getRoomId(), currentUserId);

        return ChatRoomResponse.builder()
                .roomId(room.getRoomId())
                .designerId(designer.getDesignerId())
                .designerName(designer.getDesignerName())
                .villageId(village.getVillageId())
                .villageName(village.getVillageName())
                .otherParticipantName(otherName)
                .otherParticipantType(otherType)
                .lastMessageContent(lastMessage.map(ChatMessage::getContent).orElse(null))
                .lastMessageType(lastMessage.map(m -> m.getMessageType().name()).orElse(null))
                .lastMessageAt(lastMessage.map(ChatMessage::getCreatedAt).orElse(null))
                .lastMessageSenderName(lastMessage.map(m -> getSenderName(m.getSender())).orElse(null))
                .unreadCount(unreadCount)
                .createdAt(room.getCreatedAt())
                .updatedAt(room.getUpdatedAt())
                .build();
    }

    private ChatMessageResponse mapToMessageResponse(ChatMessage message, Integer currentUserId) {
        User sender = message.getSender();
        LocalDateTime createdAt = message.getCreatedAt();
        
        // Fallback if createdAt is null (shouldn't happen but just in case)
        if (createdAt == null) {
            log.warn("Message {} has null createdAt, using current time", message.getMessageId());
            createdAt = LocalDateTime.now();
        }
        
        return ChatMessageResponse.builder()
                .messageId(message.getMessageId())
                .roomId(message.getRoom().getRoomId())
                .senderUserId(sender.getUserId())
                .senderName(getSenderName(sender))
                .senderType(sender.getUserType().name())
                .content(message.getContent())
                .messageType(message.getMessageType())
                .createdAt(createdAt)
                .isOwnMessage(sender.getUserId().equals(currentUserId))
                .fileUrl(message.getFileUrl())
                .fileName(message.getFileName())
                .fileSize(message.getFileSize())
                .fileType(message.getFileType())
                .thumbnailUrl(message.getThumbnailUrl())
                .build();
    }

    private String getSenderName(User user) {
        if (user.getUserType() == UserType.DESIGNER) {
            return designerRepository.findByUserUserId(user.getUserId())
                    .map(Designer::getDesignerName)
                    .orElse("Unknown Designer");
        } else if (user.getUserType() == UserType.VILLAGE) {
            return craftVillageRepository.findByUserUserId(user.getUserId())
                    .map(CraftVillage::getVillageName)
                    .orElse("Unknown Village");
        }
        return user.getEmail();
    }

    private long getUnreadCount(UUID roomId, Integer userId) {
        Optional<ChatReadReceipt> receipt = chatReadReceiptRepository
                .findByIdRoomIdAndIdUserId(roomId, userId);

        if (receipt.isPresent()) {
            return chatMessageRepository.countByRoomRoomIdAndCreatedAtAfter(
                    roomId, receipt.get().getLastReadAt());
        } else {
            // User has never read - all messages are unread
            return chatMessageRepository.countByRoomRoomId(roomId);
        }
    }
}
