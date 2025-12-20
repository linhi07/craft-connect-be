package com.example.demo.service;

import com.example.demo.dto.request.VillageSearchRequest;
import com.example.demo.dto.response.*;
import com.example.demo.entity.CraftVillage;
import com.example.demo.entity.QCraftVillage;
import com.example.demo.enums.*;
import com.example.demo.repository.CraftVillageRepository;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class VillageSearchService {

    private final CraftVillageRepository villageRepository;
    private final EntityManager entityManager;

    public VillageSearchResponse searchVillages(VillageSearchRequest request) {
        JPAQueryFactory queryFactory = new JPAQueryFactory(entityManager);
        QCraftVillage village = QCraftVillage.craftVillage;

        BooleanBuilder predicate = new BooleanBuilder();

        // Scale filter
        if (request.getScale() != null) {
            predicate.and(village.scale.eq(request.getScale()));
        }

        // Region filter
        if (request.getRegion() != null) {
            predicate.and(village.region.eq(request.getRegion()));
        }

        // Categories filter (any match)
        if (request.getCategories() != null && !request.getCategories().isEmpty()) {
            BooleanBuilder categoryPredicate = new BooleanBuilder();
            for (ProductCategory category : request.getCategories()) {
                categoryPredicate.or(village.categories.contains(category));
            }
            predicate.and(categoryPredicate);
        }

        // Characteristics filter (any match)
        if (request.getCharacteristics() != null && !request.getCharacteristics().isEmpty()) {
            BooleanBuilder charPredicate = new BooleanBuilder();
            for (ProductCharacteristic characteristic : request.getCharacteristics()) {
                charPredicate.or(village.characteristics.contains(characteristic));
            }
            predicate.and(charPredicate);
        }

        // Market segments filter (any match)
        if (request.getMarketSegments() != null && !request.getMarketSegments().isEmpty()) {
            BooleanBuilder marketPredicate = new BooleanBuilder();
            for (MarketSegment segment : request.getMarketSegments()) {
                marketPredicate.or(village.marketSegments.contains(segment));
            }
            predicate.and(marketPredicate);
        }

        // Count total
        long total = queryFactory
                .select(village.countDistinct())
                .from(village)
                .where(predicate)
                .fetchOne();

        // Fetch paginated results
        int page = request.getPage() != null ? request.getPage() : 0;
        int size = request.getSize() != null ? request.getSize() : 10;

        List<CraftVillage> results = queryFactory
                .selectDistinct(village)
                .from(village)
                .where(predicate)
                .offset((long) page * size)
                .limit(size)
                .orderBy(village.villageName.asc())
                .fetch();

        List<VillageResponse> villageResponses = results.stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());

        int totalPages = (int) Math.ceil((double) total / size);

        return VillageSearchResponse.builder()
                .villages(villageResponses)
                .currentPage(page)
                .totalPages(totalPages)
                .totalElements(total)
                .size(size)
                .build();
    }

    public VillageDetailResponse getVillageById(Integer villageId) {
        CraftVillage village = villageRepository.findById(villageId)
                .orElseThrow(() -> new EntityNotFoundException("Village not found with id: " + villageId));

        List<PortfolioItemResponse> portfolioItems = village.getPortfolioItems().stream()
                .map(item -> PortfolioItemResponse.builder()
                        .portfolioId(item.getPortfolioId())
                        .title(item.getTitle())
                        .description(item.getDescription())
                        .imageUrl(item.getImageUrl())
                        .createdAt(item.getCreatedAt())
                        .build())
                .collect(Collectors.toList());

        return VillageDetailResponse.builder()
                .villageId(village.getVillageId())
                .villageName(village.getVillageName())
                .contactPerson(village.getContactPerson())
                .phoneNumber(village.getPhoneNumber())
                .websiteUrl(village.getWebsiteUrl())
                .description(village.getDescription())
                .inspirationalStory(village.getInspirationalStory())
                .certifications(village.getCertifications())
                .location(village.getLocation())
                .scale(village.getScale())
                .region(village.getRegion())
                .categories(village.getCategories())
                .characteristics(village.getCharacteristics())
                .marketSegments(village.getMarketSegments())
                .portfolioItems(portfolioItems)
                .build();
    }

    private VillageResponse mapToResponse(CraftVillage village) {
        return VillageResponse.builder()
                .villageId(village.getVillageId())
                .villageName(village.getVillageName())
                .contactPerson(village.getContactPerson())
                .phoneNumber(village.getPhoneNumber())
                .websiteUrl(village.getWebsiteUrl())
                .description(village.getDescription())
                .inspirationalStory(village.getInspirationalStory())
                .certifications(village.getCertifications())
                .location(village.getLocation())
                .scale(village.getScale())
                .region(village.getRegion())
                .categories(village.getCategories())
                .characteristics(village.getCharacteristics())
                .marketSegments(village.getMarketSegments())
                .build();
    }
}
