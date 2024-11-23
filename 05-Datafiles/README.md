# Observação de datafiles
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

### Objetivo
Observar como o cassandra gera sstables (data files) em disco.

### Método
Vamos inserir, atualizar e deletar diversos registros na nossa tabela `cliente`. A cada etapa vamos executar o comando `nodetool flush` e então observar como o Cassandra gerencia os arquivos (sstables) no sistema operacional.

# Preparação
### Instalação do `hexdump`
```
apt update -y
apt upgrade -y
apt install -y bsdmainutils

```

### Tabela CLIENTE
Como eliminamos a tabela **cliente** na sessão anterior, vamos recriá-la.

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

### Definindo CLIENTE_DATAFILE_PATH

Por padrão os arquivos de dados do Cassandra são armazenados no diretório `/var/lib/cassandra/data/[O_NOME_DA_SUA_KEYSPACE/O_NOME_DA_SUA_TABELA-UUID_ALEATORIO]`.<br>
**Exemplo**:<br>

Perceba a seguir que o nome da nossa keyspace é `ks001` e o nome da tabela cliente em disco é `cliente-21c85180a8c311ef9eb4e1214b43e8c0`.
```
root@eb9cddba09cb:/# ls -la /var/lib/cassandra/data/ks001/cliente-21c85180a8c311ef9eb4e1214b43e8c0/
total 44
drwxr-xr-x 2 cassandra cassandra 4096 Nov 22 11:19 .
drwxr-xr-x 3 cassandra cassandra 4096 Nov 22 11:15 ..
-rw-r--r-- 1 cassandra cassandra   47 Nov 22 11:19 nb-1-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra   99 Nov 22 11:19 nb-1-big-Data.db
-rw-r--r-- 1 cassandra cassandra   10 Nov 22 11:19 nb-1-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   16 Nov 22 11:19 nb-1-big-Filter.db
-rw-r--r-- 1 cassandra cassandra   24 Nov 22 11:19 nb-1-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4840 Nov 22 11:19 nb-1-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Nov 22 11:19 nb-1-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Nov 22 11:19 nb-1-big-TOC.txt
root@eb9cddba09cb:/#
```

Por ser aleatório o UUID de `cliente-21c85180a8c311ef9eb4e1214b43e8c0` varia a cada vez que inicializamos um novo ambiente de laboratório.<br>
Para fluidez do labotarório vamos armazenar o caminho em uma variável de ambiente `CLIENTE_DATAFILE_PATH`.<br>
Execute o seguinte comando no terminal:

```
CLIENTE_DATAFILE_PATH=$(eval ls -rtd /var/lib/cassandra/data/ks001/cliente* | tail -n 1)

echo $CLIENTE_DATAFILE_PATH

```

---

# Ciclo 1

### `cqlsh` INSERT 1

1. Inserindo primeiro lote de registros
```
cqlsh -e "
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b162060', '01010101011', 'MARIVALDA', 'KANAMARY');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b16242a', '02020202022', 'JUCILENE', 'MOREIRA CRUZ');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b16256a', '03030303033', 'GRACIMAR', 'BRASIL GUERRA');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b16353c', '04040404044', 'ALDENORA', 'VIANA MOREIRA');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b1636ae', '05050505055', 'VERA', 'LUCIA RODRIGUES SENA');"

```

2. Checando a tabela:
```
cqlsh -e "SELECT * FROM ks001.cliente;"

```

```
cqlsh -e "SELECT COUNT(1) FROM ks001.cliente;"

```

3. Datafiles
```
ls -la $CLIENTE_DATAFILE_PATH

```

Provavelmente não houve alteração na disposição dos arquivos.

4. Commit logs

```
ls -la /var/lib/cassandra/commitlog

```

```
hexdump -C /var/lib/cassandra/commitlog/[O_COMMITLOG_MAIS_RECENTE] | more

```

5. Nodetool flush
Agora vamos forçar o flush da **memtable** para o disco:
```
nodetool flush

```

