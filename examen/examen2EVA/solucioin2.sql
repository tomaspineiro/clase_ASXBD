/* ARREGALAMOS LA BASE DE DATOS PARA PODER TRABAJR CON ELLA.  */
/* 1. Modificar o tipo de dato, facendo os cambios que consideres oportunos.  */
/* alter table ventas add date_Pedido DATE;
alter table ventas add date_envios DATE;
ALTER TABLE ventas DROP COLUMN date_envios;
ALTER TABLE ventas DROP COLUMN date_Pedido; */

DELIMITER //
CREATE OR REPLACE PROCEDURE IDaRREGLART()
BEGIN
    DECLARE vFinal integer DEFAULT 0;
    DECLARE idCliente varchar(10);
    DECLARE IDPedido int(11);
    DECLARE FechaPedido varchar(12);
    DECLARE FechaEnvio varchar(12);
    DECLARE diaPedido varchar(5);
    DECLARE mesPedido varchar(5);
    DECLARE anioPedido varchar(5);
    DECLARE diaEnvia varchar(5);
    DECLARE mesEnvia varchar(5);
    DECLARE anioEnvia varchar(5);


    DECLARE arreglarTabla CURSOR FOR SELECT ID_Cliente, Fecha_pedido,Fecha_envio, ID_Pedido FROM ventas;

    DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;

    OPEN arreglarTabla;  

    WHILE vFinal = 0 DO  
        FETCH arreglarTabla INTO idCliente, FechaPedido, FechaEnvio, IDPedido;

        IF vFinal = 0 THEN 
            SET diaPedido = SUBSTRING(FechaPedido,1,2);
            SET mesPedido = SUBSTRING(FechaPedido,4,2);
            SET anioPedido = SUBSTRING(FechaPedido,7,4);
            SET diaEnvia = SUBSTRING(FechaEnvio,1,2);
            SET mesEnvia = SUBSTRING(FechaEnvio,4,2);
            SET anioEnvia = SUBSTRING(FechaEnvio,7,4);
    

            UPDATE ventas 
                SET 
                    
                    ID_Cliente = CONCAT(LEFT(idCliente,1),'0', SUBSTRING(idCliente,3)), 
                    Fecha_pedido = CONCAT(anioPedido,'-',mesPedido,'-',diaPedido),
                    Fecha_envio = CONCAT(anioEnvia,'-',mesEnvia,'-',diaEnvia)

            WHERE ID_Pedido=IDPedido;

        END IF;    

    END WHILE;   

    CLOSE arreglarTabla; -- fin del cursor 

    ALTER TABLE ventas MODIFY Fecha_pedido DATE;
    ALTER TABLE ventas MODIFY Fecha_envio DATE;


END // -- fin del procediminto.
DELIMITER ;

CALL IDaRREGLART();

SELECT ID_Cliente, Fecha_pedido,Fecha_envio, ID_Pedido FROM ventas;

SELECT CONCAT(LEFT(ID_Cliente,1),'0', SUBSTRING(ID_Cliente,3)) AS idCliente, STR_TO_DATE(Fecha_pedido, '%d-%m-%Y') AS FechaPedido, STR_TO_DATE(Fecha_envio, '%d-%m-%Y') AS FechaEnvio FROM ventas;

SELECT  Fecha_pedido, CONCAT(SUBSTRING(Fecha_pedido,4),'-', LEFT(Fecha_pedido,2)) as core FROM ventas;

/* date_Pedido = STR_TO_DATE(FechaPedido, '%d-%m-%Y'),
date_envios = STR_TO_DATE(FechaEnvio, '%d-%m-%Y') */


/* 2. Cada primeiro de mes debes transferir os datos das ventas ?? t??boa do seu continente. O nome das t??boas de ventas por continente est?? formado polo nome do continente, un gui??n e o texto ventas. Por exemplo, Centroamerica_Ventas, Asia_Ventas, ... En ning??n caso se
borrar??n datos das t??boas orixinais. (2 ptos) */

SELECT Zona, COUNT(Zona) FROM ventas GROUP BY Zona;

