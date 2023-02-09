
DELIMITER //
CREATE OR REPLACE FUNCTION clacularVeneficios( mountTotal int) RETURNS int 
BEGIN
	
	DECLARE veneficio int;
	
	IF mountTotal > 10000 THEN
		
		SET veneficio = mountTotal * 0.15;
		
	ELSE 
		
		SET veneficio = mountTotal * 0.10;
		
	END IF;
	
	RETURN veneficio;

END //
DELIMITER ;

--------------------------------------

DELIMITER //
CREATE OR REPLACE  PROCEDURE VeneficiosVendedores()
BEGIN

	DECLARE vFinal integer DEFAULT 0;
	DECLARE idVendor int; 
	DECLARE mountTotal int;

	DECLARE verVentas CURSOR FOR SELECT sp.id, SUM(s.amount) FROM sales AS s  LEFT JOIN sales_persons AS sp ON sp.id=s.sp_id GROUP BY s.sp_id;

	DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;
	
	OPEN verVentas;
	
	WHILE vFinal = 0 DO
		
		FETCH verVentas INTO idVendor, mountTotal ;

		IF vFinal = 0 THEN 

			SELECT idVendor, mountTotal, clacularVeneficios(mountTotal);

		END IF;

	END WHILE;

	CLOSE verVentas;

END //

DELIMITER ;

call VeneficiosVendedores(); 
