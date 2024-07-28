# Inicialização do Cassandra
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nesta sessão vamos inicializar uma instância stand-alone do Apache Cassandra.

## Clone do projeto
Faça o clone do projeto com o seguinte comando:
```
git clone https://github.com/infobarbosa/cassandra5-demo.git
```

Então navegue para o diretório do projeto:
```
cd cassandra5-demo
```

> **Atenção!** Todos os comandos deste laboratório pressupõem que você esteja no diretório do projeto.

## Docker
Por simplicidade, vamos utilizar o Cassandra em um container baseado em *Docker*.<br>
Na pasta[02-Cassandra-Start/assets/scripts](./02-Cassandra-Start/assets/scripts) está disponível um arquivo `compose.yaml` que contém os parâmetros de inicialização do container Docker.<br>
Embora não seja escopo deste laboratório o entendimento detalhado do Docker, recomendo o estudo do arquivo `compose.yaml`.

```
ls -la 02-Cassandra-Start/assets/scripts/compose.yaml
```

Output esperado:
```
ls -la compose.yaml
-rw-r--r-- 1 barbosa barbosa 144 jul 16 23:20 compose.yaml
```

#### A imagem
A imagem que vamos utilizar é a [`infobarbosa/cassandra5:latest`](https://hub.docker.com/repository/docker/infobarbosa/cassandra5/general). Esta é uma imagem customizada com a versão 5.0 do Apache Cassandra onde eu adiciono um schema de exemplo `infobarbank` para fins didáticos.

## Inicialização
```
docker compose -f ./02-Cassandra-Start/assets/scripts/compose.yaml up -d
```

Output esperado:
```
[+] Running 2/2
 ✔ Network infobarbankdb_default  Created                                      0.1s 
 ✔ Container cassandra5           Started                                      0.8s 
```

Para verificar se está tudo correto:
```
docker compose -f ./02-Cassandra-Start/assets/scripts/compose.yaml logs -f
```
> Para sair do comando acima, digite `Control+C`

## Checando a inicialização
Vamos verificar se o container subiu com o seguinte comando:
```
docker ps -a
```

Output esperado:
```
CONTAINER ID   IMAGE                           COMMAND                  CREATED              STATUS              PORTS                                                                          NAMES
daeb5575b6e7   infobarbosa/cassandra5:latest   "docker-entrypoint.s…"   About a minute ago   Up About a minute   7000-7001/tcp, 7199/tcp, 9160/tcp, 0.0.0.0:9042->9042/tcp, :::9042->9042/tcp   cassandra5
```

Se tudo correu bem então será possível verificar o status do node:
```
docker exec -it cassandra5 nodetool status
```

Output esperado:
```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load        Tokens  Owns (effective)  Host ID                               Rack
UN  172.19.0.2  548.69 KiB  16      100.0%            3f137cdf-2966-4555-b5c3-dd7e33adbb73  rack1
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
docker exec -it cassandra5 /bin/bash
```

## Encerrando o Cassandra
Caso você queira reiniciar o laboratório em uma instância totalmente nova ou mesmo eliminar para higienizar o ambiente, basta executar o comando abaixo:
```
docker compose -f ./02-Cassandra-Start/assets/scripts/compose.yaml down
```

Output esperado:
```
[+] Running 2/2
 ✔ Container cassandra5           Removed                                                                                                                                     5.7s
 ✔ Network infobarbankdb_default  Removed                                                                                                                                     0.5s
 ```

# Parabéns
Sua instância Cassandra está pronta pra uso!
