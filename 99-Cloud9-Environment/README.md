# 01 - Ambiente Cloud9
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Neste laboratório faremos uso recorrente do serviço Cloud9.

1. Verifique a região no topo à direita do console AWS, normalmente é **Norte da Virgínia**.<br>
**Não** altere essa configuração!
<div align="left">

![img/001_regiao.png](img/001_regiao.png) 

</div>

2. Abra o console da AWS e na caixa de busca superior digite **Cloud9**.
<div align="left">

![img/002_cloud9_barra_de_buscas.png](img/002_cloud9_barra_de_buscas.png)

</div>

3. Clique no link Cloud9
<div align="left">

![img/003_cloud9_link.png](img/003_cloud9_link.png)

</div>

4. Clique em **Criar ambiente**
<div align="left">

![img/004_cloud9_criar_ambiente.png](img/004_cloud9_criar_ambiente.png)

</div>

---
>Outra forma de acesso ao console Cloud9 é via menu "sanduíche" (três barras horizontais) logo abaixo do logo da AWS.
>
>![img/005_cloud9_menu_sanduiche_1.png](img/005_cloud9_menu_sanduiche_1.png)
>
>Ao abrir o menu, clique então em **Meus ambientes**
>
> ![img/006_cloud9_menu_sanduiche_2.png](img/006_cloud9_menu_sanduiche_2.png)
>
>Você será direcionado ao console do Cloud9 onde também está disponível o botão **Criar ambiente**
>
>![img/007_cloud9_console.png](img/007_cloud9_console.png)
---

5. Será exibida a tela **Criar ambiente** confirme seguir.

![img/008_cloud9_tela_criar_ambiente.png](img/008_cloud9_tela_criar_ambiente.png)

6. Campo **Nome**: informe `lab`.

![img/009_cloud9_tela_criar_ambiente_nome.png](img/009_cloud9_tela_criar_ambiente_nome.png)

7. Campo **Descrição**: deixe em branco.

8. **Tipo de ambiente**: selecione `Nova instância do EC2`.

![img/010_cloud9_tela_criar_ambiente_tipo_ambiente.png](img/010_cloud9_tela_criar_ambiente_tipo_ambiente.png)

9. **Tipo instância**: selecione `t3.large`

![img/011_cloud9_tela_criar_ambiente_tipo_instancia_t3.large.png](img/011_cloud9_tela_criar_ambiente_tipo_instancia_t3.large.png)

> Atenção!
> Caso não seja possível criar uma instância `t3.large` ainda é possível escolher um tipo de instância com menos memória e CPU.
> **Para este laboratório o mínimo possível é `t2.medium`**

10. **Plataforma**: selecione `Ubuntu Server 22.04 LTS` 

![img/012_cloud9_tela_criar_ambiente_plataforma.png](img/012_cloud9_tela_criar_ambiente_plataforma.png)

11. **Tempo limite**: selecione `4 horas`

![img/013_cloud9_tela_criar_ambiente_tempo_limite.png](img/013_cloud9_tela_criar_ambiente_tempo_limite.png)

12. **Conexão**: deixe selecionado `Secure Shell (SSH)`

![img/014_cloud9_tela_criar_ambiente_conexao_ssh.png](img/014_cloud9_tela_criar_ambiente_conexao_ssh.png)

13. Clique em **Criar** ao final da página

![img/015_cloud9_tela_criar_ambiente_botao_criar.png](img/015_cloud9_tela_criar_ambiente_botao_criar.png)

>Leva de 2 a 3 minutos para o ambiente ser criado. 

Ao ser criado, seu ambiente aparece no console do Cloud9
![img/016_cloud9_ambiente_criado.png](img/016_cloud9_ambiente_criado.png)

14. Para abrir o IDE do ambiente criado, clique em "Em aberto" conforme a seguir:

![img/017_cloud9_abrir_ide.png](img/017_cloud9_abrir_ide.png)

15. Uma nova aba será aberta com o IDE do Cloud9 criado:

![img/018_cloud9_ide_aberta.png](img/018_cloud9_ide_aberta.png)

## Configuração adicional

### Clone do projeto
Caso ainda não tenha feito, faça o clone do projeto com o seguinte comando:
```
git clone https://github.com/infobarbosa/cassandra5-demo.git

```

### Configuração de disco
No terminal, execute o seguinte script para ajustar o espaço em disco do Cloud9
```
sh ./cassandra5-demo/assets/scripts/setup_cloud9_env.sh

```

# Parabéns! 
Seu ambiente Cloud9 está pronto pra uso!
