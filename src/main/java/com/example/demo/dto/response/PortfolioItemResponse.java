package com.example.demo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PortfolioItemResponse {
    
    private Integer portfolioId;
    private String title;
    private String description;
    private String imageUrl;
    private LocalDateTime createdAt;
}
