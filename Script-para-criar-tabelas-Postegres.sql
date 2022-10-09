-- Script SQl Basic

--------------------------------------------------------------------------------_
-- CREATE DATABASE IN POSTGRESQL
CREATE DATABASE Ecommerce;
\c Ecommerce;
--------------------------------------------------------------------------------_

-- ------------------------------------------------------------------------------
-- Schema Ecommerce
-- ------------------------------------------------------------------------------
CREATE SCHEMA Ecommerce;
CREATE SCHEMA Cliente; 
CREATE SCHEMA Processos; 
CREATE SCHEMA Vendas;
ALTER SCHEMA Ecommerce OWNER TO wagner;


-- ------------------------------------------------------------------------------
-- Table Tab_Clente
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS Tab_Clente;

CREATE TABLE Tab_Cliente (
  Id_Cliente SERIAL NOT NULL PRIMARY KEY,
  Nome_Cliente VARCHAR(100) NOT NULL,
  CPF NUMERIC(11) NOT NULL UNIQUE,
  Telefone NUMERIC(13) NOT NULL UNIQUE,
  Email VARCHAR(100) NOT NULL UNIQUE,
  Cep NUMERIC(8) NOT NULL,
  Data_Nasc DATE NOT NULL,
  Endereco VARCHAR(200) NOT NULL,
  Numero NUMERIC NOT NULL,
  Cidade VARCHAR(100) NOT NULL,
  Estado VARCHAR(2) CHECK (Estado IN('SP','RJ','MG', 'BA', 'AM', 'PE', 'RS'))
);

-- ------------------------------------------------------------------------------
-- Table Tab_PJCliente
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS Tab_PJCliente ;

CREATE TABLE Tab_PJCliente (
  Id_PJCliente SERIAL NOT NULL PRIMARY KEY,
  Nome_PJCliente VARCHAR(100) NOT NULL,
  Nome_Representante VARCHAR(100) NULL,
  CNPJ NUMERIC(15) NOT NULL UNIQUE,
  Nome_Empresa VARCHAR(100) NOT NULL,
  Email VARCHAR(200) NOT NULL UNIQUE,
  Telefone NUMERIC(13) NOT NULL UNIQUE,
  Endereco VARCHAR(200) NOT NULL,
  Numero NUMERIC(10) NOT NULL,
  Cidade VARCHAR(200) NOT NULL,
  Estado CHAR(2) NOT NULL CHECK (Estado IN('SP','RJ','MG', 'BA', 'AM', 'PE', 'RS')));

-- ------------------------------------------------------------------------------
-- Table Tab_Servico
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS Tab_Servico ;

CREATE TABLE Tab_Servico (
  Id_Servico SERIAL NOT NULL PRIMARY KEY,
  Nome_Servico VARCHAR(45) NOT NULL,
  Categoria VARCHAR(20) NOT NULL,
  Status VARCHAR(20) NOT NULL,
  Endereco VARCHAR(200) NOT NULL,
  Numero NUMERIC(10) NOT NULL,
  Cidade VARCHAR(200) NOT NULL,
  Estado CHAR(45) NOT NULL CHECK (Estado IN('SP','RJ','MG', 'BA', 'AM', 'PE', 'RS')),
  Preco FLOAT NOT NULL,
  Pagamento VARCHAR(50) NOT NULL
);

-- ------------------------------------------------------------------------------
-- Table `Ecommerce`.`Tab_Fornecedor`
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS Tab_Fornecedor ;

CREATE TABLE Tab_Fornecedor (
  Id_Fornecedor SERIAL NOT NULL PRIMARY KEY,
  Nome_Fornecedor VARCHAR(100) NOT NULL,
  Email VARCHAR(200) NOT NULL unique,
  CNJP NUMERIC(15) NULL UNIQUE,
  CPF NUMERIC(11) NULL UNIQUE,
  Telefone NUMERIC(13) NULL UNIQUE,
  Site VARCHAR(100) NULL UNIQUE,
  Nome_Produto VARCHAR(100) NULL,
  Quantidade NUMERIC(1000) NULL,
  Preco_varejo FLOAT NULL);

-- ------------------------------------------------------------------------------
-- Table Tab_Produto
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS Tab_Produto ;

CREATE TABLE Tab_Produto (
  Id_Produto SERIAL NOT NULL PRIMARY KEY,
  Nome_Produto VARCHAR(100) NOT NULL,
  Marca VARCHAR(50) NULL,
  Data_estoque DATE NOT NULL,
  Id_Fornecedor SERIAL NOT NULL,
  Nome_Fornecedor VARCHAR(100) NOT NULL,
  Categoria VARCHAR(50) NOT NULL,
  Descricao VARCHAR(200) NULL,
  Preco FLOAT NOT NULL,
   CONSTRAINT FK_Fornecedor FOREIGN KEY(Id_Fornecedor) REFERENCES Tab_Fornecedor(Id_Fornecedor));

