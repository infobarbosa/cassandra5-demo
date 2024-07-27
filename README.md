# Wide-column databases com Cassandra

Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

O objetivo desse laboratório é oferecer ao aluno ambiente onde de familiarização com o modelo de armazenamento de wide-column utilizando **Cassandra**.

## Cassandra

[Cassandra](https://cassandra.apache.org/_/index.html) é um banco de dados altamente escalável com modelo de armazenamento wide-column. <br>


# Laboratório

## Ambiente
Este laborarório pode ser executado em qualquer estação de trabalho.<br>
Recomendo, porém, a execução em sistema operacional Linux.<br>
Caso você não tenha um à sua disposição, recomendo o uso do AWS Cloud9. Siga essas [instruções](Cloud9/README.md).

## Setup
Para começar, faça o clone deste repositório:
```
git clone https://github.com/infobarbosa/cassandra5-demo
```

No terminal, navegue para o diretório do repositório
```
cd cassandra5-demo
```

## Docker
Por simplicidade, vamos utilizar o Cassandra em um container baseado em *Docker*.<br>
Na raiz do projeto está disponível um arquivo `compose.yaml` que contém os parâmetros de inicialização do container Docker.<br>
Embora não seja escopo deste laboratório o entendimento detalhado do Docker, recomendo o estudo do arquivo `compose.yaml`.

```
ls -la compose.yaml
```

Output esperado:
```
ls -la compose.yaml
-rw-r--r-- 1 barbosa barbosa 144 jul 16 23:20 compose.yaml
```

#### Inicialização
```
docker compose up -d
```

Para verificar se está tudo correto:
```
docker compose logs -f
```
> Para sair do comando acima, digite `Control+C`
