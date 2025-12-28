package com.example.demo.repository;

import com.example.demo.entity.Connection;
import com.example.demo.enums.ConnectionStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ConnectionRepository extends JpaRepository<Connection, UUID> {

    /**
     * Find existing connection between two users (in either direction).
     */
    @Query("SELECT c FROM Connection c WHERE " +
            "(c.requester.userId = :userId1 AND c.receiver.userId = :userId2) OR " +
            "(c.requester.userId = :userId2 AND c.receiver.userId = :userId1)")
    Optional<Connection> findBetweenUsers(@Param("userId1") Integer userId1, @Param("userId2") Integer userId2);

    /**
     * Find connection for a chat room.
     */
    Optional<Connection> findByChatRoomRoomId(UUID roomId);

    /**
     * Get all connections for a user (as requester or receiver).
     */
    @Query("SELECT c FROM Connection c WHERE " +
            "(c.requester.userId = :userId OR c.receiver.userId = :userId) " +
            "AND c.status = :status " +
            "ORDER BY c.updatedAt DESC")
    List<Connection> findAllByUserIdAndStatus(@Param("userId") Integer userId,
            @Param("status") ConnectionStatus status);

    /**
     * Get pending requests received by a user.
     */
    List<Connection> findByReceiverUserIdAndStatus(Integer userId, ConnectionStatus status);

    /**
     * Get pending requests sent by a user.
     */
    List<Connection> findByRequesterUserIdAndStatus(Integer userId, ConnectionStatus status);

    /**
     * Check if connection exists between users.
     */
    @Query("SELECT CASE WHEN COUNT(c) > 0 THEN true ELSE false END FROM Connection c WHERE " +
            "((c.requester.userId = :userId1 AND c.receiver.userId = :userId2) OR " +
            "(c.requester.userId = :userId2 AND c.receiver.userId = :userId1)) AND c.status = 'ACCEPTED'")
    boolean areConnected(@Param("userId1") Integer userId1, @Param("userId2") Integer userId2);
}
