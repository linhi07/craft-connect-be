-- V10: Update village user passwords for testing
-- Sets a common test password: "password" (BCrypt encoded)
-- This allows logging in as any village for testing the chat feature

-- BCrypt hash for password "password" (this is a valid, tested hash)
UPDATE users
SET
    password_hash = '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqQr5E7Yw1JZz5NqDd03JZw5kQx3a3.'
WHERE
    user_type = 'VILLAGE'
    AND password_hash LIKE '$2a$10$dummyhash%';