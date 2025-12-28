-- =============================================================================
-- V4__auto_create_designer_profiles.sql
-- Auto-create Designer profile for any user with user_type='DESIGNER' who doesn't have one
-- This ensures referential integrity for any future designer user registrations
-- =============================================================================

-- Create a function to automatically create designer profile when a DESIGNER user is created
CREATE OR REPLACE FUNCTION auto_create_designer_profile()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.user_type = 'DESIGNER' THEN
        INSERT INTO designers (user_id, designer_name)
        VALUES (
            NEW.user_id,
            COALESCE(
                -- Extract name from email (before @, replace dots with spaces)
                INITCAP(REPLACE(SPLIT_PART(NEW.email, '@', 1), '.', ' ')),
                'Designer'
            )
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to run after user insert
CREATE TRIGGER trigger_auto_create_designer_profile
AFTER INSERT ON users
FOR EACH ROW
WHEN (NEW.user_type = 'DESIGNER')
EXECUTE FUNCTION auto_create_designer_profile();

-- Backfill for any existing DESIGNER users without profiles
INSERT INTO designers (user_id, designer_name)
SELECT 
    u.user_id,
    COALESCE(
        INITCAP(REPLACE(SPLIT_PART(u.email, '@', 1), '.', ' ')),
        'Designer'
    )
FROM users u
LEFT JOIN designers d ON d.user_id = u.user_id
WHERE u.user_type = 'DESIGNER' AND d.designer_id IS NULL;
