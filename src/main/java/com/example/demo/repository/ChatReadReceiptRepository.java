package com.example.demo.repository;

import com.example.demo.entity.ChatReadReceipt;
import com.example.demo.entity.ChatReadReceiptId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ChatReadReceiptRepository extends JpaRepository<ChatReadReceipt, ChatReadReceiptId> {

    /**
     * Find read receipt for a specific user in a room.
     */
    Optional<ChatReadReceipt> findByIdRoomIdAndIdUserId(UUID roomId, Integer userId);
}
