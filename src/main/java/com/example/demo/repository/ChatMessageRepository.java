package com.example.demo.repository;

import com.example.demo.entity.ChatMessage;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, UUID> {

    /**
     * Get paginated messages for a room, ordered by newest first.
     */
    Page<ChatMessage> findByRoomRoomIdOrderByCreatedAtDesc(UUID roomId, Pageable pageable);

    /**
     * Get the most recent message in a room (for chat preview).
     */
    Optional<ChatMessage> findFirstByRoomRoomIdOrderByCreatedAtDesc(UUID roomId);

    /**
     * Count messages in a room created after a specific time (for unread count).
     */
    long countByRoomRoomIdAndCreatedAtAfter(UUID roomId, LocalDateTime after);

    /**
     * Count all messages in a room (for when user has never read).
     */
    long countByRoomRoomId(UUID roomId);

    /**
     * Count messages from a specific sender in a room (for connection eligibility).
     */
    long countByRoomRoomIdAndSenderUserId(UUID roomId, Integer userId);
}
