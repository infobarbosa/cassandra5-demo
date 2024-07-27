# Compaction
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

A proposta agora é criar a tabela `cliente` e executar diversas operações de escrita de registros.
Desta vez, porém, a cada etapa vamos executar o comando `nodetool flush` e então observar o que acontece com os arquivos (sstables).

De início, vamos navegar para o diretório `/var/lib/cassandra/data`
```
cd /var/lib/cassandra/data/
```

## 1o. Ciclo

Criando a keyspace `infobarbank4`:
```
cqlsh --execute "CREATE KEYSPACE infobarbank4 
                    WITH replication = {
                        'class': 'SimpleStrategy', 
                        'replication_factor': 1};"
```

Criando a tabela `cliente`
```
cqlsh --execute "CREATE TABLE infobarbank4.cliente(
                    id text PRIMARY KEY, 
                    cpf text, 
                    nome text, 
                    sobrenome text, 
                    email text);"
```

Inserindo um registro:
```
cqlsh --execute "INSERT INTO infobarbank4.cliente(id, cpf) 
                VALUES ('1', '999999999-99');"
```

Conferindo o resultado:
```
cqlsh --execute "select * from infobarbank4.cliente where id = '1';"
```


Verifique os arquivos existentes:
```
cd /var/lib/cassandra/data/infobarbank4
```

```
ls -latr
```

**ATENÇÃO!** <br>
> Perceba que foi criado um diretório com o nome da tabela (cliente) concatenado com um UUID aleatório.
Vamos verificar os objetos dentro desse diretório:

```
cd $(eval ls)
```

```
pwd
```

```
ls -latr
```

Execute `nodetool flush`:
```
nodetool flush
```

```
ls -la
```

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```
cat nb-1-big-Data.db
```

## 2o. Ciclo

Atualizando uma coluna da tabela:
```
cqlsh --execute "update infobarbank4.cliente set nome = 'marcelo' where id = '1';"
```

Conferindo o resultado:
```
cqlsh --execute "select * from infobarbank4.cliente where id = '1';"
```

Inspecione novamente o conteúdo da sstable `nb-1-big-Data.db`:
```
cat nb-1-big-Data.db
```

```
ls -latr
```

Perceba que `nb-1-big-Data.db` não tem o nome *marcelo* e ao mesmo tempo não houve modificação dos demais arquivos.

```
nodetool flush
```

```
ls -la
```

Uma nova sstable `nb-2-big-Data.db` foi gerada. Vamos inspecioná-la:
```
cat nb-2-big-Data.db
```

Apenas o atributo nome com valor *marcelo* foi encontrado.

## 3o. Ciclo

Atualizando uma coluna da tabela:
```
cqlsh --execute "update infobarbank4.cliente set sobrenome = 'barbosa' where id = '1';"
```

```
cqlsh --execute "select * from infobarbank4.cliente where id = '1';"
```

```
ls -latr
```

```
nodetool flush
```

```
ls -la
```

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```
cat nb-3-big-Data.db
```

## 4o. Ciclo

Atualizando uma coluna da tabela:
```
cqlsh --execute "update infobarbank4.cliente 
                    set email = 'marcelo@infobarbosa.com.br' 
                  where id = '1';"
```

```
cqlsh --execute "select * 
                   from infobarbank4.cliente 
                  where id = '1';"
```

```
ls -latr
```

```
nodetool flush
```

```
ls -latr
```

Perceba que sumiram as sstables anteriores e uma nova surgiu.<br>
Inspecione o conteúdo da sstable gerada `nb-5-big-Data.db`:
```
cat nb-5-big-Data.db
```


## 5o. Ciclo

Inserindo um novo registro:
```
cqlsh --execute "insert into infobarbank4.cliente(id, cpf) values ('MINHA_CHAVE', '888888888-88');"

cqlsh --execute "select * from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```

```
ls -latr
```

```
nodetool flush
```

```
ls -latr
```

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```
cat nb-6-big-Data.db
```

## 6o. Ciclo

Atualizando uma coluna da tabela:
```
cqlsh --execute "update infobarbank4.cliente set nome = 'PEDRO' where id = 'MINHA_CHAVE';"

cqlsh --execute "select * from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```

```
ls -latr
```

```
nodetool flush
```

```
ls -latr
```

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```
cat nb-7-big-Data.db
```

## 7o. Ciclo

Atualizando uma coluna da tabela:
```
cqlsh --execute "update infobarbank4.cliente 
                    set sobrenome = 'ALCÂNTARA FRANCISCO ANTÔNIO JOÃO CARLOS XAVIER DE PAULA MIGUEL RAFAEL JOAQUIM JOSÉ GONZAGA PASCOAL CIPRIANO SERAFIM DE BRAGANÇA E BOURBON' 
                  where id = 'MINHA_CHAVE';"

cqlsh --execute "select * from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```

```
ls -latr
```

```
nodetool flush
```

```
ls -latr
```

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```
cat nb-9-big-Data.db
```

## 8o. Ciclo

Atualizando uma coluna da tabela:
```
cqlsh --execute \
"delete from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```

```
cqlsh --execute \
"delete from infobarbank4.cliente where id = 'UMA_CHAVE_QUE_NUNCA_INSERI';"
```

```
cqlsh --execute \
"select * from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```

```
ls -latr
```

```
nodetool flush
```

```
ls -latr
```

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```
cat nb-10-big-Data.db
```
