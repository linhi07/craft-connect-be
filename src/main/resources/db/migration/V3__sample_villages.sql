-- =============================================================================
-- V3__sample_villages.sql
-- Sample data for craft villages using real Vietnamese village names (English)
-- Uses PostgreSQL array syntax for categories, characteristics, and market segments
-- =============================================================================

-- ============================================================================
-- OLD DATA - COMMENTED OUT
-- ============================================================================
/*
-- Insert sample users for villages
INSERT INTO users (email, password_hash, user_type, created_at, updated_at)
VALUES 
    ('vanhuc@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('ninhbinh.lacquer@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('hoian.silk@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('phuyen.bamboo@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('nghean.hemp@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('binhdinh.rattan@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('hanoi.pottery@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('binhduong.lacquer@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert sample craft villages
INSERT INTO craft_villages (
    user_id, village_name, contact_person, phone_number, website_url,
    description, inspirational_story, certifications, location,
    scale, region, 
    categories, characteristics, market_segments,
    email, craft_type, association_membership, key_products, techniques,
    production_capacity, estimated_completion_time, rating
)
VALUES
    -- 1. Van Phuc Silk Village
    (
        (SELECT user_id FROM users WHERE email = 'vanhuc@craftvillage.vn'),
        'Van Phuc Silk Village',
        'Nguyen Van Minh',
        '+84 24 3354 1234',
        'https://luavanphuc.vn',
        'Van Phuc Silk Village is famous for traditional silk weaving with over 1000 years of history. Van Phuc silk is soft, durable, and beautiful, featuring exquisite patterns that embody Vietnamese cultural identity.',
        'Since the Ly Dynasty, Van Phuc Village has been the silk supplier for the royal court. Through historical ups and downs, the people here have preserved and developed traditional silk weaving. Each piece of silk contains the dedication and skills passed down from generation to generation.',
        'National Intangible Cultural Heritage, OCOP 4-star',
        'Van Phuc, Ha Dong, Hanoi',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'SCARVES_ACCESSORIES', 'CUSTOM_DESIGN']::product_category[],
        ARRAY['HANDWOVEN', 'NATURAL_DYED']::product_characteristic[],
        ARRAY['LUXURY']::market_segment[],
        'vanhuc@craftvillage.vn',
        'Weaving & Embroidery Traditional Village',
        'Vietnamese Craft Village Association (VICRAFT)',
        'Naturally dyed silk
Traditional silk fabrics
Plain, embossed, and smooth silk for modern designs
High-quality silk scarves and accessories',
        'Hand-weaving on traditional looms
Using natural dyeing techniques from plants, bark, and leaves
Traditional pattern embroidery
Silk thread spinning',
        'Able to produce 50 meters of silk per week',
        '1 to 2 weeks, depending on design and technique requirements',
        4.8
    ),
    
    -- 2. Cat Dang Lacquerware Village
    (
        (SELECT user_id FROM users WHERE email = 'ninhbinh.lacquer@craftvillage.vn'),
        'Cat Dang Lacquerware Village',
        'Tran Thi Huong',
        '+84 229 3621 456',
        'https://sonmaicatdang.com',
        'Cat Dang Lacquerware Village has over 400 years of history, famous for traditional lacquer techniques combined with exquisite mother-of-pearl inlay. Products range from vases and boxes to artistic paintings.',
        'The Cat Dang lacquer craft was passed down from the Le Dynasty and flourished under the Nguyen Dynasty. Today, artisans still maintain the traditional 20-step technique, with each product requiring 3-6 months to complete.',
        'Traditional Vietnamese Craft Village, National Artisan Award',
        'Cat Dang, Yen Tien, Y Yen, Nam Dinh',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['HOME_DECOR', 'CUSTOM_DESIGN']::product_category[],
        ARRAY['OTHERS']::product_characteristic[],
        ARRAY['LUXURY']::market_segment[],
        'ninhbinh.lacquer@craftvillage.vn',
        'Traditional Lacquerware Village',
        'Vietnam Fine Arts Association',
        'Lacquer paintings and wall art
Decorative vases and boxes
Mother-of-pearl inlay products
Gift items and souvenirs',
        'Traditional 20-step lacquering process
Mother-of-pearl inlay (Khảm trai)
Gold leaf application
Natural lacquer extraction and preparation',
        '100-200 products per month',
        '3 to 6 months for premium lacquer products',
        4.6
    ),
    
    -- 3. Ma Chau Silk Village
    (
        (SELECT user_id FROM users WHERE email = 'hoian.silk@craftvillage.vn'),
        'Ma Chau Silk Village',
        'Le Van Tung',
        '+84 235 3861 789',
        'https://hoiansilk.vn',
        'Ma Chau Silk Village is the cradle of Quang region silk weaving with over 400 years of history. Ma Chau silk stands out for its natural dyeing techniques using local plants.',
        'Since the prosperous days of Hoi An trading port, Ma Chau silk was exported to Japan and Southeast Asian countries. Each product carries the essence of the ancient town and the weaving heritage of Quang region.',
        'Hoi An Cultural Heritage, OCOP 4-star',
        'Duy Trinh, Duy Xuyen, Quang Nam',
        'VILLAGE',
        'CENTRAL_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'RAW_MATERIALS', 'SCARVES_ACCESSORIES']::product_category[],
        ARRAY['HANDWOVEN', 'NATURAL_DYED']::product_characteristic[],
        ARRAY['AFFORDABLE']::market_segment[],
        'hoian.silk@craftvillage.vn',
        'Heritage Silk Weaving Village',
        'Quang Nam Craft Association',
        'Natural dyed silk fabrics
Traditional Ao Dai silk
Silk lanterns and decorations
Custom tailored silk garments',
        'Traditional pit loom weaving
Natural plant-based dyeing
Silk worm breeding and thread extraction
Hand embroidery',
        '300-500 meters per month',
        '2 to 3 weeks for custom orders',
        4.5
    ),
    
    -- 4. Phu Yen Bamboo Weaving Village
    (
        (SELECT user_id FROM users WHERE email = 'phuyen.bamboo@craftvillage.vn'),
        'Phu Yen Bamboo Weaving Village',
        'Nguyen Thi Mai',
        '+84 257 3822 567',
        NULL,
        'Traditional bamboo weaving village producing handicraft products from bamboo and rattan, from household items to high-end interior decorations, all environmentally friendly.',
        'The people of Phu Yen have been connected to bamboo for hundreds of years. Skilled hands have transformed bamboo into works of art, serving daily life while carrying high aesthetic value.',
        'Green Product, Sustainability Certified',
        'An My, Tuy An, Phu Yen',
        'VILLAGE',
        'CENTRAL_VIETNAM',
        ARRAY['HOME_DECOR', 'RAW_MATERIALS']::product_category[],
        ARRAY['ECO_FRIENDLY', 'HANDWOVEN']::product_characteristic[],
        ARRAY['AFFORDABLE', 'LOCALLY_FOCUSED']::market_segment[],
        'phuyen.bamboo@craftvillage.vn',
        'Eco-Friendly Bamboo Craft Village',
        'Vietnam Bamboo Association',
        'Bamboo baskets and containers
Eco-friendly home décor
Artisan bamboo furniture
Traditional household items',
        'Traditional bamboo weaving
Steam bending techniques
Natural bamboo treatment and preservation
Lacquering and finishing',
        'Up to 100 items per week',
        '1 to 3 weeks depending on complexity',
        4.3
    ),
    
    -- 5. Nghe An Hemp Weaving Village
    (
        (SELECT user_id FROM users WHERE email = 'nghean.hemp@craftvillage.vn'),
        'Nghe An Hemp Weaving Village',
        'Hoang Van Duc',
        '+84 238 3855 890',
        NULL,
        'Traditional hemp fabric weaving village of the Thai ethnic group, famous for weaving and embroidery techniques with distinctive patterns. Hemp fabric is cool, durable, and highly absorbent, perfect for tropical weather.',
        'Hemp weaving has been passed down through many generations of Thai people in Nghe An. Each pattern on the fabric tells stories of mountains, forests, life, and beliefs of the ethnic community.',
        'Ethnic Minority Cultural Heritage',
        'Con Cuong, Nghe An',
        'INDIVIDUAL_ARTIST',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'RAW_MATERIALS']::product_category[],
        ARRAY['HANDWOVEN', 'NATURAL_DYED', 'ECO_FRIENDLY']::product_characteristic[],
        ARRAY['AFFORDABLE', 'LOCALLY_FOCUSED']::market_segment[],
        'nghean.hemp@craftvillage.vn',
        'Ethnic Minority Hemp Weaving',
        'Ethnic Minority Cultural Preservation Association',
        'Traditional hemp fabric
Ethnic patterned textiles
Hemp bags and accessories
Custom woven products',
        'Traditional Thai ethnic weaving
Natural dyeing from forest plants
Hand embroidery patterns
Loom weaving techniques',
        '100-200 meters per month',
        '2 to 4 weeks for custom orders',
        4.2
    ),
    
    -- 6. Binh Dinh Rattan Village
    (
        (SELECT user_id FROM users WHERE email = 'binhdinh.rattan@craftvillage.vn'),
        'Binh Dinh Rattan Village',
        'Tran Van Binh',
        '+84 256 3741 234',
        'https://maytrebinhdinh.vn',
        'Rattan and bamboo weaving village with over 200 years of history, specializing in producing furniture, bags, and decorative products from natural rattan and bamboo, exported to many countries.',
        'From humble rattan and bamboo plants, Binh Dinh artisans have created exquisite products that reach the world. The craft village has helped thousands of families achieve stable income.',
        'Export Certified, ISO 9001',
        'Hoai Chau Bac, Hoai Nhon, Binh Dinh',
        'ASSOCIATION',
        'CENTRAL_VIETNAM',
        ARRAY['HOME_DECOR', 'RAW_MATERIALS', 'CUSTOM_DESIGN']::product_category[],
        ARRAY['ECO_FRIENDLY', 'HANDWOVEN']::product_characteristic[],
        ARRAY['EXPORT_ORIENTED']::market_segment[],
        'binhdinh.rattan@craftvillage.vn',
        'Rattan & Bamboo Craft Village',
        'Binh Dinh Craft Association',
        'Rattan furniture and home décor
Bamboo and rattan baskets
Export-quality woven products
Custom design services',
        'Traditional rattan weaving
Bamboo splitting and processing
Natural treatment methods
Modern finishing techniques',
        '500-1000 products per month',
        '2 to 6 weeks depending on order size',
        4.7
    ),
    
    -- 7. Bat Trang Pottery Village
    (
        (SELECT user_id FROM users WHERE email = 'hanoi.pottery@craftvillage.vn'),
        'Bat Trang Pottery Village',
        'Pham Thi Lan',
        '+84 24 3874 5678',
        'https://gombattrang.vn',
        'Bat Trang Pottery Village is famous for traditional ceramic craftsmanship with over 500 years of history, producing everything from household ceramics to high-end artistic ceramics with distinctive regional glazes.',
        'Bat Trang is the most famous ancient pottery village in Vietnam. Since the Ly-Tran Dynasty, Bat Trang ceramics have been exported to many countries. Today, the village combines tradition with modernity to create unique products.',
        'National Intangible Cultural Heritage, OCOP 5-star',
        'Bat Trang, Gia Lam, Hanoi',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['HOME_DECOR', 'CUSTOM_DESIGN']::product_category[],
        ARRAY['OTHERS']::product_characteristic[],
        ARRAY['LUXURY', 'EXPORT_ORIENTED']::market_segment[],
        'hanoi.pottery@craftvillage.vn',
        'Traditional Pottery Village',
        'Bat Trang Ceramic Association',
        'Traditional ceramic vases and pots
Modern tableware and dinnerware
Artistic ceramic sculptures
Custom ceramic designs',
        'Hand throwing on potter''s wheel
Traditional wood-fired kiln techniques
Glaze formulation and application
Hand-painted decorations',
        '1000+ products per month',
        '3 to 8 weeks for custom orders',
        4.9
    ),
    
    -- 8. Tuong Binh Hiep Lacquerware Village
    (
        (SELECT user_id FROM users WHERE email = 'binhduong.lacquer@craftvillage.vn'),
        'Tuong Binh Hiep Lacquerware Village',
        'Nguyen Van Thanh',
        '+84 274 3822 111',
        'https://sonmaibinhduong.com',
        'Tuong Binh Hiep Lacquerware Village is famous for Southern lacquer techniques, combining traditional and modern styles, producing lacquer paintings, decorative items, and high-end gifts.',
        'Binh Duong lacquerware developed from the 19th century, adopting techniques from the North but creating its own Southern style. Products stand out with vibrant colors and rich patterns.',
        'National Traditional Craft Village',
        'Tuong Binh Hiep, Thu Dau Mot, Binh Duong',
        'VILLAGE',
        'SOUTHERN_VIETNAM',
        ARRAY['HOME_DECOR', 'CUSTOM_DESIGN']::product_category[],
        ARRAY['OTHERS']::product_characteristic[],
        ARRAY['LUXURY', 'EXPORT_ORIENTED']::market_segment[],
        'binhduong.lacquer@craftvillage.vn',
        'Modern Lacquerware Village',
        'Binh Duong Craft Association',
        'Contemporary lacquer paintings
Decorative lacquerware
Gift items and souvenirs
Custom lacquer art',
        'Southern lacquer techniques
Eggshell inlay methods
Modern color applications
Eco-friendly finishes',
        '50-100 products per month',
        '2 to 5 months for premium pieces',
        4.4
    );

-- Link villages with materials
INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, '500-1000m/month', '$8-80 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Van Phuc Silk Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, '100-200 products/month', '$20-2000 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Cat Dang Lacquerware Village' AND m.material_name = 'Lacquer';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, '300-500m/month', '$6-60 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Ma Chau Silk Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, '300-500 products/month', '$2-20 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Phu Yen Bamboo Weaving Village' AND m.material_name = 'Bamboo';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, '100-200m/month', '$4-20 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Nghe An Hemp Weaving Village' AND m.material_name = 'Hemp';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, '500-1000 products/month', '$4-200 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Binh Dinh Rattan Village' AND m.material_name = 'Rattan';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, '1000+ products/month', '$1-400 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Bat Trang Pottery Village' AND m.material_name = 'Ceramic';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, '50-100 products/month', '$40-4000 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Tuong Binh Hiep Lacquerware Village' AND m.material_name = 'Lacquer';
*/

