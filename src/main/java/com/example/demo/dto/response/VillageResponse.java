package com.example.demo.dto.response;

import com.example.demo.enums.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VillageResponse {

    private Integer villageId;
    private String villageName;
    private String contactPerson;
    private String phoneNumber;
    private String websiteUrl;
    private String description;
    private String inspirationalStory;
    private String certifications;
    private String location;
    private Double rating;
    private Scale scale;
    private Region region;
    private ProductCategory[] categories;
    private ProductCharacteristic[] characteristics;
    private MarketSegment[] marketSegments;
}
