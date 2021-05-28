redis-cli
 
 set usuario:nome guimmox

 set usuario:sobrenome araujo

 get usuario:nome

 strlen usuario:nome

 type usuario:sobrenome

 set views:qtd 100

 incrby views:qtd 10

 get views:qtd

 del usuario:sobrenome

 expire views:qtd 3600

 ttl views:qtd

 ttl usuario:nome

 persist views:qtd


rpush views:ultimo_usuario Joao

 rpush views:ultimo_usuario Ana

 lpush views:ultimo_usuario Carlos

 rpush views:ultimo_usuario Carol

 lrange views:ultimo_usuario 0 -1

 lrange views:ultimo_usuario 0 -2

 ltrim views:ultimo_usuario 1 -1

 llen views:ultimo_usuario

 lpop views:ultimo_usuario

 rpop views:ultimo_usuario

 blpop views:ultimo_usuario 5

 brpop views:ultimo_usuario 5

 exists views:ultimo_usuario


del pesquisa:produto
 
 sadd pesquisa:produto monitor mouse teclado
 
 scard pesquisa:produto

 smembers pesquisa:produto

 sismember pesquisa:produto monitor

 srem pesquisa:produto monitor

 spop pesquisa:produto

 sadd pesquisa:desconto 'memoria ram' monitor teclado hd

 sinter pesquisa:produto pesquisa:desconto

 sdiff pesquisa:produto pesquisa:desconto

 sunionstore pesquisa:produto_desconto pesquisa:produto pesquisa:desconto

 smembers pesquisa:produto_desconto


del pesquisa:produto

 zadd pesquisa:produto 100 monitor 20 HD 10 mouse 50 teclado

 zcard pesquisa:produto

 zrevrange pesquisa:produto 0 -1

 zrevrank pesquisa:produto teclado

 zscore pesquisa:produto teclado

 zrem pesquisa:produto HD

 zpopmax pesquisa:produto

 zpopmin pesquisa:produto

 zrange pesquisa:produto 0 -1


del usuario:100
 
 hmset usuario:100 nome Augusto estado SP views 10

 hgetall usuario:100

 hlen usuario:100

 hmget usuario:100 nome views

 hstrlen usuario:100 nome

 hincrby usuario:100 views 2
 
 hkeys usuario:100

 hvals usuario:100

 hdel usuario:100 estado

