/*
Disparadores para validar a entrada de datos.  Validar letra NIF
Esta tarefa realizarase na base de datos enterprise. As táboas desta base de datos que se van a utilizar nesta actividade móstranse no seguinte diagrama entidade/relación.

Para unha nova aplicación que se vai crear, precisamos extraer unha serie de datos da táboa templeados, creando a táboa empregados co nome, apelidos, nif e data de nacemento. 

Sabemos que hai nif’s incorrectos, isto é, a letra non se corresponde como algoritmo de cálculo. 
*/
--- preeparacion del EJercio 
/*
Tenemos que cargar la Base de datos enterprise. Esta guardada en la carpeta ../BasesDeDatos
*/
-- Resolucion del ejercio / creacion de trigger
USE enterprise;

CREATE OR REPLACE TABLE empregado (
    id INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50),
    apelidos VARCHAR(105),
    nif VARCHAR(9),
    data_nacemento DATETIME,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- funcion:
DELIMITER //
CREATE OR REPLACE FUNCTION CaluclarDNIletra( DNI VARCHAR(9)) RETURNS VARCHAR(9)
BEGIN

    DECLARE letras VARCHAR(23);
    DECLARE godDNI VARCHAR(9);
    DECLARE numDNI VARCHAR(8);
    DECLARE restoDNI INT;
    DECLARE letraDNI VARCHAR(1);

    SET letras="trwagmyfpdxbnjzsqvhlcke"; 
    SET numDNI = SUBSTRING(DNI, 1, 8);
    SET restoDNI = (numDNI % 23) + 1;   
    SET godDNI=CONCAT(numDNI, UPPER(SUBSTRING(letras, restoDNI,1)));
    
    RETURN godDNI;

END //
DELIMITER ;

-- trigger: 
DELIMITER //
CREATE OR REPLACE TRIGGER corregirDNI BEFORE INSERT ON empregado FOR EACH ROW 
BEGIN
    SET NEW.nif = CaluclarDNIletra(NEW.nif);    
END //
DELIMITER ;

-- procedimieto y cursor: 
DELIMITER //
CREATE OR REPLACE  PROCEDURE CargarNEWtabla()
BEGIN

    DECLARE vFinal integer DEFAULT 0;
    DECLARE nome_pro VARCHAR(50); 
    DECLARE apelidos_pro VARCHAR(105);
    DECLARE nif_pro VARCHAR(9);
    DECLARE data_nacemento_pro DATETIME;

    DECLARE empleados CURSOR FOR  SELECT nomemp, CONCAT(  ape1emp, ' ', ape2emp), NIFemp, fnacemp FROM templeados;

    DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;

    OPEN empleados;

    WHILE vFinal = 0 DO

        FETCH empleados INTO nome_pro, apelidos_pro, nif_pro, data_nacemento_pro;

        IF vFinal = 0 THEN 

            INSERT INTO enterprise.empregado ( nome, apelidos, nif, data_nacemento) VALUES (nome_pro, apelidos_pro, nif_pro, data_nacemento_pro);

        END IF;

    END WHILE;

    CLOSE empleados;

END //
DELIMITER ;


-- Comprobacion de que el ejercio funciona correctamente 


call CargarNEWtabla();

select CaluclarDNIletra("12345678a");

INSERT INTO enterprise.empregado( nome, apelidos, nif, data_nacemento) VALUES ("PEPE", "LOPEZ", "12345678A", "2001-03-10 00:00:00");


INSERT INTO enterprise.empregado( nome, apelidos, nif, data_nacemento) SELECT nomemp, CONCAT(  ape1emp, ' ', ape2emp), NIFemp, fnacemp FROM templeados;
