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
    
    private Scale scale;
    private Region region;
    private Set<ProductCategory> categories;
    private Set<ProductCharacteristic> characteristics;
    private Set<MarketSegment> marketSegments;
    
    // Pagination
    private Integer page = 0;
    private Integer size = 10;
}
