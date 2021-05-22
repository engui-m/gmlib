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


show collections
db.produto.find().pretty()

 db.produto.updateOne( {_id: 1}, {$set: {nome: "cpu i7"}} )

 db.produto.updateOne( {_id: 1}, {$set: {qtd: 15}} )

 db.produto.updateMany({qtd: {$gte: 30}}, {$set: {qtd: 30}})

 db.produto.updateMany({}, {$rename: {"descricao.so": "descricao.sistema"}})

 db.produto.updateMany({"descricao.conexao": "USB"}, {$set: {"descricao.conexao": "USB 2.0"}})

 db.produto.updateMany({"descricao.conexao": "USB 2.0"}, {$set: {"descricao.conexao": "USB 3.0"}, $currentDate:{data_modificacao:{$type:"date"}}})
  db.produto.updateMany({"descricao.conexao": "USB 2.0"}, {$set: {"descricao.conexao": "USB 3.0", data_modificacao: new Date()}})

 db.produto.updateOne({_id: 3, "descricao.sistema": "Windows"}, {$set: {"descricao.sistema.$": "Windows 10"}})

 db.produto.updateOne({_id: 4}, {$push: {"descricao.sistema": "Linux"}})

 db.produto.updateOne({_id: 3}, {$pull: {"descricao.sistema": "Mac"}, $currentDate:{ts_modificacao:{$type:"timestamp"}}})



db.createCollection('teste')
show collections

 db.teste.insertOne({usuario: "Semantix", data_acesso: new Date()})

 db.teste.find({data_acesso: {$gte:  new Date("2020")}}) 
 db.teste.find({data_acesso: {$gte:  new ISODate("2020-01-01T00:00:00Z")}})

 db.teste.updateOne({usuario: "Semantix"}, {$currentDate:{data_modificacao:{$type:"timestamp"}}}) 
 db.teste.updateOne({usuario: "Semantix"}, {$set: {data_acesso: new Timestamp()}})

 db.teste.find().pretty()

 db.teste.deleteOne({"_id" : ObjectId("60a979c9ce027813043323b3")})

 db.teste.drop()
 
 