-- ============================================================================
-- NEW DATA - Updated Villages Based on JSON
-- ============================================================================

-- Insert sample users for new villages
INSERT INTO users (email, password_hash, user_type, created_at, updated_at)
VALUES 
    ('vanphuc@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('nhaxa@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('namcao@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('phungxa@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('lakhe@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('taphin@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('hoatien@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('aluoi@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('machau@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('baoloc@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('longkhanh@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('chaugiang@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('camne@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('dongcuu@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('zara@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('mybacpathen@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('traset@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('dhoroong@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('banluc@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('ngason@craftvillage.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.', 'VILLAGE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert new craft villages
INSERT INTO craft_villages (
    user_id, village_name, contact_person, phone_number, website_url,
    description, inspirational_story, certifications, location,
    scale, region, 
    categories, characteristics, market_segments,
    email, craft_type, association_membership, key_products, techniques,
    production_capacity, estimated_completion_time, rating, profile_image_url
)
VALUES
    -- 1. Van Phuc Silk Village
    (
        (SELECT user_id FROM users WHERE email = 'vanphuc@craftvillage.vn'),
        'Van Phuc Silk Village',
        'Van Phuc Artisan',
        '+84 24 3354 1111',
        'https://vanphucsilk.vn',
        'The oldest and most renowned silk weaving village in Vietnam, with a history spanning over 1,000 years.',
        'Legend has it that the ancestress A La Thi Nuong taught the villagers to weave a silk so fine it was described as "cool to the touch like human skin." This silk was once chosen to make the Royal attire for the Nguyen Dynasty and remains a symbol of Trang An (Hanoi) elegance.',
        'National Intangible Cultural Heritage; Record for "Oldest operating silk weaving village"',
        'Van Phuc Ward, Ha Dong District, Hanoi',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'SCARVES_ACCESSORIES']::product_category[],
        ARRAY['OTHERS']::product_characteristic[],
        ARRAY['AFFORDABLE', 'LOCALLY_FOCUSED']::market_segment[],
        'vanphuc@craftvillage.vn',
        'Traditional Silk Weaving Village',
        'Vietnamese Craft Village Association (VICRAFT)',
        'Van silk (embossed patterns)
Satin
Gauze
Smooth silk',
        'Manual craftsmanship
Semi-mechanical looms',
        'High production capacity',
        '2 to 3 weeks for standard orders',
        4.8,
        'https://statics.vinpearl.com/van-phuc-silk-village-1_1692883858.jpg'
    ),
    
    -- 2. Nha Xa Silk Weaving Village
    (
        (SELECT user_id FROM users WHERE email = 'nhaxa@craftvillage.vn'),
        'Nha Xa Silk Weaving Village',
        'Nha Xa Artisan',
        '+84 24 3354 2222',
        'https://nhaxasilk.com',
        'Known as the "Runner-up" of the silk trade, second only to Van Phuc. Nha Xa silk is famous for being soft, smooth, and durable.',
        'The craft''s founder was General Tran Khanh Du. Passing through here, he saw fertile land but poor people, so he taught them sericulture. The villagers swore an oath to keep the craft alive through ups and downs.',
        'Typical Traditional Craft Village of Ha Nam Province',
        'Moc Nam Commune, Duy Tien Town, Ha Nam',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE']::product_category[],
        ARRAY['NATURAL_DYED', 'HANDWOVEN']::product_characteristic[],
        ARRAY['EXPORT_ORIENTED', 'LOCALLY_FOCUSED']::market_segment[],
        'nhaxa@craftvillage.vn',
        'Traditional Silk Weaving Village',
        'Ha Nam Craft Association',
        'Mulberry silk
Tussore
Floral silk',
        'Meticulous natural dyeing techniques
Ensures colorfastness',
        'Medium to High production capacity',
        '2 to 4 weeks depending on technique',
        4.6,
        'https://nhaxasilk.com/wp-content/uploads/2021/05/logo-nhaxasilk.png'
    ),
    
    -- 3. Nam Cao Tussore Silk (Dui) Village
    (
        (SELECT user_id FROM users WHERE email = 'namcao@craftvillage.vn'),
        'Nam Cao Tussore Silk (Dui) Village',
        'Nam Cao Artisan',
        '+84 24 3354 3333',
        NULL,
        'Famous for handcrafted Tussore silk (Đũi), a fabric that looks rustic and rough but is incredibly breathable and soft.',
        'While the world chases shiny, smooth silk, Nam Cao artisans stick to the rustic style. Using "over-aged" silkworms, they create a "breathing" fabric that gets softer with every wash, conquering even difficult markets like Western Europe.',
        'National Intangible Cultural Heritage',
        'Nam Cao Commune, Kien Xuong District, Thai Binh',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['RAW_MATERIALS', 'FASHION_TEXTILE']::product_category[],
        ARRAY['ECO_FRIENDLY', 'HANDWOVEN']::product_characteristic[],
        ARRAY['EXPORT_ORIENTED', 'LUXURY']::market_segment[],
        'namcao@craftvillage.vn',
        'Tussore Silk Weaving Village',
        'Thai Binh Craft Association',
        'Raw Tussore fabric
Scarves
Clothing',
        '100% hand-spun
100% hand-woven',
        'Medium production capacity',
        '3 to 5 weeks for custom orders',
        4.7,
        'https://vnn-imgs-f.vgcloud.vn/2021/12/08/09/northern-village-finds-its-silk-saviour.jpg?width=0&s=clI51oMKHb6AOGVr3F6JTw'
    ),
    
    -- 4. Phung Xa Craft Village
    (
        (SELECT user_id FROM users WHERE email = 'phungxa@craftvillage.vn'),
        'Phung Xa Craft Village',
        'Phan Thi Thuan',
        '+84 24 3354 4444',
        NULL,
        'Famous for innovation: Weaving silk from Lotus stems and "self-weaving" silkworm blankets.',
        'Artisan Phan Thi Thuan spent her life researching how to extract fibers from lotus stems—previously considered waste—to weave scarves worth thousands of dollars, elevating Vietnamese silk to a new level of luxury.',
        'Meritorious Artisan; 5-Star National OCOP Product',
        'Phung Xa Commune, My Duc District, Hanoi',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'HOME_DECOR']::product_category[],
        ARRAY['ECO_FRIENDLY', 'HANDWOVEN']::product_characteristic[],
        ARRAY['LUXURY']::market_segment[],
        'phungxa@craftvillage.vn',
        'Innovative Silk Craft Village',
        'Hanoi Craft Association',
        'Lotus silk
Self-woven silk blankets',
        'Extremely labor-intensive lotus fiber extraction',
        'Small (Luxury/Limited)',
        '6 to 12 weeks for luxury products',
        4.9,
        'https://imgs.search.brave.com/L6amQ9x_ITHQkqxSFAJPg2r_zgBOFpHq-64zbSoakAo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dmlldGdvdHJhdmVs/cy5jb20vd3AtY29u/dGVudC9zbXVzaC13/ZWJwLzIwMjUvMDQv/YmFuLXBodW5nLXZp/bGxhZ2UteGEtYmFu/LXBodW5nLTIuanBn/LndlYnA'
    ),
    
    -- 5. La Khe The Weaving Village
    (
        (SELECT user_id FROM users WHERE email = 'lakhe@craftvillage.vn'),
        'La Khe The Weaving Village',
        'La Khe Artisan',
        '+84 24 3354 5555',
        NULL,
        'Specializes in "The" and "Sa" fabrics—sheer, light, transparent yet durable materials used for traditional Ao Dai layering.',
        'The craft was nearly lost due to its difficulty. Old artisans had to restore ancient looms to revive these fabrics, described as "thin as a dragonfly''s wing," preserving the noble beauty of ancient Hanoians.',
        'Cultural Craft Village Heritage',
        'La Khe Ward, Ha Dong District, Hanoi',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'CUSTOM_DESIGN']::product_category[],
        ARRAY['HANDWOVEN', 'OTHERS']::product_characteristic[],
        ARRAY['LUXURY']::market_segment[],
        'lakhe@craftvillage.vn',
        'Traditional Sheer Fabric Weaving',
        'Hanoi Heritage Craft Association',
        'The fabric
Sa fabric
Xuyen fabric',
        'Complex perforated weaving technique
Creates ventilation holes',
        'Small (Revival Stage)',
        '4 to 8 weeks for custom orders',
        4.5,
        'https://images.vietnamtourism.gov.vn/en//images/2024/oct/241011-103710-1.png'
    ),
    
    -- 6. Ta Phin Brocade Village
    (
        (SELECT user_id FROM users WHERE email = 'taphin@craftvillage.vn'),
        'Ta Phin Brocade Village',
        'Red Dao Artisan',
        '+84 24 3354 6666',
        NULL,
        'A Red Dao village distinguished by vibrant, dense hand-embroidery on dark indigo backgrounds.',
        'Red Dao women embroider everywhere: in the fields, while carrying babies, or selling goods. A single outfit takes a year to complete. Each stitch is a prayer for luck and a ward against evil spirits.',
        'Traditional Craft Village for Tourism',
        'Ta Phin Commune, Sa Pa Town, Lao Cai',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'SCARVES_ACCESSORIES']::product_category[],
        ARRAY['HANDWOVEN', 'NATURAL_DYED']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'AFFORDABLE']::market_segment[],
        'taphin@craftvillage.vn',
        'Ethnic Brocade Craft Village',
        'Lao Cai Tourism Craft Association',
        'Brocade clothing
Backpacks
Wallets
Scarves',
        'Unique cross-stitch technique
Hand embroidery',
        'Medium production capacity',
        '4 to 12 months for traditional outfits',
        4.4,
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQI67NLhoTSBbVpe7-EBd-_x6EYviYdJrBQw&s'
    ),
    
    -- 7. Hoa Tien Craft Village
    (
        (SELECT user_id FROM users WHERE email = 'hoatien@craftvillage.vn'),
        'Hoa Tien Craft Village',
        'Hoa Tien Artisan',
        '+84 24 3354 7777',
        'https://hoatienbrocade.vn',
        'Famous for the Ikat technique and ancient Thai skirts.',
        'Hoa Tien is the cradle of Nghe An brocade. Locals have revived natural dyeing techniques using roots and bark from the forest to create warm, safe colors that industrial fabrics cannot replicate.',
        'Excellent Handicraft Cooperative',
        'Chau Tien Commune, Quy Chau District, Nghe An',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'HOME_DECOR']::product_category[],
        ARRAY['NATURAL_DYED', 'HANDWOVEN']::product_characteristic[],
        ARRAY['EXPORT_ORIENTED', 'LUXURY']::market_segment[],
        'hoatien@craftvillage.vn',
        'Traditional Brocade Craft Village',
        'Nghe An Craft Association',
        'Thai skirts
Scarves
Interior decor fabric',
        'Natural dyeing
Ikat weaving',
        'Medium production capacity',
        '3 to 6 weeks for custom orders',
        4.5,
        'https://hoatienbrocade.vn/wp-content/uploads/2020/01/2f4568b433b6cbe892a7.jpg'
    ),
    
    -- 8. A Luoi District Villages (A Roang)
    (
        (SELECT user_id FROM users WHERE email = 'aluoi@craftvillage.vn'),
        'A Luoi District Villages (A Roang)',
        'Ta Oi Artisan',
        '+84 24 3354 8888',
        NULL,
        'The Ta Oi people''s unique "Zeng" weaving involves weaving beads directly into the fabric structure.',
        'Without bulky looms, the Ta Oi use their legs and backs to tension the fabric (backstrap loom). Beads are skillfully interwoven to create raised patterns, serving as essential offerings in major tribal rituals.',
        'National Intangible Cultural Heritage',
        'A Luoi District, Thua Thien Hue',
        'VILLAGE',
        'CENTRAL_VIETNAM',
        ARRAY['CUSTOM_DESIGN', 'FASHION_TEXTILE']::product_category[],
        ARRAY['HANDWOVEN']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'LUXURY']::market_segment[],
        'aluoi@craftvillage.vn',
        'Ethnic Beaded Weaving Village',
        'Thua Thien Hue Cultural Association',
        'Zeng fabric panels
Traditional costumes
Fashion accessories',
        'Beaded weaving technique
Backstrap loom weaving',
        'Small to Medium production capacity',
        '6 to 10 weeks for custom pieces',
        4.6,
        'https://vstatic.vietnam.vn/vietnam/resource/IMAGE/2025/1/18/0edbf5abe5a94b12af44584338fe9ef6'
    ),
    
    -- 9. Ma Chau Silk Village
    (
        (SELECT user_id FROM users WHERE email = 'machau@craftvillage.vn'),
        'Ma Chau Silk Village',
        'Ma Chau Artisan',
        '+84 24 3354 9999',
        NULL,
        'A royal silk weaving village in Quang Nam dating back to the 16th century.',
        'Once the exclusive silk supplier for the Nguyen nobility, Ma Chau went through a period of growing cotton but has now returned to traditional sericulture, reviving the renowned silk lines of the past.',
        'Traditional Craft Village of Quang Nam Province',
        'Nam Phuoc Town, Duy Xuyen District, Quang Nam',
        'VILLAGE',
        'CENTRAL_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'RAW_MATERIALS']::product_category[],
        ARRAY['HANDWOVEN', 'NATURAL_DYED']::product_characteristic[],
        ARRAY['LUXURY', 'EXPORT_ORIENTED']::market_segment[],
        'machau@craftvillage.vn',
        'Royal Silk Weaving Village',
        'Quang Nam Craft Association',
        'Mulberry silk
Linen
Handcrafted cotton',
        'Traditional silk weaving
Natural dyeing techniques',
        'Large production capacity',
        '2 to 4 weeks for orders',
        4.7,
        'https://vnn-imgs-a1.vgcloud.vn/en.nhandan.com.vn/cdn/en/media/k2/items/src/783/6942630c46259fdf359c4a02142d51e4.jpg?width=0&s=SkywSY2T9pC50EMi5OfIPg'
    ),
    
    -- 10. Bao Loc City Area
    (
        (SELECT user_id FROM users WHERE email = 'baoloc@craftvillage.vn'),
        'Bao Loc City Area (Cluster of factories/villages)',
        'Bao Loc Representative',
        '+84 24 3355 0000',
        NULL,
        '"The Silk Capital of Vietnam," producing the majority of the country''s high-end silk output.',
        'The year-round temperate climate of the B''lao highland allows silkworms to produce the highest quality threads in the world. Bao Loc represents the intersection of traditional weaving and modern Japanese/Korean technology.',
        '"Bao Loc Silk" Geographical Indication protection',
        'Bao Loc City, Lam Dong',
        'ASSOCIATION',
        'SOUTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'RAW_MATERIALS']::product_category[],
        ARRAY['OTHERS']::product_characteristic[],
        ARRAY['EXPORT_ORIENTED', 'LUXURY']::market_segment[],
        'baoloc@craftvillage.vn',
        'Modern Silk Production Hub',
        'Lam Dong Silk Association',
        'Raw silk
Satin
Yoryu
High-end Jacquard',
        'Modern Japanese/Korean silk production technology
Industrial scale manufacturing',
        'Very Large (Export Scale)',
        '1 to 2 weeks for bulk orders',
        4.8,
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGJzIJ_wxvpFVF6_BGSfVR17O9M5lao3m3sw&s'
    ),
    
    -- 11. Long Khanh Scarf Weaving Village
    (
        (SELECT user_id FROM users WHERE email = 'longkhanh@craftvillage.vn'),
        'Long Khanh Scarf Weaving Village',
        'Long Khanh Artisan',
        '+84 24 3355 1111',
        NULL,
        'The production hub of "Khan Ran" (checkered scarf) – the cultural icon of Southern Vietnam people.',
        'For 100 years, the sound of shuttles has echoed by the Tien River. From the traditional black-and-white labor scarf, Long Khanh people have created hundreds of new colors, turning a humble item into a fashion accessory.',
        'National Intangible Cultural Heritage',
        'Long Khanh A Commune, Hong Ngu District, Dong Thap',
        'VILLAGE',
        'SOUTHERN_VIETNAM',
        ARRAY['SCARVES_ACCESSORIES']::product_category[],
        ARRAY['OTHERS']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'AFFORDABLE']::market_segment[],
        'longkhanh@craftvillage.vn',
        'Traditional Scarf Weaving Village',
        'Dong Thap Craft Association',
        'Khan Ran (checkered scarf)
Ba Ba shirts
Striped fabric',
        'Semi-mechanical weaving
Manual weaving',
        'Large production capacity',
        '1 to 2 weeks for standard orders',
        4.5,
        'https://vstatic.vietnam.vn/vietnam/happy/2025/THUMP_PHOTO_ALBUM/2025/09/14/2025_THUMP_PHOTO_ALBUM_17792_3c57f896fce9444d8fd3d5ce2eea6fb7_khan-ran-long-khanh-niem-tu-hao-di-san.jpeg'
    ),
    
    -- 12. Chau Giang Cham Village (Phum Xoai)
    (
        (SELECT user_id FROM users WHERE email = 'chaugiang@craftvillage.vn'),
        'Chau Giang Cham Village (Phum Xoai)',
        'Cham Artisan',
        '+84 24 3355 2222',
        NULL,
        'A Muslim Cham community combining brocade weaving with unique embroidery.',
        'Cham Islam women rarely venture far, pouring their thoughts and souls into their looms. Their brocade products feature an interesting cultural fusion with elegant patterns, often used for Mat''ra (headscarves) and Sarongs.',
        'An Giang Community Tourism Destination',
        'Chau Phong Commune, Tan Chau Town, An Giang',
        'VILLAGE',
        'SOUTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE', 'SCARVES_ACCESSORIES']::product_category[],
        ARRAY['HANDWOVEN']::product_characteristic[],
        ARRAY['EXPORT_ORIENTED', 'LOCALLY_FOCUSED']::market_segment[],
        'chaugiang@craftvillage.vn',
        'Cham Brocade Weaving Village',
        'An Giang Craft Association',
        'Brocade fabric
Scarves
Sarongs',
        'Brocade weaving
Gold thread embroidery',
        'Medium production capacity',
        '3 to 5 weeks for custom orders',
        4.4,
        'https://lvtravel.vn/uploads/content/2023/12-2023/71bacdec38d0860ae472099e9d92a8d0.jpeg'
    ),
    
    -- 13. Cam Ne Mat Village
    (
        (SELECT user_id FROM users WHERE email = 'camne@craftvillage.vn'),
        'Cam Ne Mat Village',
        'Cam Ne Artisan',
        '+84 24 3355 3333',
        NULL,
        'Although specializing in mats, the weaving and dyeing techniques here are akin to fabric weaving, creating soft interior textiles.',
        'Cam Ne mats were once used in the Hue Royal Court. Artisans use a deep-dyeing technique for reeds and a thick weave structure, making mats that are cool in summer and warm in winter.',
        'Intangible Cultural Heritage',
        'Hoa Tien Commune, Hoa Vang District, Da Nang',
        'VILLAGE',
        'CENTRAL_VIETNAM',
        ARRAY['HOME_DECOR']::product_category[],
        ARRAY['HANDWOVEN', 'NATURAL_DYED']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'AFFORDABLE']::market_segment[],
        'camne@craftvillage.vn',
        'Traditional Mat Weaving Village',
        'Da Nang Craft Association',
        'Floral mats
Woven wall hangings',
        'Deep-dyeing technique for reeds
Thick weave structure',
        'Medium production capacity',
        '2 to 3 weeks for orders',
        4.3,
        'https://danangfantasticity.com/wp-content/uploads/2015/09/chieu-cam-ne.jpg'
    ),
    
    -- 14. Dong Cuu Embroidery Village
    (
        (SELECT user_id FROM users WHERE email = 'dongcuu@craftvillage.vn'),
        'Dong Cuu Embroidery Village',
        'Dong Cuu Artisan',
        '+84 24 3355 4444',
        NULL,
        'The only village specializing in embroidering royal costumes (Dragon robes) and religious parasols (Lọng) for festivals.',
        'While other villages embroider landscapes, Dong Cuu holds the strict rules of feudal hierarchy. Every dragon scale and phoenix feather must follow precise ancient regulations. They are the primary restorers for museum costumes and temple artifacts.',
        'National Intangible Cultural Heritage',
        'Dung Tien Commune, Thuong Tin District, Hanoi',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['CUSTOM_DESIGN']::product_category[],
        ARRAY['OTHERS']::product_characteristic[],
        ARRAY['LUXURY']::market_segment[],
        'dongcuu@craftvillage.vn',
        'Royal Embroidery Craft Village',
        'Hanoi Heritage Craft Association',
        'Royal robes reproductions
Festival flags
Altar curtains',
        'Gold/silver thread embroidery (Kim Hoan)
Ancient royal embroidery regulations',
        'Small (Specialized/Niche)',
        '8 to 16 weeks for specialized pieces',
        4.9,
        'https://dantocmiennui-media.baotintuc.vn/images/57c5aab70c5efc5a98d240302ffc6edba9999057ead28c855dd949345095ac54e3c6882c93754f2c0f1b9c7fcdb87290/theu-4-1.jpg'
    ),
    
    -- 15. Zara Weaving Village
    (
        (SELECT user_id FROM users WHERE email = 'zara@craftvillage.vn'),
        'Zara Weaving Village',
        'Bahnar Artisan',
        '+84 24 3355 5555',
        NULL,
        'A representative weaving village of the Bahnar ethnic group in the Central Highlands.',
        'Bahnar women weave without a fixed wooden frame, using their own bodies and legs to stretch the loom (waist-loom). The patterns reflect the Bahnar worldview: the sun, the river, and the communal house (Nha Rong). The clatter of the loom is considered the "heartbeat" of the village.',
        'Cultural Tourism Destination',
        'Tabet Commune, Kon Tum City, Kon Tum',
        'VILLAGE',
        'SOUTHERN_VIETNAM',
        ARRAY['HOME_DECOR', 'FASHION_TEXTILE']::product_category[],
        ARRAY['HANDWOVEN']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'AFFORDABLE']::market_segment[],
        'zara@craftvillage.vn',
        'Bahnar Ethnic Weaving Village',
        'Kon Tum Cultural Association',
        'Bahnar skirts
