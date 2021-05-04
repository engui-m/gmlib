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