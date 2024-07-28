# Cluster
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Cassandra em cluster

Atenção! Cuidado para executar os comandos em ordem e apenas uma vez sob o risco de ter de reiniciar o laboratório.<br>
Exceções a essa regra serão apontadas pelo professor.

### Objetivo
Executar um cluster de 2 nós (ou nodes) e então uma aplicação cliente escrita em Python e observar os principais parâmetros oferecidos pelo driver.
Por questão de comodidade e restrição de recursos, utilizaremos o docker e docker-compose para executar o laboratório.

### Instalando o `cqlsh`
Essa etapa só é necessária se você não instalou o Cassandra antes nesse host.

```
sudo snap install cqlsh
```

### Inspecionando `compose.yaml`
```
ls -latr ./09-Cluster/assets/scripts/compose.yaml
```

```
cat ./09-Cluster/assets/scripts/compose.yaml
```

### Inicializando o cluster
Por comodidade e também restrição de recursos de cpu e memória do nosso laboratório, vamos inicializar um cluster com apenas 2 nós.
```
docker compose -f ./09-Cluster/assets/scripts/compose.yaml up -d

```

Atenção! Em função das restrições de recursos, a inicialização deve demorar

Pra verificar as instâncias em funcionamento via docker, execute o comando:
```
docker stats
```

Output esperado:
```
CONTAINER ID   NAME                         CPU %     MEM USAGE / LIMIT   MEM %     NET I/O           BLOCK I/O        PIDS
ecef529adeab   infobarbankdb-cassandra2-1   1.76%     645MiB / 768MiB     83.99%    83.4kB / 80.4kB   398MB / 5.14MB   54
0cd5b5f9444f   infobarbankdb-cassandra1-1   1.38%     560.7MiB / 768MiB   73.01%    81.8kB / 82.2kB   821MB / 5.14MB   53
```

Para sair precione Ctrl+C

Para verificar o status de inicialização, execute o seguinte:
```
docker exec -it infobarbankdb-cassandra2-1 /bin/bash

```

```
nodetool status

```

Output:
```
ubuntu $ docker exec -it infobarbankdb-cassandra2-1 /bin/bash
root@ecef529adeab:/# nodetool status
Datacenter: BRA-SP-OLTP
-=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load        Tokens  Owns (effective)  Host ID                               Rack 
UN  172.18.0.3  104.35 KiB  16      100.0%            10dfa461-e7f0-441e-9588-5c59482f51cb  rack1
UN  172.18.0.2  109.41 KiB  16      100.0%            bd56f53c-676f-4e16-b43b-5ffc1d0bc2d5  rack1
```

    Para sair do container docker precione Ctrl+D

    Atenção! Perceba que a partir daqui passaremos a especificar o IP do container docker ao final dos comandos.

## Entendendo o RING

### CREATE KEYSPACE
Primeiro vamos fazer um teste, criar uma keyspace com fator de replicação maior que o número de nós:
```
cqlsh -e "CREATE KEYSPACE teste WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3 }" 172.18.0.2

```

Output:
```
ubuntu $ cqlsh -e "CREATE KEYSPACE teste WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3 }" 172.18.0.2

Warnings :
Your replication factor 3 for keyspace teste is higher than the number of nodes 2
```

Esse resultado é relativamente óbvio. Ou seja, não é possível ter mais réplicas do que o número de nós disponível.

Vamos tentar novamente, desta vez com um número menor de fator de replicação:
```
cqlsh -e "CREATE KEYSPACE teste WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3 }" 172.18.0.2

```

Agora vamos criar uma tabela "t1" e inserir alguns valores
```
cqlsh 172.18.0.2

```

```
USE teste;

```

```
create table t1(c1 text primary key, c2 text);

```

```
insert into t1(c1, c2) values('1', 'valor 1');
insert into t1(c1, c2) values('2', 'valor 2');
insert into t1(c1, c2) values('3', 'valor 3');
insert into t1(c1, c2) values('4', 'valor 4');
insert into t1(c1, c2) values('5', 'valor 5');
insert into t1(c1, c2) values('6', 'valor 6');
insert into t1(c1, c2) values('7', 'valor 7');
insert into t1(c1, c2) values('8', 'valor 8');
insert into t1(c1, c2) values('9', 'valor 9');

```

Saia do `cqlsh`

>> Atenção! Cuidado para executar `exit` apenas no `cqlsh` e não no bash. Ao sair do ubuntu sua sessão Killercoda é terminada e você deverá iniciar novamente o laboratório.

```
exit
```


### Verificando tokens
```
nodetool ring
```

Output:
```
root@faed7a313b07:~# nodetool ring

Datacenter: BRA-SP-OLTP
-==========
Address          Rack        Status State   Load            Owns                Token                                       
                                                                                8611242815775010767                         
172.18.0.2       rack1       Up     Normal  85.73 KiB       48.85%              -9017829325322190053                        
172.18.0.3       rack1       Up     Normal  80.54 KiB       51.15%              -8422526956361790802                        
172.18.0.2       rack1       Up     Normal  85.73 KiB       48.85%              -7942073444096610513                        
172.18.0.2       rack1       Up     Normal  85.73 KiB       48.85%              -7206157751385716872                        
172.18.0.3       rack1       Up     Normal  80.54 KiB       51.15%              -6545462626848804773 
```

