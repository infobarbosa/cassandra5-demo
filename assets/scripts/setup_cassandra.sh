#!/bin/sh
echo "`date -Is` - Instalação iniciada." >> /tmp/status-instalacao.txt

#########################################################
# Cassandra
#########################################################

echo "`date -Is` - Instalando Java 11." >> /tmp/status-instalacao.txt
sudo apt install -y openjdk-11-jdk-headless

echo "deb https://debian.cassandra.apache.org 41x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

echo "`date -Is` - Obtento chaves do repositório." >> /tmp/status-instalacao.txt
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -

echo "`date -Is` - Atualizando a lista de pacotes." >> /tmp/status-instalacao.txt
sudo apt-get update -y

echo "`date -Is` - Instalando o Cassandra." >> /tmp/status-instalacao.txt
sudo apt install -y cassandra

echo "`date -Is` - Inicializando serviço." >> /tmp/status-instalacao.txt
sudo systemctl start cassandra

#########################################################
# Esperando o cluster ficar up antes de prosseguir
#########################################################
echo "`date -Is` - Inicializando node. Aguarde..." >> /tmp/status-instalacao.txt
while ! cqlsh -e 'describe cluster' > /dev/null 2>&1; do sleep 5; done

echo "`date -Is` - Node inicializado. Criando schema." >> /tmp/status-instalacao.txt

#########################################################
# Keyspace infobarbank
#########################################################
cqlsh -e "
  CREATE KEYSPACE infobarbank 
  WITH replication = {
      'class': 'SimpleStrategy', 
      'replication_factor': 1};"

################################################################
#               CONTA_CORRENTE                               
#########################################################
cqlsh -e "
  CREATE TABLE infobarbank.conta_corrente(
    num_conta           TEXT,
    apelido_cliente     TEXT,
    data_ultimo_acesso  DATE,
    saldo_disponivel    FLOAT,
    PRIMARY KEY(num_conta));"

cqlsh -e "
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b162060', 'MARIVALDA', '2022-09-01', 100.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16242a', 'JUCILENE' , '2022-08-01', 500.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16256a', 'GRACIMAR' , '2022-09-04', 30.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16353c', 'ALDENORA' , '2022-09-03', 1500.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b1636ae', 'VERA'     , '2022-09-02', 70.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16396a', 'IVONE'    , '2022-08-30', 400.00);
  INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b163bcc', 'LUCILIA'  , '2022-08-31', 350.00);"

#########################################################
#               CARTAO_CREDITO                          
#########################################################

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

cqlsh -e "
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '007c2c1c', '5450 3799 9172 8454', '423', '2030-02-21', 1000.00, 900.00);
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '897199aa', '5576 8924 9861 7490', '336', '2030-07-21', 200.00 , 50.00);
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '9a748c3c', '5188 2716 2053 8850', '920', '2024-03-21', 500.00 , 100.00);
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b16242a', 'ATIVO', 'a2fab366', '5590 5738 5562 1778', '198', '2024-03-21', 5000.00, 4000.00);
  INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b16256a', 'ATIVO', 'cd586ffb', '5412 2646 1222 3738', '273', '2030-02-21', 3000.00, 1500.00);"

#########################################################
#               LANCAMENTOS_CARTAO_CREDITO                  
#########################################################

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


cqlsh -e "
  COPY infobarbank.lancamentos_cartao_credito (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"

#########################################################
#               LANCAMENTOS_POR_STATUS                      
#########################################################

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

cqlsh -e "
  COPY infobarbank.lancamentos_por_status (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"

#########################################################
#               LANCAMENTOS_POR_PERIODO                      
#########################################################

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

cqlsh -e "
  COPY infobarbank.lancamentos_por_periodo (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"

#########################################################
#               LANCAMENTOS_POR_PRODUTO                      
#########################################################
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

cqlsh -e "
  COPY infobarbank.lancamentos_por_produto (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"

#########################################################
#               LANCAMENTOS_POR_TIPO                      
#########################################################
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

cqlsh -e "
  COPY infobarbank.lancamentos_por_tipo (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"

#########################################################
#               LANCAMENTOS_DETALHE                       */
#########################################################
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

cqlsh -e "
  COPY infobarbank.lancamentos_detalhe (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './dataset/lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;"

#########################################################
# Finalizando a instalação
#########################################################
echo "`date -Is` - Instalação finalizada." >> /tmp/status-instalacao.txt