Após a execução de `nodetool flush`, uma nova listagem de arquivos (`ls -la`):
```
ls -la $CLIENTE_DATAFILE_PATH

```


Output:
```
root@8cc6dce87878:/# ls -la $CLIENTE_DATAFILE_PATH
total 44
drwxr-xr-x 2 cassandra cassandra 4096 Nov 23 13:52 .
drwxr-xr-x 5 cassandra cassandra 4096 Nov 23 13:42 ..
-rw-r--r-- 1 cassandra cassandra   47 Nov 23 13:52 nb-1-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  255 Nov 23 13:52 nb-1-big-Data.db
-rw-r--r-- 1 cassandra cassandra   10 Nov 23 13:52 nb-1-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   24 Nov 23 13:52 nb-1-big-Filter.db
-rw-r--r-- 1 cassandra cassandra   63 Nov 23 13:52 nb-1-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4852 Nov 23 13:52 nb-1-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Nov 23 13:52 nb-1-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Nov 23 13:52 nb-1-big-TOC.txt
```

Perceba que vários arquivos de dados foram criados. A importância de cada um será explicada em sala de aula.

6. Inspecionando `nb-1-big-Data.db`:
```
hexdump -C $CLIENTE_DATAFILE_PATH/nb-1-big-Data.db

```

Output:
```
root@8cc6dce87878:/# hexdump -C $CLIENTE_DATAFILE_PATH/nb-1-big-Data.db
00000000  4d 01 00 00 f2 01 00 08  32 62 31 36 33 36 61 65  |M.......2b1636ae|
00000010  7f ff ff ff 80 00 01 00  b4 24 2d 16 e1 a1 c4 5e  |.........$-....^|
00000020  08 0b 30 35 02 00 f2 0e  35 08 19 56 45 52 41 20  |..05....5..VERA |
00000030  4c 55 43 49 41 20 52 4f  44 52 49 47 55 45 53 20  |LUCIA RODRIGUES |
00000040  53 45 4e 41 01 46 00 49  32 34 32 61 46 00 a4 29  |SENA.F.I242aF..)|
00000050  16 e1 a1 95 bf 08 0b 30  32 02 00 f4 09 32 08 15  |.......02....2..|
00000060  4a 55 43 49 4c 45 4e 45  20 4d 4f 52 45 49 52 41  |JUCILENE MOREIRA|
00000070  20 43 52 55 5a 42 00 2a  35 36 42 00 a4 2a 16 e1  | CRUZB.*56B..*..|
00000080  a1 ad f7 08 0b 30 33 02  00 f4 09 33 08 16 47 52  |.....03....3..GR|
00000090  41 43 49 4d 41 52 20 42  52 41 53 49 4c 20 47 55  |ACIMAR BRASIL GU|
000000a0  45 52 52 85 00 49 33 35  33 63 85 00 00 43 00 64  |ERR..I353c...C.d|
000000b0  b9 74 08 0b 30 34 02 00  f4 02 34 08 16 41 4c 44  |.t..04....4..ALD|
000000c0  45 4e 4f 52 41 20 56 49  41 4e 41 8b 00 04 86 00  |ENORA VIANA.....|
000000d0  39 30 36 30 43 00 a4 26  16 e1 a1 87 52 08 0b 30  |9060C..&....R..0|
000000e0  31 02 00 f0 07 31 08 12  4d 41 52 49 56 41 4c 44  |1....1..MARIVALD|
000000f0  41 20 4b 41 4e 41 4d 41  52 59 01 46 e2 ce f2     |A KANAMARY.F...|
```

```
cat $CLIENTE_DATAFILE_PATH/nb-1-big-Data.db

```

---

# Ciclo 2

### `cqlsh` INSERT 2

1. Inserindo primeiro lote de registros
```
cqlsh -e "
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b16396a', '06060606066', 'IVONE', 'GLAUCIA VIANA DUTRA');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b163bcc', '07070707077', 'LUCILIA', 'ROSA LIMA PEREIRA');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b163cda', '08080808088', 'FRANCISCA', 'SANDRA FEITOSA');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b163dde', '09090909099', 'BRUNA', 'DE BRITO PAIVA');
insert into ks001.cliente(id_cliente, cpf, nome, sobrenome) VALUES('2b163ed8', '12312312312', 'LUCILENE', 'PAULO BARBOSA');"

```

