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




