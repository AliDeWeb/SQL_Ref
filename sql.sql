USE database_name;

-- SELECT
SELECT name, (price * 2) AS double_price FROM products -- in select statement we can use expressions and aliases

-- AND OR NOT
SELECT * FROM products WHERE (unit_price > 1 OR quantity_in_stock > 20) AND NOT product_id=7

-- IN
SELECT * FROM products WHERE quantity_in_stock in (70, 49)
SELECT * FROM products WHERE name in ('Foam Dinner Plate', 'Pork - Bacon,back')

-- BETWEEN
SELECT * FROM products WHERE product_id BETWEEN 1 AND 5

-- LIKE
SELECT * FROM products WHERE name LIKE 'P%l' -- % means any number of characters
SELECT * FROM products WHERE name LIKE 'P__k%' -- _ means any single character

-- REGEXP
SELECT * FROM products WHERE name REGEXP 'P.*l'

-- IS NULL | IS NOT NULL
SELECT * FROM products WHERE name IS NULL
SELECT * FROM products WHERE name IS NOT NULL

-- ORDER BY
SELECT * FROM products ORDER BY name ASC -- ASC is default and it means ascending and can be omitted
SELECT * FROM products ORDER BY name DESC -- DESC means descending
SELECT * FROM products ORDER BY name DESC, unit_price ASC

-- LIMIT
SELECT * FROM products LIMIT 5
SELECT * FROM products LIMIT 4, 5 -- LIMIT 5 OFFSET 4
SELECT * FROM products LIMIT 5 OFFSET 5 -- OFFSET is used to skip the first 5 rows

-- JOIN
SELECT * FROM products INNER JOIN categories ON products.category_id = categories.category_id -- INNER JOIN is default and can be omitted
SELECT product_id AS id FROM products JOIN categories ON products.category_id = categories.category_id -- AS is used to rename the column
SELECT product_id AS id FROM products p JOIN categories AS c ON products.category_id = categories.category_id -- AS is used to set an alias for the table, also can be omitted
-----------------
-- SELF JOIN
SELECT * FROM products p1 JOIN products p2 ON p1.category_id = p2.category_id AND p1.product_id != p2.product_id -- self join is used to join a table with itself and we can use conditions in the ON clause
-----------------
-- OUTER JOIN => LEFT JOIN | RIGHT JOIN
SELECT * FROM products LEFT JOIN categories ON products.category_id = categories.category_id -- LEFT JOIN returns all rows from the left table and the matched rows from the right table
SELECT * FROM products RIGHT JOIN categories ON products.category_id = categories.category_id -- RIGHT JOIN returns all rows from the right table and the matched rows from the left table
SELECT * FROM products LEFT JOIN categories USING (category_id) -- when the columns have the same name we can use USING instead of ON

-- UNION
SELECT * FROM products WHERE category_id = 1 UNION SELECT * FROM products WHERE category_id = 2 -- UNION is used to combine the result of two or more SELECT statements

-- INSERT
INSERT INTO products(name, category, price) VALUES ('laptop', 'electronic', 1300) -- Inserting single row
INSERT INTO products(name, category, price) VALUES ('laptop', 'electronic', 1300), ('phone', 'electronic', 800), ('charger', 'electronic', 25) -- Inserting multi rows
LAST_INSERT_ID() -- LAST_INSERT_ID() returns the last automatically generated value from an AUTO_INCREMENT column

-- UPDATE
UPDATE customers SET first_name='John' -- all rows will be updated
UPDATE customers SET first_name='John' WHERE customer_id=1 -- based on the condition we just update single row
UPDATE customers SET first_name='John' WHERE customer_id>10 -- based on the condition we update multi rows

-- DELETE
DELETE FROM customers -- all rows will be deleted
DELETE FROM customers WHERE customer_id=1 -- based on the condition we just delete single row
DELETE FROM customers WHERE customer_id>1 -- based on the condition we delete multi rows

-- CREATE TABLE
CREATE TABLE users (name VARCHAR(255), age INTEGER NOT NULL)
CREATE TABLE IF NOT EXISTS users (name VARCHAR(255), age INTEGER NOT NULL) -- creates a table if it does not already exist
