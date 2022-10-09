-- Script SQl Basic

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

--------------------------------------------------------
-- CREATE DATABASE IN POSTGRESQL
CREATE DATABASE Ecommerce;
\c Ecommerce;
--------------------------------------------------------

-- -----------------------------------------------------
-- Schema Ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS 'Ecommerce' DEFAULT CHARACTER SET utf8 ;
USE 'Ecommerce' ;

-- -----------------------------------------------------
-- Table `Ecommerce`.`Tab-Clente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab-Clente` ;

CREATE TABLE IF NOT EXISTS `Ecommerce`.`Tab-Clente` (
  Id-Cliente INT NOT NULL,
  Nome-Cliente VARCHAR(100) NOT NULL,
  CPF INT(11) NOT NULL,
  Telefone INT(13) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  Cep VARCHAR(8) NOT NULL,
  Data-Nasc DATE NOT NULL,
  Endereco VARCHAR(200) NOT NULL,
  Numero INT NOT NULL,
  Cidade VARCHAR(100) NOT NULL,
  Estado VARCHAR(2) NOT NULL CHECK (Estado IN('SP','RJ','MG', 'BA', 'AM', 'PE', 'RS')),
  PRIMARY KEY (`Id-Cliente`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `CPF_UNIQUE` ON `Ecommerce`.`Tab-Clente` (`CPF` ASC) VISIBLE;
CREATE UNIQUE INDEX `Telefone_UNIQUE` ON `Ecommerce`.`Tab-Clente` (`Telefone` ASC) VISIBLE;
CREATE UNIQUE INDEX `Email_UNIQUE` ON `Ecommerce`.`Tab-Clente` (`Email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Tab-PJ-Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab-PJ-Cliente` ;

CREATE TABLE IF NOT EXISTS `Ecommerce`.`Tab-PJ-Cliente` (
  Id-PJCliente INT NOT NULL,
  Nome-PJCliente VARCHAR(100) NOT NULL,
  Nome-Representante VARCHAR(100) NULL,
  CNPJ INT(15) NOT NULL,
  Nome-Empresa VARCHAR(100) NOT NULL,
  Email VARCHAR(200) NOT NULL,
  Telefone INT(13) NOT NULL,
  Endereco VARCHAR(200) NOT NULL,
  Numero INT(10) NOT NULL,
  Cidade VARCHAR(200) NOT NULL,
  Estado VARCHAR(2) NOT NULL CHECK (Estado IN('SP','RJ','MG', 'BA', 'AM', 'PE', 'RS')),
  PRIMARY KEY (`Id-PJCliente`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Email_UNIQUE` ON `Ecommerce`.`Tab-PJ-Cliente` (`Email` ASC) VISIBLE;
CREATE UNIQUE INDEX `Telefone_UNIQUE` ON `Ecommerce`.`Tab-PJ-Cliente` (`Telefone` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `Ecommerce`.`Tab-Servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab-Servico` ;

CREATE TABLE IF NOT EXISTS `Ecommerce`.`Tab-Servico` (
  Id-Servico INT NOT NULL,
  Nome-Servico VARCHAR(45) NOT NULL,
  Categoria VARCHAR(20) NOT NULL,
  Status VARCHAR(20) NOT NULL,
  Endereco VARCHAR(200) NOT NULL,
  Numero INT(10) NOT NULL,
  Cidade VARCHAR(200) NOT NULL,
  Estado VARCHAR(45) NOT NULL CHECK (Estado IN('SP','RJ','MG', 'BA', 'AM', 'PE', 'RS')),
  Preco DOUBLE NOT NULL,
  Pagamento VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id_Servico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Tab-Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab-Pedido` ;

CREATE TABLE IF NOT EXISTS `Ecommerce`.`Tab-Pedido` (
  Id-Pedido INT NOT NULL,
  Nome-Pedido VARCHAR(200) NOT NULL,
  Categoria VARCHAR(50) NULL,
  Quantidade INT NOT NULL,
  Status VARCHAR(50) NOT NULL,
  Descricao VARCHAR(200) NULL,
  Freete VARCHAR(45) NULL,
  Data DATE NOT NULL,
  Id-Venda INT NOT NULL,
  Id-PJCliente INT NOT NULL,
  Id-Cliente INT NOT NULL,
   PRIMARY KEY (`Id-Pedido`)
   CONSTRAINT FK_Cliente FOREIGN KEY(Id-Cliente) REFERENCES Tab-Clente(Id-Cliente),
   CONSTRAINT FK_PJCliente FOREIGN KEY(Id-PJCliente) REFERENCES Tab-Clente(ID-PJCliente),
   CONSTRAINT FK_Venda FOREIGN KEY(Id-Venda) REFERENCES Tab-Venda(Id-Venda))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Tab-Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab-Produto` ;

CREATE TABLE IF NOT EXISTS `Ecommerce`.`Tab-Produto` (
  Id-Produto INT NOT NULL,
  Nome-Produto VARCHAR(100) NOT NULL,
  Marca VARCHAR(50) NULL,
  Data-estoque DATE NOT NULL,
  Id-Fornecedor INT NOT NULL,
  Nome-Fornecedor VARCHAR(100) NOT NULL,
  Categoria VARCHAR(50) NOT NULL,
  Descricao VARCHAR(200) NULL,
  Preco DOUBLE NOT NULL,
  PRIMARY KEY (`Id-Produto`))
   CONSTRAINT FK_Fornecedor FOREIGN KEY(Id-Fornecedor) REFERENCES Tab-Fornecedor(Id-Fornecedor))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Tab-Venda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab-Venda` ;

CREATE TABLE IF NOT EXISTS `Ecommerce`.`Tab-Venda` (
  Id-Venda INT NULL,
  Id-Servico INT NOT NULL,
  Id-Produto INT NOT NULL,
  Id-Pedido INT NOT NULL,
  Preco DOUBLE NULL,
  Pagamento VARCHAR(50) NULL,
  Dia-entrega DATE NULL,
  Dia-Saida DATE NULL,
  Parcelamento INT(2) NULL,
  CPF INT(11) NULL,
  CNPJ INT(15) NULL,
  PRIMARY KEY (`Id-Venda`))
  CONSTRAINT FK_Servico FOREIGN KEY(Id-Servico) REFERENCES Tab-Servico(Id-Servico),
  CONSTRAINT FK_Produto FOREIGN KEY(Id-Produto) REFERENCES Tab-Produto(Id-Produto),
  CONSTRAINT FK_Pedido FOREIGN KEY(Id-Pedido) REFERENCES Tab-Pedido(Id-Pedido))

ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Tab-Fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab-Fornecedor` ;

CREATE TABLE IF NOT EXISTS `Ecommerce`.`Tab-Fornecedor` (
  Id-Fornecedor INT NOT NULL,
  Nome-Fornecedor VARCHAR(100) NOT NULL,
  Email VARCHAR(200) NOT NULL unique,
  CNJP INT(15) NULL,
  CPF INT(11) NULL,
  Telefone INT(13) NULL,
  Site VARCHAR(100) NULL,
  Nome-Produto VARCHAR(100) NULL,
  Quantidade INT NULL,
  Preco-varejo DOUBLE NULL,
  PRIMARY KEY (`Id-Fornecedor`))
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Tab-Estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ecommerce`.`Tab-Estoque` ;

CREATE TABLE IF NOT EXISTS `Ecommerce`.`Tab-Estoque` (
  Id-Estoque INT NOT NULL,
  Id-Fornecedor INT NOT NULL,
  Id-Produto INT NOT NULL,
  Cod-Produto INT NOT NULL,
  Nome-Produto VARCHAR(100) NOT NULL,
  Marca VARCHAR(50) NOT NULL,
  Data DATE NOT NULL,
  Status VARCHAR(50) NULL,
  Setor VARCHAR(50) NULL,
  Nome-Fornecedor VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id-Estoque`),
   CONSTRAINT FK_Fornecedor FOREIGN KEY(Id-Fornecedor) REFERENCES Tab-Fornecedor(Id-Fornecedor),
   CONSTRAINT FK_Produto FOREIGN KEY(Id-Produto) REFERENCES Tab-Produto(Id-Produto))
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