Blankets
Festive decorations',
        'Waist-loom weaving
Traditional Bahnar patterns (black, red, yellow)',
        'Small (Household scale)',
        '4 to 8 weeks for traditional items',
        4.2,
        'https://vwu.vn/documents/20182/2567114/12_Nov_2020_143445_GMThtx_zara.jpg'
    ),
    
    -- 16. My Bac Pa Then Village
    (
        (SELECT user_id FROM users WHERE email = 'mybacpathen@craftvillage.vn'),
        'My Bac Pa Then Village',
        'Pa Then Artisan',
        '+84 24 3355 6666',
        NULL,
        'The Pa Then people are famous for their "Fire Dance" and their equally fiery red traditional costumes.',
        'The Pa Then costume looks like a bird of fire. The weaving technique is complex, involving embroidery directly upon the loom (woven-in patterns). The vibrant red color symbolizes the Fire God''s protection and the vitality of the ethnic group.',
        'National Intangible Cultural Heritage',
        'Tan Trinh Commune, Quang Binh District, Ha Giang/Tuyen Quang border',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['CUSTOM_DESIGN', 'FASHION_TEXTILE']::product_category[],
        ARRAY['HANDWOVEN']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'LUXURY']::market_segment[],
        'mybacpathen@craftvillage.vn',
        'Pa Then Ethnic Brocade Village',
        'Ha Giang Cultural Association',
        'Complex brocade costumes
