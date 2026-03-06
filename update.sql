USE ovr_db;

-- Update users table
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_verified BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS locked_until TIMESTAMP NULL;

-- Update otp_tokens table
ALTER TABLE otp_tokens DROP COLUMN IF EXISTS otp_code;
ALTER TABLE otp_tokens ADD COLUMN IF NOT EXISTS otp_hash VARCHAR(255) NOT NULL;
ALTER TABLE otp_tokens ADD COLUMN IF NOT EXISTS attempts INT DEFAULT 0;
ALTER TABLE otp_tokens ADD COLUMN IF NOT EXISTS used BOOLEAN DEFAULT FALSE;

-- Ensure audit_logs has the required structure
CREATE TABLE IF NOT EXISTS audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Seed verified admin user
-- password: admin123 -> $2a$12$Nq/t1h9iEOMQ4t3b9E6bJe5Z8hX2V9c3M9D8t2L8.x1aD0bZ5QYmG
INSERT INTO users (username, password_hash, role, is_verified) 
VALUES ('admin', '$2a$12$Nq/t1h9iEOMQ4t3b9E6bJe5Z8hX2V9c3M9D8t2L8.x1aD0bZ5QYmG', 'Admin', TRUE)
ON DUPLICATE KEY UPDATE password_hash = '$2a$12$Nq/t1h9iEOMQ4t3b9E6bJe5Z8hX2V9c3M9D8t2L8.x1aD0bZ5QYmG', is_verified = TRUE, role = 'Admin';

-- Seed verified guest user
-- password: guest123 -> $2a$12$y1wYqG2/r1jD9a0X.C7QweK8v7Q2x.y9aQ0cW/Bv.7qF8sW2L3IOW
INSERT INTO users (username, password_hash, role, is_verified) 
VALUES ('guest', '$2a$12$y1wYqG2/r1jD9a0X.C7QweK8v7Q2x.y9aQ0cW/Bv.7qF8sW2L3IOW', 'Guest', TRUE)
ON DUPLICATE KEY UPDATE password_hash = '$2a$12$y1wYqG2/r1jD9a0X.C7QweK8v7Q2x.y9aQ0cW/Bv.7qF8sW2L3IOW', is_verified = TRUE, role = 'Guest';

-- Also insert guest profile if missing
INSERT IGNORE INTO guests (user_id, full_name, address, contact_number)
SELECT id, 'John Guest', '123 Ocean Drive', '0771234567' FROM users WHERE username = 'guest';

