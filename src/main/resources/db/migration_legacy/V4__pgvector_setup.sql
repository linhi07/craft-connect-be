-- =============================================================================
-- V4__pgvector_setup.sql
-- Enable pgvector extension and add embedding column to craft_villages
-- For semantic search in the chatbot
-- =============================================================================

-- Enable pgvector extension (requires PostgreSQL with pgvector installed)
CREATE EXTENSION IF NOT EXISTS vector;

-- Add content embedding column to craft_villages for RAG semantic search
-- Using 384 dimensions (compatible with all-MiniLM-L6-v2 sentence-transformer)
ALTER TABLE craft_villages
ADD COLUMN IF NOT EXISTS content_embedding vector (384);

-- Create index for efficient similarity search
CREATE INDEX IF NOT EXISTS idx_craft_villages_embedding ON craft_villages USING ivfflat (
    content_embedding vector_cosine_ops
)
WITH (lists = 10);