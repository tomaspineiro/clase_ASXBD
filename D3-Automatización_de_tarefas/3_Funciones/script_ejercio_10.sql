DELIMITER //
CREATE or replace PROCEDURE media(out txt VARCHAR(3000))
BEGIN
-- declaracion de varibles 
DECLARE numEmpregados int;
DECLARE mediaSalaro float;
DECLARE empBuenSAlario int;

-- optenemos los datos  necesarios 
select count(*) INTO @numEmpregados from empleados;
select avg(salario) INTO @mediaSalaro from empleados;
select count(*) INTO @empBuenSAlario from empleados where salario >= @mediaSalario;

-- cargamos los datos que se van a devolver
select concat('En esta empresa tabajan ', @numEmpregados, 'de los cuales ', @empBuenSAlario, ' tiene un salario superios o igual a la media de la empresa que es ', @mediaSalaro) INTO txt;
-- set txt = select concat('En esta empresa tabajan ', @numEmpregados, 'de los cuales ', @empBuenSAlario, ' tiene un salario superios o igual a la media de la empresa que es ', @mediaSalaro) ;
END //
DELIMITER ;


CALL media(@m);

SELECT @m;
