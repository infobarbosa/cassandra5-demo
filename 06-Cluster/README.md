# Cluster
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Cassandra em cluster

Atenção! Cuidado para executar os comandos em ordem e apenas uma vez sob o risco de ter de reiniciar o laboratório.<br>
Exceções a essa regra serão apontadas pelo professor.

### Objetivo
Executar um cluster de 2 ou mais nós (ou nodes) e observar os principais aspectos operacionais do mesmo.

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
```

##### `nodetool describering`
```
docker exec -it cassandra-database nodetool describering -- ks001

```

Output:
```
```

Agora um select para entendermos onde cada registro está:
```
docker exec -it cassandra-database cqlsh -e "select id_cliente, token(id_cliente), nome from ks001.cliente;"

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
INCLUIR AQUI ETAPA UJ (UP-JOINNING)
```

##### `nodetool ring`
```
docker exec -it cassandra-database nodetool ring

```

##### `nodetool describering`
```
docker exec -it cassandra-database nodetool describering -- ks001

```

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
docker exec -it cassandra-database cqlsh -e "SELECT id_cliente, nome, email FROM ks001.cliente WHERE id_cliente in('2b162060', '2b16242a');"
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
update ks001.cliente set email='gracimar.brasil@example.com' where id_cliente='2b16256a';
update ks001.cliente set email='aldenora.viana@example.com' where id_cliente='2b16353c';
```

Checando:
```
docker exec -it cassandra-database cqlsh -e "SELECT id_cliente, nome, email FROM ks001.cliente WHERE id_cliente in('2b16256a', '2b16353c');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

## Ciclo 3

```
update ks001.cliente set email='vera.sena@example.com' where id_cliente='2b1636ae';
update ks001.cliente set email='ivone.dutra@example.com' where id_cliente='2b16396a';
```

Checando:
```
docker exec -it cassandra-database cqlsh -e "SELECT id_cliente, nome, email FROM ks001.cliente WHERE id_cliente in('2b1636ae', '2b16396a');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

## Ciclo 4
```
update ks001.cliente set email='lucilia.pereira@example.com' where id_cliente='2b163bcc';
update ks001.cliente set email='francisca.feitosa@example.com' where id_cliente='2b163cda';
```

Checando:
```
docker exec -it cassandra-database cqlsh -e "SELECT id_cliente, nome, email FROM ks001.cliente WHERE id_cliente in('2b163bcc', '2b163cda');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

## Ciclo 5
```
update ks001.cliente set email='bruna.paiva@example.com' where id_cliente='2b163dde';
update ks001.cliente set email='lucilene.barbosa@example.com' where id_cliente='2b163ed8';
```

Checando:
```
docker exec -it cassandra-database cqlsh -e "SELECT id_cliente, nome, email FROM ks001.cliente WHERE id_cliente in('2b163dde', '2b163ed8');"
```

```
docker exec -it cassandra-database nodetool flush

```

```
docker exec -it cassandra-node-2 nodetool flush

``` 

## Ciclo 6
```
docker exec -it cassandra-database cqlsh -e "
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
Bom trabalho!