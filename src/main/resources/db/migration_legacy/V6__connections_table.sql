-- =============================================================================
-- V6__connections_table.sql
-- LinkedIn-style connections between designers and villages
-- Requires 3+ messages from each party in chat before connection is allowed
-- =============================================================================

-- =============================================================================
-- TABLE: connections
-- Tracks connection requests and their status
-- =============================================================================
CREATE TABLE IF NOT EXISTS connections (
    connection_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    requester_user_id INTEGER NOT NULL,
    receiver_user_id INTEGER NOT NULL,
    chat_room_id UUID NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING', -- PENDING, ACCEPTED, REJECTED
    message TEXT, -- Optional connection message
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_connections_requester FOREIGN KEY (requester_user_id) REFERENCES users (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_connections_receiver FOREIGN KEY (receiver_user_id) REFERENCES users (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_connections_chat_room FOREIGN KEY (chat_room_id) REFERENCES chat_rooms (room_id) ON DELETE CASCADE,
    CONSTRAINT uq_connections_requester_receiver UNIQUE (
        requester_user_id,
        receiver_user_id
    )
);

CREATE INDEX IF NOT EXISTS idx_connections_requester ON connections (requester_user_id);

CREATE INDEX IF NOT EXISTS idx_connections_receiver ON connections (receiver_user_id);

CREATE INDEX IF NOT EXISTS idx_connections_status ON connections (status);

CREATE INDEX IF NOT EXISTS idx_connections_chat_room ON connections (chat_room_id);