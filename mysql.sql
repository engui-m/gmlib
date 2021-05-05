SELECT * FROM employees.titles limit 15;
-- +--------+--------------------+------------+------------+
-- | emp_no | title              | from_date  | to_date    |
-- +--------+--------------------+------------+------------+
-- |  10001 | Senior Engineer    | 1986-06-26 | 9999-01-01 |
-- |  10002 | Staff              | 1996-08-03 | 9999-01-01 |
-- |  10003 | Senior Engineer    | 1995-12-03 | 9999-01-01 |
-- |  10004 | Engineer           | 1986-12-01 | 1995-12-01 |
-- |  10004 | Senior Engineer    | 1995-12-01 | 9999-01-01 |
-- |  10005 | Senior Staff       | 1996-09-12 | 9999-01-01 |
-- |  10005 | Staff              | 1989-09-12 | 1996-09-12 |
-- |  10006 | Senior Engineer    | 1990-08-05 | 9999-01-01 |
-- |  10007 | Senior Staff       | 1996-02-11 | 9999-01-01 |
-- |  10007 | Staff              | 1989-02-10 | 1996-02-11 |
-- |  10008 | Assistant Engineer | 1998-03-11 | 2000-07-31 |
-- |  10009 | Assistant Engineer | 1985-02-18 | 1990-02-18 |
-- |  10009 | Engineer           | 1990-02-18 | 1995-02-18 |
-- |  10009 | Senior Engineer    | 1995-02-18 | 9999-01-01 |
-- |  10010 | Engineer           | 1996-11-24 | 9999-01-01 |
-- +--------+--------------------+------------+------------+

DROP TABLE IF EXISTS cp_titles_date; CREATE TABLE cp_titles_date AS SELECT title, to_date FROM titles;
-- Query OK, 443308 rows affected (3.17 sec)
-- Records: 443308  Duplicates: 0  Warnings: 0

SELECT * FROM cp_titles_date limit 15;
-- +--------------------+------------+
-- | title              | to_date    |
-- +--------------------+------------+
-- | Senior Engineer    | 9999-01-01 |
-- | Staff              | 9999-01-01 |
-- | Senior Engineer    | 9999-01-01 |
-- | Engineer           | 1995-12-01 |
-- | Senior Engineer    | 9999-01-01 |
-- | Senior Staff       | 9999-01-01 |
-- | Staff              | 1996-09-12 |
-- | Senior Engineer    | 9999-01-01 |
-- | Senior Staff       | 9999-01-01 |
-- | Staff              | 1996-02-11 |
-- | Assistant Engineer | 2000-07-31 |
-- | Assistant Engineer | 1990-02-18 |
-- | Engineer           | 1995-02-18 |
-- | Senior Engineer    | 9999-01-01 |
-- | Engineer           | 9999-01-01 |
-- +--------------------+------------+
-- 15 rows in set (0.00 sec)

UPDATE cp_titles_date SET to_date = NULL WHERE title = 'Staff';
-- Query OK, 107391 rows affected (1.12 sec)
-- Rows matched: 107391  Changed: 107391  Warnings: 0