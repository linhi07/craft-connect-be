package com.example.demo.dto.response;

import com.example.demo.enums.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VillageDetailResponse {

    private Integer villageId;
    private String villageName;
    private String contactPerson;
    private String phoneNumber;
    private String websiteUrl;
    private String description;
    private String inspirationalStory;
    private String certifications;
    private String location;

    // New fields for village detail page
    private String profileImageUrl;
    private String email;
    private String craftType;
    private String associationMembership;
    private String keyProducts;
    private String techniques;
    private String productionCapacity;
    private String estimatedCompletionTime;

    private Double rating;
    private Scale scale;
    private Region region;
    private ProductCategory[] categories;
    private ProductCharacteristic[] characteristics;
    private MarketSegment[] marketSegments;
    private List<PortfolioItemResponse> portfolioItems;
}
