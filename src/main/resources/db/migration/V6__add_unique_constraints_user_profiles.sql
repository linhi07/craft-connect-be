-- =============================================================================
-- V5__add_unique_constraints_user_profiles.sql
-- Add unique constraints on user_id for designers and craft_villages tables
-- This prevents duplicate profiles for the same user
-- =============================================================================

-- Clean up any duplicate designers (keep the first one, delete others)
DELETE FROM designers d1
USING designers d2
WHERE d1.designer_id > d2.designer_id 
  AND d1.user_id = d2.user_id;

-- Clean up any duplicate craft_villages (keep the first one, delete others)
DELETE FROM craft_villages cv1
USING craft_villages cv2
WHERE cv1.village_id > cv2.village_id 
  AND cv1.user_id = cv2.user_id;

-- Add unique constraint to designers.user_id
ALTER TABLE designers
ADD CONSTRAINT uq_designers_user_id UNIQUE (user_id);

-- Add unique constraint to craft_villages.user_id
ALTER TABLE craft_villages
ADD CONSTRAINT uq_craft_villages_user_id UNIQUE (user_id);
