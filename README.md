# 🚗 Projeto Lógico de Banco de Dados - Oficina Mecânica

## 📖 Sobre o Projeto

Este projeto foi desenvolvido como parte do desafio de projeto da **Digital Innovation One (DIO)**, com o objetivo de realizar a modelagem lógica e a implementação de um banco de dados relacional para o gerenciamento de uma oficina mecânica.

O sistema permite controlar clientes, veículos, equipes, mecânicos, ordens de serviço, serviços executados, peças utilizadas e pagamentos, aplicando conceitos de modelagem relacional, normalização e consultas SQL.

---

# 🎯 Objetivos

* Criar o modelo lógico a partir do modelo conceitual.
* Implementar o banco de dados utilizando SQL.
* Popular as tabelas com dados para testes.
* Desenvolver consultas SQL utilizando diferentes cláusulas da linguagem.
* Publicar toda a solução em um repositório no GitHub.

---

# 🛠️ Tecnologias Utilizadas

* SQL Server
* SQL (DDL, DML e DQL)
* Modelo Relacional
* Git
* GitHub

---

# 📂 Estrutura do Projeto

```text
📁 oficina-banco-dados-dio
│
├── README.md
├── modelo_logico.png
├── script_criacao.sql
├── inserts.sql
├── consultas.sql
└── diagrama_oficina.drawio
```

---

# 📊 Modelo Lógico

O banco de dados é composto pelas seguintes entidades:

* Cliente
* Veículo
* Mecânico
* Equipe
* Equipe_Mecanico
* OrdemServico
* Serviço
* OS_Servico
* Peça
* OS_Peca
* Pagamento

### Relacionamentos

* Um cliente pode possuir vários veículos.
* Um veículo pode possuir várias ordens de serviço.
* Uma equipe pode atender várias ordens de serviço.
* Uma equipe possui vários mecânicos.
* Uma ordem de serviço pode conter vários serviços.
* Uma ordem de serviço pode utilizar várias peças.
* Uma ordem de serviço pode possuir um ou mais pagamentos.

---

# 🗄️ Estrutura do Banco

## Cliente

* ClienteID (PK)
* Nome
* CPF
* Telefone
* Email

## Veículo

* VeiculoID (PK)
* ClienteID (FK)
* Placa
* Marca
* Modelo
* Ano

## Mecânico

* MecanicoID (PK)
* Nome
* Especialidade
* Telefone

## Equipe

* EquipeID (PK)
* NomeEquipe

## Equipe_Mecanico

* EquipeID (FK)
* MecanicoID (FK)

## OrdemServico

* OSID (PK)
* VeiculoID (FK)
* EquipeID (FK)
* DataEntrada
* DataSaida
* Status
* ValorTotal

## Serviço

* ServicoID (PK)
* Descricao
* Valor

## OS_Servico

* OSID (FK)
* ServicoID (FK)
* Quantidade

## Peça

* PecaID (PK)
* Nome
* Valor
* Estoque

## OS_Peca

* OSID (FK)
* PecaID (FK)
* Quantidade

## Pagamento

* PagamentoID (PK)
* OSID (FK)
* FormaPagamento
* ValorPago
* DataPagamento

---

# 📥 Carga de Dados

Foram inseridos registros de teste para possibilitar a execução das consultas SQL, incluindo:

* Clientes
* Veículos
* Mecânicos
* Equipes
* Serviços
* Peças
* Ordens de Serviço
* Pagamentos

---

# 🔍 Consultas Desenvolvidas

O projeto contempla consultas utilizando diversos recursos da linguagem SQL.

### ✔ SELECT

Recuperação simples de dados.

Exemplo:

```sql
SELECT * FROM Cliente;
```

---

### ✔ WHERE

Filtragem de registros.

Exemplo:

```sql
SELECT *
FROM OrdemServico
WHERE Status = 'Aberta';
```

---

### ✔ Atributos Derivados

Criação de colunas calculadas.

Exemplo:

```sql
SELECT
Descricao,
Valor,
Valor * 0.90 AS ValorPromocional
FROM Servico;
```

---

### ✔ ORDER BY

Ordenação dos resultados.

Exemplo:

```sql
SELECT *
FROM OrdemServico
ORDER BY ValorTotal DESC;
```

---

### ✔ GROUP BY + HAVING

Agrupamento com filtros.

Exemplo:

```sql
SELECT
ClienteID,
COUNT(*) AS TotalVeiculos
FROM Veiculo
GROUP BY ClienteID
HAVING COUNT(*) > 1;
```

---

### ✔ JOIN

Consultas envolvendo múltiplas tabelas.

Exemplo:

* Cliente × Veículo
* Ordem de Serviço × Cliente × Veículo × Equipe
* Cliente × Pagamentos
* Serviços realizados
* Peças utilizadas

---

# ❓ Perguntas Respondidas pelas Consultas

* Quais clientes estão cadastrados?
* Quais clientes possuem mais de um veículo?
* Qual o valor promocional dos serviços?
* Quais veículos pertencem a cada cliente?
* Qual o valor total pago por cliente?
* Quais serviços foram mais executados?
* Quais peças foram mais utilizadas?
* Quais ordens de serviço estão em aberto?
* Quais mecânicos fazem parte de cada equipe?

---

# ▶ Como Executar

1. Clone este repositório.

```bash
git clone https://github.com/seu-usuario/oficina-banco-dados-dio.git
```

2. Abra o SQL Server Management Studio (SSMS).

3. Execute o arquivo `script_criacao.sql`.

4. Execute o arquivo `inserts.sql`.

5. Execute o arquivo `consultas.sql`.

---

# 📚 Conceitos Aplicados

* Modelagem Conceitual
* Modelo Lógico
* Modelo Relacional
* Chaves Primárias (PK)
* Chaves Estrangeiras (FK)
* Relacionamentos 1:N e N:N
* Integridade Referencial
* DDL
* DML
* DQL
* JOIN
* GROUP BY
* HAVING
* ORDER BY
* Funções de Agregação

---

# 👨‍💻 Autor

**Letícia Carvalho**

Projeto desenvolvido como parte do desafio da **Digital Innovation One (DIO)** para a formação em Banco de Dados.
