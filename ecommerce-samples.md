## 1. Tabela `pedidos`
- Inserir dados
```
INSERT INTO ecommerce.pedidos (id_pedido, data_criacao, id_cliente, produto, quantidade, uf, valor_unitario) 
VALUES ('PED-1001', '2026-05-27 15:30:00', 987654321, 'Smartphone XYZ', 1, 'SP', 1500.00);

```

- Buscar um pedido específico (Eficiente - Direto no nó responsável)
```
SELECT * FROM ecommerce.pedidos 
WHERE id_pedido = 'PED-1001';

```

## Tabela `pedidos_por_cliente`
- Inserir dados
```
INSERT INTO ecommerce.pedidos_por_cliente (id_cliente, id_pedido, data_criacao, produto, quantidade, uf, valor_unitario)
VALUES (987654321, 'PED-1001', '2026-05-27 15:30:00', 'Smartphone XYZ', 1, 'SP', 1500.00);

INSERT INTO ecommerce.pedidos_por_cliente (id_cliente, id_pedido, data_criacao, produto, quantidade, uf, valor_unitario)
VALUES (987654321, 'PED-1002', '2026-05-26 15:30:00', 'Notebook ABC', 1, 'SP', 3000.00);

```


- Buscar todos os pedidos de um cliente
```
SELECT * FROM ecommerce.pedidos_por_cliente 
WHERE id_cliente = 987654321;

```

- Buscar um pedido específico de um cliente
```
SELECT * FROM ecommerce.pedidos_por_cliente 
WHERE id_cliente = 987654321 AND id_pedido = 'PED-1001';

```

- Buscar um pedido específico sem especificar o cliente
```
SELECT * FROM ecommerce.pedidos_por_cliente 
WHERE id_pedido = 'PED-1001';

```

## Tabela `pedidos_por_data`
- Inserir dados
```
INSERT INTO ecommerce.pedidos_por_data (data_pedido, id_pedido, data_criacao, id_cliente, produto, quantidade, uf, valor_unitario)
VALUES ('2026-05-27', 'PED-1001', '2026-05-27 15:30:00', 987654321, 'Smartphone XYZ', 1, 'SP', 1500.00);

INSERT INTO ecommerce.pedidos_por_data (data_pedido, id_pedido, data_criacao, id_cliente, produto, quantidade, uf, valor_unitario)
VALUES ('2026-05-26', 'PED-1002', '2026-05-26 15:30:00', 987654321, 'Notebook ABC', 1, 'SP', 3000.00);

```

- Buscar todos os pedidos de uma data específica
```
SELECT * FROM ecommerce.pedidos_por_data 
WHERE data_pedido = '2026-05-27';

```

```
SELECT * FROM ecommerce.pedidos_por_data 
WHERE data_pedido IN ( '2026-05-27', '2026-05-26');

```

```
SELECT * FROM ecommerce.pedidos_por_data 
WHERE data_pedido BETWEEN '2026-05-26' AND '2026-05-27';

```

## Tabela `pedidos_por_produto`

- Inserir dados
```
INSERT INTO ecommerce.pedidos_por_produto (produto, data_pedido, id_pedido, data_criacao, id_cliente, quantidade, uf, valor_unitario)
VALUES ('Smartphone XYZ', '2026-05-27', 'PED-1001', '2026-05-27 15:30:00', 987654321, 1, 'SP', 1500.00);

INSERT INTO ecommerce.pedidos_por_produto (produto, data_pedido, id_pedido, data_criacao, id_cliente, quantidade, uf, valor_unitario)
VALUES ('Notebook ABC', '2026-05-26', 'PED-1002', '2026-05-26 15:30:00', 987654321, 1, 'SP', 3000.00);

```

- Buscar vendas do produto 'Smartphone XYZ' no dia 27/05/2026
```
SELECT * FROM ecommerce.pedidos_por_produto 
WHERE produto = 'Smartphone XYZ' AND data_pedido = '2026-05-27';

```

## Tabela `pedidos_por_uf`

- Inserir dados
```
INSERT INTO ecommerce.pedidos_por_uf (uf, data_pedido, id_pedido, data_criacao, id_cliente, produto, quantidade, valor_unitario)
VALUES ('SP', '2026-05-27', 'PED-1001', '2026-05-27 15:30:00', 987654321, 'Smartphone XYZ', 1, 1500.00);

INSERT INTO ecommerce.pedidos_por_uf (uf, data_pedido, id_pedido, data_criacao, id_cliente, produto, quantidade, valor_unitario)
VALUES ('SP', '2026-05-26', 'PED-1002', '2026-05-26 15:30:00', 987654321, 'Notebook ABC', 1, 3000.00);

```
- Buscar todas as vendas do estado de SP no dia 27/05/2026
```
SELECT * FROM ecommerce.pedidos_por_uf 
WHERE uf = 'SP' AND data_pedido = '2026-05-27';

```
