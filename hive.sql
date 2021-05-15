create table guimmox.pop( 
zip_code int,
total_population int,
median_age float,
total_males int,
total_females int,
total_households int,
average_household_size float
) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n'
stored as textfile
tblproperties('skip.header.line.count'='1'); 

--#####################################################################

create table guimmox.nascimento( 
nome string,
sexo string,
frequencia int
) 
partitioned by (ano int)
row format delimited 
fields terminated by ',' 
lines terminated by '\n'
stored as textfile
location '/user/aluno/guimmox/data/nascimento';

--#####################################################################

alter table guimmox.nascimento add partition (ano=2015);
alter table guimmox.nascimento add partition (ano=2016);
alter table guimmox.nascimento add partition (ano=2017);

alter table guimmox.nascimento partition column (ano int);

--#####################################################################

select * from nascimento where ano=2016 limit 10;
-- +------------------+------------------+------------------------+-----------------+
-- | nascimento.nome  | nascimento.sexo  | nascimento.frequencia  | nascimento.ano  |
-- +------------------+------------------+------------------------+-----------------+
-- | Emma             | F                | 19471                  | 2016            |
-- | Olivia           | F                | 19327                  | 2016            |
-- | Ava              | F                | 16283                  | 2016            |
-- | Sophia           | F                | 16112                  | 2016            |
-- | Isabella         | F                | 14772                  | 2016            |
-- | Mia              | F                | 14415                  | 2016            |
-- | Charlotte        | F                | 13080                  | 2016            |
-- | Abigail          | F                | 11747                  | 2016            |
-- | Emily            | F                | 10957                  | 2016            |
-- | Harper           | F                | 10773                  | 2016            |
-- +------------------+------------------+------------------------+-----------------+

select count(nome) as 2017_Nomes from nascimento where ano=2017;
-- +-------------+
-- | 2017_nomes  |
-- +-------------+
-- | 32469       |
-- +-------------+

select sum(frequencia) as 2017_total_criancas from nascimento where ano=2017;
-- +----------------------+
-- | 2017_total_criancas  |
-- +----------------------+
-- | 3546301              |
-- +----------------------+

select sexo, sum(frequencia) as 2015_total from nascimento where ano=2015 group by sexo;
-- +-------+-------------+
-- | sexo  | 2015_total  |
-- +-------+-------------+
-- | F     | 1778883     |
-- | M     | 1909804     |
-- +-------+-------------+

select ano, sexo, sum(frequencia) as total from nascimento group by ano, sexo order by ano desc;
-- +-------+-------+----------+
-- |  ano  | sexo  |  total   |
-- +-------+-------+----------+
-- | 2017  | M     | 1834490  |
-- | 2017  | F     | 1711811  |
-- | 2016  | M     | 1889052  |
-- | 2016  | F     | 1763916  |
-- | 2015  | M     | 1909804  |
-- | 2015  | F     | 1778883  |
-- +-------+-------+----------+

select ano, sexo, sum(frequencia) as total_iniciado_letra_a from nascimento where nome like 'A%' group by ano, sexo order by ano desc;
-- +-------+-------+-------------------------+
-- |  ano  | sexo  | total_iniciado_letra_a  |
-- +-------+-------+-------------------------+
-- | 2017  | M     | 185566                  |
-- | 2017  | F     | 308551                  |
-- | 2016  | M     | 191854                  |
-- | 2016  | F     | 324185                  |
-- | 2015  | M     | 194722                  |
-- | 2015  | F     | 329690                  |
-- +-------+-------+-------------------------+

select nome, sexo, max(frequencia) as 2016_total from nascimento where ano=2016 group by nome, sexo order by 2016_total desc limit 5;
-- +---------+-------+-------------+
-- |  nome   | sexo  | 2016_total  |
-- +---------+-------+-------------+
-- | Emma    | F     | 19471       |
-- | Olivia  | F     | 19327       |
-- | Noah    | M     | 19082       |
-- | Liam    | M     | 18198       |
-- | Ava     | F     | 16283       |
-- +---------+-------+-------------+

select nome, sexo, max(frequencia) as 2016_total from nascimento where ano=2016 and sexo = 'F' group by nome, sexo order by 2016_total desc limit 5;
-- +-----------+-------+-------------+
-- |   nome    | sexo  | 2016_total  |
-- +-----------+-------+-------------+
-- | Emma      | F     | 19471       |
-- | Olivia    | F     | 19327       |
-- | Ava       | F     | 16283       |
-- | Sophia    | F     | 16112       |
-- | Isabella  | F     | 14772       |
-- +-----------+-------+-------------+

select nome, sexo, max(frequencia) as 2016_total from nascimento where ano=2016 and sexo = 'M' group by nome, sexo order by 2016_total desc limit 5;
-- +----------+-------+-------------+
-- |   nome   | sexo  | 2016_total  |
-- +----------+-------+-------------+
-- | Noah     | M     | 19082       |
-- | Liam     | M     | 18198       |
-- | William  | M     | 15739       |
-- | Mason    | M     | 15230       |
-- | James    | M     | 14842       |
-- +----------+-------+-------------+

create table guimmox.pop_parquet( 
zip_code int,
total_population int,
median_age float,
total_males int,
total_females int,
total_households int,
average_household_size float
) 
stored as parquet; 

insert into guimmox.pop_parquet (select * from guimmox.pop);

select count (*) as pop_parquet_total from guimmox.pop_parquet;
-- +--------------------+
-- | pop_parquet_total  |
-- +--------------------+
-- | 319                |
-- +--------------------+

