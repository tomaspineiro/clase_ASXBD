delimiter //  
create or replace function saludo() returns VARCHAR(40)
begin 
	declare hola VARCHAR(40);
	set hola = "hola mundo";
	
	return hola;
end //
delimiter ;

------------------------------------------------------------------------------------------

delimiter //  
create or replace function saludo(nombre VARCHAR(20)) returns VARCHAR(40)
begin 
	declare hola VARCHAR(40);
	set hola = concat("hola ", nombre);
	
	return hola;
end //
delimiter ;

--------------------------------------------------------------------------------------------------