Headscarves',
        'Woven-in pattern embroidery
Bright red dominant color',
        'Small production capacity',
        '10 to 20 weeks for traditional costumes',
        4.6,
        'https://langngheviet.com.vn/stores/news_dataimages/2024/032024/25/17/1020240325170903.jpg'
    ),
    
    -- 17. Tra Set Silk Village (Vinh Chau)
    (
        (SELECT user_id FROM users WHERE email = 'traset@craftvillage.vn'),
        'Tra Set Silk Village (Vinh Chau)',
        'Khmer Artisan',
        '+84 24 3355 7777',
        NULL,
        'A unique silk weaving village of the Khmer ethnic minority in the Mekong Delta.',
        'Unlike the Cham or Viet, Khmer silk (Lụa Lãnh) has unique multi-colored Ikat patterns influenced by Indian and Cambodian culture. The craft was revived to provide jobs for Khmer women during the flood season, preserving the technique of dyeing silk with local berries.',
        'Provincial Traditional Craft Recognition',
        'Vinh Chau Town, Soc Trang',
        'VILLAGE',
        'SOUTHERN_VIETNAM',
        ARRAY['SCARVES_ACCESSORIES', 'FASHION_TEXTILE']::product_category[],
        ARRAY['NATURAL_DYED', 'HANDWOVEN']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'LUXURY']::market_segment[],
        'traset@craftvillage.vn',
        'Khmer Silk Weaving Village',
        'Soc Trang Craft Association',
        'Khmer silk scarves
