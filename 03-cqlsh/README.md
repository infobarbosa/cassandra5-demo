# `cqlsh` - CQL shell
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nas sessões a seguir vamos utilizar bastante o `cqlsh`.
`cqlsh` é uma interface de linha de comando cujo propósito é prover um meio de interagir com o Cassandra utilizando a linguagem CQL (Cassandra Query Language).<br>
Ela vem empacotada junto com o Cassandra.

De forma prática há dois modos de utilizar com o `cqlsh`: interativo e não interativo.

## 1 - Interativo
No modo interativo executa-se o comando `cqlsh` que disponibiliza então um prompt onde é possível emitir comandos CQL com resposta no próprio console.
O console se mantém aberto aguardando os próximos comandos CQL.

Por exemplo:
**Abrindo o `cqlsh`**
```
cqlsh
```

Output:
```
ubuntu $ cqlsh
Connected to Test Cluster at 127.0.0.1:9042
[cqlsh 6.1.0 | Cassandra 4.1.0 | CQL spec 3.4.6 | Native protocol v5]
Use HELP for help.
cqlsh> 
```

**Executando um comando**
```
DESCRIBE KEYSPACES;
```

Output:
```
cqlsh> describe KEYSPACES 

system       system_distributed  system_traces  system_virtual_schema
system_auth  system_schema       system_views 

cqlsh> 
``` 

## 2 - Não interativo
No modo não interativo executa-se o mesmo comando `cqlsh`, porém desta vez com o parâmetro `-e` ou `--execute` seguido do comando desejado.<br>
Nessa condição o `cqlsh` executa o comando e sai imediatamente.
Essa opção é bastante utilizada em scripts de manutenção automática do banco de dados.

Por exemplo:
```
cqlsh -e "describe keyspaces;"
```

Output
```
ubuntu $ cqlsh -e "describe keyspaces;"

system       system_distributed  system_traces  system_virtual_schema
system_auth  system_schema       system_views 
```

Ou, utilizando `--execute`
```
cqlsh --execute "describe keyspaces"
```

Output:
```
ubuntu $ cqlsh --execute "describe keyspaces"

system       system_distributed  system_traces  system_virtual_schema
system_auth  system_schema       system_views
```

### Saindo do `cqlsh`
Para sair do modo interativo do `cqlsh` basta digitar `exit` ou `Ctrl+D`:

Output:
```
ubuntu $ cqlsh
Connected to Test Cluster at 127.0.0.1:9042
[cqlsh 6.1.0 | Cassandra 4.1.0 | CQL spec 3.4.6 | Native protocol v5]
Use HELP for help.
cqlsh> 
cqlsh> exit
ubuntu $ 
```
