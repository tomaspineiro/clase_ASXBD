/* 
Programar un evento que catro veces ao ano ELIMINE* aos usuarios do blog sobre novas do motor que non publican dende hai máis de tres meses (QUARTER). 

*A eliminación é un proceso definitivo, e que pode provocar inconsistencias nas táboas da nosa BD. No lugar de facer un eliminado físico debes facer un eliminado lóxico, para elo deberás engadir unha nova columna na táboa de autores que sirva como bandeira de borrado si ou non. 

    1-Código que engade o campo bandeira á táboa de autores;
	    ALTER TABLE autores ADD f_borrado datetime; (POR DEFECCTO ES NULL)

    2-Código do evento.
	    SHOW VARIABLES LIKE 'event_scheduler';  
	    SET GLOBAL event_scheduler = 1;

    3-Listaxe dos autores marcados como eliminados.
    4-Estado dos eventos.
        SELECT * FROM INFORMATION_SCHEMA.EVENTS;

*/
-- Preeparacion del Ejercio 
/*
Tenemos que cargar la Base de datos 6.1nmotor.sql Esta guardada en la carpeta ../BasesDeDatos
*/

USE nmotor;

ALTER TABLE autores ADD f_borrado datetime; 

-- Resolucion del ejercio 

DROP EVENT IF EXISTS insertion_event;

CREATE EVENT insertion_event ON SCHEDULE AT 1 QUARTER DO 
UPDATE autores SET f_borrado=CURRENT_TIMESTAMP() WHERE (id_autor IN (SELECT autor_id FROM noticias WHERE  TIMESTAMPDIFF( MONTH, fecha_pub, NOW()) > 2 GROUP BY autor_id ORDER BY fecha_pub ASC) OR (id_autor NOT IN (SELECT autor_id FROM noticias GROUP BY autor_id))); 


--- OPCION BUEANA A MEDIAS. 
SELECT * FROM autores WHERE id_autor IN (SELECT autor_id FROM noticias WHERE  TIMESTAMPDIFF( MONTH, fecha_pub, NOW()) >= 0 GROUP BY autor_id ORDER BY fecha_pub ASC);

-- select bueno para escoger los usarios que llevan mas de 3 meses sin escribir una noticia
-- MUCHO TIEMPO IN ACTIVO 
SELECT * FROM autores WHERE id_autor IN (SELECT autor_id FROM noticias WHERE  TIMESTAMPDIFF( MONTH, fecha_pub, NOW()) > 2 GROUP BY autor_id ORDER BY fecha_pub ASC);
-- NO AN ECHO NADA 
SELECT * FROM autores WHERE (id_autor NOT IN (SELECT autor_id FROM noticias GROUP BY autor_id));

-- COMBINACION DE LOS DOS REQUESITOS:
SELECT id_autor FROM autores WHERE (id_autor IN (SELECT autor_id FROM noticias WHERE  TIMESTAMPDIFF( MONTH, fecha_pub, NOW()) > 2 GROUP BY autor_id ORDER BY fecha_pub ASC) OR (id_autor NOT IN (SELECT autor_id FROM noticias GROUP BY autor_id)));