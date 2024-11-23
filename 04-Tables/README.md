# Tabelas
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nesse laboratório vamos trabalhar com tabelas do Cassandra.

### CREATE TABLE
```
cqlsh -e "
CREATE TABLE ks001.cliente(
    id_cliente  text PRIMARY KEY, 
    cpf         text, 
    nome        text, 
    sobrenome   text, 
    email       text
);"

```

### DESCRIBE TABLE
```
cqlsh -e "DESCRIBE TABLE ks001.cliente;"

```

O output deve ser algo assim:
```
CREATE TABLE ks001.cliente (
    id_cliente text PRIMARY KEY,
    cpf text,
    email text,
    nome text,
    sobrenome text
) WITH additional_write_policy = '99p'
    AND allow_auto_snapshot = true
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND cdc = false
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '16', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND memtable = 'default'
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND extensions = {}
    AND gc_grace_seconds = 864000
    AND incremental_backups = true
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99p';

```

### INSERT
```
cqlsh -e "
INSERT INTO ks001.cliente(id_cliente, cpf, nome, sobrenome, email) 
VALUES ('1a1a1a1a', '11111111111', 'marcelo', 'barbosa', 'infobarbosa@gmail.com');"

cqlsh -e "
INSERT INTO ks001.cliente(id_cliente, cpf, nome, sobrenome, email) 
VALUES ('2b2b2b2b', '22222222222', 'juscelino', 'kubitschek', 'kubitschek@gmail.com');"

```

### SELECT
```
cqlsh -e "SELECT * FROM ks001.cliente;"

```

Output:
```

 id_cliente | cpf         | email                 | nome      | sobrenome
------------+-------------+-----------------------+-----------+------------
   1a1a1a1a | 11111111111 | infobarbosa@gmail.com |   marcelo |    barbosa
   2b2b2b2b | 22222222222 |  kubitschek@gmail.com | juscelino | kubitschek

```

##### Busca pela chave
```
cqlsh -e "
SELECT * 
FROM ks001.cliente 
WHERE id_cliente = '1a1a1a1a';"

```

Output:
```
 id_cliente | cpf         | email                 | nome    | sobrenome
------------+-------------+-----------------------+---------+-----------
   1a1a1a1a | 11111111111 | infobarbosa@gmail.com | marcelo |   barbosa
```

##### Busca por um campo não-chave
```
cqlsh -e "
SELECT * 
FROM ks001.cliente 
WHERE nome = 'marcelo';"

```

Output:
```
<stdin>:1:InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot execute this query as it might involve data filtering and thus may have unpredictable performance. If you want to execute this query despite the performance unpredictability, use ALLOW FILTERING"
```

### UPDATE
```
cqlsh -e "
UPDATE ks001.cliente 
SET sobrenome = 'almeida' 
WHERE id_cliente = '1a1a1a1a';"

```

Conferindo:
```
cqlsh -e "
SELECT * 
FROM ks001.cliente 
WHERE id_cliente = '1a1a1a1a';"

```

Output:
```
 id_cliente | cpf         | email                 | nome    | sobrenome
------------+-------------+-----------------------+---------+-----------
   1a1a1a1a | 11111111111 | infobarbosa@gmail.com | marcelo |   almeida
```

### DELETE
```
cqlsh -e "
DELETE FROM ks001.cliente 
WHERE id_cliente = '1a1a1a1a';"

```

Conferindo:
```
cqlsh -e "
SELECT * 
FROM ks001.cliente 
WHERE id_cliente = '1a1a1a1a';"

```

Output:
```
 id_cliente | cpf | email | nome | sobrenome
------------+-----+-------+------+-----------


(0 rows)
```


### JUNÇÕES

Como já é sabido, o Apache Cassandra não dá suporte a junções. <br>
Mas como se dá isso? Vamos criar outra tabela `pedido` e experimentar!

##### Criando a tabela `pedido`
```
cqlsh -e "
    CREATE TABLE ks001.pedido(
        id_pedido   int PRIMARY KEY, 
        id_cliente  text, 
        data        date, 
        valor       float,
        endereco    text,
        item        text
    );"

```

```
cqlsh -e "DESCRIBE TABLE ks001.pedido;"

```

Conferindo:
```
root@7bc306de4e1b:/# cqlsh -e "DESCRIBE TABLE ks001.pedido;"

CREATE TABLE ks001.pedido (
    id_pedido int PRIMARY KEY,
    data date,
    endereco text,
    id_cliente text,
    item text,
    valor float
) WITH additional_write_policy = '99p'
    AND allow_auto_snapshot = true
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND cdc = false
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '16', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND memtable = 'default'
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND extensions = {}
    AND gc_grace_seconds = 864000
    AND incremental_backups = true
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99p';
```

Inserindo um pedido de exemplo:
```
cqlsh -e "
INSERT INTO ks001.pedido(id_pedido, id_cliente, data, valor, endereco, item) 
VALUES (123, '2b2b2b2b', '2023-02-01', 30.00, 'Rua Cassandra, No.9042, Bairro NoSQL', 'Camiseta');"

```

```
cqlsh -e "select * from ks001.pedido;"

```

Output:
```
root@7bc306de4e1b:/# cqlsh -e "select * from ks001.pedido;"

 id_pedido | data       | endereco                             | id_cliente | item     | valor
-----------+------------+--------------------------------------+------------+----------+-------
       123 | 2023-02-01 | Rua Cassandra, No.9042, Bairro NoSQL |   2b2b2b2b | Camiseta |    30

(1 rows)
```

##### A junção
Agora queremos executar uma consulta que retorne o CPF do cliente e seus pedidos:
```
cqlsh -e "
SELECT cliente.cpf, pedido.id_pedido, pedido.data, pedido.item
FROM cliente JOIN pedido ON cliente.id_cliente = pedido.id_cliente
WHERE cliente.id_cliente = '2b2b2b2b';"

```

Output:
```
<stdin>:1:SyntaxException: line 2:13 no viable alternative at input 'JOIN' (....data, pedido.itemFROM [cliente] JOIN...)
```

### TRUNCATE TABLE
```
cqlsh -e "TRUNCATE TABLE ks001.cliente;"

```

Conferindo:
```
cqlsh -e "SELECT * FROM ks001.cliente;"

```

Output:
```
 id_cliente | cpf | email | nome | sobrenome
------------+-----+-------+------+-----------


(0 rows)

```

### DROP TABLE
```
cqlsh -e "DROP TABLE ks001.cliente;"

```

Conferindo:
```
cqlsh -e "DESCRIBE TABLE ks001.cliente;"

```

Output:
```
<stdin>:1:Table 'cliente' not found in keyspace 'ks001'
```


# Parabéns
Parabéns por concluir este laboratório! Você aprendeu diversas operações em tabelas no Apache Cassandra. <br>
Continue praticando para consolidar seus conhecimentos.
