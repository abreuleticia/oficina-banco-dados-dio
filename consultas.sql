```sql
/*==============================================================
  PROJETO: Oficina Mecânica
  ARQUIVO: consultas.sql
==============================================================*/

USE OficinaDB;
GO

/*==============================================================
1. Recuperação simples (SELECT)
Pergunta: Quais clientes estão cadastrados?
==============================================================*/
SELECT *
FROM Cliente;
GO

/*==============================================================
2. Filtro com WHERE
Pergunta: Quais ordens de serviço estão em aberto?
==============================================================*/
SELECT *
FROM OrdemServico
WHERE Status = 'Aberta';
GO

/*==============================================================
3. Filtro por ano do veículo
Pergunta: Quais veículos são fabricados a partir de 2020?
==============================================================*/
SELECT
Marca,
Modelo,
Ano,
Placa
FROM Veiculo
WHERE Ano >= 2020;
GO

/*==============================================================
4. Atributo derivado
Pergunta: Qual seria o valor promocional dos serviços
com 10% de desconto?
==============================================================*/
SELECT
Descricao,
Valor,
Valor * 0.90 AS ValorPromocional
FROM Servico;
GO

/*==============================================================
5. ORDER BY
Pergunta: Quais são as ordens mais caras?
==============================================================*/
SELECT
OSID,
ValorTotal,
Status
FROM OrdemServico
ORDER BY ValorTotal DESC;
GO

/*==============================================================
6. GROUP BY
Pergunta: Quantos veículos cada cliente possui?
==============================================================*/
SELECT
ClienteID,
COUNT(*) AS TotalVeiculos
FROM Veiculo
GROUP BY ClienteID;
GO

/*==============================================================
7. HAVING
Pergunta: Quais clientes possuem mais de um veículo?
==============================================================*/
SELECT
ClienteID,
COUNT(*) AS TotalVeiculos
FROM Veiculo
GROUP BY ClienteID
HAVING COUNT(*) > 1;
GO

/*==============================================================
8. INNER JOIN
Pergunta: Qual veículo pertence a cada cliente?
==============================================================*/
SELECT
C.Nome,
V.Placa,
V.Marca,
V.Modelo,
V.Ano
FROM Cliente C
INNER JOIN Veiculo V
ON C.ClienteID = V.ClienteID
ORDER BY C.Nome;
GO

/*==============================================================
9. JOIN entre quatro tabelas
Pergunta: Qual equipe realizou cada ordem de serviço?
==============================================================*/
SELECT
OS.OSID,
C.Nome AS Cliente,
V.Modelo,
E.NomeEquipe,
OS.Status,
OS.ValorTotal
FROM OrdemServico OS
INNER JOIN Veiculo V
ON OS.VeiculoID = V.VeiculoID
INNER JOIN Cliente C
ON V.ClienteID = C.ClienteID
INNER JOIN Equipe E
ON OS.EquipeID = E.EquipeID
ORDER BY OS.OSID;
GO

/*==============================================================
10. Total pago por cliente
==============================================================*/
SELECT
C.Nome,
SUM(P.ValorPago) AS TotalPago
FROM Cliente C
INNER JOIN Veiculo V
ON C.ClienteID = V.ClienteID
INNER JOIN OrdemServico OS
ON V.VeiculoID = OS.VeiculoID
INNER JOIN Pagamento P
ON OS.OSID = P.OSID
GROUP BY C.Nome
ORDER BY TotalPago DESC;
GO

/*==============================================================
11. Serviços mais executados
==============================================================*/
SELECT
S.Descricao,
SUM(OSS.Quantidade) AS QuantidadeExecutada
FROM Servico S
INNER JOIN OS_Servico OSS
ON S.ServicoID = OSS.ServicoID
GROUP BY S.Descricao
ORDER BY QuantidadeExecutada DESC;
GO

/*==============================================================
12. Peças mais utilizadas
==============================================================*/
SELECT
P.Nome,
SUM(OP.Quantidade) AS QuantidadeUtilizada
FROM Peca P
INNER JOIN OS_Peca OP
ON P.PecaID = OP.PecaID
GROUP BY P.Nome
ORDER BY QuantidadeUtilizada DESC;
GO

/*==============================================================
13. Mecânicos por equipe
==============================================================*/
SELECT
E.NomeEquipe,
M.Nome,
M.Especialidade
FROM Equipe E
INNER JOIN Equipe_Mecanico EM
ON E.EquipeID = EM.EquipeID
INNER JOIN Mecanico M
ON EM.MecanicoID = M.MecanicoID
ORDER BY E.NomeEquipe;
GO

/*==============================================================
14. Ordens finalizadas
==============================================================*/
SELECT
OSID,
DataEntrada,
DataSaida,
ValorTotal
FROM OrdemServico
WHERE Status = 'Finalizada';
GO

/*==============================================================
15. Ordens em andamento
==============================================================*/
SELECT
OSID,
DataEntrada,
ValorTotal
FROM OrdemServico
WHERE Status = 'Em Andamento';
GO

/*==============================================================
16. Valor médio das ordens de serviço
==============================================================*/
SELECT
AVG(ValorTotal) AS ValorMedio
FROM OrdemServico;
GO

/*==============================================================
17. Serviço mais caro
==============================================================*/
SELECT TOP 1
Descricao,
Valor
FROM Servico
ORDER BY Valor DESC;
GO

/*==============================================================
18. Quantidade de ordens por status
==============================================================*/
SELECT
Status,
COUNT(*) AS Quantidade
FROM OrdemServico
GROUP BY Status;
GO

/*==============================================================
19. Ordens com múltiplos pagamentos
==============================================================*/
SELECT
OSID,
COUNT(*) AS QuantidadePagamentos,
SUM(ValorPago) AS TotalPago
FROM Pagamento
GROUP BY OSID
HAVING COUNT(*) > 1;
GO

/*==============================================================
20. Consulta envolvendo cinco tabelas
Pergunta: Quais serviços foram realizados em cada ordem?
==============================================================*/
SELECT
OS.OSID,
C.Nome AS Cliente,
V.Modelo,
S.Descricao AS Servico,
OSS.Quantidade,
OS.Status
FROM OrdemServico OS
INNER JOIN Veiculo V
ON OS.VeiculoID = V.VeiculoID
INNER JOIN Cliente C
ON V.ClienteID = C.ClienteID
INNER JOIN OS_Servico OSS
ON OS.OSID = OSS.OSID
INNER JOIN Servico S
ON OSS.ServicoID = S.ServicoID
ORDER BY OS.OSID;
GO

/*==============================================================
21. Consulta envolvendo cinco tabelas
Pergunta: Quais peças foram utilizadas em cada ordem?
==============================================================*/
SELECT
OS.OSID,
C.Nome,
V.Modelo,
P.Nome AS Peca,
OP.Quantidade
FROM OrdemServico OS
INNER JOIN Veiculo V
ON OS.VeiculoID = V.VeiculoID
INNER JOIN Cliente C
ON V.ClienteID = C.ClienteID
INNER JOIN OS_Peca OP
ON OS.OSID = OP.OSID
INNER JOIN Peca P
ON OP.PecaID = P.PecaID
ORDER BY OS.OSID;
GO

/*==============================================================
22. Clientes que gastaram mais de R$ 500
==============================================================*/
SELECT
C.Nome,
SUM(P.ValorPago) AS TotalPago
FROM Cliente C
INNER JOIN Veiculo V
ON C.ClienteID = V.ClienteID
INNER JOIN OrdemServico OS
ON V.VeiculoID = OS.VeiculoID
INNER JOIN Pagamento P
ON OS.OSID = P.OSID
GROUP BY C.Nome
HAVING SUM(P.ValorPago) > 500
ORDER BY TotalPago DESC;
GO

/*==============================================================
23. Estoque de peças
==============================================================*/
SELECT
Nome,
Estoque
FROM Peca
ORDER BY Estoque DESC;
GO

/*==============================================================
24. Quantidade de ordens por equipe
==============================================================*/
SELECT
E.NomeEquipe,
COUNT(*) AS TotalOrdens
FROM OrdemServico OS
INNER JOIN Equipe E
ON OS.EquipeID = E.EquipeID
GROUP BY E.NomeEquipe;
GO

/*==============================================================
25. Valor total arrecadado pela oficina
==============================================================*/
SELECT
SUM(ValorPago) AS TotalArrecadado
FROM Pagamento;
GO
```
