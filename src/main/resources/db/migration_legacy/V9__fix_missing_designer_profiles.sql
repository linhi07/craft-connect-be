-- V9: Fix missing Designer profiles for existing DESIGNER users
-- Auto-create Designer profile for any user with userType=DESIGNER who doesn't have one

INSERT INTO
    designers (user_id, designer_name)
SELECT u.user_id, COALESCE(
        -- Try to extract name from email (before @, replace dots with spaces)
        INITCAP(
            REPLACE(
                SPLIT_PART(u.email, '@', 1), '.', ' '
            )
        ), 'Designer'
    )
FROM users u
    LEFT JOIN designers d ON d.user_id = u.user_id
WHERE
    u.user_type = 'DESIGNER'
    AND d.designer_id IS NULL;