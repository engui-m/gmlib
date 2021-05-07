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

DROP TABLE IF EXISTS cp_rental_append; CREATE TABLE cp_rental_append SELECT rental_id, rental_date FROM rental;
select * from cp_rental_append limit 5;
-- +-----------+---------------------+
-- | rental_id | rental_date         |
-- +-----------+---------------------+
-- |         1 | 2005-05-24 22:53:30 |
-- |         2 | 2005-05-24 22:54:33 |
-- |         3 | 2005-05-24 23:03:39 |
-- |         4 | 2005-05-24 23:04:41 |
-- |         5 | 2005-05-24 23:05:21 |
-- +-----------+---------------------+
-- 5 rows in set (0.00 sec)


DROP TABLE IF EXISTS cp_rental_id; CREATE TABLE cp_rental_id AS SELECT rental_id, rental_date FROM cp_rental_append;
-- select * from cp_rental_id limit 5;
-- +-----------+---------------------+
-- | rental_id | rental_date         |
-- +-----------+---------------------+
-- |         1 | 2005-05-24 22:53:30 |
-- |         2 | 2005-05-24 22:54:33 |
-- |         3 | 2005-05-24 23:03:39 |
-- |         4 | 2005-05-24 23:04:41 |
-- |         5 | 2005-05-24 23:05:21 |
-- +-----------+---------------------+
-- 5 rows in set (0.00 sec)

DROP TABLE IF EXISTS cp_rental_date; CREATE TABLE cp_rental_date AS SELECT rental_id, rental_date FROM cp_rental_append;
-- select * from cp_rental_date limit 5;
-- +-----------+---------------------+
-- | rental_id | rental_date         |
-- +-----------+---------------------+
-- |         1 | 2005-05-24 22:53:30 |
-- |         2 | 2005-05-24 22:54:33 |
-- |         3 | 2005-05-24 23:03:39 |
-- |         4 | 2005-05-24 23:04:41 |
-- |         5 | 2005-05-24 23:05:21 |
-- +-----------+---------------------+
-- 5 rows in set (0.00 sec)

--insert_rental.sql
use sakila;
DROP TABLE IF EXISTS cp_rental_append, cp_rental_date, cp_rental_id;
create table cp_rental_append select rental_id, rental_date from rental;
create table cp_rental_date select * from cp_rental_append;
create table cp_rental_id select * from cp_rental_date;

insert into cp_rental_date values(16048,'2005-08-23 22:30:00');
insert into cp_rental_date values(16049,'2005-08-23 22:40:00');
insert into cp_rental_date values(16050,'2005-08-23 22:52:50');
insert into cp_rental_date values(16051,'2005-08-23 22:54:30');
insert into cp_rental_date values(16052,'2005-08-23 22:55:20');
insert into cp_rental_date values(16054,'2005-08-23 22:57:40');
insert into cp_rental_date values(16053,'2005-08-23 22:56:10');
insert into cp_rental_date values(16055,'2005-08-23 22:59:20');

insert into cp_rental_id values(16048,'2005-08-23 22:30:00');
insert into cp_rental_id values(16049,'2005-08-23 22:40:00');
insert into cp_rental_id values(16050,'2005-08-23 22:52:50');
insert into cp_rental_id values(16051,'2005-08-23 22:54:30');
insert into cp_rental_id values(16052,'2005-08-23 22:55:20');
insert into cp_rental_id values(16054,'2005-08-23 22:57:40');
insert into cp_rental_id values(16053,'2005-08-23 22:56:10');
insert into cp_rental_id values(16055,'2005-08-23 22:59:20');

select * from cp_rental_date ORDER By rental_date DESC limit 10;

select * from cp_rental_id ORDER By rental_id DESC limit 10;
--end insert_rental.sql
