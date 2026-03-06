USE ovr_db;

-- 1. Create the new OTP and Audit Logs tables cleanly
DROP TABLE IF EXISTS otp_tokens;
CREATE TABLE otp_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    otp_hash VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    attempts INT DEFAULT 0,
    used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS audit_logs;
CREATE TABLE audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255) NOT NULL,
    description TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 2. Ensure existing 'admin' and 'guest' accounts use the necessary BCrypt passwords
UPDATE users SET password_hash = '$2a$12$Nq/t1h9iEOMQ4t3b9E6bJe5Z8hX2V9c3M9D8t2L8.x1aD0bZ5QYmG', is_verified = TRUE, role = 'Admin' WHERE username = 'admin';
UPDATE users SET password_hash = '$2a$12$y1wYqG2/r1jD9a0X.C7QweK8v7Q2x.y9aQ0cW/Bv.7qF8sW2L3IOW', is_verified = TRUE, role = 'Guest' WHERE username = 'guest';

-- 3. Just in case they were deleted, seamlessly re-insert them without causing duplicate errors
INSERT IGNORE INTO users (username, password_hash, role, is_verified) VALUES ('admin', '$2a$12$Nq/t1h9iEOMQ4t3b9E6bJe5Z8hX2V9c3M9D8t2L8.x1aD0bZ5QYmG', 'Admin', TRUE);
INSERT IGNORE INTO users (username, password_hash, role, is_verified) VALUES ('guest', '$2a$12$y1wYqG2/r1jD9a0X.C7QweK8v7Q2x.y9aQ0cW/Bv.7qF8sW2L3IOW', 'Guest', TRUE);