-- ------------------------------------------------------------------------------
-- Table `Ecommerce`.`Tab_Pedido`
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab_Pedido` ;

CREATE TABLE Tab_Pedido (
  Id_Pedido SERIAL NOT NULL PRIMARY KEY,
  Nome_Pedido VARCHAR(200) NOT NULL,
  Categoria VARCHAR(50) NULL,
  Quantidade NUMERIC NOT NULL,
  Status VARCHAR(50) NOT NULL,
  Descricao VARCHAR(200) NULL,
  Freete VARCHAR(45) NULL,
  Data DATE NOT NULL,
  Id_Venda SERIAL NOT NULL,
  Id_PJCliente SERIAL NOT NULL,
  Id_Cliente SERIAL NOT NULL,
   CONSTRAINT FK_Cliente2 FOREIGN KEY(Id_Cliente) REFERENCES Tab_Cliente(Id_Cliente),
   CONSTRAINT FK_PJCliente2 FOREIGN KEY(Id_PJCliente) REFERENCES Tab_PJCliente(Id_PJCliente));


-- ------------------------------------------------------------------------------
-- Table Tab_Estoque
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS Tab_Estoque ;

CREATE TABLE Tab_Estoque (
  Id_Estoque SERIAL NOT NULL PRIMARY KEY,
  Id_Fornecedor SERIAL NOT NULL,
  Id_Produto SERIAL NOT NULL,
  Cod_Produto SERIAL NOT NULL,
  Nome_Produto VARCHAR(100) NOT NULL,
  Marca VARCHAR(50) NOT NULL,
  Data DATE NOT NULL,
  Status VARCHAR(50) NULL,
  Setor VARCHAR(50) NULL,
  Nome_Fornecedor VARCHAR(100) NOT NULL,
   CONSTRAINT FK_Fornecedor3 FOREIGN KEY(Id_Fornecedor) REFERENCES Tab_Fornecedor(Id_Fornecedor),
   CONSTRAINT FK_Produto3 FOREIGN KEY(Id_Produto) REFERENCES Tab_Produto(Id_Produto));

-- ------------------------------------------------------------------------------
-- Table Tab_Venda
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS Tab_Venda;

CREATE TABLE Tab_Venda (
  Id_Venda SERIAL PRIMARY KEY,
  Id_Servico SERIAL NOT NULL,
  Id_Produto SERIAL NOT NULL,
  Id_Pedido SERIAL NOT NULL,
  Preco FLOAT NULL,
  Pagamento VARCHAR(50) NULL,
  Dia_entrega DATE NULL,
  Dia_Saida DATE NULL,
  Parcelamento NUMERIC(2) NULL,
  CPF NUMERIC(11) NULL,
  CNPJ NUMERIC(15) NULL,
  CONSTRAINT FK_Servico3 FOREIGN KEY(Id_Servico) REFERENCES Tab_Servico(Id_Servico),
  CONSTRAINT FK_Produto3 FOREIGN KEY(Id_Produto) REFERENCES Tab_Produto(Id_Produto),
  CONSTRAINT FK_Pedido2 FOREIGN KEY(Id_Pedido) REFERENCES Tab_Pedido(Id_Pedido));

----------------------------------------------------------------------------------
-- ALTER TABLE
----------------------------------------------------------------------------------
  ALTER TABLE Tab_Venda ADD CONSTRAINT FK_Venda2 FOREIGN KEY(Id_Venda) REFERENCES Tab_Venda(Id_Venda);

----------------------------------------------------------------------------------
--Create and Manipulation of Table Space
----------------------------------------------------------------------------------

-- use comand in Linux Fedora on Root
-- chown postgres /opt/db/lojavirtual

CREATE TABLESPACE LojaVirtual LOCATION '/opt/db/lojavirtual';
ALTER DATABASE ecommerce SET TABLESPACE LojaVirtual;
ALTER TABLE Tab_Cliente SET TABLESPACE LojaVirtual;
ALTER TABLE Tab_Servico SET TABLESPACE LojaVirtual;
ALTER TABLE Tab_PJ_Cliente SET TABLESPACE LojaVirtual;
ALTER TABLE Tab_Pedido SET TABLESPACE LojaVirtual;
ALTER TABLE Tab_Produto SET TABLESPACE LojaVirtual;
ALTER TABLE Tab_Venda SET TABLESPACE LojaVirtual;
ALTER TABLE Tab_Fornecedor SET TABLESPACE LojaVirtual;
ALTER TABLE Tab_Estoque SET TABLESPACE LojaVirtual;

ALTER TABLESPACE pg_default MOVE ALL TO LojaVirtual;



