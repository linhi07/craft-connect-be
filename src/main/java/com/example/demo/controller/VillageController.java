package com.example.demo.controller;

import com.example.demo.dto.request.VillageSearchRequest;
import com.example.demo.dto.response.VillageDetailResponse;
import com.example.demo.dto.response.VillageSearchResponse;
import com.example.demo.enums.*;
import com.example.demo.service.VillageSearchService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@RestController
@RequestMapping("/api/villages")
@RequiredArgsConstructor
public class VillageController {

    private final VillageSearchService villageSearchService;

    /**
     * Search villages with optional filters.
     * 
     * Example queries:
     * GET /api/villages
     * GET /api/villages?scale=VILLAGE&region=NORTHERN_VIETNAM
     * GET /api/villages?categories=RAW_MATERIALS,FASHION_TEXTILE
     * GET /api/villages?characteristics=HANDWOVEN,ECO_FRIENDLY&marketSegments=LUXURY
     */
    @GetMapping
    public ResponseEntity<VillageSearchResponse> searchVillages(
            @RequestParam(required = false) Scale scale,
            @RequestParam(required = false) Region region,
            @RequestParam(required = false) Set<ProductCategory> categories,
            @RequestParam(required = false) Set<ProductCharacteristic> characteristics,
            @RequestParam(required = false) Set<MarketSegment> marketSegments,
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "10") Integer size
    ) {
        VillageSearchRequest request = new VillageSearchRequest();
        request.setScale(scale);
        request.setRegion(region);
        request.setCategories(categories);
        request.setCharacteristics(characteristics);
        request.setMarketSegments(marketSegments);
        request.setPage(page);
        request.setSize(size);

        VillageSearchResponse response = villageSearchService.searchVillages(request);
        return ResponseEntity.ok(response);
    }

    /**
     * Get village details by ID including portfolio items.
     */
    @GetMapping("/{id}")
    public ResponseEntity<VillageDetailResponse> getVillageById(@PathVariable Integer id) {
        VillageDetailResponse response = villageSearchService.getVillageById(id);
        return ResponseEntity.ok(response);
    }
}
