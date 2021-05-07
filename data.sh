docker-compose pull

docker-compose up -d

docker-compose start

docker-compose stop


docker exec -it namenode bash

hdfs dfs -ls /

hdfs dfs -ls -R -h /user/hive/warehouse/

hdfs dfs -put -h


docker exec -it hive-server bash

beeline -u jdbc:hive2://localhost:10000 # username password


docker exec -it database bash

mysql -h localhost -uroot -psecret


docker exec -it namenode bash

sqoop eval \
--connect jdbc:mysql://database/employees \
--username=root \
--password=secret \
--query "SELECT * FROM employees limit 15"

# ---------------------------------------------------------------------------------
# | emp_no      | birth_date | first_name     | last_name        | gender | hire_date  |
# ---------------------------------------------------------------------------------
# | 10001       | 1953-09-02 | Georgi         | Facello          | M | 1986-06-26 |
# | 10002       | 1964-06-02 | Bezalel        | Simmel           | F | 1985-11-21 |
# | 10003       | 1959-12-03 | Parto          | Bamford          | M | 1986-08-28 |
# | 10004       | 1954-05-01 | Chirstian      | Koblick          | M | 1986-12-01 |
# | 10005       | 1955-01-21 | Kyoichi        | Maliniak         | M | 1989-09-12 |
# | 10006       | 1953-04-20 | Anneke         | Preusig          | F | 1989-06-02 |
# | 10007       | 1957-05-23 | Tzvetan        | Zielinski        | F | 1989-02-10 |
# | 10008       | 1958-02-19 | Saniya         | Kalloufi         | M | 1994-09-15 |
# | 10009       | 1952-04-19 | Sumant         | Peac             | F | 1985-02-18 |
# | 10010       | 1963-06-01 | Duangkaew      | Piveteau         | F | 1989-08-24 |
# | 10011       | 1953-11-07 | Mary           | Sluis            | F | 1990-01-22 |
# | 10012       | 1960-10-04 | Patricio       | Bridgland        | M | 1992-12-18 |
# | 10013       | 1963-06-07 | Eberhardt      | Terkki           | M | 1985-10-20 |
# | 10014       | 1956-02-12 | Berni          | Genin            | M | 1987-03-11 |
# | 10015       | 1959-08-19 | Guoxiang       | Nooteboom        | M | 1987-07-02 |
# ---------------------------------------------------------------------------------


sqoop list-databases \
--connect jdbc:mysql://database \
--username root \
--password secret
# information_schema
# employees
# hue
# mysql
# performance_schema
# sakila
# sys

sqoop list-tables \
--connect jdbc:mysql://database/employees \
--username root \
--password secret
# current_dept_emp
# departments
# dept_emp
# dept_emp_latest_date
# dept_manager
# employees
# employees_2
# titles

sqoop eval \
--connect jdbc:mysql://database/employees \
--username=root \
--password=secret \
--query "INSERT INTO departments(dept_no, dept_name) VALUES('d010','BI')"

sqoop eval \
--connect jdbc:mysql://database/employees \
--username=root \
--password=secret \
--query "SELECT * FROM departments"
# -------------------------------
# | dept_no | dept_name            |
# -------------------------------
# | d010 | BI                   |
# | d009 | Customer Service     |
# | d005 | Development          |
# | d002 | Finance              |
# | d003 | Human Resources      |
# | d001 | Marketing            |
# | d004 | Production           |
# | d006 | Quality Management   |
# | d008 | Research             |
# | d007 | Sales                |
# -------------------------------

sqoop eval \
--connect jdbc:mysql://database/employees \
--username=root \
--password=secret \
--query "CREATE TABLE benefits(cod int(2)  AUTO_INCREMENT PRIMARY KEY, name varchar(30))"

sqoop eval \
--connect jdbc:mysql://database/employees \
--username=root \
--password=secret \
--query "INSERT INTO benefits(cod, name) VALUES(null,'food vale')"

