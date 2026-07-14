-- Block 01: Foundations & Joins — Practice Queries
-- Run against the Chinook database

-- Basic single-table querying

-- All columns, limited preview
SELECT * FROM customer LIMIT 5;

-- Specific columns
SELECT first_name, last_name, country FROM customer;

-- Filtering with WHERE
SELECT first_name, last_name, country
FROM customer
WHERE country = 'Canada';

-- Numeric filter
SELECT name, unit_price
FROM track
WHERE unit_price > 0.99;

-- Total track count
SELECT COUNT(*) FROM track;

-- USA customers, sorted alphabetically by last name
SELECT first_name, last_name
FROM customer
WHERE country = 'USA'
ORDER BY last_name ASC;

-- Top 10 most expensive tracks
SELECT name, unit_price
FROM track
ORDER BY unit_price DESC
LIMIT 10;

-- Number of genres
SELECT COUNT(*) FROM genre;


-- Joins

-- Inner join: invoices with the customer who made them
SELECT c.first_name, c.last_name, i.invoice_id, i.total
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id;

-- Left join: every customer, with invoice_id if they have one (NULL if not)
SELECT c.first_name, c.last_name, i.invoice_id
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id;

-- Left join + gap-finding: customers with zero invoices
SELECT c.first_name, c.last_name, i.invoice_id
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id
WHERE i.invoice_id IS NULL;
-- Result: 0 rows — every customer in Chinook has made at least one purchase

-- Two-table join: track name + genre name
SELECT t.name AS track_name, g.name AS genre_name, t.unit_price
FROM track t
JOIN genre g ON t.genre_id = g.genre_id;