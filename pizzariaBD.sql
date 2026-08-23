CREATE DATABASE PIZZARIA

USE PIZZARIA

CREATE TABLE tb_estado(
		uf					CHAR(2) PRIMARY KEY,
		nome_estado			VARCHAR(50) NOT NULL
);

CREATE TABLE tb_cidade(
		id_cidade			INT IDENTITY PRIMARY KEY,
		nome_cidade			VARCHAR (50) NOT NULL,
		id_estado_fk		CHAR(2)
		FOREIGN KEY (id_estado_fk)   REFERENCES  tb_estado(uf) 
);

CREATE TABLE tb_bairro(
		id_bairro			INT IDENTITY PRIMARY KEY,
		nome_bairro			VARCHAR(50),
		id_cidade_fk		INT,
		FOREIGN KEY (id_cidade_fk)   REFERENCES  tb_cidade(id_cidade) 

)

CREATE TABLE tb_endereco (
		cep					CHAR (8) PRIMARY KEY,
		logradouro			VARCHAR (50) NOT NULL,
		id_bairro_fk		INT,
		FOREIGN KEY (Id_bairro_fk)   REFERENCES  tb_bairro(id_bairro)
);

CREATE TABLE tb_fornecedo(
		id_fornecedor		INT IDENTITY PRIMARY KEY,
		cnpj_fornecedor		CHAR(14) UNIQUE  NOT NULL ,
		nome_fornecedor		VARCHAR(50) UNIQUE NOT NULL,
		email				VARCHAR(50) NOT NULL, 
		numero				VARCHAR(50) ,
		complemento			VARCHAR(50) ,
		cep_fornecedor_fk	CHAR(8)
		FOREIGN KEY (cep_fornecedor_fk  )  REFERENCES  tb_endereco(cep), 	
);

CREATE TABLE tb_cliente(
		id_cliente			INT IDENTITY PRIMARY KEY,
		cpf_cliente			CHAR(11) UNIQUE NOT NULL,
		nome_cliente		VARCHAR (50) NOT NULL, 
		email				VARCHAR(50) NOT NULL,
		data_nascimento		DATE NOT NULL,
		numero_cliente		VARCHAR(20) NOT NULL,
		complemento			VARCHAR (50) NOT NULL,
		cep_cliente_fk		CHAR(8)
		FOREIGN KEY (cep_cliente_fk)  REFERENCES  tb_endereco(cep),
	
);

CREATE TABLE tb_funcionario(
		id_matricula		INT IDENTITY PRIMARY KEY,
		cpf_funcionario		CHAR(11) UNIQUE NOT NULL,
		nome_funcionario	VARCHAR (50) NOT NULL,
		data_nascimento		DATE NOT NULL,
		email				VARCHAR(50) NOT NULL,
		numero_funcionario	VARCHAR(20) NOT NULL,
		complemento			VARCHAR (50) NOT NULL,
		cep_funcionario_fk  CHAR(8),
		FOREIGN KEY (cep_funcionario_fk)  REFERENCES  tb_endereco (cep)
);

CREATE TABLE tb_pizzaria (
		cnpj				CHAR(15) PRIMARY KEY NOT NULL,
		nome				VARCHAR(50) NOT NULL,
		email				VARCHAR(50) NOT NULL,
		endereço			VARCHAR(50) NOT NULL,
		numero				VARCHAR(50) NOT NULL,
		complemento			VARCHAR (50) NOT NULL,
		cep_pizzaria_fk		CHAR(8),
		FOREIGN KEY (cep_pizzaria_fk)  REFERENCES  tb_endereco(cep)
);

CREATE TABLE tb_estoque(
		id_estoque			INT IDENTITY PRIMARY KEY,
		prateleira			INT NOT NULL,
		corredor			INT NOT NULL,
		tipo_estoque		VARCHAR(50) NOT NULL
);

CREATE TABLE tb_ingrediente (
		id_ingredientes		INT IDENTITY PRIMARY KEY,
		nome_ingredientes	VARCHAR(50) NOT NULL,
		quantidade			INT NOT NULL,
		validade			DATE NOT NULL,
		tipo_produto		VARCHAR(50) NOT NULL,
		data_entrada		DATETIME NOT NULL, 
		custo				DECIMAL(10,2) NOT NULL,
		id_estoque_FK		INT,
		id_fornecedor_FK	INT,
		FOREIGN KEY (id_estoque_FK)		REFERENCES  tb_estoque	 (id_estoque),
		FOREIGN KEY (id_fornecedor_FK)  REFERENCES  tb_fornecedo (id_fornecedor)
);

CREATE TABLE tb_telefone(
		id_telefone			INT IDENTITY PRIMARY KEY,
		telefone_1			CHAR(11) NOT NULL,
		telefone_2			CHAR(11),
		id_cliente_fk		INT,
		id_funcionario_fk	INT,
		id_fornecedor_fk	INT,
		FOREIGN KEY (id_funcionario_fk) REFERENCES  tb_funcionario	(id_matricula),
		FOREIGN KEY (id_cliente_fk )	REFERENCES  tb_cliente		(id_cliente),
		FOREIGN KEY (id_fornecedor_fk)  REFERENCES	tb_fornecedo	(id_fornecedor)
);

CREATE TABLE tb_desconto(
		id_desconto			INT  IDENTITY PRIMARY KEY,
		data_inicio			DATE  NOT NULL,
		data_termino		DATE NOT NULL,
		valor_desconto		DECIMAL (10,2) NOT NULL,
		id_cliente_FK		INT,
		FOREIGN KEY (id_cliente_fk) REFERENCES tb_cliente (id_cliente)
);

CREATE TABLE tb_cupom(
		id_cupom			INT  IDENTITY PRIMARY KEY,
		valor_cupom			DECIMAL(10,2) NOT NULL,
		data_inicio			DATE  NOT NULL,
		data_termino		DATE NOT NULL,
		id_cliente_fk		INT,
		FOREIGN KEY (id_cliente_fk) REFERENCES tb_cliente (id_cliente)
);

CREATE  TABLE tb_cargo(
		id_cargo			INT IDENTITY PRIMARY KEY,
		nome_cargo			VARCHAR (50) NOT NULL,
		descricao			VARCHAR(200) NOT NULL,
		id_matricula_fk		INT,
		FOREIGN KEY (id_matricula_FK ) REFERENCES tb_funcionario (id_matricula)
);

CREATE TABLE tb_categorias_pizza(
		id_categoria		INT IDENTITY PRIMARY KEY,
		nome				VARCHAR(50),
		descricao			VARCHAR(60)
);

CREATE TABLE tb_bebidas(
		id_bebida			INT PRIMARY KEY,
		nome_bebida			VARCHAR (50),
		volume_ml			DECIMAL(4,3),
		preco				DECIMAL (10,2),
		id_estoque_fk		INT,
		FOREIGN KEY (id_estoque_FK) REFERENCES tb_estoque (id_estoque)
);

