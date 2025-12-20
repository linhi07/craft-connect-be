-- Seed data for materials table
INSERT INTO materials (material_name, description) VALUES
('Silk', 'Traditional Vietnamese silk fabric'),
('Cotton', 'Natural cotton material'),
('Bamboo', 'Sustainable bamboo fiber'),
('Hemp', 'Eco-friendly hemp fabric'),
('Linen', 'Natural linen material'),
('Wool', 'Local wool fiber'),
('Rattan', 'Natural rattan material'),
('Lacquer', 'Traditional Vietnamese lacquer'),
('Ceramic', 'Handmade ceramic materials'),
('Wood', 'Local hardwood materials')
ON CONFLICT DO NOTHING;
