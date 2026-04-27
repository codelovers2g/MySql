DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products(name, price, category) VALUES
('Laptop',1200,'Electronics'),
('Mouse',25,'Accessories'),
('Keyboard',60,'Accessories');

SELECT * FROM products;

-- 1 : WINDOW FUNCTION (ROW_NUMBER)
-- analytics ranking
SELECT
    name,
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) AS price_rank
FROM products;

-- 2 : COMMON TABLE EXPRESSION (CTE)
-- Cleaner readable query logic
WITH expensive_products AS (
    SELECT * FROM products WHERE price > 100
)
SELECT * FROM expensive_products;

-- 3 : JSON_OBJECT (API READY DATA)
-- JSON response directly from database
SELECT JSON_OBJECT(
    'id', id,
    'name', name,
    'price', price
) AS product_json
FROM products;

-- 4 : GENERATED COLUMN
-- Automatic calculated column (modern schema design)
ALTER TABLE products
ADD price_with_tax DECIMAL(10,2)
GENERATED ALWAYS AS (price * 1.18) STORED;

SELECT name, price, price_with_tax FROM products;

-- 5 : WINDOW AGGREGATE (RUNNING TOTAL)
-- reporting & analytics pattern
SELECT
    id,
    name,
    price,
    SUM(price) OVER (ORDER BY id) AS running_total
FROM products;