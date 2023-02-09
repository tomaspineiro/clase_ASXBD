-- #Boletin 3.1 #

-- EJERCIO 1

DELIMITER //
CREATE OR REPLACE FUNCTION beneficios(coste FLOAT, precio FLOAT) RETURNS FLOAT
BEGIN
	DECLARE beneficio FLOAT;
	
	SET beneficio = precio - coste;
	
	RETURN beneficio;
	
END //
DELIMITER ;

select p.nombre, p.coste, p.precio, beneficios(p.coste, p.precio) from produtos as p;

-- ##########################################################################################

-- EJECIO 2

DELIMITER //
CREATE OR REPLACE FUNCTION precioIVA(precio FLOAT, tipo_iva TINYINT) RETURNS FLOAT
BEGIN
	DECLARE precioIVA FLOAT;
	
	IF tipo_iva = 1 THEN 
		SET precioIVA = precio * 1.04;
	ELSEIF tipo_iva = 2 THEN 
		SET precioIVA = precio * 1.10;
	ELSEIF tipo_iva = 3 THEN 
		SET precioIVA = precio * 1.21;
	END IF;
	
	RETURN precioIVA;
	
END //
DELIMITER ;

----------------------------------------------------------------------------------------------------

-- como le gusta el profe

DELIMITER //
CREATE OR REPLACE FUNCTION precioIVA(precio FLOAT, tipo_iva TINYINT) RETURNS FLOAT
BEGIN
	DECLARE precioIVA FLOAT;
	DECLARE valor int;
	
	IF tipo_iva=1 THEN 
		SET valor = 4;
	ELSEIF tipo_iva=2 THEN 
		SET valor = 10;
	ELSEIF tipo_iva=3 THEN
		SET valor = 21;
	END IF;
	
	SET precioIVA = precio * (1 + ( valor /100));

	RETURN precioIVA;
	
END //
DELIMITER ;




select p.nombre, p.coste, p.precio, beneficios(p.coste, p.precio) AS beneficio , precioIVA(p.precio, p.tipo_iva) AS precioConIVA from produtos as p;