Checando:
```
cqlsh -e "SELECT * FROM ks001.cliente;"

```

```
cqlsh -e "SELECT COUNT(1) FROM ks001.cliente;"

```

2. datafiles

```
hexdump -C $CLIENTE_DATAFILE_PATH/nb-1-big-Data.db

```

Perceba que o conteúdo do arquivo não foi alterado.<br>
Vamos verificar então se há novos arquivos de dados.
```
ls -la $CLIENTE_DATAFILE_PATH

```



3. Commit logs
```
ls -la /var/lib/cassandra/commitlog

```

```
grep --text IVONE /var/lib/cassandra/commitlog/[O_COMMITLOG_MAIS_RECENTE]

```

```
hexdump -C /var/lib/cassandra/commitlog/[O_COMMITLOG_MAIS_RECENTE] | grep IVONE
```

4. nodetool flush
Vamos fazer um novo flush
```
nodetool flush

```

Após a execução de `nodetool flush`, uma nova listagem de arquivos (`ls -la`):
```
ls -la $CLIENTE_DATAFILE_PATH

```

Output:
```
root@8cc6dce87878:/# ls -la $CLIENTE_DATAFILE_PATH
total 80
drwxr-xr-x 2 cassandra cassandra 4096 Nov 23 14:08 .
drwxr-xr-x 5 cassandra cassandra 4096 Nov 23 13:42 ..
-rw-r--r-- 1 cassandra cassandra   47 Nov 23 13:52 nb-1-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  255 Nov 23 13:52 nb-1-big-Data.db
-rw-r--r-- 1 cassandra cassandra   10 Nov 23 13:52 nb-1-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   24 Nov 23 13:52 nb-1-big-Filter.db
-rw-r--r-- 1 cassandra cassandra   63 Nov 23 13:52 nb-1-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4852 Nov 23 13:52 nb-1-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Nov 23 13:52 nb-1-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Nov 23 13:52 nb-1-big-TOC.txt
-rw-r--r-- 1 cassandra cassandra   47 Nov 23 14:08 nb-2-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  248 Nov 23 14:08 nb-2-big-Data.db
-rw-r--r-- 1 cassandra cassandra    9 Nov 23 14:08 nb-2-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   24 Nov 23 14:08 nb-2-big-Filter.db
-rw-r--r-- 1 cassandra cassandra   63 Nov 23 14:08 nb-2-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4852 Nov 23 14:08 nb-2-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Nov 23 14:08 nb-2-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Nov 23 14:08 nb-2-big-TOC.txt
```

4. Inspecionando `nb-2-big-Data.db`
```
cat $CLIENTE_DATAFILE_PATH/nb-2-big-Data.db

```

