-- ejercio 1

DELIMITER //
CREATE OR REPLACE  PROCEDURE nostrarxogadores()
BEGIN

	DECLARE vFinal integer DEFAULT 0;
	DECLARE juegador_id BIGINT;
	DECLARE jugador_name VARCHAR(120);
	DECLARE jugador_time BIGINT;
	DECLARE jugador_Penalty1 BIGINT;
	DECLARE jugador_Penalty2 BIGINT;
	DECLARE jugador_Points BIGINT;
	
	DECLARE verJuegos CURSOR FOR SELECT * FROM Runners;
	
	DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;
	
	OPEN verJuegos;
	
	WHILE vFinal = 0 DO
	
		FETCH verJuegos INTO juegador_id, jugador_name, jugador_time, jugador_Penalty1, jugador_Penalty2, jugador_Points;
	
		IF vFinal = 0 THEN
	
			SELECT juegador_id, jugador_name, jugador_time, jugador_Penalty1, jugador_Penalty2, jugador_Points;
	
		END IF;
	
	END WHILE;
	
	CLOSE verJuegos;

END //

DELIMITER ;

call nostrarxogadores(); 

-- ejercio 2

DELIMITER //
CREATE OR REPLACE FUNCTION calculaPoints( jugador_time BIGINT(20), jugador_Penalty1 BIGINT(20), jugador_Penalty2 BIGINT(20)) RETURNS BIGINT(20) 
BEGIN
	DECLARE total BIGINT(20);
	SET total=((500 - jugador_time) - (5 * jugador_Penalty1) - (3 * jugador_Penalty2));
	RETURN total;
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE datosPoints()
BEGIN
DECLARE vFinal integer DEFAULT 0;
DECLARE jugador_id BIGINT;
DECLARE jugador_time BIGINT;
DECLARE jugador_Penalty1 BIGINT;
DECLARE jugador_Penalty2 BIGINT;
DECLARE verJuegos CURSOR FOR SELECT Runner_id, Time, Penalty1, Penalty2 FROM Runners;
DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;
OPEN verJuegos;
WHILE vFinal = 0 DO
FETCH verJuegos INTO jugador_id, jugador_time, jugador_Penalty1, jugador_Penalty2;
IF vFinal = 0 THEN

	update Runners set Points=calculaPoints( jugador_time, jugador_Penalty1, jugador_Penalty2) where Runner_id=jugador_id;
END IF;
END WHILE;
CLOSE verJuegos;
END //
DELIMITER ;

-----------------------------------------

CALL datosPoints();

SELECT * FROM Runners;