sqoop eval \
--connect jdbc:mysql://database/employees \
--username=root \
--password=secret \
--query "SELECT * FROM benefits"
# -----------------------------
# | cod | name                 |
# -----------------------------
# | 1  | food vale            |
# -----------------------------

sqoop eval --connect jdbc:mysql://database/employees --username=root --password=secret --query "SELECT * FROM employees limit 10"
# ---------------------------------------------------------------------------------
# | emp_no      | birth_date | first_name     | last_name        | gender | hire_date  |
# ---------------------------------------------------------------------------------
# | 10001       | 1953-09-02 | Georgi         | Facello          | M | 1986-06-26 |
# | 10002       | 1964-06-02 | Bezalel        | Simmel           | F | 1985-11-21 |
# | 10003       | 1959-12-03 | Parto          | Bamford          | M | 1986-08-28 |
# | 10004       | 1954-05-01 | Chirstian      | Koblick          | M | 1986-12-01 |
# | 10005       | 1955-01-21 | Kyoichi        | Maliniak         | M | 1989-09-12 |
# | 10006       | 1953-04-20 | Anneke         | Preusig          | F | 1989-06-02 |
# | 10007       | 1957-05-23 | Tzvetan        | Zielinski        | F | 1989-02-10 |
# | 10008       | 1958-02-19 | Saniya         | Kalloufi         | M | 1994-09-15 |
# | 10009       | 1952-04-19 | Sumant         | Peac             | F | 1985-02-18 |
# | 10010       | 1963-06-01 | Duangkaew      | Piveteau         | F | 1989-08-24 |
# ---------------------------------------------------------------------------------

sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test_a -delete-target-dir

sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --where "gender='M'" --warehouse-dir /user/hive/warehouse/db_test_b -delete-target-dir

sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --columns "first_name,last_name" --fields-terminated-by '\t' --warehouse-dir /user/hive/warehouse/db_test_c -delete-target-dir

sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --columns "first_name,last_name" --lines-terminated-by ':' --warehouse-dir /user/hive/warehouse/db_test_c -delete-target-dir

hdfs dfs -ls -R /user/hive/

hdfs dfs -cat /user/hive/db_test_c/employees/part-m-00000 | head -n 5


# sqoop import --table salaries --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test_salaries --as-avrodatafile -num-mappers 8 -delete-target-dir

sqoop import --table titles --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test2_4 --as-parquetfile -m 8 -delete-target-dir

sqoop import --table titles --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test2_5 --as-parquetfile --compress --compression-codec org.apache.hadoop.io.compress.SnappyCodec -m 8 -delete-target-dir

sqoop import --table cp_titles_date --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test2_6 -m 4 -delete-target-dir

sqoop import --table cp_titles_date --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test2_title --split-by title -m 4 -delete-target-dir #error

sqoop import -Dorg.apache.sqoop.splitter.allow_text_splitter=true --table cp_titles_date --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test2_title --split-by title -m 4 -delete-target-dir

sqoop import --table cp_titles_date --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test2_date --split-by to_date -delete-target-dir

hdfs dfs -ls -h -R /user/hive/warehouse/db_test2_date

hdfs dfs -ls -h -R /user/hive/warehouse/db_test2_title



sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-textfile --warehouse-dir /user/hive/warehouse/db_format_text -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_text
# drwxr-xr-x   - root supergroup          0 2021-05-06 21:14 /user/hive/warehouse/db_format_text/employees
# -rw-r--r--   3 root supergroup          0 2021-05-06 21:14 /user/hive/warehouse/db_format_text/employees/_SUCCESS
# -rw-r--r--   3 root supergroup     13.2 M 2021-05-06 21:14 /user/hive/warehouse/db_format_text/employees/part-m-00000

sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-textfile --warehouse-dir /user/hive/warehouse/db_format_text_snappy --compress --compression-codec org.apache.hadoop.io.compress.SnappyCodec -m 8 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_text_snappy
#erro

sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-textfile --warehouse-dir /user/hive/warehouse/db_format_text_gzip --compress --compression-codec=gzip -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_text_gzip
# drwxr-xr-x   - root supergroup          0 2021-05-06 21:35 /user/hive/warehouse/db_format_text_gzip/employees
# -rw-r--r--   3 root supergroup          0 2021-05-06 21:35 /user/hive/warehouse/db_format_text_gzip/employees/_SUCCESS
# -rw-r--r--   3 root supergroup      4.9 M 2021-05-06 21:35 /user/hive/warehouse/db_format_text_gzip/employees/part-m-00000.gz

sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-textfile --warehouse-dir /user/hive/warehouse/db_format_text_lz4 --compress --compression-codec=lz4 -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_text_lz4
# drwxr-xr-x   - root supergroup          0 2021-05-06 21:43 /user/hive/warehouse/db_format_text_lz4/employees
# -rw-r--r--   3 root supergroup          0 2021-05-06 21:43 /user/hive/warehouse/db_format_text_lz4/employees/_SUCCESS
# -rw-r--r--   3 root supergroup      8.2 M 2021-05-06 21:43 /user/hive/warehouse/db_format_text_lz4/employees/part-m-00000.lz4



sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-avrodatafile --warehouse-dir /user/hive/warehouse/db_format_avro -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_avro
#erro


sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-avrodatafile --warehouse-dir /user/hive/warehouse/db_format_avro_snappy --compress --compression-codec org.apache.hadoop.io.compress.SnappyCodec -m 8 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_avro_snappy
#erro


sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-avrodatafile --warehouse-dir /user/hive/warehouse/db_format_avro_gzip --compress --compression-codec=gzip -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_avro_gzip
#erro

sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-avrodatafile --warehouse-dir /user/hive/warehouse/db_format_avro_lz4 --compress --compression-codec=lz4 -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_avro_lz4
#erro


sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-parquetfile --warehouse-dir /user/hive/warehouse/db_format_parquet -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_parquet
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees/.metadata
# -rw-r--r--   3 root supergroup        192 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees/.metadata/descriptor.properties
# -rw-r--r--   3 root supergroup        973 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees/.metadata/schema.avsc
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees/.metadata/schemas
# -rw-r--r--   3 root supergroup        973 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees/.metadata/schemas/1.avsc
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees/.signals
# -rw-r--r--   3 root supergroup          0 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees/.signals/unbounded
# -rw-r--r--   3 root supergroup      3.0 M 2021-05-06 22:06 /user/hive/warehouse/db_format_parquet/employees/c3e0940e-1ccd-49f9-b0a1-7ac8360bb5f4.parquet


sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-parquetfile --warehouse-dir /user/hive/warehouse/db_format_parquet_snappy --compress --compression-codec org.apache.hadoop.io.compress.SnappyCodec -m 8 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_parquet_snappy
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/.metadata
# -rw-r--r--   3 root supergroup        199 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/.metadata/descriptor.properties
# -rw-r--r--   3 root supergroup        973 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/.metadata/schema.avsc
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/.metadata/schemas
# -rw-r--r--   3 root supergroup        973 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/.metadata/schemas/1.avsc
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/.signals
# -rw-r--r--   3 root supergroup          0 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/.signals/unbounded
# -rw-r--r--   3 root supergroup    467.2 K 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/063230b5-5b16-4520-8e5c-9b5ac3b926e0.parquet
# -rw-r--r--   3 root supergroup    466.9 K 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/093adeb8-f2d1-44de-817d-fedcf9bcacaa.parquet
# -rw-r--r--   3 root supergroup    628.5 K 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/2a9f3da9-2316-4e63-9449-c0b79dec6bfa.parquet
# -rw-r--r--   3 root supergroup    690.5 K 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/3189ed5f-6169-4add-89b7-09b1399b6a2d.parquet
# -rw-r--r--   3 root supergroup    690.5 K 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/dae5b8d5-cd18-4518-8f5c-d91ae5d869ff.parquet
# -rw-r--r--   3 root supergroup    529.0 K 2021-05-06 22:07 /user/hive/warehouse/db_format_parquet_snappy/employees/f0969b56-1397-44f5-929b-ae7098b69a42.parquet


sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-parquetfile --warehouse-dir /user/hive/warehouse/db_format_parquet_gzip --compress --compression-codec=gzip -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_parquet_gzip
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees/.metadata
# -rw-r--r--   3 root supergroup        197 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees/.metadata/descriptor.properties
# -rw-r--r--   3 root supergroup        973 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees/.metadata/schema.avsc
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees/.metadata/schemas
# -rw-r--r--   3 root supergroup        973 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees/.metadata/schemas/1.avsc
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees/.signals
# -rw-r--r--   3 root supergroup          0 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees/.signals/unbounded
# -rw-r--r--   3 root supergroup      3.0 M 2021-05-06 22:10 /user/hive/warehouse/db_format_parquet_gzip/employees/2b115831-15dd-4457-bb0f-82fc438c6753.parquet


sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --as-parquetfile --warehouse-dir /user/hive/warehouse/db_format_parquet_lz4 --compress --compression-codec=lz4 -m 1 -delete-target-dir
hdfs dfs -ls -h -R /user/hive/warehouse/db_format_parquet_lz4
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:12 /user/hive/warehouse/db_format_parquet_lz4/employees
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:11 /user/hive/warehouse/db_format_parquet_lz4/employees/.metadata
# -rw-r--r--   3 root supergroup        196 2021-05-06 22:11 /user/hive/warehouse/db_format_parquet_lz4/employees/.metadata/descriptor.properties
# -rw-r--r--   3 root supergroup        973 2021-05-06 22:11 /user/hive/warehouse/db_format_parquet_lz4/employees/.metadata/schema.avsc
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:11 /user/hive/warehouse/db_format_parquet_lz4/employees/.metadata/schemas
# -rw-r--r--   3 root supergroup        973 2021-05-06 22:11 /user/hive/warehouse/db_format_parquet_lz4/employees/.metadata/schemas/1.avsc
# drwxr-xr-x   - root supergroup          0 2021-05-06 22:12 /user/hive/warehouse/db_format_parquet_lz4/employees/.signals
# -rw-r--r--   3 root supergroup          0 2021-05-06 22:12 /user/hive/warehouse/db_format_parquet_lz4/employees/.signals/unbounded
# -rw-r--r--   3 root supergroup      3.0 M 2021-05-06 22:12 /user/hive/warehouse/db_format_parquet_lz4/employees/ed99685d-e7f4-4cb0-b967-32f6d8ab2975.parquet



sqoop import --connect jdbc:mysql://database/sakila --username root --password secret --warehouse-dir /user/hive/warehouse/db_test3 --table cp_rental_append -m 1 -delete-target-dir

sqoop import --connect jdbc:mysql://database/sakila --username root --password secret --warehouse-dir /user/hive/warehouse/db_test3 --table cp_rental_id -m 1 -delete-target-dir

sqoop import --connect jdbc:mysql://database/sakila --username root --password secret --warehouse-dir /user/hive/warehouse/db_test3 --table cp_rental_date -m 1 -delete-target-dir

hdfs dfs -ls -h -R /user/hive/warehouse/db_test3
# drwxr-xr-x   - root supergroup          0 2021-05-07 21:14 /user/hive/warehouse/db_test3/cp_rental_append
# -rw-r--r--   3 root supergroup          0 2021-05-07 21:14 /user/hive/warehouse/db_test3/cp_rental_append/_SUCCESS
# -rw-r--r--   3 root supergroup    427.9 K 2021-05-07 21:14 /user/hive/warehouse/db_test3/cp_rental_append/part-m-00000
# drwxr-xr-x   - root supergroup          0 2021-05-07 21:18 /user/hive/warehouse/db_test3/cp_rental_date
# -rw-r--r--   3 root supergroup          0 2021-05-07 21:18 /user/hive/warehouse/db_test3/cp_rental_date/_SUCCESS
# -rw-r--r--   3 root supergroup    427.9 K 2021-05-07 21:18 /user/hive/warehouse/db_test3/cp_rental_date/part-m-00000
# drwxr-xr-x   - root supergroup          0 2021-05-07 21:17 /user/hive/warehouse/db_test3/cp_rental_id
# -rw-r--r--   3 root supergroup          0 2021-05-07 21:17 /user/hive/warehouse/db_test3/cp_rental_id/_SUCCESS
# -rw-r--r--   3 root supergroup    427.9 K 2021-05-07 21:17 /user/hive/warehouse/db_test3/cp_rental_id/part-m-00000

