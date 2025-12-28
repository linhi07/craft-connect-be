-- V8: Add rating field to craft villages
ALTER TABLE craft_villages
ADD COLUMN IF NOT EXISTS rating DOUBLE PRECISION;

-- Add sample ratings for existing villages (on a scale of 0.0 to 5.0)
UPDATE craft_villages
SET
    rating = 4.8
WHERE
    village_name = 'Van Phuc Silk Village';

UPDATE craft_villages
SET
    rating = 4.6
WHERE
    village_name = 'Cat Dang Lacquerware Village';

UPDATE craft_villages
SET
    rating = 4.5
WHERE
    village_name = 'Ma Chau Silk Village';

UPDATE craft_villages
SET
    rating = 4.3
WHERE
    village_name = 'Phu Yen Bamboo Weaving Village';

UPDATE craft_villages
SET
    rating = 4.2
WHERE
    village_name = 'Nghe An Hemp Weaving Village';

UPDATE craft_villages
SET
    rating = 4.7
WHERE
    village_name = 'Binh Dinh Rattan Village';

UPDATE craft_villages
SET
    rating = 4.9
WHERE
    village_name = 'Bat Trang Pottery Village';

UPDATE craft_villages
SET
    rating = 4.4
WHERE
    village_name = 'Tuong Binh Hiep Lacquerware Village';