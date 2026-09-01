-- ============================================
-- TASK 3: SQL FOR DATA ANALYSIS
-- E-COMMERCE DATABASE
-- ============================================


-- ============================================
-- 1. CREATE TABLES
-- ============================================

CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    city TEXT,
    country TEXT
);

CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- ============================================
-- 2. INSERT CUSTOMER DATA
-- ============================================

INSERT INTO Customers VALUES
(1, 'Arun Kumar', 'Chennai', 'India'),
(2, 'Priya Sharma', 'Mumbai', 'India'),
(3, 'Rahul Singh', 'Delhi', 'India'),
(4, 'Anitha Raj', 'Bangalore', 'India'),
(5, 'John Smith', 'New York', 'USA'),
(6, 'Emma Wilson', 'London', 'UK');


-- ============================================
-- 3. INSERT PRODUCT DATA
-- ============================================

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Smartphone', 'Electronics', 30000),
(103, 'Headphones', 'Electronics', 2500),
(104, 'Office Chair', 'Furniture', 8500),
(105, 'Desk', 'Furniture', 12000),
(106, 'Keyboard', 'Electronics', 1800),
(107, 'Running Shoes', 'Fashion', 3500),
(108, 'Backpack', 'Fashion', 2200);


-- ============================================
-- 4. INSERT ORDER DATA
-- ============================================

INSERT INTO Orders VALUES
(1001, 1, '2026-01-10'),
(1002, 2, '2026-01-12'),
(1003, 3, '2026-01-15'),
(1004, 1, '2026-01-20'),
(1005, 4, '2026-01-22'),
(1006, 5, '2026-02-01'),
(1007, 6, '2026-02-05'),
(1008, 2, '2026-02-10');


-- ============================================
-- 5. INSERT ORDER ITEMS
-- ============================================

INSERT INTO Order_Items VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1002, 106, 1),
(5, 1003, 104, 1),
(6, 1003, 105, 1),
(7, 1004, 107, 2),
(8, 1005, 108, 1),
(9, 1005, 103, 1),
(10, 1006, 101, 1),
(11, 1007, 102, 2),
(12, 1008, 105, 1);


-- ============================================
-- 6. SELECT
-- Display all products
-- ============================================

SELECT *
FROM Products;


-- ============================================
-- 7. WHERE
-- Find Electronics products
-- ============================================

SELECT product_name, category, price
FROM Products
WHERE category = 'Electronics';


-- ============================================
-- 8. ORDER BY
-- Sort products by highest price
-- ============================================

SELECT product_name, category, price
FROM Products
ORDER BY price DESC;


-- ============================================
-- 9. GROUP BY
-- Count products in each category
-- ============================================

SELECT category, COUNT(*) AS product_count
FROM Products
GROUP BY category;


-- ============================================
-- 10. AGGREGATE FUNCTIONS
-- SUM and AVG
-- ============================================

SELECT
    SUM(price) AS total_product_value,
    AVG(price) AS average_product_price
FROM Products;


-- ============================================
-- 11. INNER JOIN
-- Display customers and their orders
-- ============================================

SELECT
    Customers.customer_name,
    Orders.order_id,
    Orders.order_date
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id;


-- ============================================
-- 12. LEFT JOIN
-- Display all customers and their orders
-- ============================================

SELECT
    Customers.customer_name,
    Orders.order_id,
    Orders.order_date
FROM Customers
LEFT JOIN Orders
ON Customers.customer_id = Orders.customer_id;


-- ============================================
-- 13. RIGHT JOIN EQUIVALENT FOR SQLITE
-- SQLite can achieve the same result by
-- reversing the tables and using LEFT JOIN.
-- ============================================

SELECT
    Customers.customer_name,
    Orders.order_id,
    Orders.order_date
FROM Orders
LEFT JOIN Customers
ON Orders.customer_id = Customers.customer_id;


-- ============================================
-- 14. SUBQUERY
-- Products above average price
-- ============================================

SELECT product_name, category, price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
);


-- ============================================
-- 15. VIEW
-- Create a view for customer orders
-- ============================================

CREATE VIEW Customer_Order_View AS
SELECT
    Customers.customer_name,
    Customers.city,
    Orders.order_id,
    Orders.order_date
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id;


-- Display the VIEW

SELECT *
FROM Customer_Order_View;


-- ============================================
-- 16. INDEX
-- Optimize searching by customer_id
-- ============================================

CREATE INDEX idx_orders_customer_id
ON Orders(customer_id);


-- Check the INDEX

PRAGMA index_list('Orders');


-- ============================================
-- END OF TASK 3
-- ============================================