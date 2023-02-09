/*
Unha librería almacena os datos dos seus libros nunha táboa denominada "libros" e controla as accións que os empregados realizan sobre dita táboa almacenando na táboa "control" o nome do usuario e a data, cada vez que se modifica o "prezo" dun libro

A táboa control conterá o nome do usuario, a data da modificación, o código do libro, o novo prezo e se o movemento é de inserción ou modificación .
*/

-- Preparativos Para hacer el Ejercio.

/* Creamos la base de datos libreria: */

DROP DATABASE IF EXISTS libreria;
CREATE OR REPLACE DATABASE libreria;

USE libreria;
/* Creamos as táboas coas seguintes estruturas: */
CREATE TABLE libros(
    codigo INT(6),
    titulo VARCHAR(40),
    autor  VARCHAR(30),
    editorial VARCHAR(20),
    precio FLOAT(6,2),
    PRIMARY KEY  (codigo)
);
/* Ingresamos algúns rexistros en "libros": */
INSERT INTO libros VALUES (100,'Uno','Richard Bach','Planeta',25), (103,'El aleph','Borges','Emece',28), (105,'Matematica estas ahi','Paenza','Nuevo siglo',12), (120,'Aprenda PHP','Molina Mario','Nuevo siglo',55), (145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);

-- Resolucion del ejercio 

-- Creamos la tabla control sobre la que guardamos los datos, de las modoficaciones. 

CREATE OR REPLACE TABLE control (
    idControl INT NOT NULL AUTO_INCREMENT,
    nome_usuario VARCHAR(50),
    data_modificacion DATETIME,
    codigo_libro INT(6),
    accian ENUM('insercion','modificacion') NOT NULL,
    nowPrecio FLOAT(6,2),
    PRIMARY KEY (idControl),
    FOREIGN KEY (codigo_libro) REFERENCES libros(codigo)
);

-- Creacion de los trigger

-- triger insert:
DELIMITER //
DROP TRIGGER IF EXISTS controlaEmpleadosInsert//
CREATE TRIGGER controlaEmpleadosInsert AFTER INSERT ON libros FOR EACH ROW 
BEGIN
    INSERT INTO  control (nome_usuario, data_modificacion, codigo_libro, accian, nowPrecio) VALUES ( CURRENT_USER(), NOW(), NEW.codigo, "insercion", NEW.precio);
END //

-- triger update:
DROP TRIGGER IF EXISTS controlaEmpleadosUpdate//
CREATE TRIGGER controlaEmpleadosUpdate AFTER UPDATE ON libros FOR EACH ROW 
BEGIN

    INSERT INTO  control (nome_usuario, data_modificacion, codigo_libro, accian, nowPrecio) VALUES ( CURRENT_USER(), NOW(), OLD.codigo, "modificacion", NEW.precio);

END //
DELIMITER ;

-- Comprobacion de que el ejercio se soluciona correctamente. 

INSERT INTO libros VALUES(34,'Apais de las maravillas','Carhyrsjhroll','Pgsrglaneta',35);

UPDATE libros set precio=66 where codigo=34;

select  * from control;
