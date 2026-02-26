-- MAB-BILIS Database Schema
-- MySQL/SQLite compatible SQL script
-- Database: mab_bilis

-- ============================================
-- USERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'business', 'customer') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- BUSINESSES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS businesses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    owner_name VARCHAR(255),
    description TEXT,
    address VARCHAR(500),
    contact_number VARCHAR(50),
    category VARCHAR(100),
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    image VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ============================================
-- PRODUCTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    business_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100),
    image VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(id) ON DELETE CASCADE
);

-- ============================================
-- TOURIST SPOTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS tourist_spots (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(500),
    image VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- SESSIONS TABLE (for login sessions)
-- ============================================
CREATE TABLE IF NOT EXISTS sessions (
    id VARCHAR(255) PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_businesses_user_id ON businesses(user_id);
CREATE INDEX idx_businesses_status ON businesses(status);
CREATE INDEX idx_businesses_category ON businesses(category);
CREATE INDEX idx_products_business_id ON products(business_id);
CREATE INDEX idx_products_category ON products(category);

-- ============================================
-- DEFAULT DATA - ADMIN USER
-- ============================================
INSERT INTO users (name, email, password, role) 
VALUES ('Admin', 'admin@mab-bilis.com', 'admin123', 'admin')
ON DUPLICATE KEY UPDATE email = email;

-- ============================================
-- DEFAULT DATA - SAMPLE BUSINESSES
-- ============================================
INSERT INTO businesses (user_id, name, owner_name, description, address, contact_number, category, status, image) 
VALUES 
(1, 'KERR IT SOLUTIONS', 'Owner', 'Browse and order from registered local shops in Mabinay easily and quickly.', 'Mabinay, Negros Oriental', '09123456789', 'IT Services', 'approved', 'https://img.icons8.com/color/96/000000/shop.png'),
(1, 'Don Macchiatos', 'Owner', 'Track and receive your items conveniently with real-time updates.', 'Mabinay, Negros Oriental', '09223456789', 'Food & Beverage', 'approved', 'https://img.icons8.com/color/96/000000/delivery.png'),
(1, 'Mabinay Bakery', 'Owner', 'Get fresh products delivered straight from local markets.', 'Mabinay Public Market', '09323456789', 'Bakery', 'approved', 'https://img.icons8.com/color/96/000000/bread.png')
ON DUPLICATE KEY UPDATE name = name;

-- ============================================
-- DEFAULT DATA - SAMPLE PRODUCTS
-- ============================================
INSERT INTO products (business_id, name, description, price, category, image) 
VALUES 
(1, 'Laptop - Dell Inspiron 15', 'Intel Core i5, 8GB RAM, 512GB SSD, 15.6-inch Display', 35000, 'Laptops', 'https://img.icons8.com/color/96/000000/laptop.png'),
(1, 'Laptop - HP Pavilion', 'Intel Core i7, 16GB RAM, 1TB SSD, 14-inch Display', 45000, 'Laptops', 'https://img.icons8.com/color/96/000000/laptop.png'),
(1, 'Computer Setup - Basic', 'Desktop PC with monitor, keyboard, and mouse', 25000, 'Computer Sets', 'https://img.icons8.com/color/96/000000/computer.png'),
(1, 'Laptop - Lenovo ThinkPad', 'Intel Core i7, 16GB RAM, 512GB SSD, 14-inch Display, Business Grade', 55000, 'Laptops', 'https://img.icons8.com/color/96/000000/laptop.png'),
(2, 'Caramel Macchiato', 'Rich espresso with caramel and steamed milk', 120, 'Drinks', 'https://img.icons8.com/color/96/000000/coffee-to-go.png'),
(2, 'Iced Americano', 'Espresso shots with cold water and ice', 100, 'Drinks', 'https://img.icons8.com/color/96/000000/coffee-to-go.png'),
(2, 'Vanilla Latte', 'Espresso with steamed milk and vanilla flavor', 130, 'Drinks', 'https://img.icons8.com/color/96/000000/coffee-to-go.png'),
(3, 'Fresh Pandesal', 'Classic Filipino bread rolls, freshly baked', 5, 'Bread', 'https://img.icons8.com/color/96/000000/bread.png'),
(3, 'Cheese Bread', 'Soft bread filled with cheesy goodness', 15, 'Bread', 'https://img.icons8.com/color/96/000000/bread.png'),
(3, 'Ensaymada', 'Sweet buttery bread with cheese topping', 25, 'Bread', 'https://img.icons8.com/color/96/000000/bread.png'),
(3, 'Spanish Bread', 'Soft bread with sweet filling, Filipino favorite', 12, 'Bread', 'https://img.icons8.com/color/96/000000/bread.png'),
(3, 'Chocolate Chip Cookie', 'Freshly baked cookie with chocolate chips, pack of 4', 35, 'Cookies', 'https://img.icons8.com/color/96/000000/cookie.png')
ON DUPLICATE KEY UPDATE name = name;

-- ============================================
-- DEFAULT DATA - TOURIST SPOTS
-- ============================================
INSERT INTO tourist_spots (name, description, location, image) 
VALUES 
('Mabinay Spring', 'Discover the beautiful mountains and nature trails in Mabinay.', 'Mabinay, Negros Oriental', 'https://img.icons8.com/color/96/000000/mountain.png'),
('Niludhan Falls', 'Visit stunning waterfalls perfect for sightseeing and relaxation.', 'Mabinay, Negros Oriental', 'https://img.icons8.com/color/96/000000/waterfall.png'),
('Bulwang Caves', 'Explore the famous caves and underground wonders of the area.', 'Mabinay, Negros Oriental', 'https://img.icons8.com/color/96/000000/cave.png')
ON DUPLICATE KEY UPDATE name = name;
