# SQL for Data Science

A structured, reproducible record of SQL learning — from foundations through PostgreSQL-specific data engineering skills — built while preparing for data analyst / data engineer roles.

Each topic block includes:
- `notes.md` — concepts covered, explained in my own words
- `queries.sql` — working practice queries, commented
- `mini-project.sql` — a small business-analysis exercise applying the block's concepts end-to-end

## Dataset

All queries run against the [Chinook database](https://github.com/lerocha/chinook-database) — a sample digital music store schema (customers, invoices, tracks, artists, albums, employees) loaded into PostgreSQL. The schema dump is included in `datasets/chinook/chinook.sql`.

### Reproducing locally

```bash
createdb chinook
psql chinook < datasets/chinook/chinook.sql
```

## Progress

| Block | Topic | Status |
|---|---|---|
| 01 | Foundations & joins | ✅ |
| 02 | Aggregation & grouping | 🔜 |
| 03 | Window functions | 🔜 |
| 04 | CTEs & query optimization | 🔜 |
| 05 | Postgres-specific & data engineering | 🔜 |

## Tools

PostgreSQL 16, psql, pgAdmin