Sarongs',
        'Ikat dyeing technique
Local berry dyeing',
        'Small production capacity',
        '4 to 6 weeks for custom orders',
        4.5,
        'https://media-cdn-v2.laodong.vn/Storage/newsportal/2018/6/1/610388/12-13-An-Giang-DT-00-06.jpg'
    ),
    
    -- 18. Dho Roong / Zara (Ka Tu)
    (
        (SELECT user_id FROM users WHERE email = 'dhoroong@craftvillage.vn'),
        'Dho Roong / Zara (Ka Tu)',
        'Ka Tu Artisan',
        '+84 24 3355 8888',
        NULL,
        'The Ka Tu people are famous for "Cườm" (bead) weaving, similar to the Ta Oi but with distinct patterns.',
        'Ka Tu weaving is a mathematics marvel. Artisans weave white lead beads into the cotton thread structure to create patterns of humans and geometry. It is said that a Ka Tu girl weaves her own wedding dress to show her worth to her future husband.',
        'Intangible Cultural Heritage',
        'Dong Giang/Nam Giang Districts, Quang Nam',
        'VILLAGE',
        'CENTRAL_VIETNAM',
        ARRAY['CUSTOM_DESIGN', 'FASHION_TEXTILE']::product_category[],
        ARRAY['OTHERS']::product_characteristic[],
        ARRAY['LUXURY', 'LOCALLY_FOCUSED']::market_segment[],
        'dhoroong@craftvillage.vn',
        'Ka Tu Beaded Weaving Village',
        'Quang Nam Cultural Association',
        'Beaded loincloths
Skirts (Yem)',
        'Backstrap loom with bead insertion
White lead bead weaving',
        'Small to Medium production capacity',
        '8 to 12 weeks for custom pieces',
        4.7,
        'https://langngheviet.com.vn/stores/news_dataimages/langnghevietcomvn/042022/21/10/nghe-det-tho-cam-cua-nguoi-co-tu-28-.8195.jpg'
    ),
    
    -- 19. Ban Luc Village (Ban Hon)
    (
        (SELECT user_id FROM users WHERE email = 'banluc@craftvillage.vn'),
        'Ban Luc Village (Ban Hon)',
        'Lu Artisan',
        '+84 24 3355 9999',
        NULL,
        'Home to the Lu ethnic group, known for their black teeth and incredibly detailed weaving.',
        'The Lu women sit at floor looms (not backstrap), weaving intricate diamond patterns. Their technique is so advanced they can weave distinct upper and lower garment patterns in one go. The fabric is often adorned with old coins and silver, making it heavy and precious.',
        'Community Tourism Destination',
        'Ban Hon Commune, Tam Duong District, Lai Chau',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['FASHION_TEXTILE']::product_category[],
        ARRAY['NATURAL_DYED', 'HANDWOVEN']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'AFFORDABLE']::market_segment[],
        'banluc@craftvillage.vn',
        'Lu Ethnic Weaving Village',
        'Lai Chau Cultural Association',
        'Indigo fabric with diamond patterns
