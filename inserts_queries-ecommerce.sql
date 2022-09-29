-- Inserindo Clientes
INSERT INTO Cliente (Nome, Identificação, CPF, endereço) 
	VALUES ('Maria', 'M', 12345678901, 'Rua Silva da prata 29, Sto Antonio - Mossoro'), 
		   ('Pedro', 'P', 66655544321, 'Rua Sao Jose 139, Centro - Mossoro'),
           ('Jose', 'J', 33344455511, 'Rua do Prado 23, Liberdade - Mossoro'),
           ('Rosa', 'R', 98765432111, 'Rua Augusto dos Anjos 45, Jatoba - Patos'),
           ('Isabela', 'I', 54679843457, 'Rua Alberto Maranhao 27, Maternidade - Patos'),
           ('Rafael', 'R', 43223454367, 'Rua Antonio Vieira 234, Sto Antonio - Patos');
           

SELECT * FROM Cliente;

-- Inserindo Produtos
INSERT INTO Produto (Descrição, Categoria, Avaliacao, Tamanho) 
	VALUES ('Fone de Ouvido', 'Eletronico', 4, null), 
		   ('Barbie', 'Brinquedos', 3, null), 
           ('PS4', 'Eletronico', 5, null), 
		   ('Body Carters', 'Vestimenta', 5, null), 
           ('Microfone', 'Eletronico', 4, null), 
           ('Pippos', 'Alimentos', 4, null), 
           ('Mesa de Pinus', 'Moveis', 5, null);
           
SELECT * FROM Produto;

-- Inserindo Pedidos
INSERT INTO Pedido (Cliente_idCliente, StatusdoPedido, Descrição_Pedido, Frete, Pago) 
	VALUES (1, default, 'compra via aplicativo', null, 1), 
		   (2, default, 'compra via aplicativo', 50, 0),
           (3, 'Confirmado', null, null, 1),
		   (4, default, 'compra via web site', 150, 0);
           
SELECT * FROM Pedido;

INSERT INTO Produto_Pedido (Produto_idProduto,Pedido_idPedido,Quantidade,Status) 
	VALUES (1,1,2,null),
		   (2,1,1,null),
           (3,2,1,null);

INSERT INTO Estoque (Local, Quantidade) 
	VALUES ('Rio de Janeiro', 1000),
		   ('Rio de Janeiro', 500),
           ('Sao Paulo', 10),
           ('Sao Paulo', 100),
           ('Sao Paulo', 10),
           ('Fortaleza', 60);
           
INSERT INTO Produto_em_Estoque (Produto_idProduto, Estoque_idEstoque,UF)
	VALUES (1,2,'RJ'),
		   (2,6,'CE');
           
-- Inserindo Fornecedores
INSERT INTO Fornecedor (RazãoSocial,CNPJ,Contato)
    VALUES ('Almeida & Filhos',123456789123456,'84999900123'),
		   ('Eletronicos Silva',912345612345678,'84999903213'),
           ('Eletronicos Xtech',521344562145874,'84999903213');
           
INSERT INTO Produto_Fornecedor (Fornecedor_idFornecedor,Produto_idProduto,Quantidade)
    VALUES (1,1,500),
		   (1,2,400);
           
SELECT * FROM Fornecedor;


-- Algumas consultas
SELECT count(*) FROM Cliente;
SELECT * FROM Cliente c, Pedido p WHERE c.idCliente = p.Cliente_idCliente;
SELECT Nome,Identificação,idPedido,StatusdoPedido FROM Cliente c, Pedido p WHERE c.idCliente = idPedido;
SELECT concat(Nome,' ',Identificação) AS Cliente,idPedido AS Pedido,StatusdoPedido FROM Cliente c, Pedido p WHERE c.idCliente = idPedido;

INSERT INTO Pedido (Cliente_idCliente, StatusdoPedido, Descrição_Pedido, Frete, Pago) 
	VALUES (2, default, 'compra via aplicativo', null, 1);

SELECT * FROM Cliente c, Pedido p 
	WHERE c.idCliente = p.Cliente_idCliente
    GROUP BY p.idPedido;

SELECT * FROM Cliente c, Pedido p 
	WHERE c.idCliente = p.Cliente_idCliente
    ORDER BY c.Nome;
    
SELECT count(*) from Cliente c, Pedido p 
	WHERE c.idCliente = p.Cliente_idCliente
    ORDER BY c.Nome;

SELECT * FROM Cliente INNER JOIN Pedido ON  
		idCliente = Cliente_idCliente;
