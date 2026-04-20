-- ============================================
-- MUCYO RADIANCE HOTEL - Database Setup
-- Run this in phpMyAdmin or MySQL terminal
-- ============================================

CREATE DATABASE IF NOT EXISTS hotel;
USE hotel;

-- USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role     ENUM('admin', 'customer') DEFAULT 'customer'
);

-- ORDERS TABLE
CREATE TABLE IF NOT EXISTS orders (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(100),
    email   VARCHAR(100),
    phone   VARCHAR(20),
    menu    VARCHAR(100),
    address TEXT,
    date    DATE,
    user_id INT NULL
);

-- CONTACTS TABLE
CREATE TABLE IF NOT EXISTS contacts (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100),
    email    VARCHAR(100),
    phone    VARCHAR(20),
    location VARCHAR(100),
    message  TEXT
);

-- ============================================
-- CREATE DEFAULT ADMIN ACCOUNT
-- Username: mucyo   Password: 1234
-- ============================================
INSERT INTO users (username, password, role)
VALUES (
    'mucyo',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', -- password: password
    'admin'
)
ON DUPLICATE KEY UPDATE role = 'admin';

-- NOTE: After importing, run reset_password.php ONCE to set
-- the correct hashed password, then DELETE that file.
