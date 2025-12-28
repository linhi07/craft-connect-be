-- =============================================================================
-- V1__init_schema_with_enums.sql
-- Initial schema migration for Vietnam Artisan / Craft Connect application
-- Uses PostgreSQL native ENUM types and arrays instead of junction tables
-- =============================================================================

-- =============================================================================
-- CREATE ENUM TYPES
-- =============================================================================
CREATE TYPE user_type AS ENUM ('DESIGNER', 'VILLAGE', 'ADMIN');
CREATE TYPE scale_type AS ENUM ('VILLAGE', 'INDIVIDUAL_ARTIST', 'ASSOCIATION');
CREATE TYPE region_type AS ENUM ('NORTHERN_VIETNAM', 'CENTRAL_VIETNAM', 'SOUTHERN_VIETNAM');
CREATE TYPE connection_status AS ENUM ('PENDING', 'ACCEPTED', 'REJECTED');
CREATE TYPE message_type AS ENUM ('TEXT', 'IMAGE', 'FILE');
CREATE TYPE product_category AS ENUM ('RAW_MATERIALS', 'CUSTOM_DESIGN', 'FASHION_TEXTILE', 'SCARVES_ACCESSORIES', 'HOME_DECOR');
CREATE TYPE product_characteristic AS ENUM ('HANDWOVEN', 'MACHINE_MADE', 'NATURAL_DYED', 'ECO_FRIENDLY', 'OTHERS');
CREATE TYPE market_segment AS ENUM ('LUXURY', 'AFFORDABLE', 'EXPORT_ORIENTED', 'LOCALLY_FOCUSED');

-- =============================================================================
-- TABLE: users
-- Core user authentication table
-- =============================================================================
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    user_type user_type NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_user_type ON users (user_type);

