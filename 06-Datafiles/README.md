# Observação de datafiles
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

### Objetivo
Observar como o cassandra gera sstables (data files) em disco.

### Método
A proposta agora é recriar a tabela e inserir, atualizar e deletar diversos registros.
A cada etapa vamos executar o comando `nodetool flush` e então observar como o Cassandra gerencia os arquivos (sstables) no sistema operacional.


Navegue para o diretório `/var/lib/cassandra/data`, local padrão de armazenamento de dados do Cassandra. 
```
cd /var/lib/cassandra/data
```

Liste os arquivos e subdiretórios presentes:
```
ls -la
```

Output:
```
voclabs:/var/lib/cassandra/data $ ls -la
total 36
drwxr-xr-x  9 cassandra cassandra 4096 Dec 10 19:05 .
drwxr-xr-x  7 cassandra cassandra 4096 Dec 10 18:37 ..
drwxr-xr-x 10 cassandra cassandra 4096 Dec 10 18:38 infobarbank
drwxr-xr-x  5 cassandra cassandra 4096 Dec 10 19:10 infobarbank2
drwxr-xr-x 26 cassandra cassandra 4096 Dec 10 18:37 system
drwxr-xr-x  7 cassandra cassandra 4096 Dec 10 18:37 system_auth
drwxr-xr-x  6 cassandra cassandra 4096 Dec 10 18:37 system_distributed
drwxr-xr-x 12 cassandra cassandra 4096 Dec 10 18:37 system_schema
drwxr-xr-x  4 cassandra cassandra 4096 Dec 10 18:37 system_traces
voclabs:/var/lib/cassandra/data $ 
```

### CREATE KEYSPACE
```
cqlsh -e "CREATE KEYSPACE infobarbank3
            WITH replication = {
                'class': 'SimpleStrategy',
                'replication_factor': 1};"
```

Listando:
```
ls -la
```
Perceba que o output não mudou, mesmo após termos executado o comando `create keyspace ...`.<br>

Agora vamos criar uma tabela **`cliente`**.
### `cqlsh` CREATE TABLE
```
cqlsh -e "CREATE TABLE infobarbank3.cliente(
            id text PRIMARY KEY,
            cpf text,
            nome text);"
```

### DESCRIBE TABLE
```
cqlsh -e "DESCRIBE TABLE infobarbank3.cliente;"
```

Output:
```
CREATE TABLE infobarbank3.cliente (
    id text PRIMARY KEY,
    cpf text,
    nome text
) WITH additional_write_policy = '99p'
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
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99p';
```

Se você obteve o output acima então a tabela foi criada corretamente.

Agora vamos voltar ao `bash` e verificar o que ocorreu em disco.
```
ls -la
```

Output:
```
voclabs:/var/lib/cassandra/data $ ls -la
total 40
drwxr-xr-x 10 cassandra cassandra 4096 Dec 10 19:13 .
drwxr-xr-x  7 cassandra cassandra 4096 Dec 10 18:37 ..
drwxr-xr-x 10 cassandra cassandra 4096 Dec 10 18:38 infobarbank
drwxr-xr-x  5 cassandra cassandra 4096 Dec 10 19:10 infobarbank2
drwxr-xr-x  3 cassandra cassandra 4096 Dec 10 19:16 infobarbank3
drwxr-xr-x 26 cassandra cassandra 4096 Dec 10 18:37 system
drwxr-xr-x  7 cassandra cassandra 4096 Dec 10 18:37 system_auth
drwxr-xr-x  6 cassandra cassandra 4096 Dec 10 18:37 system_distributed
drwxr-xr-x 12 cassandra cassandra 4096 Dec 10 18:37 system_schema
drwxr-xr-x  4 cassandra cassandra 4096 Dec 10 18:37 system_traces
voclabs:/var/lib/cassandra/data $ 
```

Perceba que o diretório da keyspace só foi criado em disco após criarmos efetivamente uma tabela.<br>
Vamos navegar para o diretório `/var/lib/cassandra/data/infobarbank3`:
```
cd /var/lib/cassandra/data/infobarbank3
```

Listando os subdiretórios
```
pwd
```

