use  relacionamentos;

CREATE TABLE `funcionarios` (
  `cod_func` int NOT NULL AUTO_INCREMENT,
  `nome_func` varchar(100) NOT NULL,
  `end_func` varchar(200) NOT NULL,
  `sal_func` decimal(10,2) NOT NULL DEFAULT '0.00',
  `sexo_func` char(1) NOT NULL DEFAULT 'f',
  PRIMARY KEY (`cod_func`),
  CONSTRAINT `ch_func_1` CHECK ((`sal_func` >= 0)),
  CONSTRAINT `ch_func_2` CHECK ((`sexo_func` in (_utf8mb4'f',_utf8mb4'm')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dependentes` (
  `cod_dep` int NOT NULL AUTO_INCREMENT,
  `cod_func` int NOT NULL,
  `nome_dep` varchar(100) NOT NULL,
  `sexo_dep` char(1) NOT NULL DEFAULT 'm',
  PRIMARY KEY (`cod_dep`),
  KEY `fk_dep` (`cod_func`),
  CONSTRAINT `fk_dep` FOREIGN KEY (`cod_func`) REFERENCES `funcionarios` (`cod_func`),
  CONSTRAINT `ch_dep` CHECK ((`sexo_dep` in (_utf8mb4'f',_utf8mb4'm')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `estados` (
  `sigla_est` char(2) NOT NULL,
  `nome_est` char(50) NOT NULL,
  PRIMARY KEY (`sigla_est`),
  UNIQUE KEY `uq_est` (`nome_est`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cidades` (
  `cod_cid` int NOT NULL AUTO_INCREMENT,
  `sigla_est` char(2) NOT NULL,
  `nome_cid` varchar(100) NOT NULL,
  PRIMARY KEY (`cod_cid`),
  KEY `fk_cid` (`sigla_est`),
  CONSTRAINT `fk_cid` FOREIGN KEY (`sigla_est`) REFERENCES `estados` (`sigla_est`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `clientes` (
  `cod_cli` int NOT NULL AUTO_INCREMENT,
  `cod_cid` int NOT NULL,
  `nome_cli` varchar(100) NOT NULL,
  `end_cli` varchar(100) NOT NULL,
  `renda_cli` decimal(10,2) NOT NULL DEFAULT '0.00',
  `sexo_cli` char(1) NOT NULL DEFAULT 'f',
  PRIMARY KEY (`cod_cli`),
  KEY `fk_cli` (`cod_cid`),
  CONSTRAINT `fk_cli` FOREIGN KEY (`cod_cid`) REFERENCES `cidades` (`cod_cid`),
  CONSTRAINT `ch_cli_1` CHECK ((`renda_cli` >= 0)),
  CONSTRAINT `ch_cli_2` CHECK ((`sexo_cli` in (_utf8mb4'f',_utf8mb4'm')))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `conjuge` (
  `cod_cli` int NOT NULL,
  `nome_conj` varchar(100) NOT NULL,
  `renda_conj` decimal(10,2) NOT NULL DEFAULT '0.00',
  `sexo_conj` char(1) NOT NULL DEFAULT 'm',
  PRIMARY KEY (`cod_cli`),
  CONSTRAINT `fk_conj` FOREIGN KEY (`cod_cli`) REFERENCES `clientes` (`cod_cli`),
  CONSTRAINT `ch_conj_1` CHECK ((`renda_conj` >= 0)),
  CONSTRAINT `ch_conj_2` CHECK ((`sexo_conj` in (_utf8mb4'f',_utf8mb4'm')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `artistas` (
  `cod_art` int NOT NULL AUTO_INCREMENT,
  `nome_art` varchar(100) NOT NULL,
  PRIMARY KEY (`cod_art`),
  UNIQUE KEY `uq_art` (`nome_art`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `gravadoras` (
  `cod_grav` int NOT NULL AUTO_INCREMENT,
  `nome_grav` varchar(50) NOT NULL,
  PRIMARY KEY (`cod_grav`),
  UNIQUE KEY `nome_grav` (`nome_grav`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `categorias` (
  `cod_cat` int NOT NULL AUTO_INCREMENT,
  `nome_cat` varchar(50) NOT NULL,
  PRIMARY KEY (`cod_cat`),
  UNIQUE KEY `uq_cat` (`nome_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `titulos` (
  `cod_tit` int NOT NULL AUTO_INCREMENT,
  `cod_cat` int NOT NULL,
  `cod_grav` int NOT NULL,
  `nome_cd` varchar(100) NOT NULL,
  `val_compa` decimal(10,2) NOT NULL,
  `val_cd` decimal(10,2) NOT NULL,
  `qtd_estq` int NOT NULL,
  PRIMARY KEY (`cod_tit`),
  UNIQUE KEY `uq_tit` (`nome_cd`),
  KEY `fk_tit_1` (`cod_cat`),
  KEY `fk_tit_2` (`cod_grav`),
  CONSTRAINT `fk_tit_1` FOREIGN KEY (`cod_cat`) REFERENCES `categorias` (`cod_cat`),
  CONSTRAINT `fk_tit_2` FOREIGN KEY (`cod_grav`) REFERENCES `gravadoras` (`cod_grav`),
  CONSTRAINT `ch_tit_1` CHECK ((`val_cd` >= 0)),
  CONSTRAINT `ch_tit_2` CHECK ((`qtd_estq` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `titulos_artistas` (
  `cod_tit` int NOT NULL AUTO_INCREMENT,
  `cod_art` int NOT NULL,
  PRIMARY KEY (`cod_tit`,`cod_art`),
  KEY `fk2_titart` (`cod_art`),
  CONSTRAINT `fk1_titart` FOREIGN KEY (`cod_tit`) REFERENCES `titulos` (`cod_tit`),
  CONSTRAINT `fk2_titart` FOREIGN KEY (`cod_art`) REFERENCES `artistas` (`cod_art`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*from titulos_artistas;

create table pedidos(
num_ped int  not null auto_increment,
cod_cli int not null,
cod_func int not null,
data_ped datetime not null,
constraint pk_ped primary key(num_ped),
constraint fk_ped_1 foreign key(cod_cli) references clientes(cod_cli),
constraint fk_ped_2 foreign key(cod_func) references funcionarios(cod_func));

insert pedidos values(null,11,2,'2012/05/02'),
(null,13,4,'2012/05/02'),
(null,14,5,'2012/06/02'),
(null,11,4,'2013/03/02'),
(null,17,5,'2013/03/02'),
(null,14,4,'2013/03/02'),
(null,15,5,'2013/03/02'),
(null,18,2,'2013/03/02'),
(null,12,2,'2013/03/02'),
(null,17,1,'2013/03/02');

select*from pedidos;

create table titulos_pedidos(
num_ped int not null,
cod_tit int not null,
qtd_cd int not null,
val_cd decimal(10,2) not null,

constraint pk_titped primary key(num_ped,cod_tit),
constraint fk_titped_4 foreign key(cod_tit) references titulos(cod_tit),
constraint fk_titped_3 foreign key(num_ped) references pedidos(num_ped),
constraint ch_titped_2 check(qtd_cd>=1),
constraint ch_titped_3 check(val_cd>=0));

insert titulos_pedidos values(52,1,2,150.00),
(52,2,3,200.00),
(53,1,1,150.00),
(53,2,3,200.00),
(54,1,2,150.00),
(55,2,3,200.00),
(56,1,2,150.00),
(57,2,3,200.00),
(57,3,1,120.00),
(58,4,2,70.00),
(59,1,4,150.00),
(60,2,3,200.00),
(61,7,2,250.00);

select*from pedidos;
select*from titulos;
select*from categorias;
select*from gravadoras;
select*from titulos_pedidos;


