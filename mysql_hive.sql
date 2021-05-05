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

