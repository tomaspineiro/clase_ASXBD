
-- ejercio 1 
DELIMITER //
	CREATE FUNCTION mediaNotas(nota1 decimal(10,2), nota2 decimal(10,2), nota3 decimal(10,2)) RETURNS decimal(10,2)
	BEGIN 
		DECLARE media decimal(10,2);
		
		SET media = ( nota1 + nota2 + nota3) / 3;
		
		RETURN media;
	END //

DELIMITER ;

select mediaNotas(nota1, nota2, nota3 ) as media from notasexamenes;


-- ejercio 2

DELIMITER //
	CREATE OR REPLACE FUNCTION resultado(nota decimal(10,2)) RETURNS VARCHAR(20)
	BEGIN 
	DECLARE resultado  VARCHAR(20);
	CASE 
		WHEN nota < 3 THEN 
			SET resultado = 'Moi defuciente';	
		WHEN nota < 5 THEN 
			SET resultado = 'Insufuciente';	
		WHEN nota < 7 THEN 
			SET resultado = 'Suficiente';	
		WHEN nota < 9 THEN 
			SET resultado = 'Notable';	
		WHEN nota < 10 THEN 
			SET resultado = 'Sobresaínte';	
	END CASE;
	RETURN resultado;
	END //
DELIMITER ;



select resultado(mediaNotas(nota1, nota2, nota3)) as media from notasexamenes;






