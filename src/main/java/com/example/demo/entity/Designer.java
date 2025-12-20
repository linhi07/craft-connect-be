package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "designers")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Designer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "designer_id")
    private Integer designerId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "designer_name", nullable = false, length = 255)
    private String designerName;

    @Column(name = "contact_person", length = 255)
    private String contactPerson;

    @Column(name = "phone_number", length = 50)
    private String phoneNumber;

    @Column(name = "website_url", length = 255)
    private String websiteUrl;

    @Column(columnDefinition = "TEXT")
    private String bio;

    @Column(name = "portfolio_url", length = 255)
    private String portfolioUrl;

    @Column(length = 255)
    private String location;
}
