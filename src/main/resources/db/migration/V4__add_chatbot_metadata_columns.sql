-- =============================================================================
-- V4__add_chatbot_metadata_columns.sql
-- Add metadata columns to chatbot tables for storing conversation state and message metadata
-- Consolidated from craft-chatbot migrations: 001_add_metadata_column.sql and 002_add_conversation_metadata.sql
-- Date: 2025-12-27/28
-- =============================================================================

-- Add message_metadata column to chatbot_messages
ALTER TABLE chatbot_messages 
ADD COLUMN IF NOT EXISTS message_metadata JSONB;

-- Add conversation_metadata column to chatbot_conversations
ALTER TABLE chatbot_conversations 
ADD COLUMN IF NOT EXISTS conversation_metadata JSONB;

-- Create GIN index for efficient JSONB queries on message_metadata
CREATE INDEX IF NOT EXISTS idx_chatbot_messages_message_metadata 
ON chatbot_messages USING GIN(message_metadata);

-- Create GIN index for efficient JSONB queries on conversation_metadata
CREATE INDEX IF NOT EXISTS idx_chatbot_conversations_metadata 
ON chatbot_conversations USING GIN (conversation_metadata);

-- Add comments for documentation
COMMENT ON COLUMN chatbot_messages.message_metadata IS 'Store intent classification, extracted entities, and other metadata';
COMMENT ON COLUMN chatbot_conversations.conversation_metadata IS 'Stores conversation state including action history, current recommendations, user preferences, and follow-up context';
