CREATE TABLE client(
	idClient serial PRIMARY KEY,
	Fname VARCHAR(10),
	Minit CHAR(3),
	Lname VARCHAR(20),
	CPF CHAR(11) NOT NULL UNIQUE, 
	Address VARCHAR(30),
	CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

CREATE TYPE category as enum ('Eletrônico','Vestimenta','Brinquedo','Alimentos','Móvies');

CREATE TABLE product(
	idProduct SERIAL PRIMARY KEY,
	Pname VARCHAR(10),
	classfication_kids bool default false,
	current_category category,
	avaliação float default 0,
	size varchar(10)	
);

CREATE TYPE orderStatus as enum('Cancelado','Confirmado','Em processamento');

CREATE TABLE ordens(
	idOrder serial primary key,
	idOrderClient int,
	current_orderStatus orderStatus not null,
	orderDescrition varchar(255),
	sendValue float default 10,
	paymentCash bool default false,
	constraint fk_orders_client foreign key (idOrderClient) references client (idClient)
);

CREATE TABLE productStorage(
	idProdStorage serial primary key,
	storageLocation varchar(255),
	quantity int default 0
);

CREATE TABLE supplier(
	idSupplier serial primary key,
	SocialName varchar (255) not null,
	CNPJ char(15) not null,
	contact char(11) not null,
	constraint unique_supplier unique(CNPJ)
);

CREATE TABLE seller(
	idSeller serial primary key,
	SocialName varchar (255) not null,
	CNPJ char(15),
	CPF char(9),
	location varchar(255),
	contact char(11) not null,
	constraint unique_cnpj_seller unique(CNPJ),
	constraint unique_cpf_seller unique(CPF)
);

CREATE TABLE productSeller(
	idPseller int,
	idProduct int,
	prodQuantity int default 1,
	primary key(idPseller, idProduct),
	constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
	constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

CREATE TYPE poStatus as enum ('Disponivel','Sem estoque');

CREATE TABLE productOrder(
	idPOproduct int,
	idPOorder int,
	poQuantity int default 1,
	currents_poStatus poStatus default ('Disponivel'),
	primary key(idPOproduct , idPOorder ),
	constraint fk_product_seller foreign key (idPOproduct) references product(idProduct),
	constraint fk_product_product foreign key (idPOorder) references ordens(idOrder)
);


CREATE TABLE storageLocation(
	idLproduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key(idLproduct,idLstorage),
	constraint fk_product_seller foreign key (idLproduct) references product(idProduct),
	constraint fk_product_product foreign key (idLstorage) references productStorage(idProdStorage)
);

CREATE TABLE productSupplier(
	idPsSupplier int,
	idPsProduct int,
	quantity int not null,
	primary key(idPsSupplier,idPsProduct),
	constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
	constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

CREATE TYPE payment as enum('Boleto','Cartão','Dois Cartões');

CREATE TABLE payments(
	idclient int,
	idPayment int,
	current_payment payment,
	limitAvailable float,
	primary key (idClient, idPayment)
);

INSERT INTO client (fname,minit,lname,cpf,address)values
	('Maria','M','Silva',123456789,'rua silva de prata 29'), 
	('Matheus','O','Pimentel',987654321,'rua silva de prata 29'),
	('Ricardo','F','Silva',45678913,'rua silva de prata 29'),
	('Isabela','M','Cruz',654789123,'rua silva de prata 29');
		
SELECT * FROM client;

INSERT INTO product(Pname, classfication_kids, current_category, avaliação, size) values
			('Fone',false,'Eletrônico','4',null),
			('Barbie', true,'Brinquedo','3',null),
			('Sofá',false,'Móvies','3','3x57x80');
			
SELECT * FROM product;

INSERT INTO ordens(idOrderClient, current_orderStatus,orderdescrition,sendValue,paymentCash) values
		(1,'Confirmado','compra via aplicativo',null,false),
		(2,'Em processamento','compra via aplicativo',50,true),
		(3,'Confirmado',null,null,false);
		
SELECT * FROM ordens;	

INSERT INTO productOrder(idPOproduct,idPOorder,poQuantity,currents_poStatus) values
		(1,5,2,null),
		(2,5,1,null),
		(3,5,1,null);
		
SELECT * FROM productOrder;

INSERT INTO productStorage(storageLocation,quantity) values
		('Rio de Janeiro',1000),
		('Rio de Janeiro',500),
		('São Paulo',100);
		
INSERT INTO storageLocation(idLproduct,idLstorage,location)values
		(1,2,'RJ'),
		(2,1,'GO');

INSERT INTO supplier(SocialName,CNPJ,contact) values
		('Almeida e filhos',123456789123456,'951854740'),
		('Eletronicos Silva',854519649143457,'11219854845'),
		('Eletronicos Valma',934567893934695,'1121975474');
		
INSERT INTO productSupplier(idPsSupplier,idPsProduct,quantity) values
		(1,1,500),
		(1,2,400),
		(2,4,633);	
		
INSERT INTO seller(SocialName,CNPJ,CPF,location,contact) values
		('Tech eletronics',123456789456321,null,'Rio de Janeiro','219946287'),
		('Botique Durgas',null,123456783,'Rio de Janeiro','219900287'),
		('Kids World',456789123654485,null,'São Paulo','219946200');	

INSERT INTO productSeller(idpseller,idProduct,prodQuantity) values
		(1,6,80),
		(2,3,10);


		
		