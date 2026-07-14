-- Block 01 Mini-Project: Sales & Customer Insights
-- Business questions answered using single-table aggregation and joins on Chinook

-- Q1: Top 5 best-selling tracks by quantity (by track_id)
SELECT track_id, SUM(quantity) AS total_sold
FROM invoice_line
GROUP BY track_id
ORDER BY total_sold DESC
LIMIT 5;

-- Q2: Top 5 best-selling tracks by quantity, showing track name
SELECT t.name, SUM(il.quantity) AS total_sold
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
GROUP BY t.name
ORDER BY total_sold DESC
LIMIT 5;

-- Q3: Which genre has generated the most total revenue?
SELECT g.name, SUM(il.unit_price * il.quantity) AS revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY revenue DESC;

-- Q4: Customers who have never purchased anything
SELECT c.first_name
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id
WHERE i.invoice_id IS NULL;
-- Result: 0 rows — confirms every customer has purchased at least once

-- Q5: Total amount spent per customer, top 10 spenders
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- Q6: USA customers and the track names they've purchased
SELECT c.first_name, t.name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
WHERE c.country = 'USA';