```
ls -la
```
Output:
```
voclabs:/var/lib/cassandra/data/infobarbank3 $ ls -altr
total 12
drwxr-xr-x 10 cassandra cassandra 4096 Dec 10 19:13 ..
drwxr-xr-x  3 cassandra cassandra 4096 Dec 10 19:16 .
drwxr-xr-x  3 cassandra cassandra 4096 Dec 10 19:16 cliente-ad825a30979011ee94d7cf8dd19884e8
voclabs:/var/lib/cassandra/data/infobarbank3 $ 
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

Output:
```
voclabs:/var/lib/cassandra/data/infobarbank3/cliente-ad825a30979011ee94d7cf8dd19884e8 $ ls -latr
total 12
drwxr-xr-x 3 cassandra cassandra 4096 Dec 10 19:16 ..
drwxr-xr-x 2 cassandra cassandra 4096 Dec 10 19:16 backups
drwxr-xr-x 3 cassandra cassandra 4096 Dec 10 19:16 .
voclabs:/var/lib/cassandra/data/infobarbank3/cliente-ad825a30979011ee94d7cf8dd19884e8 $ 
```

Veja que não existem objetos além de uma pasta de backup.<br>
Agora vamos executar um primeiro lote de inserções na tabela.

### `cqlsh` INSERT
Inserindo primeiro lote de registros
```
cqlsh -e "
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b162060', '***.568.112-**', 'MARIVALDA KANAMARY');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b16242a', '***.150.512-**', 'JUCILENE MOREIRA CRUZ');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b16256a', '***.615.942-**', 'GRACIMAR BRASIL GUERRA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b16353c', '***.264.482-**', 'ALDENORA VIANA MOREIRA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b1636ae', '***.434.715-**', 'VERA LUCIA RODRIGUES SENA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b16396a', '***.777.135-**', 'IVONE GLAUCIA VIANA DUTRA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b163bcc', '***.881.955-**', 'LUCILIA ROSA LIMA PEREIRA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b163cda', '***.580.583-**', 'FRANCISCA SANDRA FEITOSA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b163dde', '***.655.193-**', 'BRUNA DE BRITO PAIVA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES('2b163ed8', '***.708.013-**', 'LUCILENE PAULO BARBOSA');"

```

```
cqlsh -e "SELECT COUNT(1) 
          FROM infobarbank3.cliente;"

```

```
ls -la
```

Provavelmente não houve alteração na disposição dos arquivos.
Agora vamos forçar o flush da **memtable** para o disco:
```
nodetool flush

```

Após a execução de `nodetool flush`, uma nova listagem de arquivos (`ls -la`) terá um output como:
```
voclabs:/var/lib/cassandra/data/infobarbank3/cliente-ad825a30979011ee94d7cf8dd19884e8 $ ls -la
total 48
drwxr-xr-x 3 cassandra cassandra 4096 Dec 10 19:23 .
drwxr-xr-x 3 cassandra cassandra 4096 Dec 10 19:16 ..
drwxr-xr-x 2 cassandra cassandra 4096 Dec 10 19:16 backups
-rw-r--r-- 1 cassandra cassandra   47 Dec 10 19:23 nb-1-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  483 Dec 10 19:23 nb-1-big-Data.db
-rw-r--r-- 1 cassandra cassandra   10 Dec 10 19:23 nb-1-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   24 Dec 10 19:23 nb-1-big-Filter.db
-rw-r--r-- 1 cassandra cassandra  128 Dec 10 19:23 nb-1-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4790 Dec 10 19:23 nb-1-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Dec 10 19:23 nb-1-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Dec 10 19:23 nb-1-big-TOC.txt
voclabs:/var/lib/cassandra/data/infobarbank3/cliente-ad825a30979011ee94d7cf8dd19884e8 $ 
```

Perceba que vários arquivos de dados foram criados. A importância de cada um será explicada em sala de aula.

Por ora vamos examinar o arquivo `nb-1-big-Data.db`:
```
cat nb-1-big-Data.db
```

O output será parecido com isso:
```
voclabs:/var/lib/cassandra/data/infobarbank3/cliente-ad825a30979011ee94d7cf8dd19884e8 $ cat nb-1-big-Data.db
2b163cda$-***.580.583-*FRANCISCA SANDRA FEITOSAF9ed8FR,Ca708.01GLUCILENE PAULO BARBE9ddeEB)a655.19DBRUNA DE BRITO PAIV9bccBB.vBp881.955IA ROSA LIMA PEREIRG*6aB.Gb434.71GPVERA LJDRIGUES SENG:242[3*[p150.512$J!MOS CRUZX:256CB+9a615.94CGRACIMAR BRASIL GUER*53B+$Db264.48DLDENORA VIANA9060Y2&CR568.1MARIVALDA KANAMARY?+39B.%@b777.13QIVONE GLAT`DUTRA.Lvoclabs:/var/lib/cassandra/data/infobarbank3/cliente-ad825a30979011ee94d7cf8dd19884e8 $ 
voclabs:/var/lib/cassandra/data/infobarbank3/cliente-ad825a30979011ee94d7cf8dd19884e8 $ 

```
