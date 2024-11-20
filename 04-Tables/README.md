# Operações de tabelas
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nesse laboratório vamos trabalhar com tabelas do Cassandra.

### CREATE TABLE
```
cqlsh -e "
    CREATE TABLE ks001.cliente(
        id uuid PRIMARY KEY, 
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
    id uuid PRIMARY KEY,
    cpf text,
    nome text
) WITH additional_write_policy = '99p'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND cdc = false
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '16', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND extensions = {}
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99p';
```

### INSERT
```
cqlsh -e "
    INSERT INTO ks001.cliente(
        id, 
        cpf, 
        nome
    ) 
    VALUES (
        6ad8b386-1015-11ed-861d-0242ac120002, 
        '11111111111', 
        'marcelo barbosa'
    );"
```

### SELECT
```
cqlsh -e "
    SELECT * 
    FROM ks001.cliente;"
```

##### Busca pela chave
```
cqlsh -e "
    SELECT * 
    FROM ks001.cliente 
    WHERE id = 6ad8b386-1015-11ed-861d-0242ac120002;"
```
Output:
```
 id                                   | cpf         | nome
--------------------------------------+-------------+-----------------
 6ad8b386-1015-11ed-861d-0242ac120002 | 11111111111 | marcelo barbosa
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
InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot execute this query as it might involve data filtering and thus may have unpredictable performance. If you want to execute this query despite the performance unpredictability, use ALLOW FILTERING"
```

### UPDATE
```
cqlsh -e "
    UPDATE ks001.cliente 
    SET nome = 'marcelo b.' 
    WHERE id = 6ad8b386-1015-11ed-861d-0242ac120002;"
```

Conferindo:
```
cqlsh -e "
    SELECT * 
    FROM ks001.cliente 
    WHERE id = 6ad8b386-1015-11ed-861d-0242ac120002;"
```

### DELETE
```
cqlsh -e "
    DELETE FROM ks001.cliente 
    WHERE id = 6ad8b386-1015-11ed-861d-0242ac120002;"
```

### TRUNCATE TABLE
```
cqlsh -e "TRUNCATE TABLE ks001.cliente;"
```

### DROP TABLE
```
cqlsh -e "DROP TABLE ks001.cliente;"
```


### JUNÇÕES

Vamos recriar a tabela `cliente` e adicionalmente criar outra tabela `pedido`.

##### Criando a tabela `cliente`
```
cqlsh -e "
    CREATE TABLE ks001.cliente(
        id int PRIMARY KEY, 
        cpf text, 
        nome text
    );"
```

```
cqlsh -e "DESCRIBE TABLE ks001.cliente;"
```

Criando um cliente
```
cqlsh -e "
    INSERT INTO ks001.cliente(id, cpf, nome) 
    VALUES (10, '11111111111', 'marcelo barbosa');"
```

```
cqlsh -e "select * from ks001.cliente;"
```

Output:
```
cqlsh> select * from ks001.cliente ;

 id | cpf         | nome
----+-------------+-----------------
 10 | 11111111111 | marcelo barbosa
```

##### Criando a tabela `pedido`
```
cqlsh -e "
    CREATE TABLE ks001.pedido(
        id          int PRIMARY KEY, 
        id_cliente  int, 
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
    VALUES (123, 10, '2023-02-01', 30.00, 'Rua Cassandra, No.9042, Bairro NoSQL', 'Camiseta');"
```

```
cqlsh -e "select * from ks001.pedido;"
```

Output:
```
cqlsh> select * from ks001.pedido ;

 id  | data       | endereco                             | id_cliente | item     | valor
-----+------------+--------------------------------------+------------+----------+-------
 123 | 2023-02-01 | Rua Cassandra, No.9042, Bairro NoSQL |         10 | Camiseta |    30

(1 rows)
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
cqlsh> SELECT cliente.cpf, pedido.id, pedido.data, pedido.item FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente WHERE cliente.id = 10;
SyntaxException: line 1:69 no viable alternative at input 'JOIN' (....data, pedido.item FROM [cliente] JOIN...)
```
