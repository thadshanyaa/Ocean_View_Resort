-- Migration to add email to users table
USE ovr_db;
ALTER TABLE users ADD COLUMN email VARCHAR(100) AFTER username;
-- Update existing users with a dummy email for safety
UPDATE users SET email = CONCAT(username, '@example.com') WHERE email IS NULL;
