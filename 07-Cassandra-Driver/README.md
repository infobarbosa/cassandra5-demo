# Driver Cassandra
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Conhecendo o driver para Cassandra

### Objetivo
Executar uma aplicação cliente Cassandra escrita em Python e observar os principais parâmetros oferecidos pelo driver.

### CREATE KEYSPACE
```
cqlsh -e "CREATE KEYSPACE infobarbank5 \
    WITH replication = { \
        'class': 'SimpleStrategy', \
        'replication_factor': 1 \
    };"
```

### Instalando o driver
```
pip install cassandra-driver
```

### Iniciando o python3
```
python3
```

### Criando uma sessão
```
from cassandra.cluster import Cluster

cluster = Cluster(['127.0.0.1'])
session = cluster.connect('infobarbank5')
```

### CREATE TABLE
```
rows = session.execute('CREATE TABLE infobarbank5.cliente(id uuid PRIMARY KEY, cpf text, nome text);')

```

### INSERT
```
session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b167754-1017-11ed-861d-0242ac120002, '***.790.738-**', 'SIDINEIDE NONATO DE SA');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b1678f8-1017-11ed-861d-0242ac120002, '***.416.131-**', 'NEUZA EVANGELISTA FERREIRA');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b1679fc-1017-11ed-861d-0242ac120002, '***.568.112-**', 'MARIVALDA KANAMARY');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b167bbe-1017-11ed-861d-0242ac120002, '***.150.512-**', 'JUCILENE MOREIRA CRUZ');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b167cb8-1017-11ed-861d-0242ac120002, '***.615.942-**', 'GRACIMAR BRASIL GUERRA');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b167e52-1017-11ed-861d-0242ac120002, '***.264.482-**', 'ALDENORA VIANA MOREIRA');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b167fa6-1017-11ed-861d-0242ac120002, '***.434.715-**', 'VERA LUCIA RODRIGUES SENA');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b1694f0-1017-11ed-861d-0242ac120002, '***.469.755-**', 'MARCOLINO CONCEICAO DE ALMEIDA');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b1696a8-1017-11ed-861d-0242ac120002, '***.777.135-**', 'IVONE GLAUCIA VIANA DUTRA');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b16989c-1017-11ed-861d-0242ac120002, '***.881.955-**', 'LUCILIA ROSA LIMA PEREIRA');")

session.execute("insert into infobarbank5.cliente(id, cpf, nome) VALUES(2b169a2c-1017-11ed-861d-0242ac120002, '***.580.583-**', 'FRANCISCA SANDRA FEITOSA');")
```

### SELECT
```
rows = session.execute('SELECT id, cpf, nome FROM cliente')

for cliente in rows:
    print (cliente.nome)

```


### UPDATE
```
session.execute("UPDATE infobarbank5.cliente SET nome = 'DAVE BRUBECK' WHERE id = 2b164bd0-1017-11ed-861d-0242ac120002")
```

```
rows = session.execute('SELECT id, cpf, nome FROM cliente WHERE id = 2b164bd0-1017-11ed-861d-0242ac120002')

for cliente in rows:
    print (cliente.nome)

```

### DELETE
```
session.execute("DELETE FROM infobarbank5.cliente WHERE id = 2b164bd0-1017-11ed-861d-0242ac120002")
```

```
rows = session.execute('SELECT id, cpf, nome FROM cliente WHERE id = 2b164bd0-1017-11ed-861d-0242ac120002')

for cliente in rows:
    print (cliente.nome)

```

### Prepared Statements
```
import uuid

id_cliente = uuid.UUID('2b167bbe-1017-11ed-861d-0242ac120002')
meu_stmt = session.prepare("SELECT id, cpf, nome FROM cliente WHERE id = ?")

cliente = session.execute(meu_stmt, [id_cliente])

print( cliente.one().nome )

```