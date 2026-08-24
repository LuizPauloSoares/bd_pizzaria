# 🍕 Pizzaria DB

Modelagem e script completo de banco de dados relacional para o sistema de gestão de uma pizzaria — cadastro de clientes, funcionários, fornecedores, estoque, pedidos, pagamentos, fidelidade, folha de pagamento e relatórios de vendas.

Desenvolvido em **T-SQL (SQL Server)**.

---

## 📋 Sobre o projeto

O banco `PIZZARIA` cobre o fluxo completo de uma pizzaria, do estoque de ingredientes até a entrega do pedido, incluindo:

- Cadastro de clientes, funcionários e fornecedores (com endereço normalizado por CEP/bairro/cidade/estado)
- Catálogo de pizzas, categorias, ingredientes extras e bebidas
- Controle de estoque e movimentações (entradas, saídas, ajustes, compras)
- Pedidos, comandas, status de pedido e avaliações de clientes
- Programas de fidelidade, cupons e descontos
- Escalas de trabalho, ponto eletrônico e folha de pagamento
- Caixa diário, contas a pagar, log do sistema e relatórios de vendas

## 🗂️ Estrutura do banco

O script está dividido em três blocos, na ordem em que devem ser executados:

1. **DDL** — criação do banco e das tabelas (`CREATE DATABASE` / `CREATE TABLE`)
2. **DML** — carga de dados de exemplo (`INSERT INTO`)
3. **Consultas** — exemplos de `SELECT` com `JOIN` para validar os relacionamentos

### Principais entidades

| Domínio | Tabelas |
|---|---|
| Localização | `tb_estado`, `tb_cidade`, `tb_bairro`, `tb_endereco` |
| Pessoas | `tb_cliente`, `tb_funcionario`, `tb_fornecedo`, `tb_telefone` |
| Cardápio | `tb_pizza`, `tb_categorias_pizza`, `tb_ingrediente`, `tb_pizza_ingrediente`, `tb_ingrediente_extra`, `tb_bebidas` |
| Estoque | `tb_estoque`, `tb_movi_estoque`, `tb_compras_estoque`, `tb_itens_compra_estoque` |
| Vendas | `tb_pedido`, `tb_comanda`, `tb_status`, `tb_avaliacao`, `tb_forma_pagamento`, `tb_promocao`, `tb_desconto`, `tb_cupom`, `tb_fidelidade` |
| RH | `tb_cargo`, `tb_horario_trabalho`, `tb_escalas_trabalho`, `tb_ponto_eletronico`, `tb_folha` |
| Administração | `tb_pizzaria`, `tb_caixa_diario`, `tb_contas_pagar`, `tb_usuarios_sistemas`, `tb_log_sistema`, `tb_relatorio_vendas` |

### Modelo de relacionamento (visão geral)

```
tb_estado ─┬─< tb_cidade ─┬─< tb_bairro ─┬─< tb_endereco ─┬─< tb_cliente
           │              │              │                ├─< tb_funcionario
           │              │              │                ├─< tb_fornecedo
           │              │              │                └─< tb_pizzaria
           │
tb_cliente ─┬─< tb_pedido ─┬─< tb_comanda
            │              ├─< tb_status
            │              └─< tb_avaliacao
            ├─< tb_fidelidade
            ├─< tb_desconto
            ├─< tb_cupom
            ├─< tb_telefone
            └─< tb_forma_pagamento

tb_funcionario ─┬─< tb_cargo
                ├─< tb_escalas_trabalho >─ tb_horario_trabalho
                ├─< tb_ponto_eletronico
                ├─< tb_folha
                └─< tb_telefone

tb_estoque ─┬─< tb_ingrediente ─< tb_pizza_ingrediente >─ tb_pizza
            ├─< tb_ingrediente_extra
            ├─< tb_bebidas
            └─< tb_movi_estoque

tb_fornecedo ─┬─< tb_compras_estoque ─< tb_itens_compra_estoque
              ├─< tb_ingrediente
              └─< tb_telefone
```

## ⚙️ Como usar

1. Abra o script no **SQL Server Management Studio** (ou outra ferramenta compatível com T-SQL).
2. Execute o bloco de criação do banco e das tabelas.
3. Execute o bloco de `INSERT` para popular as tabelas com dados de exemplo.
4. Rode as consultas de exemplo no final do script para validar os relacionamentos.

```sql
USE PIZZARIA;
GO
```

### Exemplos de consulta incluídos

- Pedidos por cliente
- Escala e horário de trabalho por funcionário
- Pontos de fidelidade por pedido
- Ingredientes utilizados por pizza
- Fornecedor de cada ingrediente
- Status atual de cada pedido
- Cupons e telefones por cliente/fornecedor

## 🛠️ Tecnologias

- **SQL Server (T-SQL)** — `IDENTITY`, `DATETIME`, `DECIMAL`, chaves estrangeiras compostas

## 📌 Status

Projeto acadêmico/pessoal, migrado para este repositório para versionamento e histórico.

## 👤 Autor

Luiz

- GitHub: [github.com/LuizPauloSoares](https://github.com/LuizPauloSoares)
- LinkedIn: [linkedin.com/in/luiz-paulo-soares](https://linkedin.com/in/luiz-paulo-soares/)
- Instagram: [@lu1z_st](https://instagram.com/lu1z_st)
