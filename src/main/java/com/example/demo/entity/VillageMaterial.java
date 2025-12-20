package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "village_materials")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VillageMaterial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "village_material_id")
    private Integer villageMaterialId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "village_id", nullable = false)
    private CraftVillage village;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "material_id", nullable = false)
    private Material material;

    @Column(name = "production_capacity", length = 255)
    private String productionCapacity;

    @Column(name = "price_range", length = 255)
    private String priceRange;
}
