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

## Docker
Por simplicidade, vamos utilizar o Cassandra em um container baseado em *Docker*.<br>
Na pasta[02-Cassandra-Start/assets/scripts](./02-Cassandra-Start/assets/scripts) está disponível um arquivo `compose.yaml` que contém os parâmetros de inicialização do container Docker.<br>
Embora não seja escopo deste laboratório o entendimento detalhado do Docker, recomendo o estudo do arquivo `compose.yaml`.

```
ls -la ./cassandra5-demo/assets/scripts/compose.yaml

```

Output esperado:
```

```

Verifique o conteúdo do arquivo:
```
cat ./cassandra5-demo/assets/scripts/compose.yaml

```

### A imagem
A imagem que vamos utilizar é a [`infobarbosa/cassandra5:latest`](https://hub.docker.com/repository/docker/infobarbosa/cassandra5/general). Esta é uma imagem customizada com a versão 5.0 do Apache Cassandra onde eu adiciono um schema de exemplo `infobarbank` para fins didáticos.

## Inicialização
```
docker compose -f ./cassandra5-demo/assets/scripts/standalone/compose.yaml up -d

```

Output esperado:
```

```

Para verificar se está tudo correto:
```
docker compose -f ./cassandra5-demo/assets/scripts/standalone/compose.yaml logs -f

```
> Para sair do comando acima, digite `Control+C`

## Checando a inicialização
Vamos verificar se o container subiu com o seguinte comando:
```
docker ps -a

```

Output esperado:
```

```

Se tudo correu bem então será possível verificar o status do node:
```
docker exec -it cassandra-demo nodetool status

```

Output esperado:
```

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
docker exec -it cassandra-demo /bin/bash

```

> Para sair da instância docker basta digitar `Control+D` ou `exit` seguido da tecla `ENTER`.


# Parabéns
Sua instância Cassandra está pronta pra uso!


### Encerrando o Cassandra
Caso você queira reiniciar o laboratório em uma instância totalmente nova ou mesmo eliminar para higienizar o ambiente, basta executar o comando abaixo:
```
docker compose -f ./cassandra5-demo/assets/scripts/standalone/compose.yaml down

```

Output esperado:
```

 ```