CREATE TABLE Africa_ventas like ventas;
CREATE TABLE Asia_ventas like ventas; 
CREATE TABLE Astralia_ventas like ventas; 
CREATE TABLE centroamerica_ventas like ventas; 
CREATE TABLE europa_ventas like ventas; 
CREATE TABLE norteamerica_ventas like ventas; 


-- creacion del evento 
DROP EVENT IF EXISTS separarContintes;
CREATE EVENT separarContintes
ON SCHEDULE EVERY 1 MONTH STARTS '2022-03-01 10:54:15'
DO CALL VentasContinetes();

-- para comprovaR QUE FUNCIONA TODO
DROP EVENT IF EXISTS separarContintes;
CREATE EVENT separarContintes
ON SCHEDULE AT '2023-03-01 10:58:15'
DO CALL VentasContinetes();

DELIMITER //
CREATE OR REPLACE PROCEDURE VentasContinetes()
BEGIN
    DECLARE vFinal integer DEFAULT 0;
    DECLARE idCliente varchar(10);
    DECLARE IDPedido int(11);
    DECLARE FechaPedido varchar(12);
    DECLARE ZonaP varchar(30);

    DECLARE repartirPorContinetes CURSOR FOR SELECT ID_Cliente, Fecha_pedido, Zona, ID_Pedido FROM ventas WHERE ((TIMESTAMPDIFF(MONTH, Fecha_pedido, CURRENT_DATE()) >= 1) &&  (TIMESTAMPDIFF(MONTH, Fecha_pedido, CURRENT_DATE()) <= 2));

    DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;

    OPEN repartirPorContinetes;  

    WHILE vFinal = 0 DO  
        FETCH repartirPorContinetes INTO idCliente, FechaPedido, ZonaP, IDPedido;
        IF vFinal = 0 THEN 
            CASE 
                WHEN ZonaP = '??frica' THEN
                    INSERT Africa_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Asia' THEN
                    INSERT Asia_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Australia y Ocean??a' THEN
                    INSERT Astralia_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Centroam??rica y Caribe' THEN
                    INSERT centroamerica_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Europa' THEN
                    INSERT europa_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Norteam??rica' THEN
                    INSERT norteamerica_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
            END CASE;
        END IF;    

    END WHILE;   

    CLOSE repartirPorContinetes; -- fin del cursor 

END // -- fin del procediminto.
DELIMITER ;

/*  &&  (TIMESTAMPDIFF(MONTH, STR_TO_DATE(FechaPedido, '%Y-%m-%d'), CURRENT_DATE()) < 2) ) */
/* 
3. Paralelamente, iranse transferindo os clientes implicados nas operaci??ns ??s t??boas de cada sucursal, seguindo a nomenclatura empregada anteriormente. De xeito que na t??boa Asia_Clientes s?? haber?? clientes que te??an feito algunha operaci??n con Asia. En ning??n caso se borrar??n datos das t??boas orixinais. (2 ptos)
*/

CREATE TABLE Africa_clientes like clientes;
CREATE TABLE Asia_clientes like clientes; 
CREATE TABLE Astralia_clientes like clientes; 
CREATE TABLE centroamerica_clientes like clientes; 
CREATE TABLE europa_clientes like clientes; 
CREATE TABLE norteamerica_clientes like clientes; 

