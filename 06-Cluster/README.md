# Cluster
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Cassandra em cluster


### Objetivo
Executar um cluster de 2 ou mais nós (ou nodes) e observar os principais aspectos operacionais do mesmo.

# Atenção!
> 1. A partir daqui o laboratório será executado ainda no terminal, mas fora do docker. Digite `Control+D` (uma única vez para sair da instância docker.)
> 2. Cuidado para executar os comandos em ordem e apenas uma vez sob o risco de ter de reiniciar o laboratório.
> 3. Exceções as essas duas regras serão apontadas pelo professor.

# Preparação
Antes de inicializar o cluster vamos fazer algumas consultas interessantes.

### Tokens

Checando a distribuição atual de tokens.
##### `nodetool ring`
```
docker exec -it cassandra-database nodetool ring
```

Output:
```
Datacenter: datacenter1
==========
Address           Rack        Status State   Load            Owns                Token
                                                                                 8170034754120362381
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   -8686704767075290596
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   -7067681471378247298
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   -6089536018862133223
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   -4310901718038546094
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   -3214859817803607805
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   -2123562707111395545
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   -1279186059620233789
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   161082170282349449
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   1232582786622382262
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   2250434191364809277
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   3068106123977160072
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   4143862005202739611
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   4879777697913633252
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   5959150505361234910
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   7202670511041826882
172.16.0.11       RAC1        Up     Normal  538.24 KiB      ?                   8170034754120362381

```

##### `nodetool describering`
```
docker exec -it cassandra-database nodetool describering -- ks001

```

Output:
```
Schema Version:131fd63b-db2a-3491-8317-11850f185784
TokenRange:
	TokenRange(start_token:3068106123977160072, end_token:4143862005202739611, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:5959150505361234910, end_token:7202670511041826882, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:8170034754120362381, end_token:-8686704767075290596, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-7067681471378247298, end_token:-6089536018862133223, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:4143862005202739611, end_token:4879777697913633252, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-3214859817803607805, end_token:-2123562707111395545, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:2250434191364809277, end_token:3068106123977160072, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-4310901718038546094, end_token:-3214859817803607805, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:7202670511041826882, end_token:8170034754120362381, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:1232582786622382262, end_token:2250434191364809277, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:4879777697913633252, end_token:5959150505361234910, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-6089536018862133223, end_token:-4310901718038546094, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:161082170282349449, end_token:1232582786622382262, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-1279186059620233789, end_token:161082170282349449, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-2123562707111395545, end_token:-1279186059620233789, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-8686704767075290596, end_token:-7067681471378247298, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])

```

Agora um select para entendermos onde cada registro está:
```
docker exec -it cassandra-database cqlsh -e "select id_cliente, token(id_cliente), nome from ks001.cliente;"

```

Output:
```
 id_cliente | system.token(id_cliente) | nome
------------+--------------------------+-----------
   2b163cda |     -8543095953418148456 | FRANCISCA
   2b163ed8 |     -5699046624560118549 |  LUCILENE
   2b163dde |     -5570112041222660315 |     BRUNA
   2b163bcc |     -5038845464850628004 |   LUCILIA
   2b1636ae |     -4846341449078699481 |      VERA
   2b16242a |     -4461337310647205397 |  JUCILENE
   2b16353c |     -3218952037653612748 |  ALDENORA
   2b162060 |      -754340186604780055 | MARIVALDA
   2b16396a |      6124063227111369309 |     IVONE

(9 rows)
```

---

# Inicializando o segundo node

```
docker run -d \
  --name cassandra-node-2 \
  --network cassandra-standalone_common_net \
  --ip 172.16.0.12 \
  -e CASSANDRA_CLUSTER_NAME=infobarbosainc \
  -e CASSANDRA_DC=datacenter1 \
  -e CASSANDRA_RACK=RAC1 \
  -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
  -e CASSANDRA_START_RPC=true \
  -e CASSANDRA_RPC_ADDRESS=0.0.0.0 \
  -e CASSANDRA_LISTEN_ADDRESS=auto \
  -e CASSANDRA_BROADCAST_ADDRESS=172.16.0.12 \
  -e CASSANDRA_SEEDS=172.16.0.11 \
  --restart on-failure \
  cassandra:latest

```