CREATE TABLE tb_pizza (
		id_pizzas			INT IDENTITY PRIMARY KEY,
		nome_pizza			VARCHAR(50),
		tamanho				VARCHAR (50),
		preco_base			DECIMAL(10,2),
		tempo_preparo		TIME,
		categoria_fk		INT,
		FOREIGN KEY (categoria_fk) REFERENCES tb_categorias_pizza (id_categoria)
);

CREATE TABLE tb_promocao(
		id_promocao			INT IDENTITY PRIMARY KEY,
		data_inicio			DATE  NOT NULL,
		data_termino		DATE NOT NULL,
		id_pizzas_fk		INT,
		FOREIGN KEY (id_pizzas_fk) REFERENCES tb_pizza (id_pizzas)
);

CREATE TABLE tb_fidelidade (
       id_fidelidade		INT IDENTITY PRIMARY KEY,
       pontos				INT NOT NULL,
       nota_fiscal_fk		INT  NOT NULL,
       id_cliente_fk		INT,
       id_pizza_fk			INT,
       FOREIGN KEY (id_cliente_FK)	REFERENCES tb_cliente	(id_cliente),
       FOREIGN KEY (id_pizza_FK)	REFERENCES tb_pizza		(id_pizzas)
);

CREATE  TABLE  tb_pedido(
		id_pedido			INT IDENTITY PRIMARY KEY,
		descricao_pedido	VARCHAR(50),
		data_pedido			DATE NOT NULL,
		status_pedido		VARCHAR(50) NOT NULL,
		tipo_pedido			VARCHAR (50) NOT NULL,
		id_fidelidade_fk	INT,
		id_matricula_fk		INT,
		id_cliente_fk		INT,
		FOREIGN KEY (id_fidelidade_FK)	REFERENCES tb_fidelidade	(Id_fidelidade),
		FOREIGN KEY (id_matricula_FK)	REFERENCES tb_funcionario	(id_matricula),
		FOREIGN KEY (id_cliente_FK)		REFERENCES tb_cliente		(id_cliente),
);

CREATE TABLE tb_avaliacao(
		id_avaliacao		INT IDENTITY PRIMARY KEY,
		comentário			VARCHAR (255),
		nota				INT,
		data_avaliacao		DATETIME,
		id_pedido_fk		INT,
		id_cliente_fk		INT,
		FOREIGN KEY (Id_pedido_fk)	REFERENCES tb_pedido	(id_pedido),
		FOREIGN KEY (Id_cliente_fk) REFERENCES tb_cliente	(Id_cliente)
);
CREATE TABLE tb_pizza_ingrediente(
		id_pizza_ingrediente INT IDENTITY PRIMARY KEY,
		quantidade_utilizada INT,
		id_pizza_FK			 INT,
		id_ingrediente_FK	 INT,
		FOREIGN KEY (id_pizza_FK)		REFERENCES tb_pizza		  (id_pizzas),
		FOREIGN KEY (id_ingrediente_FK) REFERENCES tb_ingrediente (id_ingredientes)
);

CREATE TABLE tb_Ingrediente_extra(
		id_Ingrediente_extra	INT IDENTITY PRIMARY KEY,
		nome_Ingrediente_extra	VARCHAR(50),
		tipo_Ingrediente_extra	VARCHAR(50),
		preco_Ingrediente_extra DECIMAL(10,2),
		quantidade_Ingrediente_extra INT,
		estoque_FK				INT,
		FOREIGN KEY (estoque_fk) REFERENCES tb_estoque (id_estoque)
);

CREATE TABLE tb_movi_estoque(
		id_movimento_estoque INT IDENTITY PRIMARY KEY,
		motivo_movimento	 VARCHAR(50),
		data_movimento		 DATETIME,
		tipo_movimento		 VARCHAR(50),
		id_ingrediente_FK	 INT,
		id_estoque_FK		 INT,
		FOREIGN KEY( id_ingrediente_FK) REFERENCES tb_ingrediente   (id_ingredientes),
		FOREIGN KEY (id_estoque_FK)		REFERENCES tb_estoque		(id_estoque)
);

CREATE TABLE tb_compras_estoque(
		id_compra_estoque	 INT IDENTITY PRIMARY KEY,
		data_compra_estoque	 DATETIME,
		valor_compra_estoque DECIMAL(10,2),
		status_compra		 VARCHAR(50),
		id_fornecedor_FK	 INT,
		FOREIGN KEY (id_fornecedor_FK) REFERENCES tb_fornecedo (id_fornecedor)
);

CREATE TABLE tb_itens_compra_estoque(
		id_item_estoque		 INT IDENTITY PRIMARY KEY,
		preco_unitario		 DECIMAL(10,2),
		quantidade			 INT,
		id_compra_estoque_FK INT,
		id_ingrediente_FK	 INT,
		FOREIGN KEY (id_compra_estoque_FK)  REFERENCES tb_compras_estoque (id_compra_estoque),
		FOREIGN KEY (id_ingrediente_FK)		REFERENCES tb_ingrediente	  (id_ingredientes)
);

CREATE TABLE  tb_forma_pagamento(
		id_pagamento		INT IDENTITY PRIMARY KEY,
		tipo				VARCHAR(50) NOT NULL,
		id_cliente_FK		INT,
		id_matricula_FK		INT,
		FOREIGN KEY (id_cliente_FK)   REFERENCES  tb_cliente    (id_cliente),
		FOREIGN KEY (id_matricula_FK) REFERENCES  tb_funcionario (id_matricula)
);

CREATE TABLE tb_horario_trabalho(
		id_horario_trabalho INT IDENTITY PRIMARY KEY,
		horario_entrada		TIME,
		horario_saida		TIME
);

CREATE TABLE tb_escalas_trabalho(
		id_escala			INT IDENTITY PRIMARY KEY,
		data_escala			DATE,
		id_funcionario_fk	INT,
		id_horario_fk		INT,
		FOREIGN KEY (id_funcionario_fk) REFERENCES tb_funcionario	   (id_matricula),
		FOREIGN KEY (id_horario_fk)		REFERENCES tb_horario_trabalho (id_horario_trabalho)

);

CREATE TABLE tb_ponto_eletronico(
		id_ponto		  INT IDENTITY PRIMARY KEY,
		data_ponto		  DATE,
		ponto_entrada	  TIME,
		ponto_saida		  TIME,
		id_funcionario_FK INT,
		FOREIGN KEY (id_funcionario_FK) REFERENCES tb_funcionario (id_matricula)

);