DELIMITER //
    DROP TRIGGER IF EXISTS insertClienteAfrica //
    CREATE TRIGGER insertClienteAfrica AFTER INSERT ON Africa_ventas FOR EACH ROW 
    BEGIN

        INSERT INTO Africa_clientes SELECT * FROM clientes WHERE ID = NEW.ID_Cliente;

    END //

    DROP TRIGGER IF EXISTS insertClienteAsia //
    CREATE TRIGGER insertClienteAsia AFTER INSERT ON Asia_ventas FOR EACH ROW 
    BEGIN

        INSERT INTO  Asia_clientes SELECT * FROM clientes WHERE ID = NEW.ID_Cliente;

    END //

    DROP TRIGGER IF EXISTS insertClienteAstralia //
    CREATE TRIGGER insertClienteAstralia AFTER INSERT ON Astralia_ventas FOR EACH ROW 
    BEGIN

        INSERT INTO  Astralia_clientes SELECT * FROM clientes WHERE ID = NEW.ID_Cliente;

    END //

    DROP TRIGGER IF EXISTS insertClienteCentroamerica //
    CREATE TRIGGER insertClienteCentroamerica AFTER INSERT ON centroamerica_ventas FOR EACH ROW 
    BEGIN

        INSERT INTO centroamerica_clientes SELECT * FROM clientes WHERE ID = NEW.ID_Cliente;

    END //

    DROP TRIGGER IF EXISTS insertClienteEuropa //
    CREATE TRIGGER insertClienteEuropa AFTER INSERT ON europa_ventas FOR EACH ROW 
    BEGIN

        INSERT INTO  europa_clientes SELECT * FROM clientes WHERE ID = NEW.ID_Cliente;

    END //

    DROP TRIGGER IF EXISTS insertClienteNorteamerica //
    CREATE TRIGGER insertClienteNorteamerica AFTER INSERT ON norteamerica_ventas FOR EACH ROW 
    BEGIN

        INSERT INTO  norteamerica_clientes SELECT * FROM clientes WHERE ID = NEW.ID_Cliente;

    END //
DELIMITER ;


/* 4. Incl??e capturas onde aparezan o n??mero de li??as de cada t??boa resultante, as?? como o importe total das s??as ventas. (0.5 ptos)*/
SELECT SUM(Importe_Coste_total), SUM(Importe_venta_total), COUNT(*) FROM Africa_ventas;
SELECT SUM(Importe_Coste_total), SUM(Importe_venta_total), COUNT(*) FROM Asia_ventas;
SELECT SUM(Importe_Coste_total), SUM(Importe_venta_total), COUNT(*) FROM Astralia_ventas;
SELECT SUM(Importe_Coste_total), SUM(Importe_venta_total), COUNT(*) FROM centroamerica_ventas;
SELECT SUM(Importe_Coste_total), SUM(Importe_venta_total), COUNT(*) FROM europa_ventas;
SELECT SUM(Importe_Coste_total), SUM(Importe_venta_total), COUNT(*) FROM norteamerica_ventas;


/* 5. Incl??e capturas que mostren a cantidade total dos clientes das t??boas de ??frica e Europa. (0.5 ptos) */

SELECT COUNT(*) FROM europa_clientes;
SELECT COUNT(*) FROM Africa_clientes;

/* 6. Comproba, empregando join, si hai alg??n cliente da t??boa de clientes de Centroam??rica que tam??n estea na t??boa de Norteam??rica e Europa. (1 pto) */

SELECT c.* FROM 
    clientes AS c JOIN europa_clientes AS e ON c.ID=e.ID JOIN centroamerica_clientes AS ce ON c.ID=ce.ID JOIN norteamerica_clientes AS n ON c.ID=n.ID;

/* 7. Demostra o resultado do apartado anterior mediante unha sentenza que recolla os datos da t??boa orixinal. (1 pto) */




/* Pruebas */

SELECT ID_Cliente, Fecha_pedido, Zona, ID_Pedido FROM ventas WHERE ((TIMESTAMPDIFF(MONTH, STR_TO_DATE(Fecha_pedido, '%d-%m-%Y'), CURRENT_DATE()) > 1) &&  (TIMESTAMPDIFF(MONTH, STR_TO_DATE(Fecha_pedido, '%d-%m-%Y'), CURRENT_DATE()) < 2));



SELECT TIMESTAMPDIFF(MONTH, STR_TO_DATE('01-02-2023', '%d-%m-%Y'), CURRENT_DATE());

SELECT  STR_TO_DATE('01-02-2023', '%d-%m-%Y');


SELECT ID_Cliente, Fecha_pedido, Zona, ID_Pedido FROM ventas WHERE TIMESTAMPDIFF(MONTH, STR_TO_DATE(Fecha_pedido, '%d-%m-%Y'), CURRENT_DATE()) >= 1;


