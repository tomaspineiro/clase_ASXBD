create database Empresa;

use Empresa;
drop table IF EXISTS centros ;
drop table IF EXISTS departamentos ;
drop table IF EXISTS empleados ;

create table centros(
numero int primary key,
nombre VARCHAR(32),
direccion VARCHAR(32)
);

create table departamentos(
numero int primary key,
centro int not null,
director int not null,
tipo_dir VARCHAR(1) not null,
presupuesto int not null,
depto_jefe int,
nombre VARCHAR(32) not null,
constraint ck_departamentos check (tipo_dir in ('F','P'))
);

create table empleados(
cod int primary key,
departamento int not null,
telefono int not null,
fecha_nacimiento date,
fecha_ingreso date,
salario int,
comision int,
num_hijos int DEFAULT 0,
nombre VARCHAR(32) not null
);

-- Inserción de valores en la tabla centros:
INSERT INTO centros VALUES (10,  'SEDE CENTRAL', 'C. ALCALA 820, MADRID');
INSERT INTO centros VALUES (20,  'RELACION CON CLIENTES', 'C. ATOCHA 405, MADRID');

-- Inserción de valores en la tabla departamentos:
INSERT INTO departamentos VALUES (100, 10, 260, 'P', 12, null, 'DIRECCION GENERAL');
INSERT INTO departamentos VALUES (110, 20, 180, 'P', 15, 100, 'DIRECC. COMERCIAL');
INSERT INTO departamentos VALUES (111, 20, 180, 'F', 11, 110, 'SECTOR INDUSTRIAL');
INSERT INTO departamentos VALUES (112, 20, 270, 'P', 9, 100, 'SECTOR SERVICIOS');
INSERT INTO departamentos VALUES (120, 10, 150, 'F', 3, 100, 'ORGANIZACION');
INSERT INTO departamentos VALUES (121, 10, 150, 'P', 2, 120, 'PERSONAL');
INSERT INTO departamentos VALUES (122, 10, 350, 'P', 6, 120, 'PROCESO DE DATOS');
INSERT INTO departamentos VALUES (130, 10, 310, 'P', 2, 100, 'FINANZAS');

-- Inserción de valores en la tabla empleados:
INSERT INTO empleados VALUES (110, 121, 350, '19291110', '19500210', 1310, null, 3, 'PONS, CESAR');
INSERT INTO empleados VALUES (120, 112, 840, '19350609', '19681001', 1350, 110, 1, 'LASA, MARIO');
INSERT INTO empleados VALUES (130, 112, 810, '19451109', '19690201', 1290, 110, 2, 'TEROL, LUCIANO');
INSERT INTO empleados VALUES (150, 121, 340, '19300810', '19480115', 1440, null, 0, 'PEREZ, JULIO');
INSERT INTO empleados VALUES (160, 111, 740, '19390709', '19681111', 1310, 110, 2, 'AGUIRRE, AUREO');
INSERT INTO empleados VALUES (180, 110, 508, '19341018', '19560318', 1480, 50,  2, 'PEREZ, MARCOS');
INSERT INTO empleados VALUES (190, 121, 350, '19320512', '19620211', 1300, null, 4, 'VEIGA, JULIANA');
INSERT INTO empleados VALUES (210, 100, 200, '19400928', '19590122', 1380, null, 2, 'GALVEZ, PILAR');
INSERT INTO empleados VALUES (240, 111, 760, '19420226', '19660224', 1280, 100, 3, 'SANZ, LAVINIA');
INSERT INTO empleados VALUES (250, 100, 250, '19461027', '19670301', 1450, null, 0, 'ALBA, ADRIANA');
INSERT INTO empleados VALUES (260, 100, 220, '19431203', '19680702', 1720, null, 6, 'LOPEZ, ANTONIO');
INSERT INTO empleados VALUES (270, 112, 800, '19450521', '19660910', 1380, 80, 3, 'GARCIA, OCTAVIO');
INSERT INTO empleados VALUES (280, 130, 410, '19480111', '19711008', 1290, null, 5, 'FLOR, DOROTEA');
INSERT INTO empleados VALUES (285, 122, 620, '19491025', '19680215', 1380, null, 0, 'POLO, OTILIA');
INSERT INTO empleados VALUES (290, 120, 910, '19471130', '19680214', 1270, null, 3, 'GIL, GLORIA');
INSERT INTO empleados VALUES (310, 130, 480, '19461121', '19710115', 1420, null, 0, 'GARCIA, AUGUSTO');
INSERT INTO empleados VALUES (320, 122, 620, '19571225', '19780205', 1405, null, 2, 'SANZ, CORNELIO');
INSERT INTO empleados VALUES (330, 112, 850, '19480819', '19720301', 1280, 90, 0, 'DIEZ, AMELIA');
INSERT INTO empleados VALUES (350, 122, 610, '19490313', '19840910', 1450, null, 1, 'CAMPS, AURELIO');
INSERT INTO empleados VALUES (360, 111, 750, '19581029', '19681010', 1250, 100, 2, 'LARA, DORINDA');
INSERT INTO empleados VALUES (370, 121, 360, '19670622', '19870120', 1190, null, 1, 'RUIZ, FABIOLA');
INSERT INTO empleados VALUES (380, 112, 880, '19680330', '19880101', 1180, null, 0, 'MARTIN, MICAELA');
INSERT INTO empleados VALUES (390, 110, 500, '19660219', '19861008', 1215, null, 1, 'MORAN, CARMEN');
INSERT INTO empleados VALUES (400, 111, 780, '19690819', '19871101', 1185, null, 0, 'LARA, LUCRECIA');
INSERT INTO empleados VALUES (410, 122, 660, '19680714', '19881013', 1175, null, 0, 'MIGUEZ, AZUCENA');
INSERT INTO empleados VALUES (420, 130, 450, '19661022', '19881119', 1400, null, 0, 'FIERRO, CLAUDIA');
INSERT INTO empleados VALUES (430, 122, 650, '19671026', '19881019', 1210, null, 1, 'MORA, VALERIANA');
INSERT INTO empleados VALUES (440, 111, 760, '19660927', '19860228', 1210, 100, 0, 'DURAN, LIVIA');
INSERT INTO empleados VALUES (450, 112, 880, '19661021', '19860228', 1210, 100, 0, 'PEREZ, SABINA');
INSERT INTO empleados VALUES (480, 111, 760, '19650404', '19860228', 1210, 100, 1, 'PINO, DIANA');
INSERT INTO empleados VALUES (490, 112, 880, '19640606', '19880101', 1180, 100, 0, 'TORRES, HORACIO');
INSERT INTO empleados VALUES (500, 111, 750, '19651008', '19870101', 1200, 100, 0, 'VAZQUEZ, HONORIA');
INSERT INTO empleados VALUES (510, 110, 550, '19660504', '19861001', 1200, null, 1, 'CAMPOS, ROMULO');
INSERT INTO empleados VALUES (550, 111, 780, '19700110', '19880121', 1100, 120, 0, 'SANTOS, SANCHO');

-- alter tables
alter table empleados add constraint fk_empleados_departamentos foreign key (departamento) references departamentos(numero);

alter table departamentos add constraint fk_departamentos_centros foreign key (centro) references centros(numero);

alter table departamentos add constraint fk_departamentos_empleados foreign key (director) references empleados(cod);

alter table departamentos add constraint fk_departamentos_departamentos foreign key(depto_jefe) references departamentos(numero);