Headscarves',
        'Floor loom weaving
Intricate diamond patterns
Silver and coin adornment',
        'Small (Cultural)',
        '6 to 10 weeks for traditional items',
        4.3,
        'https://file3.qdnd.vn/data/images/0/2022/09/04/thuthuytv/2.jpg?dpi=150&quality=100&w=870'
    ),
    
    -- 20. Nga Son Mat Village
    (
        (SELECT user_id FROM users WHERE email = 'ngason@craftvillage.vn'),
        'Nga Son Mat Village',
        'Nga Son Artisan',
        '+84 24 3356 0000',
        NULL,
        'Famous for the folk verse "Nga Son mats, Bat Trang bricks." While it is sedge (cói), the weaving technique is comparable to textiles.',
        'Nga Son connects the sea and the land. Farmers grow sedge on saline soil, then weave it into mats that are legendary for their durability and beauty. The "double weaving" technique creates mats with intricate characters and happiness symbols for weddings.',
        'Geographical Indication "Nga Son"',
        'Nga Son District, Thanh Hoa',
        'VILLAGE',
        'NORTHERN_VIETNAM',
        ARRAY['HOME_DECOR', 'RAW_MATERIALS']::product_category[],
        ARRAY['ECO_FRIENDLY', 'HANDWOVEN']::product_characteristic[],
        ARRAY['LOCALLY_FOCUSED', 'AFFORDABLE']::market_segment[],
        'ngason@craftvillage.vn',
        'Traditional Sedge Mat Village',
        'Thanh Hoa Craft Association',
        'Sedge mats
Sedge bags
Handicrafts',
        'Double weaving technique
Intricate character patterns
Wedding happiness symbols',
        'Very Large',
        '1 to 2 weeks for standard orders',
        4.4,
        'https://file.36.com.vn/2025/09/17/lang-nghe-det-chieu-10.jpg'
    );