```
nodetool describering -- teste
```

Output
```
root@faed7a313b07:~# nodetool describering -- teste
Schema Version:0b8f1313-7319-353e-aff0-3c23018dda7c
TokenRange: 
        TokenRange(start_token:2049906906371655395, end_token:2702379818519904657, endpoints:[172.18.0.3], rpc_endpoints:[172.18.0.3], endpoint_details:[EndpointDetails(host:172.18.0.3, datacenter:BRA-SP-OLTP, rack:rack1)])
        TokenRange(start_token:-6545462626848804773, end_token:-6126784943938115215, endpoints:[172.18.0.2], rpc_endpoints:[172.18.0.2], endpoint_details:[EndpointDetails(host:172.18.0.2, datacenter:BRA-SP-OLTP, rack:rack1)])
        TokenRange(start_token:271272605548068267, end_token:925891490664097384, endpoints:[172.18.0.3], rpc_endpoints:[172.18.0.3], endpoint_details:[EndpointDetails(host:172.18.0.3, datacenter:BRA-SP-OLTP, rack:rack1)])
        TokenRange(start_token:8611242815775010767, end_token:-9017829325322190053, endpoints:[172.18.0.2], rpc_endpoints:[172.18.0.2], endpoint_details:[EndpointDetails(host:172.18.0.2, datacenter:BRA-SP-OLTP, rack:rack1)])
        TokenRange(start_token:-1366829871956750069, end_token:-706872846968045808, endpoints:[172.18.0.2], rpc_endpoints:[172.18.0.2], endpoint_details:[EndpointDetails(host:172.18.0.2, datacenter:BRA-SP-OLTP, rack:rack1)])
        TokenRange(start_token:6521890794692550939, end_token:7139871826594751016, endpoints:[172.18.0.3], rpc_endpoints:[172.18.0.3], endpoint_details:[EndpointDetails(host:172.18.0.3, datacenter:BRA-SP-OLTP, rack:rack1)]) 
```


###
Vamos seguir com a criação da keyspace `infobarbank`:
```
cqlsh -e "CREATE KEYSPACE infobarbank WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1 }"

```

Saia do container:
```
exit

```

### Instalando o driver
```
pip install cassandra-driver

```

### Iniciando o python
```
python

```

### Criando uma sessão
```
from cassandra.cluster import Cluster

cluster = Cluster(['172.18.0.2', '172.18.0.3'])
session = cluster.connect('infobarbank')

```

### CREATE TABLE
```
rows = session.execute('CREATE TABLE infobarbank.cliente(id uuid PRIMARY KEY, cpf text, nome text);')

```

### INSERT
```

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b167754-1017-11ed-861d-0242ac120002, '***.790.738-**', 'SIDINEIDE NONATO DE SA');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b1678f8-1017-11ed-861d-0242ac120002, '***.416.131-**', 'NEUZA EVANGELISTA FERREIRA');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b1679fc-1017-11ed-861d-0242ac120002, '***.568.112-**', 'MARIVALDA KANAMARY');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b167bbe-1017-11ed-861d-0242ac120002, '***.150.512-**', 'JUCILENE MOREIRA CRUZ');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b167cb8-1017-11ed-861d-0242ac120002, '***.615.942-**', 'GRACIMAR BRASIL GUERRA');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b167e52-1017-11ed-861d-0242ac120002, '***.264.482-**', 'ALDENORA VIANA MOREIRA');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b167fa6-1017-11ed-861d-0242ac120002, '***.434.715-**', 'VERA LUCIA RODRIGUES SENA');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b1694f0-1017-11ed-861d-0242ac120002, '***.469.755-**', 'MARCOLINO CONCEICAO DE ALMEIDA');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b1696a8-1017-11ed-861d-0242ac120002, '***.777.135-**', 'IVONE GLAUCIA VIANA DUTRA');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b16989c-1017-11ed-861d-0242ac120002, '***.881.955-**', 'LUCILIA ROSA LIMA PEREIRA');")

session.execute("insert into infobarbank.cliente(id, cpf, nome) VALUES(2b169a2c-1017-11ed-861d-0242ac120002, '***.580.583-**', 'FRANCISCA SANDRA FEITOSA');")
```

### SELECT
```
rows = session.execute('SELECT id, cpf, nome FROM cliente')

for cliente in rows:
    print (cliente.nome)

```


### UPDATE
```
session.execute("UPDATE infobarbank.cliente SET nome = 'DAVE BRUBECK' WHERE id = 2b164bd0-1017-11ed-861d-0242ac120002")

rows = session.execute('SELECT id, cpf, nome FROM cliente WHERE id = 2b164bd0-1017-11ed-861d-0242ac120002')

for cliente in rows:
    print (cliente.nome)

```

### DELETE
```
session.execute("DELETE FROM infobarbank.cliente WHERE id = 2b164bd0-1017-11ed-861d-0242ac120002")

rows = session.execute('SELECT id, cpf, nome FROM cliente WHERE id = 2b164bd0-1017-11ed-861d-0242ac120002')

for cliente in rows:
    print (cliente.nome)

```
