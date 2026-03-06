-- Financial Database Updates for Accountant Dashboard
USE ovr_db;

-- 1. Create Refunds Table
CREATE TABLE IF NOT EXISTS refunds (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    reason TEXT,
    refund_status ENUM('PENDING', 'PROCESSED', 'FAILED') DEFAULT 'PENDING',
    processed_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE
);

-- 2. Audit Log for Financial Actions
-- (Already exists in schema.sql, but we will ensure extra detail for accountants)
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('last_financial_sync', CURRENT_TIMESTAMP);
