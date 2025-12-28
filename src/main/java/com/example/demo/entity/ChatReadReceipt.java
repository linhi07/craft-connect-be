package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

/**
 * Tracks when a user last read messages in a chat room.
 * Used to calculate unread message count.
 */
@Entity
@Table(name = "chat_read_receipts")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatReadReceipt {

    @EmbeddedId
    private ChatReadReceiptId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("roomId")
    @JoinColumn(name = "room_id", nullable = false)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private ChatRoom room;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("userId")
    @JoinColumn(name = "user_id", nullable = false)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private User user;

    @Column(name = "last_read_at", nullable = false)
    private LocalDateTime lastReadAt;
}
