-- Creating access for Antonet Chepkoech
CREATE USER 'antonet_user'@'%' IDENTIFIED BY 'AntonetPass#92!rTxB';

-- Creating access for Yewande Florence Morris
CREATE USER 'yewande_user'@'%' IDENTIFIED BY 'YewandePass#87!qLmC';

-- Grant users permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_db.* TO 'antonet_user'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_db.* TO 'yewande_user'@'%';

-- Apply user privileges
FLUSH PRIVILEGES;

SELECT user, host FROM mysql.user;

FLUSH PRIVILEGES;

-- 1. Create author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    nationality VARCHAR(100)
);

-- 2. Create book_language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

-- 3. Create publisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    contact_email VARCHAR(100)
);

-- 4. Create book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year INT,
    price DECIMAL(10, 2) NOT NULL,
    language_id INT,
    publisher_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- 5. Create book_author table
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 6. Create country table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- 7. Create address_status table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- 8. Create address table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 9. Create customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    date_of_birth DATE
);

-- 10. Create shipping_method table
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2)
);

-- 11. Create order_status table
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100) NOT NULL
);

-- 12. Create customer_address table
CREATE TABLE customer_address (
    customer_address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address_id INT,
    address_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(status_id)
);

-- 13. Create cust_order table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

-- 14. Create order_line table
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 15. Create order_history table
CREATE TABLE order_history (
    order_history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_change_date DATE,
    status_id INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);

-- 1. Insert authors
INSERT INTO author (first_name, last_name, date_of_birth, nationality) VALUES
('Chinua', 'Achebe', '1930-11-16', 'Nigerian'),
('Ngũgĩ', 'wa Thiong\'o', '1938-01-05', 'Kenyan'),
('Léon', 'Gontran Damas', '1912-03-28', 'French Guianese'),
('Scholastique', 'Mukasonga', '1956-05-12', 'Rwandese');

-- 2. Insert book languages
INSERT INTO book_language (language_name) VALUES
('English'),
('Swahili'),
('French');

-- 3. Insert publishers
INSERT INTO publisher (publisher_name, address, contact_email) VALUES
('African Writers Press', '12 Independence Ave, Accra, Ghana', 'contact@africanwriters.com'),
('East Africa Publishers', '7 Moi Avenue, Nairobi, Kenya', 'info@eapublishers.co.ke');

-- 4. Insert books
INSERT INTO book (title, isbn, publication_year, price, language_id, publisher_id) VALUES
('Things Fall Apart', '9780435905255', 1958, 12.99, 1, 1),
('Petals of Blood', '9780435908461', 1977, 15.50, 1, 2),
('The Barefoot Woman', '9781936932214', 2018, 13.00, 3, 1);

-- 5. Insert book authors
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 4);

-- 6. Insert countries
INSERT INTO country (country_name) VALUES
('Kenya'),
('Rwanda'),
('Mauritius');

-- 7. Insert address statuses
INSERT INTO address_status (status_name) VALUES
('Home'),
('Billing');

-- 8. Insert addresses
INSERT INTO address (street_address, city, zip_code, country_id) VALUES
('123 Kenyatta Ave', 'Nairobi', '00100', 1),
('45 Kigali Rd', 'Kigali', '25001', 2),
('88 Rue Charles', 'Port Louis', '11201', 3);

-- 9. Insert customers
INSERT INTO customer (first_name, last_name, email, phone_number, date_of_birth) VALUES
('Achieng', 'Opiyo', 'achieng@gmail.com', '+254724586963', '1994-06-10'),
('Jean', 'Uwase', 'uwase.rwanda@outlook.com', '+250725141836', '1990-11-11'),
('Thierry', 'Merven', 'thierrymev@outlook.com', '+23058012325', '1985-04-19');

-- 10. Insert shipping methods
INSERT INTO shipping_method (method_name, price) VALUES
('Standard', 3.50),
('Express', 6.99);

-- 11. Insert order statuses
INSERT INTO order_status (status_name) VALUES
('Pending'),
('Shipped'),
('Delivered');

-- 12. Insert customer addresses
INSERT INTO customer_address (customer_id, address_id, address_status_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2);

-- 13. Insert customer orders
INSERT INTO cust_order (customer_id, order_date, total_amount, shipping_method_id, order_status_id) VALUES
(1, '2025-02-10', 25.98, 1, 1),
(2, '2025-02-09', 15.50, 2, 2),
(3, '2025-02-08', 13.00, 1, 3);

-- 14. Insert order lines
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 2, 12.99),
(2, 2, 1, 15.50),
(3, 3, 1, 13.00);

-- 15. Insert order history
INSERT INTO order_history (order_id, status_change_date, status_id) VALUES
(1, '2025-02-10', 1),
(2, '2025-02-09', 2),
(3, '2025-02-08', 3);

-- Queries to retrieve data from the bookstore database
SELECT 
    b.title AS book_title,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    bl.language_name,
    p.publisher_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
JOIN book_language bl ON b.language_id = bl.language_id
JOIN publisher p ON b.publisher_id = p.publisher_id;

SELECT 
    ol.order_id,
    b.title AS book_title,
    ol.quantity,
    ol.price
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
ORDER BY ol.order_id;

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    co.order_date,
    os.status_name AS order_status,
    co.total_amount
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN order_status os ON co.order_status_id = os.order_status_id
ORDER BY co.order_date DESC;

SELECT 
    c.first_name,
    c.last_name,
    c.email,
    a.street_address,
    a.city,
    cn.country_name
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country cn ON a.country_id = cn.country_id;
