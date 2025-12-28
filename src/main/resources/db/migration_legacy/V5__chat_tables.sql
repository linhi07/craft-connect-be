-- =============================================================================
-- V5__chat_tables.sql
-- Designer-Village chat functionality
-- =============================================================================

-- =============================================================================
-- TABLE: chat_rooms
-- One room per designer-village pair for private messaging
-- =============================================================================
CREATE TABLE IF NOT EXISTS chat_rooms (
    room_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    designer_id INTEGER NOT NULL,
    village_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_rooms_designer FOREIGN KEY (designer_id) REFERENCES designers (designer_id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_rooms_village FOREIGN KEY (village_id) REFERENCES craft_villages (village_id) ON DELETE CASCADE,
    CONSTRAINT uq_chat_rooms_designer_village UNIQUE (designer_id, village_id)
);

CREATE INDEX IF NOT EXISTS idx_chat_rooms_designer_id ON chat_rooms (designer_id);

CREATE INDEX IF NOT EXISTS idx_chat_rooms_village_id ON chat_rooms (village_id);

CREATE INDEX IF NOT EXISTS idx_chat_rooms_updated_at ON chat_rooms (updated_at);

-- =============================================================================
-- TABLE: chat_messages
-- Individual messages within a chat room
-- =============================================================================
CREATE TABLE IF NOT EXISTS chat_messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    room_id UUID NOT NULL,
    sender_user_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    message_type VARCHAR(20) NOT NULL DEFAULT 'TEXT', -- TEXT, IMAGE, FILE
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_messages_room FOREIGN KEY (room_id) REFERENCES chat_rooms (room_id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_messages_sender FOREIGN KEY (sender_user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_chat_messages_room_id ON chat_messages (room_id);

CREATE INDEX IF NOT EXISTS idx_chat_messages_created_at ON chat_messages (created_at);

CREATE INDEX IF NOT EXISTS idx_chat_messages_sender ON chat_messages (sender_user_id);

-- =============================================================================
-- TABLE: chat_read_receipts
-- Tracks when each participant last read messages in a room
-- =============================================================================
CREATE TABLE IF NOT EXISTS chat_read_receipts (
    room_id UUID NOT NULL,
    user_id INTEGER NOT NULL,
    last_read_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (room_id, user_id),
    CONSTRAINT fk_chat_read_receipts_room FOREIGN KEY (room_id) REFERENCES chat_rooms (room_id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_read_receipts_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);