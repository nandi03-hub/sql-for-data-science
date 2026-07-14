
-- LeetCode SQL practice — Block 01 (Joins)
 
-- 175. Combine Two Tables
-- Report first name, last name, city, state for every person in Person,
-- regardless of whether they have an address (LEFT JOIN keeps unmatched rows).
SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;
 
 
-- 181. Employees Earning More Than Their Managers
-- Self-join: treat Employee as two roles (employee and manager) via two aliases.
-- managerId is NULL for employees with no manager (e.g. CEO) — since NULL never
-- equals anything, those rows fail to match and are dropped by INNER JOIN.
SELECT e1.name AS Employee
FROM Employee e1
JOIN Employee e2 ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;
 
 
-- 183. Customers Who Never Order
-- Gap-finding pattern: LEFT JOIN + WHERE right_table_key IS NULL.
-- Bug I hit: joined on c.id = o.id (comparing customer id to order id —
-- unrelated columns). Fixed by joining on the actual foreign key relationship:
-- Customers.id = Orders.customerId.
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;