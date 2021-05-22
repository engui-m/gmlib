docker exec -it mongo bash
 mongo
 show dbs

use guimmox
 show dbs
 db.createCollection('produto')
 show dbs
 
 db.produto.insertOne({_id: 1, "nome": "cpu i5", "qtd": "15"})
 db.produto.insertOne({_id: 2, nome: "memória ram", qtd: 10, descricao: {armazenamento: "8GB", tipo:"DDR4"}})
 db.produto.insertOne({_id: 3, nome: "mouse", qtd: 50, descricao: {conexao: "USB", so: ["Windows", "Mac", "Linux"]}})
 db.produto.insertOne({_id: 4, nome: "hd externo", "qtd": 20, descricao: {conexao: "USB", armazenamento: "500GB", so: ["Windows 10", "Windows 8", "Windows 7"]}})

 db.produto.insertMany([{_id: 1, "nome": "cpu i5", "qtd": "15"},{_id: 2, nome: "memória ram", qtd: 10, descricao: {armazenamento: "8GB", tipo:"DDR4"}},{_id: 3, nome: "mouse", qtd: 50, descricao: {conexao: "USB", so: ["Windows", "Mac", "Linux"]}},{_id: 4, nome: "hd externo", "qtd": 20, descricao: {conexao: "USB", armazenamento: "500GB", so: ["Windows 10", "Windows 8", "Windows 7"]}}])

 db.produto.find()


db.produto.find().pretty()
  db.produto.find( { nome : "mouse" } )
  
  db.produto.find( { qtd : 20 }, {_id: 0, nome: 1} )
  
  db.produto.find( { qtd : { $lte : 20 } }, {_id: 0, nome: 1, qtd: 1} )
  
  db.produto.find( { qtd : { $gte : 10, $lte : 20 } } )
  
  db.produto.find( { 'descricao.conexao' : "USB" }, {_id: 0, qtd: 0} )

  db.produto.find( { "descricao.so" : { $in : ["Windows","Windows 10"] } } )


db.produto.find().pretty()
  
  db.produto.find().sort( {nome : 1} )
  
  db.produto.find().sort( {nome : 1}, {qtd : 1} ).limit(3)
  
  db.produto.findOne({ 'descricao.conexao' : "USB" })

  db.produto.find( { 'descricao.conexao' : "USB", qtd : {$lt : 25} } )

  db.produto.find( { $or : [ {'descricao.conexao' : "USB"}, {qtd : {$lt : 25} } ] } )

  db.produto.find( { $or : [ {'descricao.conexao' : "USB"}, {qtd : {$lt : 25} } ] }, {_id: 1} )  


