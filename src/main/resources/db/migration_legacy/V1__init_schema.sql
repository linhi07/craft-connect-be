-- =============================================================================
-- V1__init_schema.sql
-- Initial schema migration for Vietnam Artisan / Craft Connect application
-- =============================================================================

-- =============================================================================
-- TABLE: users
-- Core user authentication table
-- =============================================================================
CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    user_type VARCHAR(50) NOT NULL, -- ENUM: DESIGNER, VILLAGE, ADMIN
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster email lookups during authentication
CREATE INDEX IF NOT EXISTS idx_users_email ON users (email);

CREATE INDEX IF NOT EXISTS idx_users_user_type ON users (user_type);

-- =============================================================================
-- TABLE: materials
-- Lookup table for craft materials
-- =============================================================================
CREATE TABLE IF NOT EXISTS materials (
    material_id SERIAL PRIMARY KEY,
    material_name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE INDEX IF NOT EXISTS idx_materials_name ON materials (material_name);

-- =============================================================================
-- TABLE: craft_villages
-- Main table for craft village profiles
-- =============================================================================
CREATE TABLE IF NOT EXISTS craft_villages (
    village_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users (user_id),
    village_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone_number VARCHAR(50),
    website_url VARCHAR(255),
    description TEXT,
    inspirational_story TEXT,
    certifications TEXT,
    location VARCHAR(255),
    scale VARCHAR(50), -- ENUM: VILLAGE, INDIVIDUAL_ARTIST, ASSOCIATION
    region VARCHAR(50), -- ENUM: NORTHERN_VIETNAM, CENTRAL_VIETNAM, SOUTHERN_VIETNAM
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_craft_villages_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_craft_villages_user_id ON craft_villages (user_id);

CREATE INDEX IF NOT EXISTS idx_craft_villages_region ON craft_villages (region);

CREATE INDEX IF NOT EXISTS idx_craft_villages_scale ON craft_villages (scale);

CREATE INDEX IF NOT EXISTS idx_craft_villages_village_name ON craft_villages (village_name);

-- =============================================================================
-- TABLE: designers
-- Designer profile table
-- =============================================================================
CREATE TABLE IF NOT EXISTS designers (
    designer_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users (user_id),
    designer_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone_number VARCHAR(50),
    website_url VARCHAR(255),
    bio TEXT,
    portfolio_url VARCHAR(255),
    location VARCHAR(255),
    CONSTRAINT fk_designers_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_designers_user_id ON designers (user_id);

CREATE INDEX IF NOT EXISTS idx_designers_designer_name ON designers (designer_name);

-- =============================================================================
-- TABLE: portfolio_items
-- Portfolio items belonging to craft villages
-- =============================================================================
CREATE TABLE IF NOT EXISTS portfolio_items (
    portfolio_id SERIAL PRIMARY KEY,
    village_id INTEGER NOT NULL REFERENCES craft_villages (village_id),
    title VARCHAR(255),
    description TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_portfolio_items_village FOREIGN KEY (village_id) REFERENCES craft_villages (village_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_portfolio_items_village_id ON portfolio_items (village_id);

-- =============================================================================
-- TABLE: village_materials
-- Junction table: villages and their materials with capacity/price info
-- =============================================================================
CREATE TABLE IF NOT EXISTS village_materials (
    village_material_id SERIAL PRIMARY KEY,
    village_id INTEGER NOT NULL REFERENCES craft_villages (village_id),
    material_id INTEGER NOT NULL REFERENCES materials (material_id),
    production_capacity VARCHAR(255),
    price_range VARCHAR(255),
    CONSTRAINT fk_village_materials_village FOREIGN KEY (village_id) REFERENCES craft_villages (village_id) ON DELETE CASCADE,
    CONSTRAINT fk_village_materials_material FOREIGN KEY (material_id) REFERENCES materials (material_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_village_materials_village_id ON village_materials (village_id);

CREATE INDEX IF NOT EXISTS idx_village_materials_material_id ON village_materials (material_id);

-- =============================================================================
-- TABLE: village_categories (ElementCollection)
-- Product categories for villages
-- ENUM values: RAW_MATERIALS, CUSTOM_DESIGN, FASHION_TEXTILE, SCARVES_ACCESSORIES, HOME_DECOR
-- =============================================================================
CREATE TABLE IF NOT EXISTS village_categories (
    village_id INTEGER NOT NULL REFERENCES craft_villages (village_id),
    category VARCHAR(255) NOT NULL,
    PRIMARY KEY (village_id, category),
    CONSTRAINT fk_village_categories_village FOREIGN KEY (village_id) REFERENCES craft_villages (village_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_village_categories_village_id ON village_categories (village_id);

CREATE INDEX IF NOT EXISTS idx_village_categories_category ON village_categories (category);

-- =============================================================================
-- TABLE: village_characteristics (ElementCollection)
-- Product characteristics for villages
-- ENUM values: HANDWOVEN, MACHINE_MADE, NATURAL_DYED, ECO_FRIENDLY, OTHERS
-- =============================================================================
CREATE TABLE IF NOT EXISTS village_characteristics (
    village_id INTEGER NOT NULL REFERENCES craft_villages (village_id),
    characteristic VARCHAR(255) NOT NULL,
    PRIMARY KEY (village_id, characteristic),
    CONSTRAINT fk_village_characteristics_village FOREIGN KEY (village_id) REFERENCES craft_villages (village_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_village_characteristics_village_id ON village_characteristics (village_id);

CREATE INDEX IF NOT EXISTS idx_village_characteristics_characteristic ON village_characteristics (characteristic);

-- =============================================================================
-- TABLE: village_markets (ElementCollection)
-- Market segments for villages
-- ENUM values: LUXURY, AFFORDABLE, EXPORT_ORIENTED, LOCALLY_FOCUSED
-- =============================================================================
CREATE TABLE IF NOT EXISTS village_markets (
    village_id INTEGER NOT NULL REFERENCES craft_villages (village_id),
    market_segment VARCHAR(255) NOT NULL,
    PRIMARY KEY (village_id, market_segment),
    CONSTRAINT fk_village_markets_village FOREIGN KEY (village_id) REFERENCES craft_villages (village_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_village_markets_village_id ON village_markets (village_id);

CREATE INDEX IF NOT EXISTS idx_village_markets_market_segment ON village_markets (market_segment);