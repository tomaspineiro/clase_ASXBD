-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-12-2022 a las 01:01:48
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tenda`
--

USE tendas;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artigos`
--


CREATE TABLE `artigos` (
  `ARTIGO` tinyint(4) NOT NULL,
  `COD_FAB` tinyint(4) NOT NULL,
  `PESO` tinyint(4) DEFAULT NULL,
  `CATEGORIA` enum('PRIMEIRA','SEGUNDA','TERCEIRA') DEFAULT NULL,
  `precio` float(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `artigos`
--

INSERT INTO `artigos` (`ARTIGO`, `COD_FAB`, `PESO`, `CATEGORIA`, `precio`) VALUES
(1, 1, 20, 'PRIMEIRA', 5.00),
(2, 1, 45, 'TERCEIRA', 11.25),
(3, 1, 10, 'TERCEIRA', 2.50),
(4, 1, 15, 'PRIMEIRA', 3.75),
(5, 2, 100, 'SEGUNDA', 25.00),
(6, 2, 15, 'PRIMEIRA', 3.75),
(7, 2, 30, 'PRIMEIRA', 7.50),
(8, 2, 80, 'TERCEIRA', 20.00),
(9, 3, 25, 'TERCEIRA', 6.25),
(10, 3, 25, 'PRIMEIRA', 6.25),
(11, 3, 70, 'SEGUNDA', 17.50),
(12, 3, 90, 'SEGUNDA', 22.50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fabricante`
--

CREATE TABLE `fabricante` (
  `COD_FAB` tinyint(4) NOT NULL,
  `MARCA` VARCHAR(20) DEFAULT NULL,
  `NOME_PAIS` VARCHAR(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `fabricante`
--

INSERT INTO `fabricante` (`COD_FAB`, `MARCA`, `NOME_PAIS`) VALUES
(1, 'FELVI', 'ITALIA'),
(2, 'CANTIER', 'FRANCIA'),
(3, 'PEDROSA', 'ESPAÑA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `NIF` VARCHAR(10) NOT NULL,
  `ARTIGO` tinyint(4) NOT NULL,
  `COD_FAB` tinyint(4) NOT NULL,
  `DATA_PEDIDO` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UNIDADES_PEDIDAS` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`NIF`, `ARTIGO`, `COD_FAB`, `DATA_PEDIDO`, `UNIDADES_PEDIDAS`) VALUES
('2222-A', 12, 3, '0000-00-00 00:00:00', 20),
('4545-C', 1, 1, '2009-03-10 22:00:00', 10),
('5555-B', 1, 1, '2009-03-08 22:00:00', 40),
('5555-B', 2, 1, '2009-03-10 22:00:00', 20),
('7788-D', 3, 1, '2010-03-11 22:00:00', 40);

-- --------------------------------------------------------
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tendas`
--

CREATE TABLE `tendas` (
  `NIF` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `poboacion` VARCHAR(50) NOT NULL,
  `PROVINCIA` VARCHAR(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tendas`
--

INSERT INTO `tendas` (`NIF`, `nome`, `email`, `poboacion`, `PROVINCIA`) VALUES
('1111-A', 'El Pintaor', 'admin@elpintaor.com', 'Dos Hermanas', 'SEVILLA'),
('2222-A', 'La pintura del Quijote', 'pinturas@yepes.com', 'Yepes', 'TOLEDO'),
('4545-C', 'Pinturas Carabanchel', 'carabanchel@loquepuedas.com', 'Carabanchel', 'MADRID'),
('5555-B', 'Proa', 'proa@algo.es', 'Arcade', 'PONTEVEDRA'),
('7788-D', 'Galipintura', '', 'Mos', 'PONTEVEDRA'),
('9911-H', 'Seoane Pinturas', 'pinturas@seoane.es', 'Santiago', 'A CORUÑA');

-- --------------------------------------------------------

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `artigos`
--
ALTER TABLE `artigos`
  ADD PRIMARY KEY (`ARTIGO`,`COD_FAB`),
  ADD KEY `FK_ARTICULOS_FABRICANTE` (`COD_FAB`);

--
-- Indices de la tabla `fabricante`
--
ALTER TABLE `fabricante`
  ADD PRIMARY KEY (`COD_FAB`),
  ADD UNIQUE KEY `MARCA` (`MARCA`),
  ADD UNIQUE KEY `NOME_PAIS` (`NOME_PAIS`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`NIF`,`ARTIGO`,`COD_FAB`),
  ADD KEY `FK_PEDIDOS_ARTICULOS` (`ARTIGO`),
  ADD KEY `FK_PEDIDOS_FABRICANTE` (`COD_FAB`);

--
-- Indices de la tabla `tendas`
--
ALTER TABLE `tendas`
  ADD PRIMARY KEY (`NIF`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `artigos`
--
ALTER TABLE `artigos`
  ADD CONSTRAINT `FK_ARTICULOS_FABRICANTE` FOREIGN KEY (`COD_FAB`) REFERENCES `fabricante` (`COD_FAB`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `FK_PEDIDOS_ARTICULOS` FOREIGN KEY (`ARTIGO`) REFERENCES `artigos` (`ARTIGO`),
  ADD CONSTRAINT `FK_PEDIDOS_FABRICANTE` FOREIGN KEY (`COD_FAB`) REFERENCES `fabricante` (`COD_FAB`),
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`NIF`) REFERENCES `tendas` (`NIF`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

