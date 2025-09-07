# Inicialização do Cassandra
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nesta sessão vamos inicializar uma instância stand-alone do Apache Cassandra.

## Arquivo docker compose
Por simplicidade, vamos utilizar o Cassandra em um container baseado em *Docker*.<br>
Baixe o script utilizando o comando:
```
wget https://raw.githubusercontent.com/infobarbosa/cassandra5-demo/main/assets/scripts/standalone/compose.yaml

```

Verifique o conteúdo do arquivo:
```
cat ./compose.yaml

```

## Inicialização
```
docker compose up -d

```

Para verificar se está tudo correto:
```
docker logs -f cassandra-database 

```
> Para sair do comando acima, digite `Control+C`

## Checando a inicialização
Vamos verificar se o container subiu com o seguinte comando:
```
docker ps -a

```

Output esperado:
```
CONTAINER ID   IMAGE                                             COMMAND                  CREATED         STATUS                     PORTS                                         NAMES
3084fe9ee0c4   infobarbosa/infobarbank-cassandra-schema:latest   "python3 infobarbank…"   3 minutes ago   Exited (0) 2 minutes ago                                                 cassandra-init
d3cb569bd839   cassandra:latest                                  "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes (healthy)     7000-7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp   cassandra-database
```

Se tudo correu bem então será possível verificar o status do node:
```
docker exec -it cassandra-database nodetool status

```

Output esperado:
```
voclabs:~/environment $ docker exec -it cassandra-database nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address      Load        Tokens  Owns (effective)  Host ID                               Rack
UN  172.16.0.11  109.18 KiB  16      100.0%            d1f6b84a-6d7d-469e-8b93-46887cf69b25  RAC1
```

**Atenção!** Se retornar o erro erro abaixo, é provável que o serviço Cassandra ainda esteja em processo de inicialização.
```
Exception in thread "main" java.lang.IllegalArgumentException: Server is not initialized yet, cannot run nodetool.
	at org.apache.cassandra.tools.NodeTool.err(NodeTool.java:319)
	at org.apache.cassandra.tools.NodeTool.execute(NodeTool.java:282)
	at org.apache.cassandra.tools.NodeTool.main(NodeTool.java:85)
```
Espere alguns segundos até que a inicialização tenha terminado e execute o comando novamente.

## Acessando a instância
  > **IMPORTANTE!**<br>
  > Todos os comandos do laboratório pressupõem que você esteja conectado na instância *docker* do Cassandra.<br>

Para acessar a instância, basta executar o comando abaixo:
```
docker exec -it cassandra-database /bin/bash

```

> Para sair da instância docker basta digitar `Control+D` ou `exit` seguido da tecla `ENTER`.


# Parabéns
Sua instância Cassandra está pronta pra uso!


### Encerrando o Cassandra
Caso você queira reiniciar o laboratório em uma instância totalmente nova ou mesmo eliminar para higienizar o ambiente, basta executar o comando abaixo:
```
docker compose down

```
