docker exec -it broker bash

kafka-topics --bootstrap-server localhost:9092 --topic msg-cli --create --partitions 2 --replication-factor 1

kafka-topics --bootstrap-server localhost:9092 --topic msg-cli --describe

kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-cli --group app-cli

kafka-console-producer --broker-list localhost:9092 --topic msg-cli

Msg 1
Msg 2

kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-cli --group app-cli

kafka-console-producer --broker-list localhost:9092 --topic msg-cli

Msg 4
Msg 5
Msg 6
Msg 7

kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-cli --group app2-cli

Msg 8
Msg 9
Msg 10
Msg 11

kafka-consumer-groups --bootstrap-server localhost:9092 \
--group app-cli --reset-offsets --shift-by -2 --execute --topic msg-cli

kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group app-cli

kafka-consumer-groups --bootstrap-server localhost:9092 --group app-cli \
--reset-offsets --to-earliest --execute --topic msg-cli

kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group app-cli

kafka-consumer-groups bootstrap-server localhost:9092 --list


kafka-topics --bootstrap-server localhost:9092 --topic msg-usuario-csv --create --partitions 2 --replication-factor 1

kafka-console-producer --broker-list localhost:9092 --topic msg-usuario-csv

docker exec –it ksqldb-cli bash | kskl

create stream usuario_csv (id varchar, nome varchar) with (Kafka_topic=‘msg-usuario-csv’, value_format=‘delimited’);

select * from usuario_csv;

select * from usuario_csv;


ksql-datagen bootstrap-server=broker:29092 schemaRegistryUrl=schema-registry:8081 quickstart=users topic=users

print users;

CREATE STREAM users_raw () WITH (KAFKA_TOPIC='users', VALUE_FORMAT='JSON’, key='userid' timestamp='viewtime')

select * from users_raw


ksql-datagen bootstrap-server=broker:29092 schemaRegistryUrl=schema-registry:8081 quickstart=pageviews topic=pageviews

print pageviews;

CREATE STREAM pageviews_raw () WITH (KAFKA_TOPIC='pageviews', VALUE_FORMAT='JSON’, key='pageviewsid' timestamp='viewtime')

select * from pageviews_raw;


docker exec –it schema-registry bash

print users;

kafka-avro-console-producer --broker-list broker:29092 --topic users-avro --property schema.registry.url=http://localhost:8081 --property value.schema='{"type":"record","name":"myrecord","fields":[ {"name":"id","type":“int"}, {"name":"user","type":"string"}]}’

kafka-avro-console-consumer --topic users-avro --bootstrap-server broker:29092 --property schema.registry.url=http://localhost:8081 --from-beginning

print users-avro; select * from users-avro;

create stream users-avro1 with (kafka_topic='users-avro', value_format='avro’);

sudo kafka-avro-console-producer --broker-list localhost:9092 --topic users-avro --property schema.registry.url=http://localhost:8081 --property value.schema='{"type":"record","name":"myrecord", "fields":[ {"name":"id","type":"int"}, {"user":"nome","type":"string"},{"name":"unit","type":"int", "default":"1"}]}’

kafka-avro-console-consumer --topic users-avro --bootstrap-server broker:29092 --property schema.registry.url=http://localhost:8081 --from-beginning

print users-avro; select * from users-avro;