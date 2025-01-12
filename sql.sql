USE database_name;

-- SELECT
SELECT name, (price * 2) AS double_price FROM products -- in select statement we can use expressions and aliases
SELECT DISTINCT city FROM customers -- returns only unique values from the specified columns

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

-- DELETE TABLE
DROP TABLE users
DROP TABLE IF EXISTS table_name -- deletes a table if it exists

-- Aggregations => MIN() | MAX() | AVG() | COUNT() | SUM()
SELECT SUM(price) AS total FROM products
SELECT COUNT(*) AS total FROM products WHERE create_at > '2025-11-26' -- aggregations will skip the null values, so to calculate count we must use * to consider all rows.

-- GROUP BY
SELECT client_id, SUM(payment_total) AS total_payment FROM invoices GROUP BY client_id WHERE create_at > '2025-11-26'
SELECT client_id, SUM(payment_total) FROM invoices GROUP BY client_id, payment_total -- Selects the client_id and the sum of payment_total from invoices, grouping by both client_id and payment_total, it means it will do it for any form of mixing these two items

-- HAVING
SELECT SUM(payment_total) FROM invoices GROUP BY client_id HAVING payment_total > 500 -- using HAVING we can check conditions after grouping data

-- SUB QUERIES
SELECT * FROM products WHERE unit_price > (SELECT AVG(unit_price) FROM products)
SELECT * FROM invoices WHERE invoice_total = ALL (SELECT invoice_total FROM invoices) -- ALL keyword is used to compare a value to all values in another result set (AND)
SELECT * FROM invoices WHERE invoice_total = ANY (SELECT invoice_total FROM invoices) -- ANY keyword is used to compare a value to any values in another result set (OR)
SELECT name FROM students WHERE EXISTS (SELECT 1 FROM enrollments WHERE students.id = enrollments.student_id) -- EXISTS checks if a subquery returns any rows; it returns TRUE if rows exist, otherwise FALSE.
SELECT invoice_id, invoice_total, payment_total, (SELECT AVG(invoice_total) FROM invoices) AS average, invoice_total - (SELECT average) AS difference FROM invoices;

-- BUILT-IN SQL FUNCTIONS
-- NUMBERS
SELECT ROUND(5.6) -- => 6
SELECT ROUND(5.678, 2) -- => 5.68
SELECT TRUNCATE(5.689898,3) -- => 5.689
SELECT CEIL(5.9) -- => 6
SELECT FLOOR(5.9) -- => 5
SELECT ABS(-5) -- => 5
SELECT RAND() -- => random number between 0 and 1
-----------------
-- STRINGS *INDEX starts at 1 not 0!
SELECT LENGTH('john') -- => 4
SELECT UPPER('john') -- => JOHN
SELECT LOWER('JOHN') -- => john
SELECT LOWER(TRIM('JOHN    ')) -- => john
SELECT RTRIM('JOHN    ') -- => JOHN
SELECT LTRIM('    JOHN') -- => JOHN
SELECT LEFT('john',2) -- => jo
SELECT RIGHT('john',2) -- => hn
SELECT SUBSTRING('john is coming home', 8) -- =>  coming home, from index 8 to the end
SELECT SUBSTRING('john is coming home', 8, 7) -- =>  coming, from index 8 to 7 index after
SELECT LOCATE("o", "john is coming home") -- => 2
SELECT LOCATE("is", "john is coming home") -- => 6
SELECT REPLACE("john is coming home", "is", "is not") -- => john is not coming home
SELECT CONCAT('HELLO', ' WORLD') -- => HELLO WORLD
-----------------
-- DATE & TIME
SELECT NOW() -- => 2025-01-12 11:59:56
SELECT CURDATE() -- => 2025-01-12
SELECT CURTIME() -- => 12:00:53
SELECT YEAR(NOW()) -- YEAR | MONTH | DAY | HOUR | MINUTE | SECOND | DAYNAME | MONTHNAME
SELECT EXTRACT(DAY FROM NOW()) -- it is the standard way to use dates
SELECT DATE_FORMAT(NOW(), '%Y-%y-%M-%m-%D-%d-%H-%h-%p') -- => 2025-25-January-01-12th-12-12-12-PM
SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR) -- => 2026-01-12 12:18:46
SELECT DATE_ADD(NOW(), INTERVAL -1 YEAR) -- => 2024-01-12 12:18:46
SELECT DATEDIFF(NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR)) -- => -365 (day)
SELECT TIME_TO_SEC('01:00') - TIME_TO_SEC('02:00') -- => -3600 (sec)

