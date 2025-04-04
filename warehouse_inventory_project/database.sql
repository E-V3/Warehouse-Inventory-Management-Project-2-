CREATE DATABASE warehouse_db;
USE warehouse_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    supplier_id INT,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE SET NULL
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO suppliers (name, contact_info) VALUES
('Tech Supply Co.', 'tech@email.com'),
('Warehouse Solutions Ltd.', 'warehouse@email.com');

INSERT INTO products (name, description, quantity, supplier_id, price) VALUES
('Laptop', 'Business laptop', 10, 1, 999.99),
('Warehouse Scanner', 'Barcode scanner', 5, 2, 199.99),
('Forklift', 'Warehouse Forklift', 2, 2, 8999.99);

INSERT INTO orders (status) VALUES
('Pending'),
('Shipped');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 999.99),
(2, 3, 1, 8999.99);