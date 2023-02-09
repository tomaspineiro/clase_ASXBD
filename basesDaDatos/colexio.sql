-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-12-2022 a las 18:53:21
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 7.3.31


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `colexio`
--
create database  colexio;
use colexio;



DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_media` (`nota1` DECIMAL(10,2), `nota2` DECIMAL(10,2), `nota3` DECIMAL(10,2)) RETURNS DECIMAL(10,2) BEGIN
DECLARE media decimal(10,2);
SET media = (nota1+nota2+nota3)/3;
	return media;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nota_texto` (`media` DECIMAL(10,2)) RETURNS VARCHAR(15) CHARSET utf8mb4 COLLATE utf8mb4_spanish_ci BEGIN
DECLARE nota VARCHAR(15) ;

set nota="Moi deficiente";	
set nota="Sobresaínte";
case
when media <= 3 then
	set nota="Moi deficiente";
when media <= 5 then
	set nota="Insuficiente";

when media <= 7 then
	set nota="Suficiente";
when media <= 9 then
	set nota="Notable";

end case;
	return nota;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notasexamenes`
--

CREATE TABLE `notasexamenes` (
  `id` int(11) NOT NULL,
  `idalumno` int(11) NOT NULL,
  `idmateria` int(11) NOT NULL,
  `nota1` decimal(10,2) NOT NULL,
  `nota2` decimal(10,2) NOT NULL,
  `nota3` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `notasexamenes`
--

INSERT INTO `notasexamenes` (`id`, `idalumno`, `idmateria`, `nota1`, `nota2`, `nota3`) VALUES
(1, 1000, 1, '8.00', '9.25', '7.00'),
(2, 1001, 1, '6.33', '8.50', '8.00'),
(3, 1002, 1, '10.00', '7.50', '8.33'),
(4, 1003, 2, '4.50', '2.00', '5.50'),
(5, 1004, 1, '3.50', '2.00', '2.00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `notasexamenes`
--
ALTER TABLE `notasexamenes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `notasexamenes`
--
ALTER TABLE `notasexamenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

