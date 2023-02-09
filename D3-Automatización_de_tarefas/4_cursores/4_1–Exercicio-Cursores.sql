-- 4_1 – Exercicio - Cursores

-- ejercio 

DELIMITER //
CREATE OR REPLACE  PROCEDURE emailsList(OUT emails text)
BEGIN
DECLARE vFinal integer DEFAULT 0;
DECLARE correo VARCHAR(100);
DECLARE emailTendas CURSOR FOR SELECT email FROM tendas WHERE email!="";
DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;
OPEN emailTendas;
SET emails = "";
WHILE vFinal = 0 DO
	FETCH emailTendas INTO correo;
	IF vFinal = 0 THEN
	set emails = CONCAT(emails, ";", correo);
	END IF;
END WHILE;
CLOSE emailTendas;

END //
DELIMITER ;

call emailsList(@lista); 
select @lista;