mysql -psecret < insert_rental.sql

sqoop import --connect jdbc:mysql://database/sakila --username root --password secret --warehouse-dir /user/hive/warehouse/db_test3 --append --table cp_rental_append -m 1

sqoop eval --connect jdbc:mysql://database/sakila --username root --password secret --query "select * from cp_rental_append order by rental_id desc limit 5"
# -------------------------------------
# | rental_id   | rental_date         |
# -------------------------------------
# | 16049       | 2005-08-23 22:50:12.0 |
# | 16048       | 2005-08-23 22:43:07.0 |
# | 16047       | 2005-08-23 22:42:48.0 |
# | 16046       | 2005-08-23 22:26:47.0 |
# | 16045       | 2005-08-23 22:25:26.0 |
# -------------------------------------

sqoop import --connect jdbc:mysql://database/sakila --username root --password secret --warehouse-dir /user/hive/warehouse/db_test3 --incremental append --check-column rental_id --last-value 16049 --table cp_rental_id -m 1

sqoop import --connect jdbc:mysql://database/sakila --username root --password secret --warehouse-dir /user/hive/warehouse/db_test3 --incremental lastmodified --merge-key rental_id --check-column rental_date --last-value '2005-08-23 22:50:12.0' --table cp_rental_date -m 1

hdfs dfs -ls -h -R /user/hive/warehouse/db_test3
# drwxr-xr-x   - root supergroup          0 2021-05-07 21:42 /user/hive/warehouse/db_test3/cp_rental_append
# -rw-r--r--   3 root supergroup          0 2021-05-07 21:14 /user/hive/warehouse/db_test3/cp_rental_append/_SUCCESS
# -rw-r--r--   3 root supergroup    427.9 K 2021-05-07 21:14 /user/hive/warehouse/db_test3/cp_rental_append/part-m-00000
# -rw-r--r--   3 root supergroup    427.9 K 2021-05-07 21:42 /user/hive/warehouse/db_test3/cp_rental_append/part-m-00001
# drwxr-xr-x   - root supergroup          0 2021-05-07 22:12 /user/hive/warehouse/db_test3/cp_rental_date
# -rw-r--r--   3 root supergroup          0 2021-05-07 22:12 /user/hive/warehouse/db_test3/cp_rental_date/_SUCCESS
# -rw-r--r--   3 root supergroup    428.0 K 2021-05-07 22:12 /user/hive/warehouse/db_test3/cp_rental_date/part-r-00000
# drwxr-xr-x   - root supergroup          0 2021-05-07 21:52 /user/hive/warehouse/db_test3/cp_rental_id
# -rw-r--r--   3 root supergroup          0 2021-05-07 21:17 /user/hive/warehouse/db_test3/cp_rental_id/_SUCCESS
# -rw-r--r--   3 root supergroup    427.9 K 2021-05-07 21:17 /user/hive/warehouse/db_test3/cp_rental_id/part-m-00000
# -rw-r--r--   3 root supergroup        168 2021-05-07 21:52 /user/hive/warehouse/db_test3/cp_rental_id/part-m-00001


sqoop import -m 1 -delete-target-dir --connect jdbc:mysql://database/employees --username root --password secret --table titles --warehouse-dir /user/aluno/guimmox/data

sqoop import -m 1 -delete-target-dir --connect jdbc:mysql://database/employees --username root --password secret --table titles --hive-import --hive-table guimmox.titles

sqoop eval --connect jdbc:mysql://database/employees --username=root --password=secret --query "truncate table titles"

sqoop export --connect jdbc:mysql://database/employees --username root --password secret --table titles --export-dir /user/aluno/guimmox/data/titles