CREATE TABLE tb_folha(
		id_folha		  INT IDENTITY,
		mes_referencia	  DATE,
		salario_bruto	  DECIMAL(10,2),
		salario_liquido	  DECIMAL(10,2),
		desconto_salario  DECIMAL(10,2),
		id_funcionario_FK INT,
		FOREIGN KEY (id_funcionario_fk) REFERENCES tb_funcionario (id_matricula)
);

CREATE TABLE tb_log_sistema(
		id_log			INT IDENTITY PRIMARY KEY,
		usuario			VARCHAR(50),
		acao			VARCHAR(50),
		data_hora		DATETIME
);

CREATE TABLE tb_contas_pagar(
		id_contas		INT IDENTITY PRIMARY KEY,
		descricao		VARCHAR(50),
		valor_conta		DECIMAL(10,2) NOT NULL,
		data_vencimento DATE NOT NULL,
);

CREATE TABLE tb_caixa_diario(
		id_caixa		INT IDENTITY PRIMARY KEY,
		abertura		DATETIME NOT NULL,
		fechamento		DATETIME NOT NULL,
		saldo_inicial	DECIMAL(10,2) NOT NULL,
		saldo_final		DECIMAL(10,2) NOT NULL
);

CREATE TABLE tb_usuarios_sistemas(
		id_usuario		  INT IDENTITY PRIMARY KEY,
		nome_usuario	  VARCHAR(50)NOT NULL,
		senha			  VARCHAR(50) NOT NULL,
		nivel_acesso	  INT,
		id_funcionario_fk INT,
		id_cliente_fk     INT,
		FOREIGN KEY (id_funcionario_fk) REFERENCES tb_funcionario (id_matricula),
		FOREIGN KEY (id_cliente_fk )    REFERENCES tb_cliente     (id_cliente)
);

CREATE TABLE tb_relatorio_vendas(
		id_relatorio	INT IDENTITY PRIMARY KEY,
		periodo_inicio	DATETIME NOT NULL,
		periodo_final	DATETIME NOT NULL,
		total_vendas	INT NOT NULL,
		pizzas_vendidas INT NOT NULL
);

CREATE TABLE tb_comanda (
		id_comanda		INT IDENTITY PRIMARY KEY,
		numero_comanda	INT NOT NULL, 
		nome			VARCHAR(50) NOT NULL,
		id_pedido_FK	INT,
		id_pizza_FK		INT,
		FOREIGN KEY (id_pedido_FK) REFERENCES tb_pedido (id_pedido),
		FOREIGN KEY (id_pizza_FK)  REFERENCES tb_pizza  (id_pizzas)
);

CREATE TABLE tb_status (
		id_status		INT IDENTITY PRIMARY KEY,
		tipo_status		VARCHAR(50),
		id_pedido_fk	INT,
		FOREIGN KEY (id_pedido_fk) REFERENCES tb_pedido (id_pedido)
);


