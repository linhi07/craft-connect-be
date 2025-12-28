package com.example.demo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Paginated response for listing chat rooms.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatListResponse {

    private List<ChatRoomResponse> rooms;
    private int currentPage;
    private int totalPages;
    private long totalElements;
    private int size;
}
