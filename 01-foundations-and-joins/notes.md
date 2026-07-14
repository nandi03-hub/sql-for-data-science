# Block 01 — Foundations & Joins

## Basic single-table querying

- `SELECT columns FROM table` to pick specific columns; `SELECT *` for all (fine for exploring, avoid in real queries)
- `WHERE` filters rows before they're returned. String values need **single quotes** (`'Canada'`); double quotes are reserved for column/table identifiers in Postgres.
- `ORDER BY column ASC|DESC` sorts results; ascending is the default.
- `LIMIT n` caps the number of rows returned.
- Aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) collapse many rows into one number.
- **Rule:** if a query mixes a plain column with an aggregate function, it needs `GROUP BY` — the plain column tells the aggregate how to bucket rows before collapsing them.

## Joins

Joins combine rows from two or more tables based on a shared key (usually a foreign key relationship, e.g. `invoice.customer_id` referencing `customer.customer_id`).

- **INNER JOIN** (or just `JOIN`) — keeps only rows with a match in both tables. If a customer has no invoices, they disappear from the result.
- **LEFT JOIN** — keeps every row from the left (first) table, whether or not it finds a match on the right. Unmatched rows show `NULL` for the right table's columns. Essential for "find rows in A with no match in B" questions — e.g. `LEFT JOIN ... WHERE right_table.key IS NULL`.
- **RIGHT JOIN** — mirror of LEFT; keeps everything from the right table. Rarely used in practice since you can just reorder tables and use LEFT.
- **FULL JOIN** — keeps everything from both tables, matched or not.

### Syntax pattern

```sql
SELECT a.col1, b.col2
FROM table_a a
JOIN table_b b ON a.shared_key = b.shared_key;
```

Multiple joins chain together, each with its own `ON` clause:

```sql
FROM table1 t1
JOIN table2 t2 ON t1.key = t2.key
JOIN table3 t3 ON t2.key = t3.key
```

### Clause order matters

SQL clauses must appear in this order — this isn't stylistic, the query fails otherwise:

```
SELECT ... FROM ... JOIN ... ON ... WHERE ... GROUP BY ... ORDER BY ... LIMIT ...
```

Self-joins

A table can be joined to itself when a column refers back to another row in the same table (e.g. Employee.managerId refers to another Employee.id). Use two different aliases for the same table to treat it as two logical roles:

sqlSELECT e1.name
FROM Employee e1
JOIN Employee e2 ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;

e1 and e2 both point at Employee, but represent different roles ("the employee" vs. "their manager").

NULL and joins

NULL never equals anything — not even another NULL. NULL = NULL evaluates to unknown, not true.

Consequence: in an INNER JOIN, if the join column is NULL on one side (e.g. an employee with no manager), that row can never match anything on the other side — it simply doesn't appear in the result. It does not show up with NULLs; it's silently dropped.
This only matters for INNER JOIN. With LEFT JOIN, the row from the left table is kept regardless, and unmatched columns from the right table show as NULL — that's the "gap-finding" pattern.

## Common mistakes I made (and why they happened)

1. **Trailing comma before FROM** — `SELECT a, b, FROM table` fails because the comma signals "more columns coming."
2. **Double quotes for string literals** — `WHERE country = "Canada"` fails because Postgres reads double quotes as an identifier (column/table name), not a string value.
3. **Referencing a column from the wrong table alias** — e.g. writing `c.invoice_id` when `invoice_id` actually lives in the `invoice` table, not `customer`. Aliasing doesn't grant access to columns that don't exist in that table.
4. **GROUP BY before JOIN** — clause order is fixed; GROUP BY must come after all FROM/JOIN clauses.
5. **Grouping by a non-unique column** (e.g. `first_name` alone) — multiple people can share a first name, so grouping/selecting by a non-unique field can blend distinct entities together. Group by the primary key (and any columns functionally dependent on it) instead.