Output:
```
root@8cc6dce87878:/# hexdump -C $CLIENTE_DATAFILE_PATH/nb-2-big-Data.db
00000000  4a 01 00 00 f2 01 00 08  32 62 31 36 33 63 64 61  |J.......2b163cda|
00000010  7f ff ff ff 80 00 01 00  94 24 2a 16 9d d1 08 0b  |.........$*.....|
00000020  30 38 02 00 f3 0d 38 08  18 46 52 41 4e 43 49 53  |08....8..FRANCIS|
00000030  43 41 20 53 41 4e 44 52  41 20 46 45 49 54 4f 53  |CA SANDRA FEITOS|
00000040  41 01 43 00 39 65 64 38  43 00 94 28 16 b5 9c 08  |A.C.9ed8C..(....|
00000050  0b 31 32 33 03 00 f7 06  08 16 4c 55 43 49 4c 45  |.123......LUCILE|
00000060  4e 45 20 50 41 55 4c 4f  20 42 41 52 42 41 00 39  |NE PAULO BARBA.9|
00000070  64 64 65 41 00 84 26 16  aa 3f 08 0b 30 39 02 00  |ddeA..&..?..09..|
00000080  f5 07 39 08 14 42 52 55  4e 41 20 44 45 20 42 52  |..9..BRUNA DE BR|
00000090  49 54 4f 20 50 41 49 56  80 00 39 62 63 63 3f 00  |ITO PAIV..9bcc?.|
000000a0  84 2b 16 92 48 08 0b 30  37 02 00 31 37 08 19 80  |.+..H..07..17...|
000000b0  00 f5 04 49 41 20 52 4f  53 41 20 4c 49 4d 41 20  |...IA ROSA LIMA |
000000c0  50 45 52 45 49 52 44 00  2c 39 36 07 01 54 00 08  |PEREIRD.,96..T..|
000000d0  0b 30 36 02 00 f0 0e 36  08 19 49 56 4f 4e 45 20  |.06....6..IVONE |
000000e0  47 4c 41 55 43 49 41 20  56 49 41 4e 41 20 44 55  |GLAUCIA VIANA DU|
000000f0  54 52 41 01 a2 8d 56 1c                           |TRA...V.|
000000f8
```

### Ordenação (o primeiro S de SSTable)
Percebeu a diferença entre o output do **commit log** versus o output do arquivo de dados?

```
cqlsh -e "select id_cliente, token(id_cliente), nome from ks001.cliente"

```

Output:
```
root@8cc6dce87878:/# cqlsh -e "select id_cliente, token(id_cliente), nome from ks001.cliente"

 id_cliente | system.token(id_cliente) | nome
------------+--------------------------+---------------------------
   2b163cda |     -8543095953418148456 |  FRANCISCA SANDRA FEITOSA
   2b163ed8 |     -5699046624560118549 |    LUCILENE PAULO BARBOSA
   2b163dde |     -5570112041222660315 |      BRUNA DE BRITO PAIVA
   2b163bcc |     -5038845464850628004 | LUCILIA ROSA LIMA PEREIRA
   2b1636ae |     -4846341449078699481 | VERA LUCIA RODRIGUES SENA
   2b16242a |     -4461337310647205397 |     JUCILENE MOREIRA CRUZ
   2b16353c |     -3218952037653612748 |    ALDENORA VIANA MOREIRA
   2b162060 |      -754340186604780055 |        MARIVALDA KANAMARY
   2b16396a |      6124063227111369309 | IVONE GLAUCIA VIANA DUTRA
```

---

# Ciclo 3

### `cqlsh` UPDATE 1

1. Vamos atualizar o sobrenome da **Marivalda** para algo beeeeem grande!

```
cqlsh -e "
UPDATE ks001.cliente SET sobrenome = 'DE ALCÂNTARA FRANCISCO ANTÔNIO JOÃO CARLOS XAVIER DE PAULA MIGUEL RAFAEL JOAQUIM JOSÉ GONZAGA PASCOAL CIPRIANO SERAFIM DE BRAGANÇA E BOURBON KANAMARY' WHERE id_cliente = '2b162060';"

```

Checando:
```
cqlsh -e "SELECT id_cliente, sobrenome FROM ks001.cliente WHERE id_cliente = '2b162060';"

```

2. Commit log
```
ls -la /var/lib/cassandra/commitlog/
```

```
grep --text FRANCISCO /var/lib/cassandra/commitlog/[O_COMMIT_LOG_MAIS_RECENTE]
```

3. nodetool flush

```
nodetool flush

```

Após a execução de `nodetool flush`, uma nova listagem de arquivos (`ls -la`):
```
ls -la $CLIENTE_DATAFILE_PATH

```