-- Link villages with materials (Silk villages with Silk material)
INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'High', '$10-100 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Van Phuc Silk Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Medium-High', '$12-120 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Nha Xa Silk Weaving Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Medium', '$15-150 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Nam Cao Tussore Silk (Dui) Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small', '$500-5000 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Phung Xa Craft Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small', '$20-200 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'La Khe The Weaving Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Medium', '$8-80 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Ta Phin Brocade Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Medium', '$15-120 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Hoa Tien Craft Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small-Medium', '$30-300 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'A Luoi District Villages (A Roang)' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Large', '$20-200 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Ma Chau Silk Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Very Large', '$25-250 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Bao Loc City Area (Cluster of factories/villages)' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Large', '$3-30 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Long Khanh Scarf Weaving Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Medium', '$10-100 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Chau Giang Cham Village (Phum Xoai)' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Medium', '$5-50 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Cam Ne Mat Village' AND m.material_name = 'Rattan';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small', '$200-2000 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Dong Cuu Embroidery Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small', '$8-80 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Zara Weaving Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small', '$50-500 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'My Bac Pa Then Village' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small', '$15-150 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Tra Set Silk Village (Vinh Chau)' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small-Medium', '$40-400 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Dho Roong / Zara (Ka Tu)' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Small', '$10-100 USD/m'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Ban Luc Village (Ban Hon)' AND m.material_name = 'Silk';

INSERT INTO village_materials (village_id, material_id, production_capacity, price_range)
SELECT cv.village_id, m.material_id, 'Very Large', '$2-20 USD/product'
FROM craft_villages cv, materials m
WHERE cv.village_name = 'Nga Son Mat Village' AND m.material_name = 'Rattan';
