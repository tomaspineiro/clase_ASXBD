DELIMITER //
CREATE or PROCEDURE hacer(out dias int, in data date)
BEGIN
DECLARE hoy date;
select curdate() INTO hoy;
select timestampdiff(DAY, @data, @hoy) INTO @dias;                   
END //
DELIMITER ;

call hacer(@d,'2000-11-30');

select @d;

