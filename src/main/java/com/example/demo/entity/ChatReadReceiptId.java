package com.example.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;
import java.util.UUID;

/**
 * Composite primary key for ChatReadReceipt (room_id + user_id).
 */
@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatReadReceiptId implements Serializable {

    @Column(name = "room_id")
    private UUID roomId;

    @Column(name = "user_id")
    private Integer userId;
}
