USE database_name;

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
SELECT * FROM products ORDER BY name ASC -- ASC is default and it means ascending
SELECT * FROM products ORDER BY name DESC -- DESC means descending
SELECT * FROM products ORDER BY name DESC, unit_price ASC

-- LIMIT
SELECT * FROM products LIMIT 5
SELECT * FROM products LIMIT 4, 5 -- LIMIT 5 OFFSET 4
SELECT * FROM products LIMIT 5 OFFSET 5 -- OFFSET is used to skip the first 5 rows

