/* Base de datos para a tarefa 
Dispoñemos dunha folla de cálculo excel que contén os seguintes datos dos abonados:
    ID – Código único que identifica ao abonados
    Usuario – Nome e apelidos
    Email – Correo electrónico
    Teléfono
    Saldo – Importe que indica o saldo que lle queda ao usuario 

Ademais destes datos, débese incluír unha nova columna na que se indique o nivel ou categoría do abonado. Deberá cubrirse esa columna cun random que entre 1 e 3.
Enunciado:
    1.Cada primeiro de mes descontarase do saldo do usuario a cuota correspondente ao seu nivel ou tipo de usuario:
        A). Se o usuario é tipo 1, descóntanselle 50 €.
        B). Se o usuario é tipo 2, descóntanselle 100 €.
        C). Se o usuario é tipo 3, descóntanselle 200 €.

    2. Se despois de facer o desconto o saldo é negativo, débese incluír na táboa de saldos negativos mensual, co que haberá tantos rexistros dun usuario como veces teña estado con saldo negativo.
    3. Cando un usuario acumule 3 aparicións na táboa mensual, procederase á súa eliminación da táboa de usuarios, non sin antes incluílo na táboa de usuarios eliminados.
 */
-- Preeparacion del Ejercio 
/* 
Tenemos que pasar el archivo usuarios.xlsx a usuarios.csv. Antes tenemos que añadir una calomana que sea tipo que vallan de entre 1 a 3. 
*/
DROP  DATABASE IF EXISTS usuarios
CREATE DATABASE usuarios;

USE usuarios;

DROP  TABLE IF EXISTS usuarios;
create TABLE usuarios (
    ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Usuario VARCHAR(200),
    Email VARCHAR(200),
    Teléfono VARCHAR(9),
    Saldo INT,
    Tipo INT
);

LOAD DATA LOCAL INFILE '/home/usuario/clase_ASXBD/BasesDeDatos/usuarios.csv' INTO TABLE usuarios FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';

-- Resolucion del ejercio 

DROP EVENT IF EXISTS cuotaMes;

CREATE  EVENT IF NOT EXISTS cuotaMes 
    ON SCHEDULE AT 1 MONTH
    DO CALL cobroCuota();

DELIMITER //
CREATE OR REPLACE PROCEDURE cobroCuota()
BEGIN

    DECLARE vFinal integer DEFAULT 0;
    DECLARE idCliente INT;
    DECLARE saldoActual INT;
    DECLARE tipoCliente INT;

    DECLARE tipo1 INT;
    DECLARE tipo2 INT;
    DECLARE tipo3 INT;

    DECLARE restarSaldo CURSOR FOR SELECT id, saldo, tipo FROM usuarios;
    DECLARE CONTINUE handler FOR NOT found SET vFinal = 1;

    SET tipo1 = 50;
    SET tipo2 = 100;
    SET tipo2 = 200;

    -- inicio del cursor

    OPEN restarSaldo;
    
    WHILE vFinal = 0 DO  
        FETCH restarSaldo INTO idCliente, saldoActual, tipoCliente;
        IF vFinal = 0 THEN 
            CASE 
            WHEN tipoCliente = 1 THEN 
                UPDATE usuario SET saldo = saldoActual- tipo1 WHERE id=idCliente;      
            WHEN tipoCliente = 2 THEN
                UPDATE usuario SET saldo = saldoActual - tipo2 WHERE id=idCliente;           
            WHEN tipoCliente = 3 THEN
                UPDATE usuario SET saldo = saldoActual - tipo3 WHERE id=idCliente;           
            END CASE;
        END IF;    
    END WHILE;    

    CLOSE restarSaldo; -- fin del cursor 

END // -- fin del procediminto.
DELIMITER ;

CREATE OR REPLACE TABLE messaldoNegativo (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP(),
    saldoActual INT
);

DELIMITER //
DROP TRIGGER IF EXISTS saldoNegativo //
CREATE TRIGGER saldoNegativo AFTER UPDATE ON usuarios  FOR EACH ROW 
BEGIN
    
    IF NEW.saldo < 0 THEN 
    
        INSERT INTO  messaldoNegativo (saldoActual, idUsuario ) VALUES (NEW.saldo, id);
    
    END IF;

END //
DELIMITER ;

CREATE OR REPLACE TABLE borrados  (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    Usuario VARCHAR(200),
    Email VARCHAR(200),
    Teléfono VARCHAR(9),
    Saldo INT,
    Tipo INT,
    data DATETIME DEFAULT CURRENT_TIMESTAMP()
);

DELIMITER //
DROP TRIGGER IF EXISTS impagos3 //
CREATE TRIGGER impagos3 AFTER INSERT ON messaldoNegativo  FOR EACH ROW 
BEGIN
    
    DECLARE contador INT;
    
    SET contador = (SELECT COUNT(*) FROM messaldoNegativo WHERE idUsuario=NEW.idUsuario);
    
    IF contador >= 3 THEN 
        
        INSERT INTO  borrados (idUsuario, Usuario, Email, Teléfono, Saldo, Tipo) SELECT ID, Usuario, Email, Teléfono, Saldo, Tipo FROM usuarios WHERE  id=idUsuario;
    
    END IF;
END //
DELIMITER ;