Vamos aguardar um minuto enquanto o node inicializa.<br>

### Logs de inicialização
Enquanto o segundo node inicializa, vamos checar os logs dele:
```
docker logs -f cassandra-node-2

```

Utiliza `Control+C` (uma única vez) para sair do docker logs.

### Checando a inicialização
```
docker exec -it cassandra-database nodetool status

```

Output:
```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address      Load        Tokens  Owns  Host ID                               Rack
UJ  172.16.0.12  30.9 KiB    16      ?     2c7d204b-8375-4ee1-b2c2-bcda888f3cfb  RAC1
UN  172.16.0.11  538.24 KiB  16      ?     770924c2-9e0b-4cea-89f5-f9a3edebb4bd  RAC1
```

Perceba que o node `172.16.0.12` tem o status `UJ` (Up & Joining). Quando a inicialização terminar o status será alterado para `UN` (Up & Normal).

##### `nodetool ring`
```
docker exec -it cassandra-database nodetool ring

```

##### `nodetool describering`
```
docker exec -it cassandra-database nodetool describering -- ks001

```

Perceba que desta vez o output é bem maior, o cluster está redistribuindo os tokens de forma balanceada.<br>
Output:
```
Schema Version:e35dd15e-7d47-3e37-b8df-aa9997e73c3f
TokenRange:
	TokenRange(start_token:-1915622271984372983, end_token:-1255665246995668722, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-4464693095206610657, end_token:-3940263130576706799, endpoints:[172.16.0.12], rpc_endpoints:[172.16.0.12], endpoint_details:[EndpointDetails(host:172.16.0.12, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:8880122348359738647, end_token:-8971319356389413718, endpoints:[172.16.0.12], rpc_endpoints:[172.16.0.12], endpoint_details:[EndpointDetails(host:172.16.0.12, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:3210963935421239960, end_token:3688453517271183029, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:7655420416340191498, end_token:8062450415747387852, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-5432057338285146156, end_token:-4876176303368222219, endpoints:[172.16.0.12], rpc_endpoints:[172.16.0.12], endpoint_details:[EndpointDetails(host:172.16.0.12, datacenter:datacenter1, rack:RAC1)])
    ...
    ...
```

# Novas operações de escrita

## Ciclo 1
```
docker exec -it cassandra-database cqlsh -e "
update ks001.cliente set email='marivalda.kanamary@example.com' where id_cliente='2b162060';
update ks001.cliente set email='jucilene.moreira@example.com' where id_cliente='2b16242a';"
```

Checando:
```
docker exec -it cassandra-database \
cqlsh -e "
SELECT id_cliente, nome, email 
FROM ks001.cliente 
WHERE id_cliente in('2b162060', '2b16242a');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

Observe os datafiles nos dois nodes.

## Ciclo 2

```
docker exec -it cassandra-database \
cqlsh -e "
update ks001.cliente set email='gracimar.brasil@example.com' where id_cliente='2b16256a';
update ks001.cliente set email='aldenora.viana@example.com' where id_cliente='2b16353c';"
```

Checando:
```
docker exec -it cassandra-database \
cqlsh -e "
SELECT id_cliente, nome, email 
FROM ks001.cliente 
WHERE id_cliente in('2b16256a', '2b16353c');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

## Ciclo 3

```
docker exec -it cassandra-database \
cqlsh -e "
update ks001.cliente set email='vera.sena@example.com' where id_cliente='2b1636ae';
update ks001.cliente set email='ivone.dutra@example.com' where id_cliente='2b16396a';"
```