-- IFNULL
SELECT shipper_id, IFNUll(shipper_id, 'not assigned') AS formatted FROM orders

-- IF
SELECT *, IF(order_date > '2018-01-01', 'active', 'not active') AS status FROM orders

-- CASE WHEN THEN END
SELECT *, CASE WHEN status=1 THEN 'active' WHEN status=2 THEN 'not active' ElSE 'unknown' END AS status FROM orders

-- VIEWS => it is a virtual table, we treat views the same way we treat tables.
CREATE VIEW cv
CREATE OR REPLACE VIEW cv
CREATE VIEW cv AS SELECT * FROM customers WHERE customer_id > 8
CREATE VIEW cv AS SELECT * FROM customers WHERE customer_id > 8 WITH CHECK OPTION -- WITH CHECK OPTION ensures that all INSERT and UPDATE operations on the view adhere to the view's WHERE clause conditions.
DROP VIEW IF EXISTS cv

-- PROCEDURE
-- Better Code Management: SQL commands are stored as a single unit, making them easier to manage.
-- Improved Performance: Procedures are compiled once and stored, enhancing execution speed.
-- Enhanced Security: Access levels for execution or viewing can be controlled.
-- Reduced Network Traffic: Data processing occurs on the database server, minimizing client-server requests.
-- Parameterization: Supports input and output parameters for dynamic and reusable processes.
-- CREATE
DELIMITER $$ -- DELIMITER is used to define a custom statement terminator in SQL to avoid confusion with default semicolons inside procedures.
CREATE PROCEDURE get_clients()
BEGIN
	SELECT * FROM customers;
END $$
DELIMITER ;
-----------------
-- USE
CALL get_clients()
-----------------
-- DELETE
DROP PROCEDURE IF EXISTS get_clients
-----------------
-- GET PARAMETERS
DELIMITER $$
CREATE PROCEDURE get_clients(state CHAR(2))
BEGIN
	SELECT * FROM customers c
    WHERE c.state = state;
END $$
DELIMITER ;
-- USAGE
CALL get_clients('VA')
-----------------
-- SET DEFAULT VALUES FOR PARAMS
DELIMITER $$
CREATE PROCEDURE get_clients(state CHAR(2))
BEGIN
	IF state IS NULL THEN 
		SET state = 'CA';
	END IF;
	SELECT * FROM customers c
    WHERE c.state = state;
END $$
DELIMITER ;
-- or
DELIMITER $$
CREATE PROCEDURE get_clients(state CHAR(2))
BEGIN
	SELECT * FROM customers c
    WHERE c.state = IFNULL(state, 'VA');
END $$
DELIMITER ;
-----------------
-- PARAMS VALIdATION
DROP PROCEDURE IF EXISTS get_clients;
DELIMITER $$
CREATE PROCEDURE get_clients(state CHAR(2), points INTEGER)
BEGIN
	IF points < 0 THEN SIGNAL SQLSTATE '22003' SET MESSAGE_TEXT = 'INVALID POINT'; END IF;
	SELECT * FROM customers c
    WHERE c.state = IFNULL(state, 'VA');
END $$
DELIMITER ;
-----------------
-- OUTPUT PARAMS
DROP PROCEDURE IF EXISTS get_clients;
DELIMITER $$
CREATE PROCEDURE get_clients(state CHAR(2), OUT count INTEGER, OUT points INTEGER)
BEGIN
	SELECT COUNT(*), SUM(points)
    INTO count, points
    FROM customers c
    WHERE c.state = IFNULL(state, 'VA');
END $$
DELIMITER ;
-- USAGE
SET @count = 0;
SET @points = 0;
CALL get_clients('va', @count, @points);
SELECT @count, @points;

-- VARIABLES
-- Session vars
SET @count = 0; -- the variable exists as long as the connection is open
-----------------
-- Local vars
DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
    DECLARE var1 INT DEFAULT 5;  -- the variable exists as long as the PROCEDURE done its task

    SET var1 = 12
END $$
DELIMITER ;
