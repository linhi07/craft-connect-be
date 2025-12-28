-- =============================================================================
-- V11__add_file_support_to_messages.sql
-- Add file and image support to chat messages
-- =============================================================================

-- Add file-related columns to chat_messages table
ALTER TABLE chat_messages
ADD COLUMN file_url VARCHAR(500),
ADD COLUMN file_name VARCHAR(255),
ADD COLUMN file_size BIGINT,
ADD COLUMN file_type VARCHAR(100),
ADD COLUMN thumbnail_url VARCHAR(500);

-- Add index for file_type to optimize queries filtering by message type
CREATE INDEX IF NOT EXISTS idx_chat_messages_file_type ON chat_messages (file_type);

-- Add comments for documentation
COMMENT ON COLUMN chat_messages.file_url IS 'MinIO URL for uploaded file';
COMMENT ON COLUMN chat_messages.file_name IS 'Original filename uploaded by user';
COMMENT ON COLUMN chat_messages.file_size IS 'File size in bytes';
COMMENT ON COLUMN chat_messages.file_type IS 'MIME type of the file (e.g., image/jpeg, application/pdf)';
COMMENT ON COLUMN chat_messages.thumbnail_url IS 'MinIO URL for image thumbnail (for images only)';
