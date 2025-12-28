package com.example.demo.service;

import com.example.demo.dto.request.VillageSearchRequest;
import com.example.demo.dto.response.*;
import com.example.demo.entity.CraftVillage;
import com.example.demo.entity.QCraftVillage;
import com.example.demo.enums.*;
import com.example.demo.repository.CraftVillageRepository;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.OrderSpecifier;
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

        // Text search filter (search in villageName and description)
        if (request.getQuery() != null && !request.getQuery().trim().isEmpty()) {
            String searchTerm = "%" + request.getQuery().trim().toLowerCase() + "%";
            predicate.and(
                    village.villageName.lower().like(searchTerm)
                            .or(village.description.lower().like(searchTerm)));
        }

        // Material filter (filter by materialId via villageMaterials relationship)
        if (request.getMaterialId() != null) {
            predicate.and(village.villageMaterials.any().material.materialId.eq(request.getMaterialId()));
        }

        // Location filter (partial match on location field)
        if (request.getLocation() != null && !request.getLocation().trim().isEmpty()) {
            String locationTerm = "%" + request.getLocation().trim().toLowerCase() + "%";
            predicate.and(village.location.lower().like(locationTerm));
        }

        // Rating filter (minimum rating)
        if (request.getMinRating() != null && request.getMinRating() > 0) {
            predicate.and(village.rating.goe(request.getMinRating()));
        }

        // Scale filter
        if (request.getScale() != null) {
            predicate.and(village.scale.eq(request.getScale()));
        }

        // Region filter
        if (request.getRegion() != null) {
            predicate.and(village.region.eq(request.getRegion()));
        }

        // Categories filter (any match) - using array overlap
        // Note: QueryDSL doesn't have good array support, so we'll use a workaround
        // For now, fetch all and filter in memory if needed, or use native query
        // Arrays will be filtered via native query in repository if performance becomes an issue
        if (request.getCategories() != null && !request.getCategories().isEmpty()) {
            // Will be filtered post-query due to QueryDSL array limitations
        }

        // Characteristics filter (any match)
        if (request.getCharacteristics() != null && !request.getCharacteristics().isEmpty()) {
            // Will be filtered post-query due to QueryDSL array limitations
        }

        // Market segments filter (any match)
        if (request.getMarketSegments() != null && !request.getMarketSegments().isEmpty()) {
            // Will be filtered post-query due to QueryDSL array limitations
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

        // Determine sort order
        OrderSpecifier<?> orderBy = getSortOrder(request.getSortBy(), request.getSortOrder(), village);

        List<CraftVillage> results = queryFactory
                .selectDistinct(village)
                .from(village)
                .where(predicate)
                .offset((long) page * size)
                .limit(size)
                .orderBy(orderBy)
                .fetch();

        // Apply array filters post-query (due to QueryDSL array limitations)
        results = filterByArrayFields(results, request);

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
                // New fields for village detail page
                .profileImageUrl(village.getProfileImageUrl())
                .email(village.getEmail())
                .craftType(village.getCraftType())
                .associationMembership(village.getAssociationMembership())
                .keyProducts(village.getKeyProducts())
                .techniques(village.getTechniques())
                .productionCapacity(village.getProductionCapacity())
                .estimatedCompletionTime(village.getEstimatedCompletionTime())
                // Existing fields
                .rating(village.getRating())
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
                .rating(village.getRating())
                .scale(village.getScale())
                .region(village.getRegion())
                .categories(village.getCategories())
                .characteristics(village.getCharacteristics())
                .marketSegments(village.getMarketSegments())
                .build();
    }

    /**
     * Filter villages by array fields (categories, characteristics, marketSegments)
     * since QueryDSL doesn't have good PostgreSQL array support.
     */
    private List<CraftVillage> filterByArrayFields(List<CraftVillage> villages, VillageSearchRequest request) {
        return villages.stream()
                .filter(v -> matchesCategories(v, request.getCategories()))
                .filter(v -> matchesCharacteristics(v, request.getCharacteristics()))
                .filter(v -> matchesMarketSegments(v, request.getMarketSegments()))
                .collect(Collectors.toList());
    }

    private boolean matchesCategories(CraftVillage village, Set<ProductCategory> requestedCategories) {
        if (requestedCategories == null || requestedCategories.isEmpty()) {
            return true;
        }
        if (village.getCategories() == null || village.getCategories().length == 0) {
            return false;
        }
        List<ProductCategory> villageCategories = List.of(village.getCategories());
        return requestedCategories.stream().anyMatch(villageCategories::contains);
    }

    private boolean matchesCharacteristics(CraftVillage village, Set<ProductCharacteristic> requestedChars) {
        if (requestedChars == null || requestedChars.isEmpty()) {
            return true;
        }
        if (village.getCharacteristics() == null || village.getCharacteristics().length == 0) {
            return false;
        }
        List<ProductCharacteristic> villageChars = List.of(village.getCharacteristics());
        return requestedChars.stream().anyMatch(villageChars::contains);
    }

    private boolean matchesMarketSegments(CraftVillage village, Set<MarketSegment> requestedSegments) {
        if (requestedSegments == null || requestedSegments.isEmpty()) {
            return true;
        }
        if (village.getMarketSegments() == null || village.getMarketSegments().length == 0) {
            return false;
        }
        List<MarketSegment> villageSegments = List.of(village.getMarketSegments());
        return requestedSegments.stream().anyMatch(villageSegments::contains);
    }

    /**
     * Get the OrderSpecifier based on sortBy and sortOrder parameters.
     * Supports: rating, name, createdAt
     */
    private OrderSpecifier<?> getSortOrder(String sortBy, String sortOrder, QCraftVillage village) {
        boolean isDesc = "desc".equalsIgnoreCase(sortOrder);

        return switch (sortBy != null ? sortBy.toLowerCase() : "rating") {
            case "name" -> isDesc ? village.villageName.desc() : village.villageName.asc();
            case "createdat", "created" -> isDesc ? village.createdAt.desc() : village.createdAt.asc();
            case "rating" -> isDesc ? village.rating.desc().nullsLast() : village.rating.asc().nullsLast();
            default -> village.rating.desc().nullsLast(); // Default: highest rated first
        };
    }
}
