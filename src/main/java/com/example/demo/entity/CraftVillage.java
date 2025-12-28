package com.example.demo.entity;

import com.example.demo.enums.*;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "craft_villages", uniqueConstraints = {
    @UniqueConstraint(name = "uq_craft_villages_user_id", columnNames = "user_id")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CraftVillage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "village_id")
    private Integer villageId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "village_name", nullable = false, length = 255)
    private String villageName;

    @Column(name = "contact_person", length = 255)
    private String contactPerson;

    @Column(name = "phone_number", length = 50)
    private String phoneNumber;

    @Column(name = "website_url", length = 255)
    private String websiteUrl;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "inspirational_story", columnDefinition = "TEXT")
    private String inspirationalStory;

    @Column(columnDefinition = "TEXT")
    private String certifications;

    @Column(length = 255)
    private String location;

    // New fields for village detail page
    @Column(name = "profile_image_url", length = 500)
    private String profileImageUrl;

    @Column(name = "email", length = 255)
    private String email;

    @Column(name = "craft_type", length = 255)
    private String craftType; // e.g., "Weaving & Embroidery Traditional Village"

    @Column(name = "association_membership", length = 255)
    private String associationMembership; // e.g., "VICRAFT"

    @Column(name = "key_products", columnDefinition = "TEXT")
    private String keyProducts; // JSON array or newline-separated list

    @Column(name = "techniques", columnDefinition = "TEXT")
    private String techniques; // JSON array or newline-separated list

    @Column(name = "production_capacity", length = 500)
    private String productionCapacity; // e.g., "50 meters of silk per week"

    @Column(name = "estimated_completion_time", length = 255)
    private String estimatedCompletionTime; // e.g., "1 to 2 weeks"

    @Column(name = "rating")
    private Double rating; // Average rating 0.0 to 5.0

    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "scale")
    private Scale scale;

    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "region")
    private Region region;

    // PostgreSQL array fields for search criteria (replacing junction tables)
    // Using Hibernate 6 @JdbcTypeCode for array support
    @JdbcTypeCode(SqlTypes.ARRAY)
    @Column(name = "categories", columnDefinition = "product_category[]")
    private ProductCategory[] categories;

    @JdbcTypeCode(SqlTypes.ARRAY)
    @Column(name = "characteristics", columnDefinition = "product_characteristic[]")
    private ProductCharacteristic[] characteristics;

    @JdbcTypeCode(SqlTypes.ARRAY)
    @Column(name = "market_segments", columnDefinition = "market_segment[]")
    private MarketSegment[] marketSegments;

    @OneToMany(mappedBy = "village", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private Set<PortfolioItem> portfolioItems = new HashSet<>();

    @OneToMany(mappedBy = "village", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private Set<VillageMaterial> villageMaterials = new HashSet<>();

    /**
     * Vector embedding for semantic search (RAG).
     * Populated by Python chatbot service using sentence-transformers.
     * 384 dimensions (all-MiniLM-L6-v2 model).
     * Stored as TEXT in Java side, pgvector handles the actual vector operations.
     */
    @Column(name = "content_embedding", columnDefinition = "vector(384)", insertable = false, updatable = false)
    private String contentEmbedding;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}
