package com.example.demo.repository;

import com.example.demo.entity.ChatRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ChatRoomRepository extends JpaRepository<ChatRoom, UUID> {

    /**
     * Find a chat room by designer and village IDs.
     */
    Optional<ChatRoom> findByDesignerDesignerIdAndVillageVillageId(Integer designerId, Integer villageId);

    /**
     * Find all chat rooms for a user (as designer or village owner).
     * Ordered by most recent activity.
     */
    @Query("SELECT cr FROM ChatRoom cr " +
            "WHERE cr.designer.user.userId = :userId OR cr.village.user.userId = :userId " +
            "ORDER BY cr.updatedAt DESC")
    List<ChatRoom> findAllByUserId(@Param("userId") Integer userId);

    /**
     * Check if user is a participant in the room.
     */
    @Query("SELECT CASE WHEN COUNT(cr) > 0 THEN true ELSE false END FROM ChatRoom cr " +
            "WHERE cr.roomId = :roomId AND (cr.designer.user.userId = :userId OR cr.village.user.userId = :userId)")
    boolean isUserParticipant(@Param("roomId") UUID roomId, @Param("userId") Integer userId);
}
