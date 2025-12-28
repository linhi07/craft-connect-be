package com.example.demo.service;

import com.example.demo.dto.request.SendConnectionRequest;
import com.example.demo.dto.response.ConnectionEligibilityResponse;
import com.example.demo.dto.response.ConnectionResponse;
import com.example.demo.entity.*;
import com.example.demo.enums.ConnectionStatus;
import com.example.demo.enums.UserType;
import com.example.demo.repository.*;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class ConnectionService {

    private static final int REQUIRED_MESSAGE_COUNT = 3;

    private final ConnectionRepository connectionRepository;
    private final ChatRoomRepository chatRoomRepository;
    private final ChatMessageRepository chatMessageRepository;
    private final UserRepository userRepository;
    private final DesignerRepository designerRepository;
    private final CraftVillageRepository craftVillageRepository;

    /**
     * Check if user is eligible to send a connection request in a chat room.
     */
    @Transactional(readOnly = true)
    public ConnectionEligibilityResponse checkEligibility(Integer currentUserId, UUID roomId) {
        ChatRoom room = chatRoomRepository.findById(roomId)
                .orElseThrow(() -> new EntityNotFoundException("Chat room not found"));

        // Verify user is a participant
        if (!chatRoomRepository.isUserParticipant(roomId, currentUserId)) {
            throw new IllegalArgumentException("User is not a participant in this chat room");
        }

        Integer designerUserId = room.getDesigner().getUser().getUserId();
        Integer villageUserId = room.getVillage().getUser().getUserId();

        long designerMsgCount = chatMessageRepository.countByRoomRoomIdAndSenderUserId(roomId, designerUserId);
        long villageMsgCount = chatMessageRepository.countByRoomRoomIdAndSenderUserId(roomId, villageUserId);

        // Determine counts from current user's perspective
        boolean isDesigner = currentUserId.equals(designerUserId);
        long myMessageCount = isDesigner ? designerMsgCount : villageMsgCount;
        long theirMessageCount = isDesigner ? villageMsgCount : designerMsgCount;

        // Check if already connected
        Optional<Connection> existingConnection = connectionRepository.findByChatRoomRoomId(roomId);

        if (existingConnection.isPresent()) {
            Connection conn = existingConnection.get();
            if (conn.getStatus() == ConnectionStatus.ACCEPTED) {
                return ConnectionEligibilityResponse.builder()
                        .eligible(false)
                        .reason("Already connected")
                        .alreadyConnected(true)
                        .requesterMessageCount(myMessageCount)
                        .receiverMessageCount(theirMessageCount)
                        .requiredMessageCount(REQUIRED_MESSAGE_COUNT)
                        .build();
            }
            if (conn.getStatus() == ConnectionStatus.PENDING) {
                return ConnectionEligibilityResponse.builder()
                        .eligible(false)
                        .reason("Connection request already pending")
                        .pendingRequest(true)
                        .requesterMessageCount(myMessageCount)
                        .receiverMessageCount(theirMessageCount)
                        .requiredMessageCount(REQUIRED_MESSAGE_COUNT)
                        .build();
            }
        }

        boolean eligible = designerMsgCount >= REQUIRED_MESSAGE_COUNT && villageMsgCount >= REQUIRED_MESSAGE_COUNT;
        String reason = eligible ? "Eligible to connect"
                : String.format("Both parties need at least %d messages (Designer: %d, Village: %d)",
                        REQUIRED_MESSAGE_COUNT, designerMsgCount, villageMsgCount);

        return ConnectionEligibilityResponse.builder()
                .eligible(eligible)
                .reason(reason)
                .requesterMessageCount(myMessageCount)
                .receiverMessageCount(theirMessageCount)
                .requiredMessageCount(REQUIRED_MESSAGE_COUNT)
                .build();
    }

    /**
     * Send a connection request.
     */
    public ConnectionResponse sendConnectionRequest(Integer currentUserId, SendConnectionRequest request) {
        ConnectionEligibilityResponse eligibility = checkEligibility(currentUserId, request.getRoomId());

        if (!eligibility.isEligible()) {
            throw new IllegalArgumentException(eligibility.getReason());
        }

        ChatRoom room = chatRoomRepository.findById(request.getRoomId())
                .orElseThrow(() -> new EntityNotFoundException("Chat room not found"));

        User requester = userRepository.findById(currentUserId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        // Determine receiver (the other party in the chat)
        User receiver;
        if (room.getDesigner().getUser().getUserId().equals(currentUserId)) {
            receiver = room.getVillage().getUser();
        } else {
            receiver = room.getDesigner().getUser();
        }

        Connection connection = Connection.builder()
                .requester(requester)
                .receiver(receiver)
                .chatRoom(room)
                .status(ConnectionStatus.PENDING)
                .message(request.getMessage())
                .build();

        connection = connectionRepository.save(connection);
        return mapToResponse(connection, currentUserId);
    }

    /**
     * Accept a connection request.
     */
    public ConnectionResponse acceptConnection(Integer currentUserId, UUID connectionId) {
        Connection connection = connectionRepository.findById(connectionId)
                .orElseThrow(() -> new EntityNotFoundException("Connection not found"));

        if (!connection.getReceiver().getUserId().equals(currentUserId)) {
            throw new IllegalArgumentException("Only the receiver can accept this request");
        }

        if (connection.getStatus() != ConnectionStatus.PENDING) {
            throw new IllegalArgumentException("Connection is not pending");
        }

        connection.setStatus(ConnectionStatus.ACCEPTED);
        connection = connectionRepository.save(connection);
        return mapToResponse(connection, currentUserId);
    }

    /**
     * Reject a connection request.
     */
    public ConnectionResponse rejectConnection(Integer currentUserId, UUID connectionId) {
        Connection connection = connectionRepository.findById(connectionId)
                .orElseThrow(() -> new EntityNotFoundException("Connection not found"));

        if (!connection.getReceiver().getUserId().equals(currentUserId)) {
            throw new IllegalArgumentException("Only the receiver can reject this request");
        }

        if (connection.getStatus() != ConnectionStatus.PENDING) {
            throw new IllegalArgumentException("Connection is not pending");
        }

        connection.setStatus(ConnectionStatus.REJECTED);
        connection = connectionRepository.save(connection);
        return mapToResponse(connection, currentUserId);
    }

    /**
     * Get all accepted connections for a user.
     */
    @Transactional(readOnly = true)
    public List<ConnectionResponse> getConnections(Integer currentUserId) {
        List<Connection> connections = connectionRepository
                .findAllByUserIdAndStatus(currentUserId, ConnectionStatus.ACCEPTED);
        return connections.stream()
                .map(c -> mapToResponse(c, currentUserId))
                .collect(Collectors.toList());
    }

    /**
     * Get pending requests received by a user.
     */
    @Transactional(readOnly = true)
    public List<ConnectionResponse> getPendingReceived(Integer currentUserId) {
        List<Connection> connections = connectionRepository
                .findByReceiverUserIdAndStatus(currentUserId, ConnectionStatus.PENDING);
        return connections.stream()
                .map(c -> mapToResponse(c, currentUserId))
                .collect(Collectors.toList());
    }

    /**
     * Get pending requests sent by a user.
     */
    @Transactional(readOnly = true)
    public List<ConnectionResponse> getPendingSent(Integer currentUserId) {
        List<Connection> connections = connectionRepository
                .findByRequesterUserIdAndStatus(currentUserId, ConnectionStatus.PENDING);
        return connections.stream()
                .map(c -> mapToResponse(c, currentUserId))
                .collect(Collectors.toList());
    }

    // ============ Private helper methods ============

    private ConnectionResponse mapToResponse(Connection connection, Integer currentUserId) {
        User requester = connection.getRequester();
        User receiver = connection.getReceiver();

        String requesterName = getUserDisplayName(requester);
        String receiverName = getUserDisplayName(receiver);

        boolean isRequester = requester.getUserId().equals(currentUserId);
        String otherPartyName = isRequester ? receiverName : requesterName;
        String otherPartyType = isRequester ? receiver.getUserType().name() : requester.getUserType().name();

        return ConnectionResponse.builder()
                .connectionId(connection.getConnectionId())
                .chatRoomId(connection.getChatRoom().getRoomId())
                .requesterUserId(requester.getUserId())
                .requesterName(requesterName)
                .requesterType(requester.getUserType().name())
                .receiverUserId(receiver.getUserId())
                .receiverName(receiverName)
                .receiverType(receiver.getUserType().name())
                .otherPartyName(otherPartyName)
                .otherPartyType(otherPartyType)
                .status(connection.getStatus())
                .message(connection.getMessage())
                .createdAt(connection.getCreatedAt())
                .updatedAt(connection.getUpdatedAt())
                .isRequester(isRequester)
                .build();
    }

    private String getUserDisplayName(User user) {
        if (user.getUserType() == UserType.DESIGNER) {
            return designerRepository.findByUserUserId(user.getUserId())
                    .map(Designer::getDesignerName)
                    .orElse(user.getEmail());
        } else if (user.getUserType() == UserType.VILLAGE) {
            return craftVillageRepository.findByUserUserId(user.getUserId())
                    .map(CraftVillage::getVillageName)
                    .orElse(user.getEmail());
        }
        return user.getEmail();
    }
}
