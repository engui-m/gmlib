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