select * from guimmox.pop_parquet limit 10;
-- +-----------------------+-------------------------------+-------------------------+--------------------------+----------------------------+-------------------------------+-------------------------------------+
-- | pop_parquet.zip_code  | pop_parquet.total_population  | pop_parquet.median_age  | pop_parquet.total_males  | pop_parquet.total_females  | pop_parquet.total_households  | pop_parquet.average_household_size  |
-- +-----------------------+-------------------------------+-------------------------+--------------------------+----------------------------+-------------------------------+-------------------------------------+
-- | 91371                 | 1                             | 73.5                    | 0                        | 1                          | 1                             | 1.0                                 |
-- | 90001                 | 57110                         | 26.6                    | 28468                    | 28642                      | 12971                         | 4.4                                 |
-- | 90002                 | 51223                         | 25.5                    | 24876                    | 26347                      | 11731                         | 4.36                                |
-- | 90003                 | 66266                         | 26.3                    | 32631                    | 33635                      | 15642                         | 4.22                                |
-- | 90004                 | 62180                         | 34.8                    | 31302                    | 30878                      | 22547                         | 2.73                                |
-- | 90005                 | 37681                         | 33.9                    | 19299                    | 18382                      | 15044                         | 2.5                                 |
-- | 90006                 | 59185                         | 32.4                    | 30254                    | 28931                      | 18617                         | 3.13                                |
-- | 90007                 | 40920                         | 24.0                    | 20915                    | 20005                      | 11944                         | 3.0                                 |
-- | 90008                 | 32327                         | 39.7                    | 14477                    | 17850                      | 13841                         | 2.33                                |
-- | 90010                 | 3800                          | 37.8                    | 1874                     | 1926                       | 2014                          | 1.87                                |
-- +-----------------------+-------------------------------+-------------------------+--------------------------+----------------------------+-------------------------------+-------------------------------------+

create table guimmox.pop_parquet_snappy( 
zip_code int,
total_population int,
median_age float,
total_males int,
total_females int,
total_households int,
average_household_size float
) 
stored as parquet
tblproperties('parquet.compress'='SNAPPY'); 

insert into guimmox.pop_parquet_snappy (select * from guimmox.pop);

select count (*) as pop_parquet_snappy_total from guimmox.pop_parquet;
-- +---------------------------+
-- | pop_parquet_snappy_total  |
-- +---------------------------+
-- | 319                       |
-- +---------------------------+

select * from guimmox.pop_parquet_snappy limit 10;
-- +------------------------------+--------------------------------------+--------------------------------+---------------------------------+-----------------------------------+--------------------------------------+--------------------------------------------+
-- | pop_parquet_snappy.zip_code  | pop_parquet_snappy.total_population  | pop_parquet_snappy.median_age  | pop_parquet_snappy.total_males  | pop_parquet_snappy.total_females  | pop_parquet_snappy.total_households  | pop_parquet_snappy.average_household_size  |
-- +------------------------------+--------------------------------------+--------------------------------+---------------------------------+-----------------------------------+--------------------------------------+--------------------------------------------+
-- | 91371                        | 1                                    | 73.5                           | 0                               | 1                                 | 1                                    | 1.0                                        |
-- | 90001                        | 57110                                | 26.6                           | 28468                           | 28642                             | 12971                                | 4.4                                        |
-- | 90002                        | 51223                                | 25.5                           | 24876                           | 26347                             | 11731                                | 4.36                                       |
-- | 90003                        | 66266                                | 26.3                           | 32631                           | 33635                             | 15642                                | 4.22                                       |
-- | 90004                        | 62180                                | 34.8                           | 31302                           | 30878                             | 22547                                | 2.73                                       |
-- | 90005                        | 37681                                | 33.9                           | 19299                           | 18382                             | 15044                                | 2.5                                        |
-- | 90006                        | 59185                                | 32.4                           | 30254                           | 28931                             | 18617                                | 3.13                                       |
-- | 90007                        | 40920                                | 24.0                           | 20915                           | 20005                             | 11944                                | 3.0                                        |
-- | 90008                        | 32327                                | 39.7                           | 14477                           | 17850                             | 13841                                | 2.33                                       |
-- | 90010                        | 3800                                 | 37.8                           | 1874                            | 1926                              | 2014                                 | 1.87                                       |
-- +------------------------------+--------------------------------------+--------------------------------+---------------------------------+-----------------------------------+--------------------------------------+--------------------------------------------+

select * from guimmox.titles limit 10;
-- +----------------+------------------+-------------------+-----------------+
-- | titles.emp_no  |   titles.title   | titles.from_date  | titles.to_date  |
-- +----------------+------------------+-------------------+-----------------+
-- | 10001          | Senior Engineer  | 1986-06-26        | 9999-01-01      |
-- | 10002          | Staff            | 1996-08-03        | 9999-01-01      |
-- | 10003          | Senior Engineer  | 1995-12-03        | 9999-01-01      |
-- | 10004          | Engineer         | 1986-12-01        | 1995-12-01      |
-- | 10004          | Senior Engineer  | 1995-12-01        | 9999-01-01      |
-- | 10005          | Senior Staff     | 1996-09-12        | 9999-01-01      |
-- | 10005          | Staff            | 1989-09-12        | 1996-09-12      |
-- | 10006          | Senior Engineer  | 1990-08-05        | 9999-01-01      |
-- | 10007          | Senior Staff     | 1996-02-11        | 9999-01-01      |
-- | 10007          | Staff            | 1989-02-10        | 1996-02-11      |
-- +----------------+------------------+-------------------+-----------------+
-- 10 rows selected (2.998 seconds)