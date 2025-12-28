package com.example.demo.dto.request;

import com.example.demo.enums.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VillageSearchRequest {

    private String query;
    private Integer materialId; // Filter by material
    private String location; // Filter by location (partial match)
    private Double minRating; // Minimum rating filter (e.g., 4.0 for "4/5 & up")
    private Scale scale;
    private Region region;
    private Set<ProductCategory> categories;
    private Set<ProductCharacteristic> characteristics;
    private Set<MarketSegment> marketSegments;

    // Sorting (rating, name, createdAt)
    private String sortBy = "rating"; // Default sort by rating
    private String sortOrder = "desc"; // asc or desc

    // Pagination
    private Integer page = 0;
    private Integer size = 10;
}
