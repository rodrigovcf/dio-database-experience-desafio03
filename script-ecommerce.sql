-- Banco de Dados: E-commerce
create database ecommerce;
use ecommerce;

-- Criar tabelas

-- Tabela Cliente / Cliente_PF / Cliente_PJ

CREATE TABLE IF NOT EXISTS `ecommerce`.`Cliente` (
  `idCliente` INT AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Identificação` VARCHAR(45) NULL,
  `CPF` CHAR(11) NOT NULL,
  `endereço` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  CONSTRAINT unique_cpf_cliente UNIQUE (CPF)
);

-- CREATE TABLE IF NOT EXISTS `ecommerce`.`Cliente_PF` (
--   `idCliente_PF` INT NOT NULL AUTO_INCREMENT,
--   `CPF` INT(11) NOT NULL,
--   `RG` VARCHAR(15) NOT NULL,
--   `Data_Nascimento` DATE NULL,
--   PRIMARY KEY (`idCliente_PF`),
--   UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC),
--   UNIQUE INDEX `RG_UNIQUE` (`RG` ASC)
-- );
-- 
-- CREATE TABLE IF NOT EXISTS `ecommerce`.`Cliente_PJ` (
--   `idCliente_PJ` INT NOT NULL AUTO_INCREMENT,
--   `CNPJ` INT(15) NOT NULL,
--   `Razão_Social` VARCHAR(80) NOT NULL,
--   `IE` INT(15) NULL,
--   `IM` INT(15) NULL,
--   PRIMARY KEY (`idCliente_PJ`),
--   UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC),
--   UNIQUE INDEX `Razão_Social_UNIQUE` (`Razão_Social` ASC)
-- );



-- Tabela Produto

CREATE TABLE IF NOT EXISTS `ecommerce`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Descrição` VARCHAR(45) NOT NULL,
  `Categoria` ENUM('Eletronico', 'Vestimenta','Brinquedos','Alimentos','Moveis') NOT NULL,
  `Avaliacao` FLOAT DEFAULT 0,
  `Tamanho` VARCHAR(10),
  PRIMARY KEY (`idProduto`)
);

-- Tabela Pedido

CREATE TABLE IF NOT EXISTS `ecommerce`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` INT,
  `StatusdoPedido` ENUM('Cancelado', 'Confirmado','Brinquedos','Em processamento') DEFAULT 'Em processamento',
  `Descrição_Pedido` VARCHAR(255) NULL,
  `Frete` FLOAT DEFAULT 10,
  `Pago` BOOLEAN DEFAULT FALSE, 
  PRIMARY KEY (`idPedido`),
  CONSTRAINT fk_Pedido_Cliente
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `ecommerce`.`Cliente` (`idCliente`)
	ON UPDATE CASCADE    
);


CREATE TABLE IF NOT EXISTS `ecommerce`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `Tipo_PG` ENUM('Boleto','Cartao','Pix') NOT NULL,
  `Limite` FLOAT,
  PRIMARY KEY (`idPagamento`, `idCliente`)
);

CREATE TABLE IF NOT EXISTS `ecommerce`.`Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Local` VARCHAR(45) NOT NULL,
  `Quantidade` INT DEFAULT 0,
  PRIMARY KEY (`idEstoque`)
);


-- Tabela Fornecedor
CREATE TABLE IF NOT EXISTS `ecommerce`.`Fornecedor` (
  `idFornecedor` INT AUTO_INCREMENT,
  `RazãoSocial` VARCHAR(45) NOT NULL,
  `CNPJ` CHAR(15) NOT NULL,
  `Contato` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC)
);

-- Tabela Vendedor

CREATE TABLE IF NOT EXISTS `ecommerce`.`Terceiro_Vendedor` (
  `idTerceiro_Vendedor` INT NOT NULL AUTO_INCREMENT,
  `RazãoSocial` VARCHAR(45) NOT NULL,
  `Local` VARCHAR(45),
  `NomeFantasia` VARCHAR(45),
  `CNPJ` CHAR(15) NOT NULL,
  `CPF` CHAR(9) NOT NULL,
  PRIMARY KEY (`idTerceiro_Vendedor`),
  UNIQUE INDEX `RazãoSocial_UNIQUE` (`RazãoSocial` ASC),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC)
);

CREATE TABLE IF NOT EXISTS `ecommerce`.`Produtos_Vendedor (terceiro)` (
  `idPVendedor` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `prodQuantidade` INT DEFAULT 1,
  PRIMARY KEY (`idPVendedor`, `idProduto`),
  INDEX `fk_Terceiro_Vendedor_has_Produto_Produto1_idx` (`idProduto` ASC),
  INDEX `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1_idx` (`idPVendedor` ASC),
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1`
    FOREIGN KEY (`idPVendedor`)
    REFERENCES `ecommerce`.`Terceiro_Vendedor` (`idTerceiro_Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `ecommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `ecommerce`.`Produto_Pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  `Status` ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC),
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC),
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `ecommerce`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `ecommerce`.`Produto_em_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `UF` CHAR(2),
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC),
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC),
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `ecommerce`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `ecommerce`.`Produto_Fornecedor` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC),
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC),
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `ecommerce`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

show tables;
