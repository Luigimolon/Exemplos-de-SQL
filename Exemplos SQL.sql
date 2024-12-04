USE exemplos;

-- 1. Nome do aluno:
-- Luigi Molon

-- 2. Criação do banco de dados e das tabelas
CREATE DATABASE Livraria;
USE Livraria;

CREATE TABLE Cliente (
  idCliente INT AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  Endereco VARCHAR(100),
  PRIMARY KEY (idCliente)
);

CREATE TABLE Produto (
  idProduto INT AUTO_INCREMENT,
  Nome VARCHAR(100),
  Titulo VARCHAR(100),
  PRIMARY KEY (idProduto)
);

CREATE TABLE Funcionario (
  idFuncionario INT AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  Cargo VARCHAR(45),
  Salario DECIMAL(10, 2) NOT NULL,
  Telefone VARCHAR(15),
  Data_de_admissao DATE,
  PRIMARY KEY (idFuncionario)
);

CREATE TABLE Venda (
  idVenda INT AUTO_INCREMENT,
  idItem INT,
  idFormapagto INT,
  Data_de_Venda DATE,
  Valor_Total DECIMAL(9,2),
  PRIMARY KEY (idVenda)
);

CREATE TABLE Unidade (
  idUnidade INT AUTO_INCREMENT,
  Descricao VARCHAR(100),
  PRIMARY KEY (idUnidade)
);

-- 3. Inserção de no mínimo 5 registros em cada tabela

INSERT INTO Cliente (Nome, Endereco) VALUES
('Carlos Silva', 'Rua A, 123'),
('Joana Souza', 'Rua B, 456'),
('Marcos Lima', 'Rua C, 789'),
('Ana Moura', 'Rua D, 101'),
('Julia Farias', 'Rua E, 202');

INSERT INTO Produto (Nome, Titulo) VALUES
('Livro A', 'Título A'),
('Livro B', 'Título B'),
('Livro C', 'Título C'),
('Livro D', 'Título D'),
('Livro E', 'Título E');

INSERT INTO Funcionario (Nome, Cargo, Salario, Telefone, Data_de_admissao) VALUES
('Pedro Silva', 'Gerente', 3500.00, '1111-2222', '2023-01-01'),
('Paula Oliveira', 'Caixa', 2500.00, '2222-3333', '2023-02-01'),
('Lucas Pereira', 'Assistente', 2000.00, '3333-4444', '2023-03-01'),
('Marta Lima', 'Supervisor', 3000.00, '4444-5555', '2023-04-01'),
('Bruno Cardoso', 'Estagiário', 1500.00, '5555-6666', '2023-05-01');

INSERT INTO Venda (idItem, idFormapagto, Data_de_Venda, Valor_Total) VALUES
(1, 1, '2023-06-01', 100.00),
(2, 2, '2023-06-02', 150.00),
(3, 1, '2023-06-03', 200.00),
(4, 2, '2023-06-04', 250.00),
(5, 1, '2023-06-05', 300.00);

INSERT INTO Unidade (Descricao) VALUES
('Unidade Centro'),
('Unidade Sul'),
('Unidade Norte'),
('Unidade Leste'),
('Unidade Oeste');

-- 4. Alteração de registro em cada tabela

UPDATE Cliente SET Endereco = 'Rua Z, 999' WHERE idCliente = 1;
UPDATE Produto SET Titulo = 'Título Alterado' WHERE idProduto = 1;
UPDATE Funcionario SET Salario = 3600.00 WHERE idFuncionario = 1;
UPDATE Venda SET Valor_Total = 110.00 WHERE idVenda = 1;
UPDATE Unidade SET Descricao = 'Unidade Central' WHERE idUnidade = 1;

-- 5. Exclusão de um registro em cada tabela

DELETE FROM Cliente WHERE idCliente = 5;
DELETE FROM Produto WHERE idProduto = 5;
DELETE FROM Funcionario WHERE idFuncionario = 5;
DELETE FROM Venda WHERE idVenda = 5;
DELETE FROM Unidade WHERE idUnidade = 5;

-- 6. Alteração na estrutura de uma das tabelas
ALTER TABLE Produto ADD Preco DECIMAL(8, 2);

