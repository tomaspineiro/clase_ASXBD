use Empresa;

create table clientes ( 
	codigo int not null AUTO_INCREMENT,  
	nombre  VARCHAR(50) not null,
	domicilio VARCHAR(255),
	ciudad VARCHAR(255),
	codigoProvincia int,
	telefono VARCHAR(20),
	primary key (codigo),
	FOREIGN KEY (codigoProvincia) REFERENCES provincias(codigo)
);

create table provincias (
	codigo  int not null auto_increment,
	nombre VARCHAR(255),
	primary key (codigo)
);



