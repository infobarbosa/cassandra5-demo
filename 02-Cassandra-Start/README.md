# Instalação do Cassandra
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nesta sessão vamos instalar o Apache Cassandra no servidor EC2 do Cloud9.<br>
Você pode optar pela instalação automática via script `scripts/setup_cassandra.sh` ou por fazer o passo-a-passo descrito a seguir.<br>
As duas instalações são exatamente iguais.

## Instalação via `setup_cassandra.sh`

> Atenção! Os comandos aqui descritos presumem que você esteja no diretório raiz do projeto clonado do Github.

```
sh scripts/setup_cassandra.sh
```

Output:
```
voclabs:~/environment/cassandra-aws (main) $ sh scripts/setup_cassandra.sh
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
openjdk-11-jdk-headless is already the newest version (11.0.20.1+1-0ubuntu1~22.04).
0 upgraded, 0 newly installed, 0 to remove and 7 not upgraded.
deb https://debian.cassandra.apache.org 41x main
...
...
The following NEW packages will be installed:
  cassandra
0 upgraded, 1 newly installed, 0 to remove and 7 not upgraded.
Need to get 48.3 MB of archives.
After this operation, 58.8 MB of additional disk space will be used.
...
```

## Instalação passo-a-passo

**Instalando o Java 11**
```
sudo apt install -y openjdk-11-jdk-headless
```

**Instalando o Cassandra**
Vamos incluir a chave e link para o repositório para que o gerenciador de pacotes do Linux saiba onde buscar os binários.  

```
echo "deb https://debian.cassandra.apache.org 41x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
```

Obtento chaves do repositório:
```
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
```

Atualizando a lista de pacotes:
```
sudo apt update -y
```

Instalando o Cassandra:
```
sudo apt install -y cassandra
```

Caso o serviço não tenha iniciado, você pode inicializá-lo manualmente:
```
sudo systemctl start cassandra
```

Verifique o status do serviço
```
sudo systemctl status cassandra
```

## Checando a instalação
Se tudo correu bem então será possível verificar o status do node:
```
nodetool status
```

O comando acima deve retornar algo assim:
```
voclabs:~/environment/cassandra-aws (main) $ nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens  Owns (effective)  Host ID                               Rack 
UN  127.0.0.1  94.87 KiB  16      100.0%            8632e0e0-4901-428f-9484-6e1cf0c44cf1  rack1

voclabs:~/environment/cassandra-aws (main) $ 
```

**Atenção!** Se retornar o erro erro abaixo, é provável que o serviço Cassandra ainda esteja em processo de inicialização.
```
java.lang.RuntimeException: No nodes present in the cluster. Has this node finished starting up?
        at org.apache.cassandra.dht.Murmur3Partitioner.describeOwnership(Murmur3Partitioner.java:294)
```
Espere alguns segundos até que a inicialização tenha terminado e execute o comando novamente.

## Carregando schemas


### Keyspace infobarbank

```
cqlsh -e "
  CREATE KEYSPACE infobarbank 
  WITH replication = {
      'class': 'SimpleStrategy', 
      'replication_factor': 1};"
```

### Tabela CONTA_CORRENTE                               

```
cqlsh -e "
  CREATE TABLE infobarbank.conta_corrente(
    num_conta           TEXT,
    apelido_cliente     TEXT,
    data_ultimo_acesso  DATE,
    saldo_disponivel    FLOAT,
    PRIMARY KEY(num_conta));"
```

```
cqlsh -e "
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b162060', 'MARIVALDA', '2022-09-01', 100.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16242a', 'JUCILENE' , '2022-08-01', 500.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16256a', 'GRACIMAR' , '2022-09-04', 30.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16353c', 'ALDENORA' , '2022-09-03', 1500.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b1636ae', 'VERA'     , '2022-09-02', 70.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16396a', 'IVONE'    , '2022-08-30', 400.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b163bcc', 'LUCILIA'  , '2022-08-31', 350.00);"
```

### Tabela CARTAO_CREDITO
```
cqlsh -e "
  CREATE TABLE infobarbank.cartao_credito(
    id_cliente          TEXT,
    status              TEXT,
    id                  TEXT,
    num_cartao          TEXT,
    cvv	                TEXT,
    data_validade       DATE,
    limite_total        FLOAT,
    limite_disponivel   FLOAT,
    PRIMARY KEY((id_cliente), status, id));"
```

```
cqlsh -e "
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '007c2c1c', '5450 3799 9172 8454', '423', '2030-02-21', 1000.00, 900.00);
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '897199aa', '5576 8924 9861 7490', '336', '2030-07-21', 200.00 , 50.00);
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '9a748c3c', '5188 2716 2053 8850', '920', '2024-03-21', 500.00 , 100.00);
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b16242a', 'ATIVO', 'a2fab366', '5590 5738 5562 1778', '198', '2024-03-21', 5000.00, 4000.00);
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b16256a', 'ATIVO', 'cd586ffb', '5412 2646 1222 3738', '273', '2030-02-21', 3000.00, 1500.00);"
```


### Tabela LANCAMENTOS_CARTAO_CREDITO
```
cqlsh -e "
  CREATE TABLE infobarbank.lancamentos_cartao_credito(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), data_hora, id_produto, status, tipo_lancamento, id)
  ) WITH CLUSTERING ORDER BY (data_hora DESC, id_produto ASC, status ASC, tipo_lancamento ASC, id ASC) ;"
```

```
cqlsh -e "
  COPY infobarbank.lancamentos_cartao_credito (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"
```

### Tabela LANCAMENTOS_POR_STATUS
```
cqlsh -e "
  CREATE TABLE infobarbank.lancamentos_por_status(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), status, data_hora, id)
  ) WITH CLUSTERING ORDER BY (status ASC, data_hora DESC, id ASC);"
```

```
cqlsh -e "
  COPY infobarbank.lancamentos_por_status (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"
```

### Tabela LANCAMENTOS_POR_PERIODO

```
cqlsh -e "
  CREATE TABLE infobarbank.lancamentos_por_periodo(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), data_hora, id)
  ) WITH CLUSTERING ORDER BY (data_hora DESC, id ASC) ;"
```

```
cqlsh -e "
  COPY infobarbank.lancamentos_por_periodo (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"
```


### Tabela LANCAMENTOS_POR_PRODUTO                      

```
cqlsh -e "
  CREATE TABLE infobarbank.lancamentos_por_produto(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), id_produto, data_hora, id)
  ) WITH CLUSTERING ORDER BY (id_produto ASC, data_hora DESC, id ASC) ;"
```

```
cqlsh -e "
  COPY infobarbank.lancamentos_por_produto (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"
```


### Tabela LANCAMENTOS_POR_TIPO                      

```
cqlsh -e "
  CREATE TABLE infobarbank.lancamentos_por_tipo(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), tipo_lancamento, data_hora, id)
  ) WITH CLUSTERING ORDER BY (tipo_lancamento ASC, data_hora DESC, id ASC);"
```

```
cqlsh -e "
  COPY infobarbank.lancamentos_por_tipo (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"
```

### Tabela LANCAMENTOS_DETALHE                       

```
cqlsh -e "
  CREATE TABLE infobarbank.lancamentos_detalhe(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY(id));"
```

```
cqlsh -e "
  COPY infobarbank.lancamentos_detalhe (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"
```
