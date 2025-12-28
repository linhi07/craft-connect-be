-- =============================================================================
-- V2__chatbot_tables.sql
-- Chatbot-specific tables for conversation management
-- Prefix: chatbot_ to separate from future designer-village chat feature
-- =============================================================================

-- =============================================================================
-- TABLE: chatbot_conversations
-- Tracks chat sessions with the AI chatbot (BotCiCi)
-- =============================================================================
CREATE TABLE IF NOT EXISTS chatbot_conversations (
    conversation_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    session_id VARCHAR(100) NOT NULL,
    user_id INTEGER REFERENCES users (user_id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_chatbot_conversations_session_id ON chatbot_conversations (session_id);

CREATE INDEX IF NOT EXISTS idx_chatbot_conversations_user_id ON chatbot_conversations (user_id);

-- =============================================================================
-- TABLE: chatbot_messages
-- Individual messages within a chatbot conversation
-- =============================================================================
CREATE TABLE IF NOT EXISTS chatbot_messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    conversation_id UUID NOT NULL REFERENCES chatbot_conversations (conversation_id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL, -- 'user', 'assistant', 'system'
    content TEXT NOT NULL,
    tool_calls JSONB, -- Store any tool calls made by the assistant
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_chatbot_messages_conversation_id ON chatbot_messages (conversation_id);

CREATE INDEX IF NOT EXISTS idx_chatbot_messages_created_at ON chatbot_messages (created_at);