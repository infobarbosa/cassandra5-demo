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

### Inicializando o segundo node
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

##### Logs de inicialização
Enquanto o segundo node inicializa, vamos checar os logs dele:
```
docker logs -f cassandra-node-2

```

Utiliza `Control+C` (uma única vez) para sair do docker logs.

##### Checando a inicialização
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


### Encerrando o cluster
Por comodidade e também restrição de recursos de cpu e memória do nosso laboratório, vamos inicializar um cluster com apenas 2 nós.
```
docker compose -f ./cassandra5-demo/assets/scripts/standalone/compose.yaml down --remove-orphans

```

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

# Parabéns! 

Você concluiu com sucesso a sessão de configuração e operação de um cluster Cassandra. <br>
Bom trabalho!