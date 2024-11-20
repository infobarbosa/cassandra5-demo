# Tabelas
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nesse laboratório vamos trabalhar com tabelas do Cassandra.

### CREATE TABLE
```
cqlsh -e "
CREATE TABLE ks001.cliente(
    id text PRIMARY KEY, 
    cpf text, 
    nome text
);"

```

### DESCRIBE TABLE
```
cqlsh -e "DESCRIBE TABLE ks001.cliente;"

```

O output deve ser algo assim:
```
CREATE TABLE ks001.cliente (
    id text PRIMARY KEY,
    cpf text,
    nome text
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
INSERT INTO ks001.cliente(id, cpf, nome) 
VALUES ('6ad8b386', '11111111111', 'marcelo barbosa');"

```

### SELECT
```
cqlsh -e "SELECT * FROM ks001.cliente;"

```

Output:
```
root@d3cb569bd839:/# cqlsh -e "SELECT * FROM ks001.cliente;"

 id       | cpf         | nome
----------+-------------+-----------------
 6ad8b386 | 11111111111 | marcelo barbosa

(1 rows)
```

##### Busca pela chave
```
cqlsh -e "
SELECT * 
FROM ks001.cliente 
WHERE id = '6ad8b386';"

```
Output:
```
root@d3cb569bd839:/# cqlsh -e "
> SELECT * 
> FROM ks001.cliente 
> WHERE id = '6ad8b386';"

 id       | cpf         | nome
----------+-------------+-----------------
 6ad8b386 | 11111111111 | marcelo barbosa

(1 rows)
```

##### Busca por um campo não-chave
```
cqlsh -e "
SELECT * 
FROM ks001.cliente 
WHERE nome = 'marcelo barbosa';"

```

Output:
```
<stdin>:1:InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot execute this query as it might involve data filtering and thus may have unpredictable performance. If you want to execute this query despite the performance unpredictability, use ALLOW FILTERING"
```

### UPDATE
```
cqlsh -e "
UPDATE ks001.cliente 
SET nome = 'marcelo b.' 
WHERE id = '6ad8b386';"

```

Conferindo:
```
cqlsh -e "
SELECT * 
FROM ks001.cliente 
WHERE id = '6ad8b386';"

```

Output:
```
root@d3cb569bd839:/# cqlsh -e "
> SELECT * 
> FROM ks001.cliente 
> WHERE id = '6ad8b386';"

 id       | cpf         | nome
----------+-------------+------------
 6ad8b386 | 11111111111 | marcelo b.

(1 rows)
```

### DELETE
```
cqlsh -e "
DELETE FROM ks001.cliente 
WHERE id = '6ad8b386';"

```

Conferindo:
```
cqlsh -e "
SELECT * 
FROM ks001.cliente 
WHERE id = '6ad8b386';"

```

Output:
```
root@d3cb569bd839:/# cqlsh -e "
> SELECT * 
> FROM ks001.cliente 
> WHERE id = '6ad8b386';"

 id | cpf | nome
----+-----+------
```

### TRUNCATE TABLE
```
cqlsh -e "TRUNCATE TABLE ks001.cliente;"

```


### JUNÇÕES

Como já é sabido, o Apache Cassandra não dá suporte a junções. <br>
Mas como se dá isso? Vamos criar outra tabela `pedido` e experimentar!

##### Criando a tabela `pedido`
```
cqlsh -e "
    CREATE TABLE ks001.pedido(
        id          int PRIMARY KEY, 
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

Inserindo um pedido de exemplo:
```
cqlsh -e "
    INSERT INTO ks001.pedido(id, id_cliente, data, valor, endereco, item) 
    VALUES (123, '6ad8b386', '2023-02-01', 30.00, 'Rua Cassandra, No.9042, Bairro NoSQL', 'Camiseta');"
```

```
cqlsh -e "select * from ks001.pedido;"

```

Output:
```

```

##### A junção
Agora queremos executar uma consulta que retorne o CPF do cliente e seus pedidos:
```
cqlsh -e "
    SELECT cliente.cpf, pedido.id, pedido.data, pedido.item
    FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente
    WHERE cliente.id = 10;"

```

Output:
```


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