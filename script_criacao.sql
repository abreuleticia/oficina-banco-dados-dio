/*==============================================================
  PROJETO: Oficina Mecânica
  AUTOR: Letícia Carvalho
  DESCRIÇÃO: Script de criação do banco de dados
==============================================================*/

-- Criação do banco de dados
CREATE DATABASE OficinaDB;
GO

USE OficinaDB;
GO

/*==============================================================
  TABELA: CLIENTE
==============================================================*/
CREATE TABLE Cliente (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Telefone VARCHAR(20),
    Email VARCHAR(100)
);

GO

/*==============================================================
  TABELA: VEÍCULO
==============================================================*/
CREATE TABLE Veiculo (
    VeiculoID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    Placa VARCHAR(10) NOT NULL UNIQUE,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Ano INT NOT NULL,

    CONSTRAINT FK_Veiculo_Cliente
        FOREIGN KEY (ClienteID)
        REFERENCES Cliente(ClienteID)
);

GO

/*==============================================================
  TABELA: MECÂNICO
==============================================================*/
CREATE TABLE Mecanico (
    MecanicoID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Especialidade VARCHAR(100),
    Telefone VARCHAR(20)
);

GO

/*==============================================================
  TABELA: EQUIPE
==============================================================*/
CREATE TABLE Equipe (
    EquipeID INT IDENTITY(1,1) PRIMARY KEY,
    NomeEquipe VARCHAR(100) NOT NULL
);

GO

/*==============================================================
  TABELA: EQUIPE_MECANICO
==============================================================*/
CREATE TABLE Equipe_Mecanico (
    EquipeID INT NOT NULL,
    MecanicoID INT NOT NULL,

    CONSTRAINT PK_Equipe_Mecanico
        PRIMARY KEY (EquipeID, MecanicoID),

    CONSTRAINT FK_EquipeMecanico_Equipe
        FOREIGN KEY (EquipeID)
        REFERENCES Equipe(EquipeID),

    CONSTRAINT FK_EquipeMecanico_Mecanico
        FOREIGN KEY (MecanicoID)
        REFERENCES Mecanico(MecanicoID)
);

GO

/*==============================================================
  TABELA: SERVIÇO
==============================================================*/
CREATE TABLE Servico (
    ServicoID INT IDENTITY(1,1) PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL
);

GO

/*==============================================================
  TABELA: PEÇA
==============================================================*/
CREATE TABLE Peca (
    PecaID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Estoque INT NOT NULL
);

GO

/*==============================================================
  TABELA: ORDEM DE SERVIÇO
==============================================================*/
CREATE TABLE OrdemServico (
    OSID INT IDENTITY(1,1) PRIMARY KEY,
    VeiculoID INT NOT NULL,
    EquipeID INT NOT NULL,

    DataEntrada DATE NOT NULL,
    DataSaida DATE NULL,

    Status VARCHAR(30) NOT NULL,

    ValorTotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_OS_Veiculo
        FOREIGN KEY (VeiculoID)
        REFERENCES Veiculo(VeiculoID),

    CONSTRAINT FK_OS_Equipe
        FOREIGN KEY (EquipeID)
        REFERENCES Equipe(EquipeID)
);

GO

/*==============================================================
  TABELA: OS_SERVICO
==============================================================*/
CREATE TABLE OS_Servico (
    OSID INT NOT NULL,
    ServicoID INT NOT NULL,
    Quantidade INT NOT NULL DEFAULT 1,

    CONSTRAINT PK_OS_Servico
        PRIMARY KEY (OSID, ServicoID),

    CONSTRAINT FK_OSServico_OS
        FOREIGN KEY (OSID)
        REFERENCES OrdemServico(OSID),

    CONSTRAINT FK_OSServico_Servico
        FOREIGN KEY (ServicoID)
        REFERENCES Servico(ServicoID)
);

GO

/*==============================================================
  TABELA: OS_PECA
==============================================================*/
CREATE TABLE OS_Peca (
    OSID INT NOT NULL,
    PecaID INT NOT NULL,
    Quantidade INT NOT NULL DEFAULT 1,

    CONSTRAINT PK_OS_Peca
        PRIMARY KEY (OSID, PecaID),

    CONSTRAINT FK_OSPeca_OS
        FOREIGN KEY (OSID)
        REFERENCES OrdemServico(OSID),

    CONSTRAINT FK_OSPeca_Peca
        FOREIGN KEY (PecaID)
        REFERENCES Peca(PecaID)
);

GO

/*==============================================================
  TABELA: PAGAMENTO
==============================================================*/
CREATE TABLE Pagamento (
    PagamentoID INT IDENTITY(1,1) PRIMARY KEY,

    OSID INT NOT NULL,

    FormaPagamento VARCHAR(30) NOT NULL,

    ValorPago DECIMAL(10,2) NOT NULL,

    DataPagamento DATE NOT NULL,

    CONSTRAINT FK_Pagamento_OS
        FOREIGN KEY (OSID)
        REFERENCES OrdemServico(OSID)
);

GO

/*==============================================================
  FIM DO SCRIPT
==============================================================*/

PRINT 'Banco de dados OficinaDB criado com sucesso!';