Checando:
```
docker exec -it cassandra-database \
cqlsh -e "
SELECT id_cliente, nome, email 
FROM ks001.cliente 
WHERE id_cliente in('2b1636ae', '2b16396a');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

## Ciclo 4
```
docker exec -it cassandra-database \
cqlsh -e "
update ks001.cliente set email='lucilia.pereira@example.com' where id_cliente='2b163bcc';
update ks001.cliente set email='francisca.feitosa@example.com' where id_cliente='2b163cda';"
```

Checando:
```
docker exec -it cassandra-database \
cqlsh -e "
SELECT id_cliente, nome, email 
FROM ks001.cliente 
WHERE id_cliente in('2b163bcc', '2b163cda');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

## Ciclo 5
```
docker exec -it cassandra-database \
cqlsh -e "
update ks001.cliente set email='bruna.paiva@example.com' where id_cliente='2b163dde';
update ks001.cliente set email='lucilene.barbosa@example.com' where id_cliente='2b163ed8';"
```

Checando:
```
docker exec -it cassandra-database \
cqlsh -e "
SELECT id_cliente, nome, email 
FROM ks001.cliente 
WHERE id_cliente in('2b163dde', '2b163ed8');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

## Ciclo 6
Agora vamos interromper o container `cassandra-database` e testar a disponibilidade dos dados.
```
docker stop cassandra-database
```

Checando:
```
docker exec -it cassandra-node-2 nodetool status
```

Agora vamos validar, um a um, os registros que inserimos anteriormente.<br>
Perceba que alguns estarão disponíveis enquanto outros retornarão a seguinte mensagem:
```
<stdin>:1:NoHostAvailable: ('Unable to complete the operation against any hosts', {<Host: 127.0.0.1:9042 datacenter1>: Unavailable('Error from server: code=1000 [Unavailable exception] message="Cannot achieve consistency level ONE" info={\'consistency\': \'ONE\', \'required_replicas\': 1, \'alive_replicas\': 0}')})
```

```
# 1. Marivalda
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b162060';"

# 2. Jucilene
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b16242a';"

# 3. Gracimar
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b16256a';"

# 4. Aldenora
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b16353c';"

#5. Vera
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b1636ae';"

# 6. Ivone
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b16396a';"

# 7. Lucilia
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b163bcc';"

#8. Francisca
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b163cda';"

# 9. Bruna
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b163dde';"

# 10. Lucilene
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b163ed8';"

```

## Ciclo 7 (Ajustando o replication factor)
Nesse ciclo vamos resolver o problema de disponibilidade incrementando o fator de replicação da keyspace `ks001`.

1. Reiniciando o container `cassandra-database`
```
docker start cassandra-database
```

Checando:
```
docker exec -it cassandra-node-2 nodetool status
```
Aguarde o status **UN** (Up & Normal)

2. Ajustando o fator de replicação par 2

```
docker exec -it cassandra-database \
cqlsh -e "
  ALTER KEYSPACE ks001
      WITH REPLICATION = {
          'class' : 'SimpleStrategy', 
          'replication_factor':2  
      };"
```

Checando:
```
docker exec -it cassandra-database \
cqlsh -e "DESCRIBE KEYSPACE ks001;"
```

Nos logs do cassandra será possível encontrar uma mensagem assim:
```
INFO  [Native-Transport-Requests-1] 2024-11-23 22:15:09,808 Keyspace.java:379 - Creating replication strategy ks001 params KeyspaceParams{durable_writes=true, replication=ReplicationParams{class=org.apache.cassandra.locator.SimpleStrategy, replication_factor=2}}
```

3. Interrompendo novamente
```
docker stop cassandra-node-2
```

Checando:
```
docker exec -it cassandra-database nodetool status
```

4. Executando a checagem individual novamente
```

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b162060';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b16242a';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b16256a';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b16353c';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b1636ae';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b16396a';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b163bcc';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b163cda';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b163dde';"

docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome 
from ks001.cliente 
where id_cliente='2b163ed8';"

