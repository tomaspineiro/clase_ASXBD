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

    DECLARE repartirPorContinetes CURSOR FOR SELECT ID_Cliente, Fecha_pedido, Zona, ID_Pedido FROM ventas WHERE ((TIMESTAMPDIFF(MONTH, STR_TO_DATE(Fecha_pedido, '%d-%m-%Y'), '2023-03-01') >= 1) &&  (TIMESTAMPDIFF(MONTH, STR_TO_DATE(Fecha_pedido, '%d-%m-%Y'), '2023-03-01') <= 2));

    DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;

    OPEN repartirPorContinetes;  

    WHILE vFinal = 0 DO  
        FETCH repartirPorContinetes INTO idCliente, FechaPedido, ZonaP, IDPedido;
        IF vFinal = 0 THEN 
            CASE 
                WHEN ZonaP = 'África' THEN
                    INSERT Africa_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Asia' THEN
                    INSERT Asia_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Australia y Oceanía' THEN
                    INSERT Astralia_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Centroamérica y Caribe' THEN
                    INSERT centroamerica_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Europa' THEN
                    INSERT europa_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
                WHEN ZonaP = 'Norteamérica' THEN
                    INSERT norteamerica_ventas SELECT * FROM ventas WHERE ID_Pedido=IDPedido;
            END CASE;
        END IF;    

    END WHILE;   

    CLOSE repartirPorContinetes; -- fin del cursor 

END // -- fin del procediminto.
DELIMITER ;