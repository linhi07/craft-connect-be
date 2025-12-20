package com.example.demo.entity;

import com.example.demo.enums.*;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "craft_villages")
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

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private Scale scale;

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private Region region;

    // Many-to-many relationships for search criteria
    @ElementCollection(targetClass = ProductCategory.class)
    @CollectionTable(name = "village_categories", joinColumns = @JoinColumn(name = "village_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "category")
    @Builder.Default
    private Set<ProductCategory> categories = new HashSet<>();

    @ElementCollection(targetClass = ProductCharacteristic.class)
    @CollectionTable(name = "village_characteristics", joinColumns = @JoinColumn(name = "village_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "characteristic")
    @Builder.Default
    private Set<ProductCharacteristic> characteristics = new HashSet<>();

    @ElementCollection(targetClass = MarketSegment.class)
    @CollectionTable(name = "village_markets", joinColumns = @JoinColumn(name = "village_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "market_segment")
    @Builder.Default
    private Set<MarketSegment> marketSegments = new HashSet<>();

    @OneToMany(mappedBy = "village", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private Set<PortfolioItem> portfolioItems = new HashSet<>();

    @OneToMany(mappedBy = "village", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private Set<VillageMaterial> villageMaterials = new HashSet<>();

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}