```

---

## Ciclo 8
```
docker exec -it cassandra-database \
cqlsh -e "
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162061', '06060606066', 'JOÃO', 'SILVA', 'joao.silva@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162062', '07070707077', 'MARIA', 'FERREIRA', 'maria.ferreira@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162063', '08080808088', 'ANTONIO', 'SANTOS', 'antonio.santos@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162064', '09090909099', 'ANA', 'COSTA', 'ana.costa@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162065', '10101010100', 'CARLOS', 'RODRIGUES', 'carlos.rodrigues@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162066', '11111111111', 'PAULO', 'ALMEIDA', 'paulo.almeida@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162067', '12121212122', 'LUCIA', 'PEREIRA', 'lucia.pereira@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162068', '13131313133', 'PEDRO', 'LIMA', 'pedro.lima@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162069', '14141414144', 'JOSE', 'MARTINS', 'jose.martins@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162070', '15151515155', 'RAFAELA', 'GONÇALVES', 'rafaela.goncalves@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162071', '16161616166', 'MARCOS', 'BARBOSA', 'marcos.barbosa@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162072', '17171717177', 'FERNANDA', 'RIBEIRO', 'fernanda.ribeiro@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162073', '18181818188', 'ROBERTO', 'CARVALHO', 'roberto.carvalho@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162074', '19191919199', 'JULIANA', 'SOUZA', 'juliana.souza@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162075', '20202020200', 'GABRIEL', 'MENDES', 'gabriel.mendes@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162076', '21212121211', 'MARIANA', 'NUNES', 'mariana.nunes@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162077', '22222222222', 'ANDRE', 'TEIXEIRA', 'andre.teixeira@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162078', '23232323233', 'PATRICIA', 'FREITAS', 'patricia.freitas@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162079', '24242424244', 'RAFAEL', 'ARAÚJO', 'rafael.araujo@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162080', '25252525255', 'LARISSA', 'CASTRO', 'larissa.castro@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162081', '26262626266', 'DANIEL', 'SILVEIRA', 'daniel.silveira@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162082', '27272727277', 'CAROLINA', 'MORAES', 'carolina.moraes@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162083', '28282828288', 'FELIPE', 'PINTO', 'felipe.pinto@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162084', '29292929299', 'RENATA', 'LOPES', 'renata.lopes@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162085', '30303030300', 'GUSTAVO', 'CAMPOS', 'gustavo.campos@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162086', '31313131311', 'TATIANA', 'ROCHA', 'tatiana.rocha@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162087', '32323232322', 'BRUNO', 'SANTANA', 'bruno.santana@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162088', '33333333333', 'ALICE', 'MACEDO', 'alice.macedo@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162089', '34343434344', 'MATEUS', 'REIS', 'mateus.reis@example.com');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome, email) VALUES('2b162090', '35353535355', 'ISABELA', 'CORREA', 'isabela.correa@example.com');"

```

Checando:
```
docker exec -it cassandra-database cqlsh -e "SELECT id_cliente, nome, email FROM ks001.cliente;"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

---

### Encerrando o cluster
Por comodidade e também restrição de recursos de cpu e memória do nosso laboratório, vamos inicializar um cluster com apenas 2 nós.
```
docker compose -f ./cassandra5-demo/assets/scripts/standalone/compose.yaml down --remove-orphans

```

---

# Desafio (Terceiro node)
Inicialize o terceiro node e refaça esse laboratório observando os mesmos aspectos operacionais do Cassandra.
```
docker run -d \
  --name cassandra-node-3 \
  --network cassandra-standalone_common_net \
  --ip 172.16.0.13 \
  -e CASSANDRA_CLUSTER_NAME=infobarbosainc \
  -e CASSANDRA_DC=datacenter1 \
  -e CASSANDRA_RACK=RAC1 \
  -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
  -e CASSANDRA_START_RPC=true \
  -e CASSANDRA_RPC_ADDRESS=0.0.0.0 \
  -e CASSANDRA_LISTEN_ADDRESS=auto \
  -e CASSANDRA_BROADCAST_ADDRESS=172.16.0.13 \
  -e CASSANDRA_SEEDS=172.16.0.11 \
  --restart on-failure \
  cassandra:latest

```

---

# Parabéns! 

Você concluiu com sucesso a sessão de configuração e operação de um cluster Cassandra. <br>
Entendeu como sistemas de altíssima disponibilidade se comportam em situações de falha. <br>
Bom trabalho!