-- =============================================================================
-- TABLE: materials
-- Lookup table for craft materials
-- =============================================================================
CREATE TABLE materials (
    material_id SERIAL PRIMARY KEY,
    material_name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE INDEX idx_materials_name ON materials (material_name);

-- =============================================================================
-- TABLE: craft_villages
-- Main table for craft village profiles
-- Uses PostgreSQL arrays for categories, characteristics, and market segments
-- =============================================================================
CREATE TABLE craft_villages (
    village_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    village_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone_number VARCHAR(50),
    website_url VARCHAR(255),
    description TEXT,
    inspirational_story TEXT,
    certifications TEXT,
    location VARCHAR(255),
    
    -- Enum fields
    scale scale_type,
    region region_type,
    
    -- Array fields (replacing junction tables)
    categories product_category[] NOT NULL DEFAULT '{}',
    characteristics product_characteristic[] NOT NULL DEFAULT '{}',
    market_segments market_segment[] NOT NULL DEFAULT '{}',
    
    -- Village detail page fields
    profile_image_url VARCHAR(500),
    email VARCHAR(255),
    craft_type VARCHAR(255),
    association_membership VARCHAR(255),
    key_products TEXT,
    techniques TEXT,
    production_capacity VARCHAR(500),
    estimated_completion_time VARCHAR(255),
    rating DOUBLE PRECISION,
    
    -- Vector embedding for RAG (added in V2)
    -- content_embedding vector(384),
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_craft_villages_user_id ON craft_villages (user_id);
CREATE INDEX idx_craft_villages_region ON craft_villages (region);
CREATE INDEX idx_craft_villages_scale ON craft_villages (scale);
CREATE INDEX idx_craft_villages_village_name ON craft_villages (village_name);

-- GIN indexes for efficient array search
CREATE INDEX idx_craft_villages_categories ON craft_villages USING GIN (categories);
CREATE INDEX idx_craft_villages_characteristics ON craft_villages USING GIN (characteristics);
CREATE INDEX idx_craft_villages_market_segments ON craft_villages USING GIN (market_segments);

-- =============================================================================
-- TABLE: designers
-- Designer profile table
-- =============================================================================
CREATE TABLE designers (
    designer_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    designer_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone_number VARCHAR(50),
    website_url VARCHAR(255),
    bio TEXT,
    portfolio_url VARCHAR(255),
    location VARCHAR(255)
);

CREATE INDEX idx_designers_user_id ON designers (user_id);
CREATE INDEX idx_designers_designer_name ON designers (designer_name);

-- =============================================================================
-- TABLE: portfolio_items
-- Portfolio items belonging to craft villages
-- =============================================================================
CREATE TABLE portfolio_items (
    portfolio_id SERIAL PRIMARY KEY,
    village_id INTEGER NOT NULL REFERENCES craft_villages (village_id) ON DELETE CASCADE,
    title VARCHAR(255),
    description TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_portfolio_items_village_id ON portfolio_items (village_id);

-- =============================================================================
-- TABLE: village_materials
-- Junction table: villages and their materials with capacity/price info
-- =============================================================================
CREATE TABLE village_materials (
    village_material_id SERIAL PRIMARY KEY,
    village_id INTEGER NOT NULL REFERENCES craft_villages (village_id) ON DELETE CASCADE,
    material_id INTEGER NOT NULL REFERENCES materials (material_id) ON DELETE CASCADE,
    production_capacity VARCHAR(255),
    price_range VARCHAR(255)
);

CREATE INDEX idx_village_materials_village_id ON village_materials (village_id);
CREATE INDEX idx_village_materials_material_id ON village_materials (material_id);

-- =============================================================================
-- TABLE: chatbot_conversations
-- Tracks chat sessions with the AI chatbot (BotCiCi)
-- =============================================================================
CREATE TABLE chatbot_conversations (
    conversation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id VARCHAR(100) NOT NULL,
    user_id INTEGER REFERENCES users (user_id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_chatbot_conversations_session_id ON chatbot_conversations (session_id);
CREATE INDEX idx_chatbot_conversations_user_id ON chatbot_conversations (user_id);

-- =============================================================================
-- TABLE: chatbot_messages
-- Individual messages within a chatbot conversation
-- =============================================================================
CREATE TABLE chatbot_messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES chatbot_conversations (conversation_id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL, -- 'user', 'assistant', 'system'
    content TEXT NOT NULL,
    tool_calls JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_chatbot_messages_conversation_id ON chatbot_messages (conversation_id);
CREATE INDEX idx_chatbot_messages_created_at ON chatbot_messages (created_at);

-- =============================================================================
-- TABLE: chat_rooms
-- One room per designer-village pair for private messaging
-- =============================================================================
CREATE TABLE chat_rooms (
    room_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    designer_id INTEGER NOT NULL REFERENCES designers (designer_id) ON DELETE CASCADE,
    village_id INTEGER NOT NULL REFERENCES craft_villages (village_id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_chat_rooms_designer_village UNIQUE (designer_id, village_id)
);

CREATE INDEX idx_chat_rooms_designer_id ON chat_rooms (designer_id);
CREATE INDEX idx_chat_rooms_village_id ON chat_rooms (village_id);
CREATE INDEX idx_chat_rooms_updated_at ON chat_rooms (updated_at);

-- =============================================================================
-- TABLE: chat_messages
-- Individual messages within a chat room
-- =============================================================================
CREATE TABLE chat_messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    room_id UUID NOT NULL REFERENCES chat_rooms (room_id) ON DELETE CASCADE,
    sender_user_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    message_type message_type NOT NULL DEFAULT 'TEXT',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- File support fields
    file_url VARCHAR(500),
    file_name VARCHAR(255),
    file_size BIGINT,
    file_type VARCHAR(100),
    thumbnail_url VARCHAR(500)
);

CREATE INDEX idx_chat_messages_room_id ON chat_messages (room_id);
CREATE INDEX idx_chat_messages_created_at ON chat_messages (created_at);
CREATE INDEX idx_chat_messages_sender ON chat_messages (sender_user_id);
CREATE INDEX idx_chat_messages_file_type ON chat_messages (file_type);

COMMENT ON COLUMN chat_messages.file_url IS 'MinIO URL for uploaded file';
COMMENT ON COLUMN chat_messages.file_name IS 'Original filename uploaded by user';
COMMENT ON COLUMN chat_messages.file_size IS 'File size in bytes';
COMMENT ON COLUMN chat_messages.file_type IS 'MIME type of the file (e.g., image/jpeg, application/pdf)';
COMMENT ON COLUMN chat_messages.thumbnail_url IS 'MinIO URL for image thumbnail (for images only)';

-- =============================================================================
-- TABLE: chat_read_receipts
-- Tracks when each participant last read messages in a room
-- =============================================================================
CREATE TABLE chat_read_receipts (
    room_id UUID NOT NULL REFERENCES chat_rooms (room_id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    last_read_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (room_id, user_id)
);

-- =============================================================================
-- TABLE: connections
-- LinkedIn-style connections between designers and villages
-- =============================================================================
CREATE TABLE connections (
    connection_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    requester_user_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    receiver_user_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    chat_room_id UUID NOT NULL REFERENCES chat_rooms (room_id) ON DELETE CASCADE,
    status connection_status NOT NULL DEFAULT 'PENDING',
    message TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_connections_requester_receiver UNIQUE (requester_user_id, receiver_user_id)
);

CREATE INDEX idx_connections_requester ON connections (requester_user_id);
CREATE INDEX idx_connections_receiver ON connections (receiver_user_id);
CREATE INDEX idx_connections_status ON connections (status);
CREATE INDEX idx_connections_chat_room ON connections (chat_room_id);
