-- =============================================================================
-- V3__sample_villages.sql
-- Sample data for craft villages using real Vietnamese village names (English)
-- =============================================================================

-- Insert sample users for villages
INSERT INTO
    users (
        email,
        password_hash,
        user_type,
        created_at,
        updated_at
    )
VALUES (
        'vanhuc@craftvillage.vn',
        '$2a$10$dummyhash1',
        'VILLAGE',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    (
        'ninhbinh.lacquer@craftvillage.vn',
        '$2a$10$dummyhash2',
        'VILLAGE',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    (
        'hoian.silk@craftvillage.vn',
        '$2a$10$dummyhash3',
        'VILLAGE',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    (
        'phuyen.bamboo@craftvillage.vn',
        '$2a$10$dummyhash4',
        'VILLAGE',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    (
        'nghean.hemp@craftvillage.vn',
        '$2a$10$dummyhash5',
        'VILLAGE',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    (
        'binhdinh.rattan@craftvillage.vn',
        '$2a$10$dummyhash6',
        'VILLAGE',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    (
        'hanoi.pottery@craftvillage.vn',
        '$2a$10$dummyhash7',
        'VILLAGE',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    (
        'binhduong.lacquer@craftvillage.vn',
        '$2a$10$dummyhash8',
        'VILLAGE',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    );

-- Insert sample craft villages
INSERT INTO
    craft_villages (
        user_id,
        village_name,
        contact_person,
        phone_number,
        website_url,
        description,
        inspirational_story,
        certifications,
        location,
        scale,
        region
    )
VALUES
    -- 1. Van Phuc Silk Village (Ha Dong, Hanoi) - Northern Vietnam silk village
    (
        (
            SELECT user_id
            FROM users
            WHERE
                email = 'vanhuc@craftvillage.vn'
        ),
        'Van Phuc Silk Village',
        'Nguyen Van Minh',
        '+84 24 3354 1234',
        'https://luavanphuc.vn',
        'Van Phuc Silk Village is famous for traditional silk weaving with over 1000 years of history. Van Phuc silk is soft, durable, and beautiful, featuring exquisite patterns that embody Vietnamese cultural identity.',
        'Since the Ly Dynasty, Van Phuc Village has been the silk supplier for the royal court. Through historical ups and downs, the people here have preserved and developed traditional silk weaving. Each piece of silk contains the dedication and skills passed down from generation to generation.',
        'National Intangible Cultural Heritage, OCOP 4-star',
        'Van Phuc, Ha Dong, Hanoi',
        'VILLAGE',
        'NORTHERN_VIETNAM'
    ),
    -- 2. Cat Dang Lacquerware Village (Nam Dinh) - Northern Vietnam lacquerware
    (
        (
            SELECT user_id
            FROM users
            WHERE
                email = 'ninhbinh.lacquer@craftvillage.vn'
        ),
        'Cat Dang Lacquerware Village',
        'Tran Thi Huong',
        '+84 229 3621 456',
        'https://sonmaicatdang.com',
        'Cat Dang Lacquerware Village has over 400 years of history, famous for traditional lacquer techniques combined with exquisite mother-of-pearl inlay. Products range from vases and boxes to artistic paintings.',
        'The Cat Dang lacquer craft was passed down from the Le Dynasty and flourished under the Nguyen Dynasty. Today, artisans still maintain the traditional 20-step technique, with each product requiring 3-6 months to complete.',
        'Traditional Vietnamese Craft Village, National Artisan Award',
        'Cat Dang, Yen Tien, Y Yen, Nam Dinh',
        'VILLAGE',
        'NORTHERN_VIETNAM'
    ),
    -- 3. Ma Chau Silk Village (Hoi An, Quang Nam) - Central Vietnam silk
    (
        (
            SELECT user_id
            FROM users
            WHERE
                email = 'hoian.silk@craftvillage.vn'
        ),
        'Ma Chau Silk Village',
        'Le Van Tung',
        '+84 235 3861 789',
        'https://hoiansilk.vn',
        'Ma Chau Silk Village is the cradle of Quang region silk weaving with over 400 years of history. Ma Chau silk stands out for its natural dyeing techniques using local plants.',
        'Since the prosperous days of Hoi An trading port, Ma Chau silk was exported to Japan and Southeast Asian countries. Each product carries the essence of the ancient town and the weaving heritage of Quang region.',
        'Hoi An Cultural Heritage, OCOP 4-star',
        'Duy Trinh, Duy Xuyen, Quang Nam',
        'VILLAGE',
        'CENTRAL_VIETNAM'
    ),
    -- 4. Phu Yen Bamboo Weaving Village - Central Vietnam bamboo
    (
        (
            SELECT user_id
            FROM users
            WHERE
                email = 'phuyen.bamboo@craftvillage.vn'
        ),
        'Phu Yen Bamboo Weaving Village',
        'Nguyen Thi Mai',
        '+84 257 3822 567',
        NULL,
        'Traditional bamboo weaving village producing handicraft products from bamboo and rattan, from household items to high-end interior decorations, all environmentally friendly.',
        'The people of Phu Yen have been connected to bamboo for hundreds of years. Skilled hands have transformed bamboo into works of art, serving daily life while carrying high aesthetic value.',
        'Green Product, Sustainability Certified',
        'An My, Tuy An, Phu Yen',
        'VILLAGE',
        'CENTRAL_VIETNAM'
    ),
    -- 5. Nghe An Hemp Weaving Village - Northern Vietnam hemp fabric
    (
        (
            SELECT user_id
            FROM users
            WHERE
                email = 'nghean.hemp@craftvillage.vn'
        ),
        'Nghe An Hemp Weaving Village',
        'Hoang Van Duc',
        '+84 238 3855 890',
        NULL,
        'Traditional hemp fabric weaving village of the Thai ethnic group, famous for weaving and embroidery techniques with distinctive patterns. Hemp fabric is cool, durable, and highly absorbent, perfect for tropical weather.',
        'Hemp weaving has been passed down through many generations of Thai people in Nghe An. Each pattern on the fabric tells stories of mountains, forests, life, and beliefs of the ethnic community.',
        'Ethnic Minority Cultural Heritage',
        'Con Cuong, Nghe An',
        'INDIVIDUAL_ARTIST',
        'NORTHERN_VIETNAM'
    ),
    -- 6. Binh Dinh Rattan Village - Central/Southern Vietnam rattan
    (
        (
            SELECT user_id
            FROM users
            WHERE
                email = 'binhdinh.rattan@craftvillage.vn'
        ),
        'Binh Dinh Rattan Village',
        'Tran Van Binh',
        '+84 256 3741 234',
        'https://maytrebinhdinh.vn',
        'Rattan and bamboo weaving village with over 200 years of history, specializing in producing furniture, bags, and decorative products from natural rattan and bamboo, exported to many countries.',
        'From humble rattan and bamboo plants, Binh Dinh artisans have created exquisite products that reach the world. The craft village has helped thousands of families achieve stable income.',
        'Export Certified, ISO 9001',
        'Hoai Chau Bac, Hoai Nhon, Binh Dinh',
        'ASSOCIATION',
        'CENTRAL_VIETNAM'
    ),
    -- 7. Bat Trang Pottery Village (Hanoi) - Northern Vietnam ceramics
    (
        (
            SELECT user_id
            FROM users
            WHERE
                email = 'hanoi.pottery@craftvillage.vn'
        ),
        'Bat Trang Pottery Village',
        'Pham Thi Lan',
        '+84 24 3874 5678',
        'https://gombattrang.vn',
        'Bat Trang Pottery Village is famous for traditional ceramic craftsmanship with over 500 years of history, producing everything from household ceramics to high-end artistic ceramics with distinctive regional glazes.',
        'Bat Trang is the most famous ancient pottery village in Vietnam. Since the Ly-Tran Dynasty, Bat Trang ceramics have been exported to many countries. Today, the village combines tradition with modernity to create unique products.',
        'National Intangible Cultural Heritage, OCOP 5-star',
        'Bat Trang, Gia Lam, Hanoi',
        'VILLAGE',
        'NORTHERN_VIETNAM'
    ),
    -- 8. Tuong Binh Hiep Lacquerware Village (Binh Duong) - Southern Vietnam lacquer
    (
        (
            SELECT user_id
            FROM users
            WHERE
                email = 'binhduong.lacquer@craftvillage.vn'
        ),
        'Tuong Binh Hiep Lacquerware Village',
        'Nguyen Van Thanh',
        '+84 274 3822 111',
        'https://sonmaibinhduong.com',
        'Tuong Binh Hiep Lacquerware Village is famous for Southern lacquer techniques, combining traditional and modern styles, producing lacquer paintings, decorative items, and high-end gifts.',
        'Binh Duong lacquerware developed from the 19th century, adopting techniques from the North but creating its own Southern style. Products stand out with vibrant colors and rich patterns.',
        'National Traditional Craft Village',
        'Tuong Binh Hiep, Thu Dau Mot, Binh Duong',
        'VILLAGE',
        'SOUTHERN_VIETNAM'
    );

-- Insert village categories
INSERT INTO
    village_categories (village_id, category)
SELECT v.village_id, c.category
FROM craft_villages v
    CROSS JOIN (
        SELECT 'FASHION_TEXTILE' AS category
        UNION ALL
        SELECT 'SCARVES_ACCESSORIES'
        UNION ALL
        SELECT 'CUSTOM_DESIGN'
    ) c
WHERE
    v.village_name = 'Van Phuc Silk Village';

INSERT INTO
    village_categories (village_id, category)
SELECT v.village_id, c.category
FROM craft_villages v
    CROSS JOIN (
        SELECT 'HOME_DECOR' AS category
        UNION ALL
        SELECT 'CUSTOM_DESIGN'
    ) c
WHERE
    v.village_name = 'Cat Dang Lacquerware Village';

INSERT INTO
    village_categories (village_id, category)
SELECT v.village_id, c.category
FROM craft_villages v
    CROSS JOIN (
        SELECT 'FASHION_TEXTILE' AS category
        UNION ALL
        SELECT 'RAW_MATERIALS'
        UNION ALL
        SELECT 'SCARVES_ACCESSORIES'
    ) c
WHERE
    v.village_name = 'Ma Chau Silk Village';

INSERT INTO
    village_categories (village_id, category)
SELECT v.village_id, c.category
FROM craft_villages v
    CROSS JOIN (
        SELECT 'HOME_DECOR' AS category
        UNION ALL
        SELECT 'RAW_MATERIALS'
    ) c
WHERE
    v.village_name = 'Phu Yen Bamboo Weaving Village';

INSERT INTO
    village_categories (village_id, category)
SELECT v.village_id, c.category
FROM craft_villages v
    CROSS JOIN (
        SELECT 'FASHION_TEXTILE' AS category
        UNION ALL
        SELECT 'RAW_MATERIALS'
    ) c
WHERE
    v.village_name = 'Nghe An Hemp Weaving Village';

INSERT INTO
    village_categories (village_id, category)
SELECT v.village_id, c.category
FROM craft_villages v
    CROSS JOIN (
        SELECT 'HOME_DECOR' AS category
        UNION ALL
        SELECT 'RAW_MATERIALS'
        UNION ALL
        SELECT 'CUSTOM_DESIGN'
    ) c
WHERE
    v.village_name = 'Binh Dinh Rattan Village';

INSERT INTO
    village_categories (village_id, category)
SELECT v.village_id, c.category
FROM craft_villages v
    CROSS JOIN (
        SELECT 'HOME_DECOR' AS category
        UNION ALL
        SELECT 'CUSTOM_DESIGN'
    ) c
WHERE
    v.village_name = 'Bat Trang Pottery Village';

INSERT INTO
    village_categories (village_id, category)
SELECT v.village_id, c.category
FROM craft_villages v
    CROSS JOIN (
        SELECT 'HOME_DECOR' AS category
        UNION ALL
        SELECT 'CUSTOM_DESIGN'
    ) c
WHERE
    v.village_name = 'Tuong Binh Hiep Lacquerware Village';

-- Insert village characteristics
INSERT INTO
    village_characteristics (village_id, characteristic)
SELECT v.village_id, c.characteristic
FROM craft_villages v
    CROSS JOIN (
        SELECT 'HANDWOVEN' AS characteristic
        UNION ALL
        SELECT 'NATURAL_DYED'
    ) c
WHERE
    v.village_name IN (
        'Van Phuc Silk Village',
        'Ma Chau Silk Village',
        'Nghe An Hemp Weaving Village'
    );

INSERT INTO
    village_characteristics (village_id, characteristic)
SELECT v.village_id, 'ECO_FRIENDLY'
FROM craft_villages v
WHERE
    v.village_name IN (
        'Phu Yen Bamboo Weaving Village',
        'Binh Dinh Rattan Village',
        'Nghe An Hemp Weaving Village'
    );

INSERT INTO
    village_characteristics (village_id, characteristic)
SELECT v.village_id, 'HANDWOVEN'
FROM craft_villages v
WHERE
    v.village_name IN (
        'Phu Yen Bamboo Weaving Village',
        'Binh Dinh Rattan Village'
    );

INSERT INTO
    village_characteristics (village_id, characteristic)
SELECT v.village_id, 'OTHERS'
FROM craft_villages v
WHERE
    v.village_name IN (
        'Cat Dang Lacquerware Village',
        'Tuong Binh Hiep Lacquerware Village',
        'Bat Trang Pottery Village'
    );

-- Insert village market segments
INSERT INTO
    village_markets (village_id, market_segment)
SELECT v.village_id, 'LUXURY'
FROM craft_villages v
WHERE
    v.village_name IN (
        'Van Phuc Silk Village',
        'Cat Dang Lacquerware Village',
        'Bat Trang Pottery Village',
        'Tuong Binh Hiep Lacquerware Village'
    );

INSERT INTO
    village_markets (village_id, market_segment)
SELECT v.village_id, 'EXPORT_ORIENTED'
FROM craft_villages v
WHERE
    v.village_name IN (
        'Binh Dinh Rattan Village',
        'Bat Trang Pottery Village',
        'Tuong Binh Hiep Lacquerware Village'
    );

INSERT INTO
    village_markets (village_id, market_segment)
SELECT v.village_id, 'AFFORDABLE'
FROM craft_villages v
WHERE
    v.village_name IN (
        'Phu Yen Bamboo Weaving Village',
        'Nghe An Hemp Weaving Village',
        'Ma Chau Silk Village'
    );

INSERT INTO
    village_markets (village_id, market_segment)
SELECT v.village_id, 'LOCALLY_FOCUSED'
FROM craft_villages v
WHERE
    v.village_name IN (
        'Nghe An Hemp Weaving Village',
        'Phu Yen Bamboo Weaving Village'
    );

-- Link villages with materials
INSERT INTO
    village_materials (
        village_id,
        material_id,
        production_capacity,
        price_range
    )
SELECT cv.village_id, m.material_id, '500-1000m/month', '$8-80 USD/m'
FROM craft_villages cv, materials m
WHERE
    cv.village_name = 'Van Phuc Silk Village'
    AND m.material_name = 'Silk';

INSERT INTO
    village_materials (
        village_id,
        material_id,
        production_capacity,
        price_range
    )
SELECT cv.village_id, m.material_id, '100-200 products/month', '$20-2000 USD/product'
FROM craft_villages cv, materials m
WHERE
    cv.village_name = 'Cat Dang Lacquerware Village'
    AND m.material_name = 'Lacquer';

INSERT INTO
    village_materials (
        village_id,
        material_id,
        production_capacity,
        price_range
    )
SELECT cv.village_id, m.material_id, '300-500m/month', '$6-60 USD/m'
FROM craft_villages cv, materials m
WHERE
    cv.village_name = 'Ma Chau Silk Village'
    AND m.material_name = 'Silk';

INSERT INTO
    village_materials (
        village_id,
        material_id,
        production_capacity,
        price_range
    )
SELECT cv.village_id, m.material_id, '300-500 products/month', '$2-20 USD/product'
FROM craft_villages cv, materials m
WHERE
    cv.village_name = 'Phu Yen Bamboo Weaving Village'
    AND m.material_name = 'Bamboo';

INSERT INTO
    village_materials (
        village_id,
        material_id,
        production_capacity,
        price_range
    )
SELECT cv.village_id, m.material_id, '100-200m/month', '$4-20 USD/m'
FROM craft_villages cv, materials m
WHERE
    cv.village_name = 'Nghe An Hemp Weaving Village'
    AND m.material_name = 'Hemp';

INSERT INTO
    village_materials (
        village_id,
        material_id,
        production_capacity,
        price_range
    )
SELECT cv.village_id, m.material_id, '500-1000 products/month', '$4-200 USD/product'
FROM craft_villages cv, materials m
WHERE
    cv.village_name = 'Binh Dinh Rattan Village'
    AND m.material_name = 'Rattan';

INSERT INTO
    village_materials (
        village_id,
        material_id,
        production_capacity,
        price_range
    )
SELECT cv.village_id, m.material_id, '1000+ products/month', '$1-400 USD/product'
FROM craft_villages cv, materials m
WHERE
    cv.village_name = 'Bat Trang Pottery Village'
    AND m.material_name = 'Ceramic';

INSERT INTO
    village_materials (
        village_id,
        material_id,
        production_capacity,
        price_range
    )
SELECT cv.village_id, m.material_id, '50-100 products/month', '$40-4000 USD/product'
FROM craft_villages cv, materials m
WHERE
    cv.village_name = 'Tuong Binh Hiep Lacquerware Village'
    AND m.material_name = 'Lacquer';