USE PIZZARIA

		INSERT INTO tb_estado(nome_estado, uf) 
		VALUES
		('São Paulo', 'SP')
 
		INSERT INTO tb_cidade(nome_cidade, id_estado_fk )
		VALUES
		('Taboão da Serra', 'SP')

		INSERT INTO tb_bairro (nome_bairro,id_cidade_fk) 
		VALUES
		('Jardim Maria Rosa' ,1),
		('Parque Pinheiros', 1),
		('Vila Iase',1),
		('Pirajuçara',1),
		('Parque Assunção',1),
		('Jardim Helena',1),
		('Jardim Salete',1),
		('Cidade Intercap',1),
		('Parque Monte Alegre',1),
		('Vila Santa Luzia',1);

		INSERT INTO tb_endereco(Cep,Logradouro,Id_bairro_fk)
		VALUES
		 ('06763040', 'Avenida Vida Nova',1),
		 ('06757000', 'Estrada São Francisco',1),
		 ('06764035', 'Rua Marechal Artur da Costa e Silva',1),
		 ('06756040', 'Rua José Mari',5),
		 ('06754020', 'Rua Rio de Janeiro',1),
		 ('06765050', 'Avenida Taboão da Serra',9),
		 ('06775100', 'Rua Guiomar Novaes',7),
		 ('06786000', 'Rodovia Régis Bittencourt',1),
		 ('06755010', 'Praça Miguel Ortega',8),
		 ('06775010', 'Rua Doutor Carlos Siqueira Neto',1),
		 ('06754150', 'Rua Pedro Mari', 5),
		 ('06768200', 'Rodovia Régis Bittencourt', 1),
		 ('06774010', 'Rua Jurandyr Cabello', 3),
		 ('06757290', 'Rua Rio de Janeiro', 1),
		 ('06765100', 'Rua Zeicy Aparecida Nogueira Batista', 2),
		 ('06785010', 'Rua Guilherme Busto', 1),
		 ('06783360', 'Rua Rodrigues Alves', 1),
		 ('06765450', 'Rua Elza Feres', 1),
		 ('06763460', 'Rua Maria Augusta de Oliveira', 1),
		 ('06775000', 'Estrada São Francisco', 1),
		 ('06775160', 'Rua José Alves da Cunha',8),
		 ('06764030', 'Rua Marechal Artur da Costa e Silva',1),
		 ('06785050', 'Rua Doutor João Guimarães',1),
		 ('06763000', 'Avenida Intercap',1),
		 ('06774050', 'Rua João Pires de Camargo',1),
		 ('06780000', 'Avenida Castelo Branco',1),
		 ('06773350', 'Rua São Judas Tadeu',1),
		 ('06767250', 'Rua Manoel da Silva Pires',1),
		 ('06753000', 'Rua Doutor Abílio Rúbio',1),
		 ('06786020', 'Rua Manoel Augusto Oliveira',1);

		INSERT INTO tb_fornecedo (Cnpj_fornecedor, Nome_fornecedor, Email, Numero, Complemento,cep_fornecedor_fk) 
		VALUES 
		('11234567000180', 'Queijos Nobres Ltda', 'vendas@queijosnobres.com.br', '550', 'Galpão 5', '06753000'),
		('12345678000171', 'Temperos do Mundo Eireli', 'contato@temperosdomundo.com', '120', 'Sala B', '06774050'),
		('13456789000162', 'Carnes & Cia S.A.', 'comercial@carnesecia.com.br', '880', 'Setor Frio', '06786020'),
		('14567890000153', 'Farinhas Top Quality', 'atendimento@farinhasgourmet.com', '99', 'Prédio 1', '06764030'),
		('15678901000144', 'Caixas e Embalagens Sul', 'orcamento@caixassul.com.br', '321', NULL, '06763460'),
		('16789012000135', 'Distribuidora Maravilha', 'vendas@maravilha.com', '405', 'Térreo', '06775100'),
		('17890123000126', 'Produtos Enlatados Mais', 'sac@enlatadosmais.com.br', '1800', 'Bloco C', '06775100'),
		('18901234000117', 'Refrigerantes Gelados Max', 'suporte@geladosmax.com.br', '75', 'Anexo A','06780000'),
		('19012345000108', 'Vegetais Frescos Ltda', 'contato@vegetaisfrescos.com', '20', 'Câmara Fria','06754020'),
		('20123456000199', 'Acessórios Profissionais', 'vendas@acessoriospro.com', '601', 'Loja', '06765050')

		INSERT INTO Tb_cliente (cpf_Cliente, nome_cliente, email, data_nascimento, numero_cliente, complemento, cep_cliente_fk )
		VALUES
		('11122233344', 'Ana Silva Pereira', 'ana.sp@email.com', '1985-05-15', '45', 'Apartamento 12A', '06786000'),
		('22233344455', 'Bruno Santos Oliveira', 'bruno.so@email.com', '1990-11-20', '1050', 'Casa 2', '06763040'),
		('33344455566', 'Carla Mendes Costa', 'carla.mc@email.com', '1992-08-01', '88', 'Bloco B', '06785050'),
		('44455566677', 'Daniel Rocha Almeida', 'daniel.ra@email.com', '1978-03-25', '220', 'Fundos', '06785050'),
		('55566677788', 'Elisa Ferreira Lima', 'elisa.fl@email.com', '2000-01-10', '15', 'Sala 301','06763040'),
		('66677788899', 'Felipe Gomes Soares', 'felipe.gs@email.com', '1995-07-07', '300', 'Loja 1','06775010'),
		('77788899900', 'Giovana Alves Pinheiro', 'giovana.ap@email.com', '1989-12-12', '1200', 'Edifício Central', '06786000'),
		('88899900011', 'Hugo Vaz Teixeira', 'hugo.vt@email.com', '1980-04-30', '501', 'Portaria','06775010'),
		('99900011122', 'Ingrid Lopes Martins', 'ingrid.lm@email.com', '1998-06-18', '77', 'Subsolo','06775010'),
		('00011122233', 'Júlio Barros Vieira', 'julio.bv@email.com', '1975-09-03', '2020', 'Térreo', '06786000');

		INSERT INTO tb_pizzaria (cnpj, nome, email, Endereço, Numero, Complemento, cep_pizzaria_fk) 
		VALUES
		('30123456000199', 'Pizza Master Taboão', 'contato@pizzamaster.com.br', 
		'Estrada São Francisco', '1250', 'Lote 15','06775010');

		INSERT INTO tb_estoque (prateleira, corredor, tipo_estoque) 
		VALUES
		(1, 1, 'Seco - Farinhas e Massas'),
		(1, 2, 'Seco - Embalagens'),
		(2, 1, 'Refrigerado - Laticínios'),
		(2, 2, 'Refrigerado - Embutidos'),
		(3, 1, 'Congelado - Carnes'),
		(3, 2, 'Congelado - Massas Prontas'),
		(4, 1, 'Seco - Molhos e Enlatados'),
		(4, 2, 'Seco - Bebidas (Não Alcoólicas)'),
		(5, 1, 'Utensílios e Equipamentos'),
		(5, 2, 'Produtos de Limpeza'),
		(3, 3, 'Vegetais - Legumes e Frutas')

		INSERT INTO TB_Ingrediente (nome_Ingredientes, quantidade, validade, tipo_produto, data_entrada, custo,Id_estoque_FK, Id_fornecedor_FK ) VALUES
		('Queijo Muçarela', 50, '2025-11-25', 'Laticínio Refrigerado', '15-10-2025 10:00:00', 28.50, 3, 1),
		('Farinha de Trigo Tipo 1', 100, '2026-06-01', 'Seco - Base', '16-10-2025 09:30:00', 3.20, 1, 4),
		('Molho de Tomate Pelado', 80, '2026-03-10', 'Enlatado/Molho', '16-10-2025 11:00:00', 5.80, 7, 7),
		('Linguiça Calabresa Fatiada', 30, '2025-11-05', 'Embutido Refrigerado', '17-10-2025 08:00:00', 19.90, 4, 6),
		('Azeitona Preta s/ caroço', 45, '2026-01-20', 'Conservas', '17-10-2025 09:00:00', 13.50, 7, 9),
		('Fermento Biológico Seco', 10, '2025-12-30', 'Seco - Base', '06-10-2025 09:15:00', 1.20, 1, 4),
		('Azeite Extra Virgem (L)', 25, '2026-09-15', 'Óleo/Líquido', '10-10-2025 14:00:00', 15.00, 7, 9),
		('Presunto Cozido', 40, '2025-11-15', 'Embutido Refrigerado', '15-10-2025 10:30:00', 15.50, 4, 8),
		('Cebola Roxa (kg)', 20, '2025-10-25', 'Hortifruti', '5-10-2025 11:00:00', 4.50, 11, 9 ),
		('Catupiry Original (kg)', 15, '2025-11-20', 'Laticínio Refrigerado', '14-10-2025 15:30:00', 32.80, 3, 1);

		INSERT INTO tb_funcionario (cpf_funcionario, nome_funcionario, data_nascimento, email, numero_funcionario, Complemento,cep_funcionario_fk) VALUES
		('20101010101', 'Roberto Dias', '1990-01-20', 'roberto.d@pizzaria.com', '123','Apto 101','06753000' ),
		('20202020202', 'Carla Fernandes', '1988-05-15', 'carla.f@pizzaria.com','154', 'Casa A', '06754150'),
		('20303030303', 'Mauro Souza', '1995-11-30', 'mauro.s@pizzaria.com', '235', 'Bloco C', '06756040'),
		('20404040404', 'Lívia Oliveira', '1992-07-08', 'livia.o@pizzaria.com','175', 'Fundos', '06757290'),
		('20505050505', 'César Santos', '1985-03-01', 'cesar.s@pizzaria.com', '567',  'Sala 2', '06763040'),
		('20606060606', 'Sofia Alves', '1998-09-12', 'sofia.a@pizzaria.com','756', 'Prédio Principal','06764030'),
		('20707070707', 'Eduardo Lopes', '1983-02-28', 'eduardo.l@pizzaria.com', '958', 'Galpão 3', '06765050'),
		('20808080808', 'Bianca Rocha', '2000-04-05', 'bianca.r@pizzaria.com', '865' ,'Anexo B', '06765450'),
		('20909090909', 'Vinícius Gomes', '1993-10-22', 'vinicius.g@pizzaria.com', '761', 'Loja de Esquina', '06768200'),
		('21011011011', 'Natália Ribeiro', '1991-06-17', 'natalia.r@pizzaria.com', '645', 'Térreo', '06774010');

		INSERT INTO tb_telefone (Telefone_1, Telefone_2,Id_cliente_fk, id_funcionario_fk, Id_fornecedor_fk ) 
		VALUES
		('11980010001', '1140010001',1,		NULL,	NULL),
		('11980010002', '1140010002',NULL,	2,		NULL),
		('11980010003', '1140010003',NULL,	NULL,	3),
		('11980010004', '1140010004',4,		NULL,	NULL),
		('11980010005', '1140010005',NULL,	NULL,	5),
		('11980010006', '1140010006',NULL,	6,		NULL),
		('11980010007', '1140010007',NULL,	7,		NULL),
		('11980010008', '1140010008',NULL,	NULL,	7),
		('11980010009', '1140010009',9,		NULL,	NULL),
		('11980010010', '1140010010',10,	NULL,	NULL),
		('11980010011', '1140010011',6,		NULL,	NULL),
		('11980010012', '1140010012',NULL,	3,		NULL),
		('11980010013', '1140010013',NULL,	NULL,	10),
		('11980010014', '1140010014',NULL,	4,		NULL),
		('11980010015', '1140010015',NULL,	NULL,	5),
		('11980010016', '1140010016',2,		NULL,	NULL),
		('11980010017', '1140010017',7,		NULL,	NULL),
		('11980010018', '1140010018',NULL,	8,		NULL),
		('11980010019', '1140010019',NULL,	9,		NULL),
		('11980010020', '1140010020',NULL,	10,		NULL),
		('11980010021', '1140010021',3,		NULL,	NULL),
		('11980010022', '1140010022',NULL,	1,		NULL),
		('11980010023', '1140010023',NULL,	NULL,	3),
		('11980010024', '1140010024',NULL,	3,		NULL),
		('11980010025', '1140010025',5,		NULL,	NULL),
		('11980010026', '1140010026',NULL,	NULL,	6),
		('11980010027', '1140010027',NULL,	NULL,	7),
		('11980010028', '1140010028',8,		NULL,	NULL),
		('11980010029', '1140010029',NULL,	NULL,	9),
		('11980010030', '1140010030',NULL,	NULL,	10);

		INSERT INTO tb_categorias_pizza (nome, descricao)
		VALUES 
		('Tradicional',		'Sabores clássicos com ingredientes comuns'),
		('Especial',		'Combinações exclusivas e diferenciadas'),
		('Vegetariana',		'Sem ingredientes de origem animal'),
		('Doce',			'Pizzas com ingredientes doces'),
		('Premium',			'Ingredientes nobres e selecionados'),
		('Picante',			'Sabores com toque apimentado'),
		('Infantil',		'Sabores suaves para crianças'),
		('Vegana',			'Sem ingredientes de origem animal ou derivados'),
		('Fitness',			'Ingredientes leves e saudáveis'),
		('Personalizada',	'Montada conforme escolha do cliente');

		INSERT INTO tb_pizza (nome_pizza, tamanho, preco_base, tempo_preparo, categoria_FK)
		VALUES 
		('Margherita',				'Média',	25.90, '00:20:00', 1),
		('Calabresa',				'Grande',	32.50, '00:25:00', 1),
		('Quatro Queijos',			'Média',	29.90, '00:22:00', 2),
		('Frango com Catupiry',		'Grande',	34.00, '00:27:00', 2),
		('Vegetariana',				'Média',	28.00, '00:20:00', 3),
		('Chocolate com Morango',	'Pequena',	22.50, '00:18:00', 4),
		('Portuguesa',				'Grande',	33.75, '00:26:00', 1),
		('Mexicana',				'Média',	30.00, '00:24:00', 6),
		('Pizza Kids',				'Pequena',	20.00, '00:15:00', 7),
		('Pizza Fit',				'Média',	27.50, '00:21:00', 9);

		INSERT INTO tb_promocao (Data_inicio, Data_termino, id_pizzas_fk)
		VALUES
		('2025-11-01', '2025-11-30',1), -- Mês da Black Friday
		('2025-10-18', '2025-10-25',2), -- Promoção de 1 semana
		('2025-12-01', '2025-12-24',3), -- Promoção Natalina
		('2026-01-01', '2026-01-31',4), -- Promoção de Verão
		('2025-10-17', '2025-10-17',5), -- Promoção relâmpago (1 dia)
		('2025-11-15', '2025-12-15',6), -- Promoção de 1 mês
		('2026-02-10', '2026-02-18',7), -- Promoção de Carnaval
		('2025-12-31', '2026-01-05',8), -- Promoção de Ano Novo
		('2025-10-01', '2025-12-31',9), -- Promoção de Longo Prazo (trimestral)
		('2026-03-01', '2026-03-31',10); -- Promoção de Início de Outono

		INSERT INTO Tb_desconto (Data_inicio, Data_termino, Valor_desconto, id_cliente_fk) 
		VALUES
		('2025-10-20', '2025-10-27', 15.00, 1), -- 15% de desconto por uma semana
		('2025-11-01', '2025-11-03', 10.00, 2), -- 10% de desconto de final de semana
		('2025-11-28', '2025-11-28', 30.00, 3), -- 30% Black Friday (1 dia)
		('2025-12-05', '2025-12-19', 20.00, 4), -- 20% de desconto pré-natalino
		('2026-01-10', '2026-02-10', 5.00, 5),  -- 5% de desconto de fidelidade (1 mês)
		('2025-10-17', '2025-10-17', 25.00, 6), -- 25% de desconto relâmpago (hoje)
		('2025-12-26', '2025-12-30', 12.50, 7), -- 12.5% de desconto pós-natalino
		('2026-03-01', '2026-03-07', 8.00, 8),  -- 8% de desconto na primeira semana do mês
		('2026-04-15', '2026-05-15', 18.00, 9), -- 18% de desconto em baixa temporada
		('2026-06-01', '2026-08-31', 7.50, 10);  -- 7.5% de desconto para pedidos online (3 meses)

		INSERT INTO tb_cupom (Valor_cupom, Data_inicio, Data_termino, id_cliente_fk)
		VALUES
		(10.00, '2025-10-17', '2025-10-31',1),  -- R$ 10,00 off, válido até o fim do mês
		(15.00, '2025-11-01', '2025-11-30',2),  -- R$ 15,00 off para novembro
		(5.00,  '2025-10-20', '2026-01-20',3),  -- R$ 5,00 off, validade mais longa
		(20.00, '2025-12-01', '2025-12-25',4),  -- R$ 20,00 off para Natal
		(7.50,  '2025-10-18', '2025-10-24',5),  -- R$ 7,50 off, cupom semanal
		(25.00, '2025-11-28', '2025-11-28',6),  -- R$ 25,00 off, Black Friday (1 dia)
		(12.00, '2026-01-01', '2026-01-31',7),  -- R$ 12,00 off para o ano novo
		(8.50,  '2025-10-17', '2025-10-17',8),  -- R$ 8,50 off, cupom relâmpago (hoje)
		(30.00, '2026-02-01', '2026-02-28',9),  -- R$ 30,00 off, cupom de alto valor
		(19.90, '2025-10-25', '2025-11-15',10);  -- R$ 19,90 off, promocional

		INSERT INTO tb_fidelidade (pontos, nota_fiscal_FK,id_cliente_fk, id_pizza_FK)
		VALUES 
		(10, 1001,2, 1),
		(15, 1002,5, 2),
		(20, 1003,4, 3),
		(25, 1004,7, 4),
		(30, 1005,9, 5),
		(12, 1006,3, 6),
		(18, 1007,1, 7),
		(22, 1008,6, 8),
		(28, 1009,8, 9),
		(35, 1010,10, 10);

		INSERT INTO tb_pedido (descricao_pedido, data_pedido, status_pedido, tipo_pedido, id_fidelidade_FK, id_matricula_FK, id_cliente_FK)
		VALUES 
		('Pedido Margherita',	   '2025-10-01', 'Concluído',	'Delivery', 1, 2, 1),
		('Pedido Calabresa',	   '2025-10-02', 'Concluído',	'Retirada', 2, 1, 2),
		('Pedido Quatro Queijos',  '2025-10-03', 'Concluído',   'Delivery', 3, 3, 3),
		('Pedido Frango Catupiry', '2025-10-04', 'Concluído',   'Retirada', 4, 4, 4),
		('Pedido Vegetariana',	   '2025-10-05', 'Concluído',	'Delivery',	5, 5, 5),
		('Pedido Portuguesa',	   '2025-10-06', 'Concluído',	'Delivery', 6, 6, 6),
		('Pedido Mexicana',        '2025-10-07', 'Concluído',	'Retirada',	7, 7, 7),
		('Pedido Kids',			   '2025-10-08', 'Concluído',	'Delivery',	8, 8, 8),
		('Pedido Fit',			   '2025-10-09', 'Concluído',	'Retirada',	9, 9, 9),
		('Pedido Especial',		   '2025-10-10', 'Concluído',	'Delivery',	10,10, 10);

		INSERT INTO tb_avaliacao (comentário, Nota, Data_avaliacao, Id_pedido_FK, Id_cliente_FK) 
		VALUES
		('Pizza chegou super rápida e quentinha! Massa excelente.', 5, '10-09-2025 20:15:00', 1, NULL),
		('O recheio de calabresa estava muito saboroso, mas a entrega demorou um pouco.', 4, '09-09-2025 21:40:00',2 ,2),
		('Pedi a de Quatro Queijos, estava impecável! Perfeita.', 5, '01-09-2025 19:30:00', 3, 3),
		('O pedido veio errado. Faltou a borda recheada que solicitei.', 2, '7-08-2025 20:55:00', 4, 4),
		('Atendimento telefônico foi excelente e a pizza chegou antes do previsto.', 5, '01-08-2025 19:05:00', 5, 5),
		('Gosto bom, mas o preço é um pouco elevado para o tamanho.', 3, '5-09-2025 22:10:00', 6, 6),
		('A pizza estava fria, infelizmente. Precisa melhorar a embalagem de transporte.', 2, '04-07-2025 21:10:00', 7, 7),
		('Melhor pizza de frango com catupiry que já comi em Taboão da Serra!', 5, '10-09-2025 18:50:00', 8, 8),
		('Comentário: Nenhuma reclamação. Pedirei novamente na próxima semana.', 4, '20-09-2025 22:05:00', 9, 9),
		('A qualidade da muçarela deixou a desejar. Estava um pouco borrachuda.', 3, '22-09-2025 20:35:00', 10, 10);

		INSERT INTO tb_bebidas (Id_bebida, Nome_bebida, Volume_ml, Preco, Id_estoque_FK)
		VALUES 
		(1, 'Coca-Cola',		3.00, 5.50, 1),
		(2, 'Guaraná',			2.00,	6.00, 2),
		(3, 'Soda Limonada',	3.00, 4.75, 3),
		(4, 'Água Mineral',		2.00, 3.00, 4),
		(5, 'Sprite',			2.00, 5.25, 5),
		(6, 'Fanta Laranja',	2.00, 4.90, 6),
		(7, 'Pepsi Zero',		2.00, 5.10, 7),
		(8, 'Energético',		2.0, 7.80, 8),
		(9, 'Água com Gás',		1.00, 3.20, 9),
		(10,'Fanta uva',		2.00, 6.50, 10);

		INSERT INTO tb_pizza_ingrediente (quantidade_utilizada, id_pizza_FK, id_ingrediente_FK)
		VALUES 
		(2, 1,1),
		(3, 10, 2),
		(1, 2, 3),
		(4, 3, 4),
		(2, 4, 5),
		(3, 5, 6),
		(1, 6, 7),
		(2, 7, 8),
		(3, 8, 9),
		(2, 9, 10);

		INSERT INTO tb_Ingrediente_extra (nome_Ingrediente_extra, tipo_Ingrediente_extra, preco_Ingrediente_extra, quantidade_Ingrediente_extra, estoque_FK)
		VALUES 
		('Queijo Cheddar', 'Laticínio', 5.50, 20, 1),
		('Bacon', 'Carne', 7.25, 15, 2),
		('Molho Barbecue', 'Condimento', 3.80, 10, 3),
		('Cebola Crispy', 'Vegetal', 2.50, 25, 4),
		('Tomate Seco', 'Vegetal', 4.75, 12, 5),
		('Azeitona Preta', 'Vegetal', 3.20, 18, 6),
		('Frango Desfiado', 'Carne', 6.90, 22, 7),
		('Catupiry', 'Laticínio', 5.10, 16, 8),
		('Calabresa', 'Carne', 7.00, 20, 9),
		('Orégano', 'Tempero', 1.50, 50, 10);

		INSERT INTO tb_movi_estoque (motivo_movimento, data_movimento, tipo_movimento, id_ingrediente_FK, id_estoque_FK)
		VALUES 
		('Reposição de estoque', '2025-10-01 08:30:00', 'Entrada', 1, 1),
		('Uso na produção', '2025-10-02 14:00:00', 'Saída', 2, 2),
		('Ajuste de inventário', '2025-10-03 09:15:00', 'Ajuste', 3, 3),
		('Devolução de fornecedor', '2025-10-04 11:45:00', 'Saída', 4, 4),
		('Compra de ingredientes', '2025-10-05 16:20:00', 'Entrada', 5, 5),
		('Perda por validade', '2025-10-06 10:00:00', 'Saída', 6, 6),
		('Transferência interna', '2025-10-07 13:30:00', 'Ajuste', 7, 7),
		('Reposição urgente', '2025-10-08 09:45:00', 'Entrada', 8, 8),
		('Erro de contagem', '2025-10-09 15:10:00', 'Ajuste', 9, 9),
		('Uso em evento especial', '2025-10-10 17:00:00', 'Saída', 10, 10);

		INSERT INTO tb_compras_estoque (data_compra_estoque, valor_compra_estoque, status_compra, id_fornecedor_FK)
		VALUES 
		('01-10-2025 10:30:00', 250.00, 'Concluída', 1),
		('05-10-2025 14:15:00', 480.75, 'Pendente', 2),
		('10-10-2025 09:00:00', 120.50, 'Cancelada', 3),
		('15-10-2025 16:45:00', 300.00, 'Concluída', 4),
		('17-10-2025 11:20:00', 150.25, 'Em andamento', 5),
		('17-10-2025 13:00:00', 275.40, 'Concluída', 6),
		('16-10-2025 08:50:00', 90.00, 'Pendente', 7),
		('10-09-2025 17:30:00', 310.00, 'Cancelada', 8),
		('10-10-2025 12:10:00', 450.60, 'Concluída', 9),
		('17-10-2025 15:45:00', 200.00, 'Em andamento', 10);

		INSERT INTO tb_itens_compra_estoque (preco_unitario, quantidade, id_compra_estoque_FK, id_ingrediente_FK)
		VALUES 
		(4.50, 20, 1, 1),
		(2.75, 50, 2, 2),
		(10.00, 10, 3, 3),
		(1.25, 100, 4, 4),
		(7.80, 30, 5, 5),
		(3.60, 40, 6, 6),
		(5.90, 25, 7, 7),
		(6.75, 35, 8, 8),
		(2.20, 60, 9, 9),
		(8.10, 15, 10, 1);
		
		INSERT INTO tb_forma_pagamento (tipo, id_cliente_FK, id_matricula_FK)
		VALUES 
		('Cartão de Crédito', 1, 1),
		('Pix', 2, 2),
		('Pix', 3, 3),
		('Dinheiro', 4, 4),
		('Dinheiro', 5, 5),
		('Cartão de Débito', 6, 6),
		('Vale Refeição', 7, 7),
		('Pix', 8, 8),
		('Pagamento Online', 9, 9),
		('Cartão de Crédito', 10, 1); 

		INSERT INTO tb_pizza_ingrediente (quantidade_utilizada, id_pizza_FK, id_ingrediente_FK)
		VALUES 
		(2, 1, 1),
		(3, 1, 2),
		(1, 2, 3),
		(4, 2, 4),
		(2, 3, 5),
		(3, 3, 6),
		(1, 4, 7),
		(2, 4, 8),
		(3, 5, 9),
		(2, 5, 10);

		INSERT INTO tb_horario_trabalho (horario_entrada, horario_saida)
		VALUES
		('08:00:00', '16:00:00'),
		('09:00:00', '17:00:00'),
		('10:00:00', '18:00:00'),
		('12:00:00', '20:00:00'),
		('13:00:00', '21:00:00'),
		('14:00:00', '22:00:00'),
		('15:00:00', '23:00:00'),
		('16:00:00', '00:00:00'),
		('17:00:00', '01:00:00'),
		('18:00:00', '02:00:00');


		INSERT INTO tb_escalas_trabalho (data_escala, id_funcionario_FK, id_horario_FK)
		VALUES

		('2025-10-20', 1, 1),
		('2025-10-20', 2, 2),
		('2025-10-21', 3, 1),
		('2025-10-21', 4, 3),
		('2025-10-22', 5, 1),
		('2025-10-22', 6, 4),
		('2025-10-23', 7, 2),
		('2025-10-23', 8, 3),
		('2025-10-24', 9, 1),
		('2025-10-24', 10, 2);

		INSERT INTO tb_ponto_eletronico (data_ponto, ponto_entrada, ponto_saida, id_funcionario_FK) VALUES

		('2025-10-01', '08:00:00', '17:00:00', 1),
		('2025-10-01', '08:05:00', '17:10:00', 2),
		('2025-10-01', '07:55:00', '16:50:00', 3),
		('2025-10-02', '08:00:00', '17:00:00', 4),
		('2025-10-02', '08:10:00', '17:05:00', 5),
		('2025-10-02', '08:00:00', '16:55:00', 6),
		('2025-10-03', '08:03:00', '17:02:00', 7),
		('2025-10-03', '08:00:00', '17:00:00', 8),
		('2025-10-03', '08:07:00', '17:10:00', 9),
		('2025-10-03', '07:58:00', '16:59:00', 10);
 
		INSERT INTO tb_folha (mes_referencia, salario_bruto, salario_liquido, desconto_salario, id_funcionario_fk) VALUES

		('2025-01-01', 3000.00, 2700.00, 300.00, 1),
		('2025-02-01', 3200.00, 2880.00, 320.00, 2),
		('2025-03-01', 3100.00, 2795.00, 305.00, 3),
		('2025-04-01', 2800.00, 2520.00, 280.00, 4),
		('2025-05-01', 3500.00, 3150.00, 350.00, 5),
		('2025-06-01', 4000.00, 3600.00, 400.00, 6),
		('2025-07-01', 2900.00, 2610.00, 290.00, 7),
		('2025-08-01', 3700.00, 3330.00, 370.00, 8),
		('2025-09-01', 3300.00, 2970.00, 330.00, 9),
		('2025-10-01', 3600.00, 3240.00, 360.00, 10);

		INSERT INTO tb_log_sistema (usuario, acao, data_hora)
		VALUES
		('admin', 'Login realizado', '17/10/2025 08:05:22'),
		('roberto.d@pizzaria.com', 'Cadastro de cliente', '17/10/2025 09:14:08'),
		('carla.f@pizzaria.com', 'Atualização de pedido', '17/10/2025 09:47:33'),
		('admin', 'Backup do banco de dados', '17/10/2025 10:00:00'),
		('roberto.d@pizzaria.com', 'Logout realizado', '17/10/2025 11:22:49'),
		('carla.f@pizzaria.com', 'Login realizado', '17/10/2025 12:11:10'),
		('roberto.d@pizzaria.com', 'Exclusão de produto', '17/10/2025 13:40:25'),
		('admin', 'Cadastro de funcionário', '17/10/2025 14:55:10'),
		('carla.f@pizzaria.com', 'Atualização de estoque', '17/10/2025 15:27:42'),
		('admin', 'Logout realizado', '17/10/2025 16:00:00');


		INSERT INTO tb_contas_pagar (descricao, valor_conta, data_vencimento)
		VALUES
		('Conta de Energia', 1250.75, '10/11/2025'),
		('Conta de Água', 430.60, '12/11/2025'),
		('Internet e Telefonia', 299.90, '15/11/2025'),
		('Compra de Ingredientes', 2580.40, '08/11/2025'),
		('Fornecedor de Embalagens', 845.30, '05/11/2025'),
		('Aluguel do Estabelecimento', 4200.00, '01/11/2025'),
		('Serviço de Limpeza', 750.00, '09/11/2025'),
		('Manutenção de Equipamentos', 960.80, '20/11/2025'),
		('Conta de Gás', 580.25, '13/11/2025'),
		('Compra de Bebidas', 1340.00, '11/11/2025');

		INSERT INTO tb_caixa_diario (abertura, fechamento, saldo_inicial, saldo_final)
		VALUES
		('01/10/2025 09:00:00', '01/10/2025 23:59:00', 500.00, 3240.75),
		('02/10/2025 09:00:00', '02/10/2025 23:58:00', 3240.75, 5025.30),
		('03/10/2025 09:00:00', '03/10/2025 23:57:00', 5025.30, 4789.20),
		('04/10/2025 09:00:00', '04/10/2025 23:59:00', 4789.20, 6150.10),
		('05/10/2025 09:00:00', '05/10/2025 23:55:00', 6150.10, 5980.40),
		('06/10/2025 09:00:00', '06/10/2025 23:59:00', 5980.40, 7250.00),
		('07/10/2025 09:00:00', '07/10/2025 23:56:00', 7250.00, 7045.85),
		('08/10/2025 09:00:00', '08/10/2025 23:57:00', 7045.85, 8900.60),
		('09/10/2025 09:00:00', '09/10/2025 23:59:00', 8900.60, 9200.00),
		('10/10/2025 09:00:00', '10/10/2025 23:59:00', 9200.00, 9875.45);

		INSERT INTO tb_usuarios_sistemas (nome_usuario, senha, nivel_acesso, id_funcionario_fk, id_cliente_fk)
		VALUES
		('admin', 'admin123', 1, NULL, NULL),
		('roberto.d@pizzaria.com', 'rdias2025', 2, 1, NULL),
		('carla.f@pizzaria.com', 'cfernandes', 2, 2, NULL),
		('joao.silva@pizzaria.com', 'joaos123', 2, 3, NULL),
		('maria.lima@pizzaria.com', 'maria!2025', 2, 4, NULL),
		('cliente1@teste.com', 'cliente01', 3, NULL, 1),
		('cliente2@teste.com', 'cliente02', 3, NULL, 2),
		('cliente3@teste.com', 'cliente03', 3, NULL, 3),
		('cliente4@teste.com', 'cliente04', 3, NULL, 4),
		('cliente5@teste.com', 'cliente05', 3, NULL, 5);

		INSERT INTO tb_relatorio_vendas (periodo_inicio, periodo_final, total_vendas, pizzas_vendidas)
		VALUES
		('01/10/2025 00:00:00', '07/10/2025 23:59:59', 145, 382),
		('08/10/2025 00:00:00', '14/10/2025 23:59:59', 162, 415),
		('15/10/2025 00:00:00', '21/10/2025 23:59:59', 180, 440),
		('22/10/2025 00:00:00', '28/10/2025 23:59:59', 172, 428),
		('29/10/2025 00:00:00', '31/10/2025 23:59:59', 69, 155);

		INSERT INTO tb_comanda (numero_comanda, nome, id_pedido_fk, id_pizza_fk)
		VALUES
		(101, 'João da Silva', 1, 1),
		(102, 'Maria Oliveira', 2, 2),
		(103, 'Carlos Souza', 3, 3),
		(104, 'Ana Paula', 4, 2),
		(105, 'Rafael Santos', 5, 4),
		(106, 'Fernanda Lima', 6, 1),
		(107, 'Pedro Rocha', 7, 5),
		(108, 'Juliana Costa', 8, 3),
		(109, 'Lucas Almeida', 9, 6),
		(110, 'Patrícia Mendes', 10, 2);

		INSERT INTO tb_status (tipo_status, id_pedido_fk)
		VALUES
		('Pedido recebido', 1),
		('Em preparo', 2),
		('Saiu para entrega', 3),
		('Entregue', 4),
		('Cancelado', 5),
		('Pedido recebido', 6),
		('Em preparo', 7),
		('Saiu para entrega', 8),
		('Entregue', 9),
		('Entregue', 10);

		SELECT c.nome_cliente, p.descricao_pedido, p.data_pedido
				FROM tb_cliente c
				INNER JOIN tb_pedido p
				ON c.id_cliente = p.id_cliente_fk;

		SELECT f.nome_funcionario, e.data_escala, h.horario_entrada, h.horario_saida
				FROM tb_funcionario f
				INNER JOIN tb_escalas_trabalho e
				ON f.id_matricula = e.id_funcionario_fk
				INNER JOIN tb_horario_trabalho h
				ON e.id_horario_fk = h.id_horario_trabalho;

		SELECT p.descricao_pedido, f.pontos, c.nome_cliente
				FROM tb_pedido p
				INNER JOIN tb_fidelidade f
				ON p.id_fidelidade_fk = f.id_fidelidade
				INNER JOIN tb_cliente c
				ON f.id_cliente_fk = c.id_cliente;

			SELECT pz.id_pizza_FK, p.nome_pizza, i.nome_ingredientes, pz.quantidade_utilizada
				FROM tb_pizza_ingrediente pz
				INNER JOIN tb_pizza p
				ON pz.id_pizza_FK = p.id_pizzas
				INNER JOIN tb_ingrediente i
				ON pz.id_ingrediente_FK = i.id_ingredientes;

			SELECT f.nome_fornecedor, i.nome_ingredientes
				FROM tb_ingrediente i
				INNER JOIN tb_fornecedo f
				ON i.id_fornecedor_FK = f.id_fornecedor;

			SELECT pd.descricao_pedido, s.tipo_status
				FROM tb_pedido pd
				INNER JOIN tb_status s
				ON pd.id_pedido = s.id_pedido_fk;

			SELECT c.nome_cliente, cp.valor_cupom
				FROM tb_cliente c
				INNER JOIN tb_cupom cp
				ON c.id_cliente = cp.id_cliente_fk;

			SELECT c.nome_cliente, t.telefone_1, t.telefone_2
				FROM tb_cliente c
				INNER JOIN tb_telefone t
				ON c.id_cliente = t.id_cliente_fk;

			SELECT f.nome_fornecedor, t.telefone_1, t.telefone_2
				FROM tb_fornecedo f
				INNER JOIN tb_telefone t
				ON f.id_fornecedor = t.id_fornecedor_fk;

			SELECT c.nome_cliente, p.descricao_pedido
				FROM tb_cliente c
				JOIN tb_pedido p
				ON c.id_cliente = p.id_cliente_fk;





