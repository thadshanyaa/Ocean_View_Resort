-- staff_management.sql
-- Create Staff Details table
CREATE TABLE IF NOT EXISTS staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    staff_code VARCHAR(20) UNIQUE,
    full_name VARCHAR(100),
    position VARCHAR(50),
    department VARCHAR(50),
    shift_preference ENUM('Morning', 'Evening', 'Night'),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create Staff Attendance table for real-time tracking
CREATE TABLE IF NOT EXISTS staff_attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    check_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    check_out TIMESTAMP NULL,
    status ENUM('Active', 'Offline', 'On-Break') DEFAULT 'Offline',
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE
);

-- Create Staff Schedules table
CREATE TABLE IF NOT EXISTS staff_schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    shift_date DATE NOT NULL,
    shift_start TIME NOT NULL,
    shift_end TIME NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE
);

-- Seed Initial Staff (Receptionists)
INSERT INTO staff (user_id, staff_code, full_name, position, department, shift_preference)
SELECT id, CONCAT('REC', id), username, 'Receptionist', 'Front Desk', 'Morning' FROM users WHERE role = 'Receptionist' LIMIT 3;

-- Seed Some Attendance Data for "Live Status"
INSERT INTO staff_attendance (staff_id, check_in, status)
SELECT id, DATE_SUB(NOW(), INTERVAL 2 HOUR), 'Active' FROM staff WHERE position = 'Receptionist' LIMIT 1;
