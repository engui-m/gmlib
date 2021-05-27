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







