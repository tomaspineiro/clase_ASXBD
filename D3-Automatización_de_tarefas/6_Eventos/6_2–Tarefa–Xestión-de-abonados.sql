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
    ON SCHEDULE 
        EVERY  1 MONTH
        
    DO 
    ;



CREATE PROCEDURE cobroCuota()
