Output:
```
root@8cc6dce87878:/# ls -la $CLIENTE_DATAFILE_PATH
total 116
drwxr-xr-x 2 cassandra cassandra 4096 Nov 23 14:15 .
drwxr-xr-x 5 cassandra cassandra 4096 Nov 23 13:42 ..
-rw-r--r-- 1 cassandra cassandra   47 Nov 23 13:52 nb-1-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  255 Nov 23 13:52 nb-1-big-Data.db
-rw-r--r-- 1 cassandra cassandra   10 Nov 23 13:52 nb-1-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   24 Nov 23 13:52 nb-1-big-Filter.db
-rw-r--r-- 1 cassandra cassandra   63 Nov 23 13:52 nb-1-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4852 Nov 23 13:52 nb-1-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Nov 23 13:52 nb-1-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Nov 23 13:52 nb-1-big-TOC.txt
-rw-r--r-- 1 cassandra cassandra   47 Nov 23 14:08 nb-2-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  248 Nov 23 14:08 nb-2-big-Data.db
-rw-r--r-- 1 cassandra cassandra    9 Nov 23 14:08 nb-2-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   24 Nov 23 14:08 nb-2-big-Filter.db
-rw-r--r-- 1 cassandra cassandra   63 Nov 23 14:08 nb-2-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4852 Nov 23 14:08 nb-2-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Nov 23 14:08 nb-2-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Nov 23 14:08 nb-2-big-TOC.txt
-rw-r--r-- 1 cassandra cassandra   47 Nov 23 14:15 nb-3-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  193 Nov 23 14:15 nb-3-big-Data.db
-rw-r--r-- 1 cassandra cassandra   10 Nov 23 14:15 nb-3-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   16 Nov 23 14:15 nb-3-big-Filter.db
-rw-r--r-- 1 cassandra cassandra   12 Nov 23 14:15 nb-3-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4797 Nov 23 14:15 nb-3-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Nov 23 14:15 nb-3-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Nov 23 14:15 nb-3-big-TOC.txt
```

4. Inspecionando `nb-3-big-Data.db`
```
cat $CLIENTE_DATAFILE_PATH/nb-3-big-Data.db

```

Output:
```
root@8cc6dce87878:/# cat $CLIENTE_DATAFILE_PATH/nb-3-big-Data.db
�2b162060�����s ����DE ALCÂNTARA FRANCISCO ANTÔNIO JOÃO CARLOS XAVIER DE PAULA MIGUEL RAFAEL JOAQUIM JOSÉ GONZAGA PASCOAL CIPRIANO SERAFIMF�BRAGANÇA E BOURBON KANAMARY��j�
root@8cc6dce87878:/#
```

```
hd -C $CLIENTE_DATAFILE_PATH/nb-3-big-Data.db

```

---

# Ciclo 4

### `cqlsh` UPDATE 2

1. Vamos atualizar registro da **Jucilene** para incluir o email.

```
cqlsh -e "
UPDATE ks001.cliente SET email = 'jucilene@infobarmail.com' WHERE id_cliente = '2b16242a';"

```

Checando:
```
cqlsh -e "SELECT * FROM ks001.cliente WHERE id_cliente = '2b16242a';"

```

Output:
```
root@8cc6dce87878:/# cqlsh -e "SELECT * FROM ks001.cliente WHERE id_cliente = '2b16242a';"

 id_cliente | cpf         | email                    | nome                  | sobrenome
------------+-------------+--------------------------+-----------------------+-----------
   2b16242a | 02020202022 | jucilene@infobarmail.com | JUCILENE MOREIRA CRUZ |      null
```

2. nodetool flush
Verifique o conteúdo do diretório antes do flush.
```
ls -la $CLIENTE_DATAFILE_PATH

```

```
nodetool flush

```

Após a execução de `nodetool flush`, uma nova listagem de arquivos (`ls -la`):
```
ls -la $CLIENTE_DATAFILE_PATH

```

Output:
```
root@8cc6dce87878:/# ls -la $CLIENTE_DATAFILE_PATH
total 44
drwxr-xr-x 2 cassandra cassandra 4096 Nov 23 14:30 .
drwxr-xr-x 5 cassandra cassandra 4096 Nov 23 13:42 ..
-rw-r--r-- 1 cassandra cassandra   55 Nov 23 14:30 nb-5-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  657 Nov 23 14:30 nb-5-big-Data.db
-rw-r--r-- 1 cassandra cassandra    9 Nov 23 14:30 nb-5-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   24 Nov 23 14:30 nb-5-big-Filter.db
-rw-r--r-- 1 cassandra cassandra  128 Nov 23 14:30 nb-5-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4968 Nov 23 14:30 nb-5-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   68 Nov 23 14:30 nb-5-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Nov 23 14:30 nb-5-big-TOC.txt
```

