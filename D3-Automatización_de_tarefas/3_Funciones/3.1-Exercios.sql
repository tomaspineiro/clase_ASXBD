-- # BOLETIN 3-1 #

USE empleados;

-- EJECIO 1

DELIMITER //  
CREATE OR REPLACE FUNCTION departamento_getName(id int(11) ) RETURNS VARCHAR(50)
BEGIN
	DECLARE name_departamento VARCHAR(50);
	
	SET name_departamento = IFNULL ((SELECT d.nombredep FROM departamento AS d WHERE d.numdep = id), "Descoñecido" );
	
	RETURN  name_departamento;
END //
DELIMITER ;

------------------------------------------------------------------------------------------------------

DELIMITER //  
CREATE OR REPLACE FUNCTION departamento_getName(id int(11) ) RETURNS VARCHAR(50)
BEGIN
	DECLARE name_departamento VARCHAR(50) DEFAULT "descoñecido";
	
	SELECT d.Nombredep INTO name_departamento FROM departamento AS d WHERE d.Numdep = id;
	
	RETURN  name_departamento;
END //
DELIMITER ;
 
-- ###################################################################################################

-- EJERCIO 2

DELIMITER //  
CREATE OR REPLACE FUNCTION masHorastrabjadas(id_empleado VARCHAR(6) ) RETURNS int(10) 
BEGIN
	DECLARE hora_max int(10);
		
	SELECT max(NUMHORAS) INTO hora_max FROM empleadoproyecto as ep WHERE ep.NSS = id_empleado ;
	
	set hora_max = IFNULL(hora_max, 0);
	
	RETURN  hora_max;
END //
DELIMITER ;


