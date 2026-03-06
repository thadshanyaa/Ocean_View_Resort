USE ovr_db;

-- 1. Insert Initial Settings
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES 
('tax_rate', '0.10'),
('service_fee_rate', '0.05');

-- 2. Insert Room Types
INSERT IGNORE INTO room_types (id, type_name, base_rate, capacity, description) VALUES
(1, 'Standard Room', 100.00, 2, 'Cozy room with basic amenities.'),
(2, 'Deluxe Room', 150.00, 3, 'Spacious room with ocean view.'),
(3, 'Luxury Suite', 300.00, 4, 'Premium suite with a private pool and balcony.'),
(4, 'Family Room', 200.00, 5, 'Large room suitable for a whole family.');

-- 3. Insert Rooms
INSERT IGNORE INTO rooms (room_number, room_type_id, is_available) VALUES
('101', 1, TRUE), ('102', 1, TRUE), ('103', 1, TRUE),
('201', 2, TRUE), ('202', 2, TRUE),
('301', 3, TRUE), ('401', 4, TRUE), ('402', 4, TRUE);

-- 4. Insert Default Admin User
-- Password is 'admin123', hashed with SHA-256
INSERT IGNORE INTO users (id, username, password_hash, role, is_verified) VALUES
(1, 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Admin', TRUE);
