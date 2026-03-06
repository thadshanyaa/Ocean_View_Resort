CREATE DATABASE IF NOT EXISTS ovr_db;
USE ovr_db;

-- 1. Users & Roles Table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Receptionist', 'Manager', 'Accountant', 'Guest') NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    locked_until TIMESTAMP NULL,
    failed_attempts INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. OTP Tokens Table
CREATE TABLE IF NOT EXISTS otp_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    otp_hash VARCHAR(255) NOT NULL,
    expiry TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Guests Table (Linked to users)
CREATE TABLE IF NOT EXISTS guests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address TEXT,
    contact_number VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 4. Room Types Table
CREATE TABLE IF NOT EXISTS room_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    base_rate DECIMAL(10,2) NOT NULL,
    capacity INT NOT NULL,
    description TEXT
);

-- 5. Rooms Table
CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id INT NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE CASCADE
);

-- 6. Reservations Table
CREATE TABLE IF NOT EXISTS reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_number VARCHAR(50) NOT NULL UNIQUE,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled', 'Checked-In', 'Checked-Out') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id) REFERENCES guests(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);

-- 7. Bills Table
CREATE TABLE IF NOT EXISTS bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    nights INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    service_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL,
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE
);

-- 8. Payments Table
CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL, -- 'Online Gateway', 'Cash', 'Card'
    transaction_ref VARCHAR(100),
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_status ENUM('PENDING', 'PAID', 'PARTIAL', 'FAILED') DEFAULT 'PENDING',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES bills(id) ON DELETE CASCADE
);

-- 9. Settings Table
CREATE TABLE IF NOT EXISTS settings (
    setting_key VARCHAR(50) PRIMARY KEY,
    setting_value VARCHAR(255) NOT NULL
);

-- 10. Audit Logs Table
CREATE TABLE IF NOT EXISTS audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255) NOT NULL,
    details TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- 11. Additional Charges Table
CREATE TABLE IF NOT EXISTS additional_charges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    qty INT NOT NULL DEFAULT 1,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE
);

-- Seed exactly 50 rooms per type
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM rooms;
ALTER TABLE rooms AUTO_INCREMENT = 1;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO rooms (room_number, room_type_id, is_available) VALUES 
('101', 1, 1), ('102', 1, 1), ('103', 1, 1), ('104', 1, 1), ('105', 1, 1), ('106', 1, 1), ('107', 1, 1), ('108', 1, 1), ('109', 1, 1), ('110', 1, 1),
('111', 1, 1), ('112', 1, 1), ('113', 1, 1), ('114', 1, 1), ('115', 1, 1), ('116', 1, 1), ('117', 1, 1), ('118', 1, 1), ('119', 1, 1), ('120', 1, 1),
('121', 1, 1), ('122', 1, 1), ('123', 1, 1), ('124', 1, 1), ('125', 1, 1), ('126', 1, 1), ('127', 1, 1), ('128', 1, 1), ('129', 1, 1), ('130', 1, 1),
('131', 1, 1), ('132', 1, 1), ('133', 1, 1), ('134', 1, 1), ('135', 1, 1), ('136', 1, 1), ('137', 1, 1), ('138', 1, 1), ('139', 1, 1), ('140', 1, 1),
('141', 1, 1), ('142', 1, 1), ('143', 1, 1), ('144', 1, 1), ('145', 1, 1), ('146', 1, 1), ('147', 1, 1), ('148', 1, 1), ('149', 1, 1), ('150', 1, 1),
('201', 2, 1), ('202', 2, 1), ('203', 2, 1), ('204', 2, 1), ('205', 2, 1), ('206', 2, 1), ('207', 2, 1), ('208', 2, 1), ('209', 2, 1), ('210', 2, 1),
('211', 2, 1), ('212', 2, 1), ('213', 2, 1), ('214', 2, 1), ('215', 2, 1), ('216', 2, 1), ('217', 2, 1), ('218', 2, 1), ('219', 2, 1), ('220', 2, 1),
('221', 2, 1), ('222', 2, 1), ('223', 2, 1), ('224', 2, 1), ('225', 2, 1), ('226', 2, 1), ('227', 2, 1), ('228', 2, 1), ('229', 2, 1), ('230', 2, 1),
('231', 2, 1), ('232', 2, 1), ('233', 2, 1), ('234', 2, 1), ('235', 2, 1), ('236', 2, 1), ('237', 2, 1), ('238', 2, 1), ('239', 2, 1), ('240', 2, 1),
('241', 2, 1), ('242', 2, 1), ('243', 2, 1), ('244', 2, 1), ('245', 2, 1), ('246', 2, 1), ('247', 2, 1), ('248', 2, 1), ('249', 2, 1), ('250', 2, 1),
('301', 3, 1), ('302', 3, 1), ('303', 3, 1), ('304', 3, 1), ('305', 3, 1), ('306', 3, 1), ('307', 3, 1), ('308', 3, 1), ('309', 3, 1), ('310', 3, 1),
('311', 3, 1), ('312', 3, 1), ('313', 3, 1), ('314', 3, 1), ('315', 3, 1), ('316', 3, 1), ('317', 3, 1), ('318', 3, 1), ('319', 3, 1), ('320', 3, 1),
('321', 3, 1), ('322', 3, 1), ('323', 3, 1), ('324', 3, 1), ('325', 3, 1), ('326', 3, 1), ('327', 3, 1), ('328', 3, 1), ('329', 3, 1), ('330', 3, 1),
('331', 3, 1), ('332', 3, 1), ('333', 3, 1), ('334', 3, 1), ('335', 3, 1), ('336', 3, 1), ('337', 3, 1), ('338', 3, 1), ('339', 3, 1), ('340', 3, 1),
('341', 3, 1), ('342', 3, 1), ('343', 3, 1), ('344', 3, 1), ('345', 3, 1), ('346', 3, 1), ('347', 3, 1), ('348', 3, 1), ('349', 3, 1), ('350', 3, 1),
('401', 4, 1), ('402', 4, 1), ('403', 4, 1), ('404', 4, 1), ('405', 4, 1), ('406', 4, 1), ('407', 4, 1), ('408', 4, 1), ('409', 4, 1), ('410', 4, 1),
('411', 4, 1), ('412', 4, 1), ('413', 4, 1), ('414', 4, 1), ('415', 4, 1), ('416', 4, 1), ('417', 4, 1), ('418', 4, 1), ('419', 4, 1), ('420', 4, 1),
('421', 4, 1), ('422', 4, 1), ('423', 4, 1), ('424', 4, 1), ('425', 4, 1), ('426', 4, 1), ('427', 4, 1), ('428', 4, 1), ('429', 4, 1), ('430', 4, 1),
('431', 4, 1), ('432', 4, 1), ('433', 4, 1), ('434', 4, 1), ('435', 4, 1), ('436', 4, 1), ('437', 4, 1), ('438', 4, 1), ('439', 4, 1), ('440', 4, 1),
('441', 4, 1), ('442', 4, 1), ('443', 4, 1), ('444', 4, 1), ('445', 4, 1), ('446', 4, 1), ('447', 4, 1), ('448', 4, 1), ('449', 4, 1), ('450', 4, 1);
