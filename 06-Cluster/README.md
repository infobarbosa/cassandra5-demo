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
docker exec -it cassandra-database nodetool describering -- infobarbank

```

Output:
```
Schema Version:c223a1cc-30c3-389e-bf5e-8a2a28d02a54
TokenRange:
	TokenRange(start_token:3380842163723588779, end_token:4116757856434482420, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-601937671196801382, end_token:469562945143231430, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:1487414349885658445, end_token:2305086282498009240, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:7407014912641211549, end_token:8997019465155110187, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-7830701312857398131, end_token:-6852555860341284055, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-5073921559517696926, end_token:-3977879659282758637, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-3977879659282758637, end_token:-2886582548590546377, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-6852555860341284055, end_token:-5073921559517696926, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-2886582548590546377, end_token:-2042205901099384621, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:4116757856434482420, end_token:5196130663882084078, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:8997019465155110187, end_token:-7830701312857398131, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:6439650669562676050, end_token:7407014912641211549, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:2305086282498009240, end_token:3380842163723588779, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:-2042205901099384621, end_token:-601937671196801382, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:469562945143231430, end_token:1487414349885658445, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
	TokenRange(start_token:5196130663882084078, end_token:6439650669562676050, endpoints:[172.16.0.11], rpc_endpoints:[172.16.0.11], endpoint_details:[EndpointDetails(host:172.16.0.11, datacenter:datacenter1, rack:RAC1)])
```

Agora um select para entendermos onde cada registro está:
```
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, token(id_cliente), nome_completo 
from infobarbank.cliente;"

```

Output:
```
 id_cliente | system.token(id_cliente) | nome_completo
------------+--------------------------+------------------------------
   2b169e92 |     -8712532110630726946 |         JULIO CESAR DA SILVA
   2b165fec |     -8558176393376349233 |    JOANA FERREIRA DOS SANTOS
   2b1648b8 |     -7612830640053820666 | CLAUDIA APARECIDA DOS SANTOS
   2b1658f6 |     -6562846931424734492 |        FABIANA SILVA MENEZES
   2b16954a |     -6347999470134102728 |          PAULA GOMES PEREIRA
   2b16623e |     -5882310209747122173 |                ADRIANA MOURA
   2b163f70 |     -5835949017412829022 |       MARIA DO SOCORRO SILVA
   2b163bcc |     -5038845464850628004 |    LUCILIA ROSA LIMA PEREIRA
   2b167720 |     -5013264196111508838 |      JOSÉ ANTONIO DOS SANTOS
   2b1636ae |     -4846341449078699481 |    VERA LUCIA RODRIGUES SENA
   2b164414 |     -4655472260298954328 |              ANA PAULA COSTA
   2b16242a |     -4461337310647205397 |        JUCILENE MOREIRA CRUZ
   2b1692f8 |     -4194022825755270734 |             GUSTAVO TEIXEIRA
   2b1674ce |     -4190093608918873441 |        SANDRA REGINA PEREIRA
   2b167972 |     -4107711411801234542 |              MONICA TEIXEIRA
   2b16875e |     -3637458913481672298 |           CAMILA SOUZA SILVA
   2b16256a |     -3452877568120123027 |       GRACIMAR BRASIL GUERRA
   2b16353c |     -3218952037653612748 |       ALDENORA VIANA MOREIRA
   2b166dd8 |     -3008750763346009173 |         JOÃO CARLOS DA SILVA
   2b164d5c |     -1456266778803695171 |         PAULO CESAR FERREIRA
   2b168c02 |     -1395989636492372385 |       RODRIGO CARLOS MARTINS
   2b162060 |      -754340186604780055 |           MARIVALDA KANAMARY
   2b1666e2 |      -746090397426357031 |      JULIANA MENDES DA SILVA
   2b16979c |       -40868543715028755 |     CAROLINA MENDES DA SILVA
   2b169c40 |       339950139224958179 |        FABIANO LOPES PEREIRA
   2b165d9a |      1109809741577075537 |           EDSON LUIZ PEREIRA
   2b16727c |      1329741771561399491 |       ROBERTO CARLOS MARTINS
   2b165452 |      1666979987203666860 |     RENATA ALMEIDA GONÇALVES
   2b165200 |      1684844209539938490 |      MARCOS ANTONIO DA SILVA
   2b1689b0 |      1789661482577644004 |        MARIA EDUARDA MARTINS
   2b167bc4 |      2305300893192919252 |        ANDREIA GOMES PEREIRA
   2b1641c2 |      2706381768932907895 |            JOÃO CARLOS SILVA
   2b164b0a |      2811038833994637089 |            LUCAS GOMES SILVA
   2b163d1e |      3086150251938639246 |        RAIMUNDA PEREIRA LIMA
   2b168e54 |      3260121672773250572 |         LUANA REGINA PEREIRA
   2b166490 |      3480908928027940444 |        RICARDO GOMES PEREIRA
   2b167e16 |      3778294173766598603 |        FABIO MENDES DA SILVA
   2b1682ba |      4119150782386367407 |      ANA LUCIA LOPES PEREIRA
   2b166934 |      4490858419784835712 |        MARCELO TEIXEIRA LIMA
   2b166b86 |      5817313228743043344 |       FERNANDA LOPES PEREIRA
   2b168068 |      6024187432660981336 |         MARCIA TEIXEIRA LIMA
   2b16396a |      6124063227111369309 |    IVONE GLAUCIA VIANA DUTRA
   2b165b48 |      6150238245947877385 |       CARLOS EDUARDO MARTINS
   2b1699ee |      6196564456643707629 |        CLAUDIO TEIXEIRA LIMA
   2b1656a4 |      6942672213897942684 |         ANTONIO JOSÉ PEREIRA
   2b16850c |      7230449702395993687 |      PEDRO HENRIQUE DA SILVA
   2b1690a6 |      7645068900960427482 |    MARIA FERNANDA DOS SANTOS
   2b164fae |      8021365594885164742 |        ROSANA MARIA TEIXEIRA
   2b164666 |      8423054394199960816 |      FRANCISCO OLIVEIRA LIMA
   2b16702a |      8599604025704049430 |        ELIZABETH SOUZA SILVA

(50 rows)
```

Nesse laboratório vamos nos concentrar nessas pessoas especificamente:
```
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, token(id_cliente), nome_completo 
from infobarbank.cliente 
where id_cliente in(
'2b162060',
'2b16242a',
'2b16256a',
'2b16353c',
'2b1636ae',
'2b16396a',
'2b163bcc',
'2b1656a4',
'2b166b86',
'2b16727c');"

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

Output:
```
barbosa: cassandra5-demo $ docker exec -it cassandra-database nodetool ring


Datacenter: datacenter1
==========
Address           Rack        Status State   Load            Owns                Token
                                                                                 8920941708532877872
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -9001372400546769886
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -8585734740975130006
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             -7935797812662775105
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -7374054394303148859
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -6976731541954436068
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             -6316774516965731807
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -5718310826008992980
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             -5338629064449617732
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -4684010179333588614
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -4257723678052459224
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             -3559994763626030603
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -2907521851477781340
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             -2463952863391092314
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   -1850145334548823123
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             -1372655752698880054
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             -528279105207718298
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   271549565453411984
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             911989124694864940
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   1529970156597065017
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             1983489741034897753
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   2594311146370128414
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             3001341145777324768
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             3819013078389675563
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   4414315447350074813
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             4894768959615255102
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             5630684652326148743
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   6291379776863060842
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             6710057459773750401
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   7460334700042075221
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             7953577465454342373
172.16.0.12       RAC1        Up     Joining 30.9 KiB        ?                   8509458500371266309
172.16.0.11       RAC1        Up     Normal  109.15 KiB      100.00%             8920941708532877872
```

##### `nodetool describering`
```
docker exec -it cassandra-database nodetool describering -- infobarbank

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
Checando as pessoas que vamos usar como exemplo neste lab.
```
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, token(id_cliente), nome_completo 
from infobarbank.cliente 
where id_cliente in(
'2b162060',
'2b16242a',
'2b16256a',
'2b16353c',
'2b1636ae',
'2b16396a',
'2b163bcc',
'2b1656a4',
'2b166b86',
'2b16727c');"
```

Output:
```
 id_cliente | system.token(id_cliente) | nome_completo
------------+--------------------------+---------------------------
   2b162060 |      -754340186604780055 |        MARIVALDA KANAMARY
   2b16242a |     -4461337310647205397 |     JUCILENE MOREIRA CRUZ
   2b16256a |     -3452877568120123027 |    GRACIMAR BRASIL GUERRA
   2b16353c |     -3218952037653612748 |    ALDENORA VIANA MOREIRA
   2b1636ae |     -4846341449078699481 | VERA LUCIA RODRIGUES SENA
   2b16396a |      6124063227111369309 | IVONE GLAUCIA VIANA DUTRA
   2b163bcc |     -5038845464850628004 | LUCILIA ROSA LIMA PEREIRA
   2b1656a4 |      6942672213897942684 |      ANTONIO JOSÉ PEREIRA
   2b166b86 |      5817313228743043344 |    FERNANDA LOPES PEREIRA
   2b16727c |      1329741771561399491 |    ROBERTO CARLOS MARTINS
```

## Ciclo 2
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
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b162060';"

```

```
# 2. Jucilene
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b16242a';"

```

```
# 3. Gracimar
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b16256a';"

```

```
# 4. Aldenora
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b16353c';"

```

```
# 5. Vera
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b1636ae';"

```

```
# 6. Ivone
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b16396a';"

```

```
# 7. Lucilia
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b163bcc';"

```

```
#8. José Antônio
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b1656a4';"

```

```
# 9. Fernanda Lopes
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b166b86';"

```

```
# 10. Roberto Carlos
docker exec -it cassandra-node-2 \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b16727c';"

```

## Ciclo 3 (Ajustando o replication factor)
Nesse ciclo vamos resolver o problema de disponibilidade incrementando o fator de replicação da keyspace `infobarbank`.

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
  ALTER KEYSPACE infobarbank
      WITH REPLICATION = {
          'class' : 'SimpleStrategy', 
          'replication_factor':2  
      };"

```

Output:
```
Warnings :
When increasing replication factor you need to run a full (-full) repair to distribute the data.
```

Checando:
```
docker exec -it cassandra-database \
cqlsh -e "DESCRIBE KEYSPACE infobarbank;"

```

Nos logs do cassandra será possível encontrar uma mensagem assim:
```
INFO  [Native-Transport-Requests-1] 2024-11-23 22:15:09,808 Keyspace.java:379 - Creating replication strategy infobarbank params KeyspaceParams{durable_writes=true, replication=ReplicationParams{class=org.apache.cassandra.locator.SimpleStrategy, replication_factor=2}}
```

3. Full repair
```
docker exec -it cassandra-database \
nodetool repair -full infobarbank

```

Output:
```
[2024-12-01 15:09:02,933] Starting repair command #1 (33463730-aff6-11ef-bb3f-d165bc4d0c5a), repairing keyspace infobarbank with repair options (parallelism: parallel, primary range: false, incremental: false, job threads: 1, ColumnFamilies: [], dataCenters: [], hosts: [], previewKind: NONE, # of ranges: 32, pull repair: false, force repair: false, optimise streams: false, ignore unreplicated keyspaces: false, repairPaxos: true, paxosOnly: false)
[2024-12-01 15:09:08,142] Repair session 3360eb20-aff6-11ef-bb3f-d165bc4d0c5a for range [(-4684010179333588614,-4257723678052459224], (7460334700042075221,8063197611355638076], (979356839683397236,1529970156597065017], (1529970156597065017,2168690362807901872], (-1072193076303726574,-560756366483902548], (5526238352456026334,6291379776863060842], (8509458500371266309,9031570845768332186], (-6976731541954436068,-6227594643935658604], (-5718310826008992980,-5112501197811042660], (5029631943465144012,5526238352456026334], (-8585734740975130006,-7851915807664741701], (-7851915807664741701,-7374054394303148859], (8063197611355638076,8509458500371266309], (9031570845768332186,-9001372400546769886], (3670362857388014885,4414315447350074813], (2168690362807901872,2594311146370128414], (6291379776863060842,7006909029794780606], (-7374054394303148859,-6976731541954436068], (-2907521851477781340,-2260581816716580904], (271549565453411984,979356839683397236], (2594311146370128414,3214916992614397046], (-3507911865466341968,-2907521851477781340], (-9001372400546769886,-8585734740975130006], (-1850145334548823123,-1072193076303726574], (-4257723678052459224,-3507911865466341968], (-560756366483902548,271549565453411984], (4414315447350074813,5029631943465144012], (7006909029794780606,7460334700042075221], (-5112501197811042660,-4684010179333588614], (3214916992614397046,3670362857388014885], (-6227594643935658604,-5718310826008992980], (-2260581816716580904,-1850145334548823123]] finished (progress: 57%)
[2024-12-01 15:09:08,175] Repair completed successfully
[2024-12-01 15:09:08,176] Repair command #1 finished in 5 seconds
[2024-12-01 15:09:08,193] condition satisfied queried for parent session status and discovered repair completed.
[2024-12-01 15:09:08,194] Repair completed successfully
```

4. Interrompendo novamente
```
docker stop cassandra-node-2

```

Checando:
```
docker exec -it cassandra-database nodetool status

```

5. Executando a checagem individual novamente
```
# 1. Marivalda
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b162060';"

```

```
# 2. Jucilene
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b16242a';"

```

```
# 3. Gracimar
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b16256a';"

```

```
# 4. Aldenora
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b16353c';"

```

```
# 5. Vera
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b1636ae';"

```

```
# 6. Ivone
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b16396a';"

```

```
# 7. Lucilia
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b163bcc';"

```

```
#8. José Antônio
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo 
from infobarbank.cliente 
where id_cliente='2b1656a4';"

```

```
# 9. Fernanda Lopes
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b166b86';"

```

```
# 10. Roberto Carlos
docker exec -it cassandra-database \
cqlsh -e "
select id_cliente, nome_completo
from infobarbank.cliente 
where id_cliente='2b16727c';"

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