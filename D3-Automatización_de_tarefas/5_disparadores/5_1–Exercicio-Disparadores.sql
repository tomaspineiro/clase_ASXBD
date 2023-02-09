
/*
Crear un disparador que ao gravar un rexistro con idade menor que 0 poña o valor a 0. 
Para levar a cabo esta tarefa crearase a seguinte táboa: 
    CREATE TABLE people (age INT, name VARCHAR(150));

O disparador executarase antes de cada sentencia INSERT na táboa people
*/
--- preeparacion del EJercio 

CREATE DATABASE peoples;

USE peoples;

CREATE TABLE people (age INT, name VARCHAR(150));

--
-- creacion de trigger
DELIMITER //
CREATE OR REPLACE TRIGGER edadPositiva BEFORE INSERT ON people FOR EACH ROW 
BEGIN

    IF NEW.age < 0 THEN

        SET NEW.age=0;  

    END IF;

END //
DELIMITER ;


-- Comprobacion de que el ejercio funciona correctamente 

INSERT INTO peoples.people ( age, name) VALUES (-52, "tom"), (12, "pepe"), ( -69, "akai");

SELECT * FROM peoples.people;