**Compaction**
O que você acabou de certificar foi a operação de [Compaction](https://cassandra.apache.org/doc/stable/cassandra/operating/compaction/index.html).<br>
Essa operação tem como base o conceito de [Log-structured merge-tree](https://en.wikipedia.org/wiki/Log-structured_merge-tree), também conhecido como **LSM tree**.<br>

Finalmente, vamos examinar o arquivo de dados gerado:
```
hexdump -C $CLIENTE_DATAFILE_PATH/nb-5-big-Data.db

```

Output:
```
root@8cc6dce87878:/# hexdump -C $CLIENTE_DATAFILE_PATH/nb-5-big-Data.db
00000000  68 03 00 00 f2 01 00 08  32 62 31 36 33 63 64 61  |h.......2b163cda|
00000010  7f ff ff ff 80 00 01 00  d4 04 2e 16 f0 29 26 c9  |.............)&.|
00000020  03 0a 08 0b 30 38 02 00  f3 0d 38 08 18 46 52 41  |....08....8..FRA|
00000030  4e 43 49 53 43 41 20 53  41 4e 44 52 41 20 46 45  |NCISCA SANDRA FE|
00000040  49 54 4f 53 41 01 47 00  39 65 64 38 47 00 10 2c  |ITOSA.G.9ed8G..,|
00000050  47 00 84 e0 ce 0a 08 0b  31 32 33 03 00 f7 06 08  |G.......123.....|
00000060  16 4c 55 43 49 4c 45 4e  45 20 50 41 55 4c 4f 20  |.LUCILENE PAULO |
00000070  42 41 52 42 45 00 39 64  64 65 45 00 10 2a 45 00  |BARBE.9ddeE..*E.|
00000080  20 d5 71 8c 00 14 39 02  00 f5 07 39 08 14 42 52  | .q...9....9..BR|
00000090  55 4e 41 20 44 45 20 42  52 49 54 4f 20 50 41 49  |UNA DE BRITO PAI|
000000a0  56 88 00 39 62 63 63 43  00 10 2f 43 00 20 bd 7a  |V..9bccC../C. .z|
000000b0  43 00 14 37 02 00 31 37  08 19 88 00 f5 04 49 41  |C..7..17......IA|
000000c0  20 52 4f 53 41 20 4c 49  4d 41 20 50 45 52 45 49  | ROSA LIMA PEREI|
000000d0  52 48 00 2a 36 61 8b 00  40 2c 16 bd 0c 45 00 14  |RH.*6a..@,...E..|
000000e0  35 02 00 80 35 08 19 56  45 52 41 20 4a 00 00 48  |5...5..VERA J..H|
000000f0  00 b4 44 52 49 47 55 45  53 20 53 45 4e 45 00 3a  |..DRIGUES SENE.:|
00000100  32 34 32 5c 01 94 47 16  8e 6d 08 08 0b 30 32 02  |242\..G..m...02.|
00000110  00 f4 14 32 00 f0 9d e1  4c f8 18 6a 75 63 69 6c  |...2....L..jucil|
00000120  65 6e 65 40 69 6e 66 6f  62 61 72 6d 61 69 6c 2e  |ene@infobarmail.|
00000130  63 6f 6d 08 15 4a 31 01  21 4d 4f a0 00 53 20 43  |com..J1.!MO..S C|
00000140  52 55 5a 75 01 3a 32 35  36 60 00 40 29 16 a6 a5  |RUZu.:256`.@)...|
00000150  a5 00 14 33 02 00 f6 08  33 08 16 47 52 41 43 49  |...3....3..GRACI|
00000160  4d 41 52 20 42 52 41 53  49 4c 20 47 55 45 52 e7  |MAR BRASIL GUER.|
00000170  00 2a 35 33 2f 01 40 29  16 b2 22 42 00 14 34 02  |.*53/.@).."B..4.|
00000180  00 f4 02 34 08 16 41 4c  44 45 4e 4f 52 41 20 56  |...4..ALDENORA V|
00000190  49 41 4e 41 89 00 04 84  00 39 30 36 30 71 01 94  |IANA.....9060q..|
000001a0  80 c6 16 00 02 08 0b 30  31 02 00 f0 19 31 08 12  |.......01....1..|
000001b0  4d 41 52 49 56 41 4c 44  41 20 4b 41 4e 41 4d 41  |MARIVALDA KANAMA|
000001c0  52 59 00 f0 67 49 b8 7c  80 9a 44 45 20 41 4c 43  |RY..gI.|..DE ALC|
000001d0  c3 82 4e 54 41 54 02 03  65 02 f0 0f 4f 20 41 4e  |..NTAT..e...O AN|
000001e0  54 c3 94 4e 49 4f 20 4a  4f c3 83 4f 20 43 41 52  |T..NIO JO..O CAR|
000001f0  4c 4f 53 20 58 41 56 49  45 52 fa 01 00 3f 02 30  |LOS XAVIER...?.0|
00000200  41 20 4d 73 01 f0 28 4c  20 52 41 46 41 45 4c 20  |A Ms..(L RAFAEL |
00000210  4a 4f 41 51 55 49 4d 20  4a 4f 53 c3 89 20 47 4f  |JOAQUIM JOS.. GO|
00000220  4e 5a 41 47 41 20 50 41  53 43 4f 41 4c 20 43 49  |NZAGA PASCOAL CI|
00000230  50 52 49 41 4e 4f 20 53  45 52 41 46 49 4d 46 00  |PRIANO SERAFIMF.|
00000240  f5 04 42 52 41 47 41 4e  c3 87 41 20 45 20 42 4f  |..BRAGAN..A E BO|
00000250  55 52 42 4f 4e a2 00 03  e0 00 2b 33 39 64 01 01  |URBON.....+39d..|
00000260  51 02 20 ab 32 25 01 14  36 02 00 c1 36 08 19 49  |Q. .2%..6...6..I|
00000270  56 4f 4e 45 20 47 4c 41  0f 02 02 2a 01 60 44 55  |VONE GLA...*.`DU|
00000280  54 52 41 01 53 79 43 fd  00 00 00 00 00 c6 22 f7  |TRA.SyC.......".|
00000290  1d                                                |.|
```

```
cat $CLIENTE_DATAFILE_PATH/nb-5-big-Data.db

```

Ou seja, a operação de compactação reuniu o conteúdo de 4 sstables em uma só.

---

## Ciclo 5

### `cqlsh` DELETE

1. Eliminando o registro da **Gracimar**:
```
cqlsh --execute \
"DELETE FROM ks001.cliente WHERE id_cliente = '2b16256a';"

```

Checando:
```
cqlsh --execute \
"SELECT * FROM ks001.cliente WHERE id_cliente = '2b16256a';"

```

2. Eliminando um registro com uma chave inexistente na tabela:
```
cqlsh --execute \
"DELETE FROM ks001.cliente WHERE id_cliente = 'UMA_CHAVE_QUE_NUNCA_INSERI';"

```

3. Checando os arquivos:
```
ls -la $CLIENTE_DATAFILE_PATH

```

```
nodetool flush

```

```
ls -la $CLIENTE_DATAFILE_PATH

```

4. Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```
cat $CLIENTE_DATAFILE_PATH/nb-6-big-Data.db

```

---

# Parabéns!

Você concluiu o laboratório de observação de datafiles no Cassandra! Você aprendeu como o Cassandra gerencia os arquivos de dados (sstables) em disco, desde a inserção, atualização e deleção de registros até a operação de flush e compactação. Continue explorando e aprofundando seus conhecimentos em Cassandra e sistemas de banco de dados distribuídos. Bom trabalho!