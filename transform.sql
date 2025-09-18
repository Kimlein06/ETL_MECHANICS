CREATE DATABASE IF NOT EXISTS etl_db;
USE etl_db;

CREATE TABLE IF NOT EXISTS raw_products(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brands VARCHAR(100),
    categories VARCHAR(255),
    nutrition_score CHAR(1)
);


-- load data 
LOAD DATA LOCAL INFILE 'path/to/your/raw_products.csv'---- FILL IN THE ABSOLUTE PATH TO THE FILE CREATED BY THE PYTHON FILE
INTO TABLE raw_products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_name, brands, categories, nutrition_score);

-- clean data
CREATE TABLE IF NOT EXISTS clean_products AS
SELECT * 
FROM raw_products
WHERE 
    product_name <> '' ;
;
-- group by categories and count
SELECT categories, COUNT(*) AS total_products
FROM clean_products
GROUP BY categories
ORDER BY total_products DESC
LIMIT 10;

-- transction table
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(255),
    quantity INT,
    transaction_date DATE
);
SELECT DISTINCT product_name from clean_products ;

-- sample data for transactions
INSERT INTO transactions (customer_id, product_name, quantity, transaction_date) VALUES
(101, 'Coca-Cola', 3, '2025-09-10'),
(102, 'Sidi Ali', 2, '2025-09-11'),
(103, 'CRISTALINE Eau De Source 0.5L', 5, '2025-09-11'),
(101, 'Orange juice', 1, '2025-09-12'),
(104, 'Ain Saiss Eau Minerale Naturelle', 4, '2025-09-12'),
(105, 'Coca-Cola', 2, '2025-09-13');

-- joining tables
SELECT t.transaction_id, t.customer_id, t.product_name, t.quantity,
       p.categories, p.nutrition_score
FROM transactions as t
LEFT JOIN clean_products as p
  ON t.product_name = p.product_name;

-- top products by sales quatity
SELECT t.product_name, SUM(t.quantity) AS total_sold
FROM transactions t
GROUP BY t.product_name
ORDER BY total_sold DESC;

-- sales and group by nutrition_score
SELECT p.nutrition_score, SUM(t.quantity) AS total_sold
FROM transactions t
JOIN clean_products p
  ON t.product_name = p.product_name
GROUP BY p.nutrition_score
ORDER BY total_sold DESC;

-- tansformed data into a new table
CREATE TABLE sales_summary AS
SELECT p.categories, p.nutrition_score, SUM(t.quantity) AS total_sold
FROM transactions t
JOIN clean_products p
  ON t.product_name = p.product_name
GROUP BY p.categories, p.nutrition_score;
