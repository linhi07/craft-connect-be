-- V7: Add new fields for village detail page
ALTER TABLE craft_villages
ADD COLUMN IF NOT EXISTS profile_image_url VARCHAR(500),
ADD COLUMN IF NOT EXISTS email VARCHAR(255),
ADD COLUMN IF NOT EXISTS craft_type VARCHAR(255),
ADD COLUMN IF NOT EXISTS association_membership VARCHAR(255),
ADD COLUMN IF NOT EXISTS key_products TEXT,
ADD COLUMN IF NOT EXISTS techniques TEXT,
ADD COLUMN IF NOT EXISTS production_capacity VARCHAR(500),
ADD COLUMN IF NOT EXISTS estimated_completion_time VARCHAR(255);

-- =============================================================================
-- Sample data for all existing villages
-- =============================================================================

-- 1. Van Phuc Silk Village
UPDATE craft_villages
SET
    email = 'vanhuc@craftvillage.vn',
    craft_type = 'Weaving & Embroidery Traditional Village',
    association_membership = 'Vietnamese Craft Village Association (VICRAFT)',
    key_products = 'Naturally dyed silk
Traditional silk fabrics
Plain, embossed, and smooth silk for modern designs
High-quality silk scarves and accessories',
    techniques = 'Hand-weaving on traditional looms
Using natural dyeing techniques from plants, bark, and leaves
Traditional pattern embroidery
Silk thread spinning',
    production_capacity = 'Able to produce 50 meters of silk per week',
    estimated_completion_time = '1 to 2 weeks, depending on design and technique requirements'
WHERE
    village_name = 'Van Phuc Silk Village';

-- 2. Cat Dang Lacquerware Village
UPDATE craft_villages
SET
    email = 'ninhbinh.lacquer@craftvillage.vn',
    craft_type = 'Traditional Lacquerware Village',
    association_membership = 'Vietnam Fine Arts Association',
    key_products = 'Lacquer paintings and wall art
Decorative vases and boxes
Mother-of-pearl inlay products
Gift items and souvenirs',
    techniques = 'Traditional 20-step lacquering process
Mother-of-pearl inlay (Khảm trai)
Gold leaf application
Natural lacquer extraction and preparation',
    production_capacity = '100-200 products per month',
    estimated_completion_time = '3 to 6 months for premium lacquer products'
WHERE
    village_name = 'Cat Dang Lacquerware Village';

-- 3. Ma Chau Silk Village
UPDATE craft_villages
SET
    email = 'hoian.silk@craftvillage.vn',
    craft_type = 'Heritage Silk Weaving Village',
    association_membership = 'Quang Nam Craft Association',
    key_products = 'Natural dyed silk fabrics
Traditional Ao Dai silk
Silk lanterns and decorations
Custom tailored silk garments',
    techniques = 'Traditional pit loom weaving
Natural plant-based dyeing
Silk worm breeding and thread extraction
Hand embroidery',
    production_capacity = '300-500 meters per month',
    estimated_completion_time = '2 to 3 weeks for custom orders'
WHERE
    village_name = 'Ma Chau Silk Village';

-- 4. Phu Yen Bamboo Weaving Village
UPDATE craft_villages
SET
    email = 'phuyen.bamboo@craftvillage.vn',
    craft_type = 'Eco-Friendly Bamboo Craft Village',
    association_membership = 'Vietnam Bamboo Association',
    key_products = 'Bamboo baskets and containers
Eco-friendly home décor
Artisan bamboo furniture
Traditional household items',
    techniques = 'Traditional bamboo weaving
Steam bending techniques
Natural bamboo treatment and preservation
Lacquering and finishing',
    production_capacity = 'Up to 100 items per week',
    estimated_completion_time = '1 to 3 weeks depending on complexity'
WHERE
    village_name = 'Phu Yen Bamboo Weaving Village';

-- 5. Nghe An Hemp Weaving Village
UPDATE craft_villages
SET
    email = 'nghean.hemp@craftvillage.vn',
    craft_type = 'Ethnic Minority Hemp Weaving',
    association_membership = 'Ethnic Minority Cultural Preservation Association',
    key_products = 'Traditional hemp fabric
Ethnic patterned textiles
Hemp bags and accessories
Ceremonial garments',
    techniques = 'Traditional backstrap loom weaving
Natural hemp fiber processing
Ethnic pattern embroidery
Batik and indigo dyeing',
    production_capacity = '100-200 meters per month',
    estimated_completion_time = '3 to 4 weeks for custom pieces'
WHERE
    village_name = 'Nghe An Hemp Weaving Village';

-- 6. Binh Dinh Rattan Village
UPDATE craft_villages
SET
    email = 'binhdinh.rattan@craftvillage.vn',
    craft_type = 'Rattan & Bamboo Export Village',
    association_membership = 'Vietnam Handicraft Exporters Association (VIETCRAFT)',
    key_products = 'Rattan furniture
Designer storage baskets
Home décor accessories
Export-quality woven products',
    techniques = 'Traditional rattan weaving
Contemporary design integration
Quality control for export standards
Eco-friendly finishing',
    production_capacity = '500-1000 products per month',
    estimated_completion_time = '2 to 4 weeks for bulk orders'
WHERE
    village_name = 'Binh Dinh Rattan Village';

-- 7. Bat Trang Pottery Village
UPDATE craft_villages
SET
    email = 'hanoi.pottery@craftvillage.vn',
    craft_type = 'Traditional Pottery Village',
    association_membership = 'Vietnam Ceramics Association',
    key_products = 'Traditional Vietnamese ceramics
Decorative pottery and vases
Custom-designed tableware
Artistic sculptures',
    techniques = 'Hand-thrown pottery
Traditional kiln firing
Natural glaze techniques
Underglaze painting',
    production_capacity = 'Up to 1000+ pieces per month',
    estimated_completion_time = '2 to 4 weeks for custom orders'
WHERE
    village_name = 'Bat Trang Pottery Village';

-- 8. Tuong Binh Hiep Lacquerware Village
UPDATE craft_villages
SET
    email = 'binhduong.lacquer@craftvillage.vn',
    craft_type = 'Southern Lacquerware Art Village',
    association_membership = 'Vietnam Fine Arts Association',
    key_products = 'Contemporary lacquer paintings
High-end gift items
Decorative furniture
Corporate awards and trophies',
    techniques = 'Southern lacquer tradition
Modern artistic techniques
Eggshell inlay (Khảm trứng)
Abstract and contemporary styles',
    production_capacity = '50-100 products per month',
    estimated_completion_time = '1 to 3 months for art pieces'
WHERE
    village_name = 'Tuong Binh Hiep Lacquerware Village';