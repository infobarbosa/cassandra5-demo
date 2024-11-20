# Tabelas
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nesse laboratório vamos trabalhar com tabelas do Cassandra.

### CREATE TABLE
```
cqlsh -e "
CREATE TABLE ks001.cliente(
    id_cliente text PRIMARY KEY, 
    cpf        text, 
    nome       text
);"

```

### DESCRIBE TABLE
```
cqlsh -e "DESCRIBE TABLE ks001.cliente;"

```

O output deve ser algo assim:
```

```

### INSERT
```
cqlsh -e "
INSERT INTO ks001.cliente(id_cliente, cpf, nome) 
VALUES ('1a1a1a1a', '11111111111', 'marcelo barbosa');"

cqlsh -e "
INSERT INTO ks001.cliente(id_cliente, cpf, nome) 
VALUES ('2b2b2b2b', '22222222222', 'juscelino kubitschek');"

```

### SELECT
```
cqlsh -e "SELECT * FROM ks001.cliente;"

```

Output:
```

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


```

### TRUNCATE TABLE
```
cqlsh -e "TRUNCATE TABLE ks001.cliente;"

```

Conferindo:
```
cqlsh -e "SELECT * FROM ks001.cliente;"

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