-- 7. Conversão de dados (adicionando preços aos produtos)
UPDATE Produto SET Preco = 29.90 WHERE idProduto = 1;
UPDATE Produto SET Preco = 39.90 WHERE idProduto = 2;
UPDATE Produto SET Preco = 49.90 WHERE idProduto = 3;
UPDATE Produto SET Preco = 59.90 WHERE idProduto = 4;

-- 8. Consultas envolvendo apenas uma tabela

-- Consulta 1: Selecionar todos os clientes
SELECT * FROM Cliente;

-- Consulta 2: Selecionar produtos com preço maior que 30
SELECT * FROM Produto WHERE Preco > 30;

-- Consulta 3: Selecionar funcionários com salário acima de 3000
SELECT * FROM Funcionario WHERE Salario > 3000;

-- Consulta 4: Selecionar vendas feitas após uma data específica
SELECT * FROM Venda WHERE Data_de_Venda > '2023-06-01';

-- Consulta 5: Selecionar unidades com descrição contendo 'Centro'
SELECT * FROM Unidade WHERE Descricao LIKE '%Centro%';

-- 9. Consultas envolvendo no mínimo duas tabelas

-- Consulta 1: Listar vendas com detalhes do produto
SELECT Venda.idVenda, Produto.Nome, Produto.Titulo, Venda.Valor_Total
FROM Venda
JOIN Produto ON Venda.idItem = Produto.idProduto;

-- Consulta 2: Listar funcionários e a unidade onde trabalham (assumindo um campo Unidade_id no Funcionario)
-- ALTER TABLE Funcionario ADD Unidade_id INT; -- adiciona campo Unidade_id
-- UPDATE Funcionario SET Unidade_id = 1 WHERE idFuncionario = 1; -- exemplo
SELECT Funcionario.Nome, Unidade.Descricao
FROM Funcionario
JOIN Unidade ON Funcionario.Unidade_id = Unidade.idUnidade;

-- Consulta 3: Listar vendas com dados de clientes (assumindo um campo idCliente em Venda)
-- ALTER TABLE Venda ADD idCliente INT; -- adiciona campo idCliente
-- UPDATE Venda SET idCliente = 1 WHERE idVenda = 1; -- exemplo
SELECT Venda.idVenda, Cliente.Nome, Venda.Valor_Total
FROM Venda
JOIN Cliente ON Venda.idCliente = Cliente.idCliente;

-- Consulta 4: Exibir funcionários e suas vendas (assumindo campo idFuncionario em Venda)
-- ALTER TABLE Venda ADD idFuncionario INT; -- adiciona campo idFuncionario
-- UPDATE Venda SET idFuncionario = 1 WHERE idVenda = 1; -- exemplo
SELECT Funcionario.Nome, Venda.Valor_Total
FROM Funcionario
JOIN Venda ON Venda.idFuncionario = Funcionario.idFuncionario;

-- Consulta 5: Listar produtos com suas unidades
SELECT Produto.Nome, Unidade.Descricao
FROM Produto
JOIN Unidade ON Produto.idProduto = Unidade.idUnidade;

-- 10. Criação de uma função
DELIMITER //
CREATE FUNCTION CalcularDesconto(preco DECIMAL(8, 2), desconto DECIMAL(5, 2))
RETURNS DECIMAL(8, 2)
DETERMINISTIC
BEGIN
  RETURN preco - (preco * desconto / 100);
END //
DELIMITER ;

-- 11. Criação e execução de uma procedure
DELIMITER //
CREATE PROCEDURE AdicionarCliente(nome VARCHAR(45), endereco VARCHAR(100))
BEGIN
  INSERT INTO Cliente (Nome, Endereco) VALUES (nome, endereco);
END //
DELIMITER ;
CALL AdicionarCliente('José Almeida', 'Rua F, 303');

-- 12. Criação de um gatilho
DELIMITER //
CREATE TRIGGER AtualizarEstoqueVenda AFTER INSERT ON Venda
FOR EACH ROW
BEGIN
  UPDATE Produto SET Quantidade = Quantidade - 1 WHERE idProduto = NEW.idItem;
END //
DELIMITER ;

-- 13. Deleção das tabelas e do banco de dados
DROP TABLE IF EXISTS Cliente, Produto, Funcionario, Venda, Unidade;
DROP DATABASE IF EXISTS Livraria;

