-- MariaDB dump 10.19  Distrib 10.5.15-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: Empresa
-- ------------------------------------------------------
-- Server version	10.5.15-MariaDB-0+deb11u1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `centros`
--

DROP TABLE IF EXISTS `centros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centros` (
  `numero` int(11) NOT NULL,
  `nombre` VARCHAR(32) DEFAULT NULL,
  `direccion` VARCHAR(32) DEFAULT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centros`
--

LOCK TABLES `centros` WRITE;
/*!40000 ALTER TABLE `centros` DISABLE KEYS */;
INSERT INTO `centros` VALUES (10,'SEDE CENTRAL','C. ALCALA 820, MADRID'),(20,'RELACION CON CLIENTES','C. ATOCHA 405, MADRID');
/*!40000 ALTER TABLE `centros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamentos` (
  `numero` int(11) NOT NULL,
  `centro` int(11) NOT NULL,
  `director` int(11) NOT NULL,
  `tipo_dir` VARCHAR(1) NOT NULL,
  `presupuesto` int(11) NOT NULL,
  `depto_jefe` int(11) DEFAULT NULL,
  `nombre` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_departamentos_centros` (`centro`),
  KEY `fk_departamentos_empleados` (`director`),
  KEY `fk_departamentos_departamentos` (`depto_jefe`),
  CONSTRAINT `fk_departamentos_centros` FOREIGN KEY (`centro`) REFERENCES `centros` (`numero`),
  CONSTRAINT `fk_departamentos_departamentos` FOREIGN KEY (`depto_jefe`) REFERENCES `departamentos` (`numero`),
  CONSTRAINT `fk_departamentos_empleados` FOREIGN KEY (`director`) REFERENCES `empleados` (`cod`),
  CONSTRAINT `ck_departamentos` CHECK (`tipo_dir` in ('F','P'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamentos`
--

LOCK TABLES `departamentos` WRITE;
/*!40000 ALTER TABLE `departamentos` DISABLE KEYS */;
INSERT INTO `departamentos` VALUES (100,10,260,'P',12,NULL,'DIRECCION GENERAL'),(110,20,180,'P',15,100,'DIRECC. COMERCIAL'),(111,20,180,'F',11,110,'SECTOR INDUSTRIAL'),(112,20,270,'P',9,100,'SECTOR SERVICIOS'),(120,10,150,'F',3,100,'ORGANIZACION'),(121,10,150,'P',2,120,'PERSONAL'),(122,10,350,'P',6,120,'PROCESO DE DATOS'),(130,10,310,'P',2,100,'FINANZAS');
/*!40000 ALTER TABLE `departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `cod` int(11) NOT NULL,
  `departamento` int(11) NOT NULL,
  `telefono` int(11) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `salario` int(11) DEFAULT NULL,
  `comision` int(11) DEFAULT NULL,
  `num_hijos` int(11) DEFAULT 0,
  `nombre` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`cod`),
  KEY `fk_empleados_departamentos` (`departamento`),
  CONSTRAINT `fk_empleados_departamentos` FOREIGN KEY (`departamento`) REFERENCES `departamentos` (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (110,121,350,'1929-11-10','1950-02-10',1310,NULL,3,'PONS, CESAR'),(120,112,840,'1935-06-09','1968-10-01',1350,110,1,'LASA, MARIO'),(130,112,810,'1945-11-09','1969-02-01',1290,110,2,'TEROL, LUCIANO'),(150,121,340,'1930-08-10','1948-01-15',1440,NULL,0,'PEREZ, JULIO'),(160,111,740,'1939-07-09','1968-11-11',1310,110,2,'AGUIRRE, AUREO'),(180,110,508,'1934-10-18','1956-03-18',1480,50,2,'PEREZ, MARCOS'),(190,121,350,'1932-05-12','1962-02-11',1300,NULL,4,'VEIGA, JULIANA'),(210,100,200,'1940-09-28','1959-01-22',1380,NULL,2,'GALVEZ, PILAR'),(240,111,760,'1942-02-26','1966-02-24',1280,100,3,'SANZ, LAVINIA'),(250,100,250,'1946-10-27','1967-03-01',1450,NULL,0,'ALBA, ADRIANA'),(260,100,220,'1943-12-03','1968-07-02',1720,NULL,6,'LOPEZ, ANTONIO'),(270,112,800,'1945-05-21','1966-09-10',1380,80,3,'GARCIA, OCTAVIO'),(280,130,410,'1948-01-11','1971-10-08',1290,NULL,5,'FLOR, DOROTEA'),(285,122,620,'1949-10-25','1968-02-15',1380,NULL,0,'POLO, OTILIA'),(290,120,910,'1947-11-30','1968-02-14',1270,NULL,3,'GIL, GLORIA'),(310,130,480,'1946-11-21','1971-01-15',1420,NULL,0,'GARCIA, AUGUSTO'),(320,122,620,'1957-12-25','1978-02-05',1405,NULL,2,'SANZ, CORNELIO'),(330,112,850,'1948-08-19','1972-03-01',1280,90,0,'DIEZ, AMELIA'),(350,122,610,'1949-03-13','1984-09-10',1450,NULL,1,'CAMPS, AURELIO'),(360,111,750,'1958-10-29','1968-10-10',1250,100,2,'LARA, DORINDA'),(370,121,360,'1967-06-22','1987-01-20',1190,NULL,1,'RUIZ, FABIOLA'),(380,112,880,'1968-03-30','1988-01-01',1180,NULL,0,'MARTIN, MICAELA'),(390,110,500,'1966-02-19','1986-10-08',1215,NULL,1,'MORAN, CARMEN'),(400,111,780,'1969-08-19','1987-11-01',1185,NULL,0,'LARA, LUCRECIA'),(410,122,660,'1968-07-14','1988-10-13',1175,NULL,0,'MIGUEZ, AZUCENA'),(420,130,450,'1966-10-22','1988-11-19',1400,NULL,0,'FIERRO, CLAUDIA'),(430,122,650,'1967-10-26','1988-10-19',1210,NULL,1,'MORA, VALERIANA'),(440,111,760,'1966-09-27','1986-02-28',1210,100,0,'DURAN, LIVIA'),(450,112,880,'1966-10-21','1986-02-28',1210,100,0,'PEREZ, SABINA'),(480,111,760,'1965-04-04','1986-02-28',1210,100,1,'PINO, DIANA'),(490,112,880,'1964-06-06','1988-01-01',1180,100,0,'TORRES, HORACIO'),(500,111,750,'1965-10-08','1987-01-01',1200,100,0,'VAZQUEZ, HONORIA'),(510,110,550,'1966-05-04','1986-10-01',1200,NULL,1,'CAMPOS, ROMULO'),(550,111,780,'1970-01-10','1988-01-21',1100,120,0,'SANTOS, SANCHO');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_empleados`
--

DROP TABLE IF EXISTS `view_empleados`;
/*!50001 DROP VIEW IF EXISTS `view_empleados`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_empleados` (
  `cod` tinyint NOT NULL,
  `Empleado` tinyint NOT NULL,
  `Departamento` tinyint NOT NULL,
  `idade` tinyint NOT NULL,
  `leva_empresa` tinyint NOT NULL,
  `salario` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_empleados`
--

/*!50001 DROP TABLE IF EXISTS `view_empleados`*/;
/*!50001 DROP VIEW IF EXISTS `view_empleados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`xurxo`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_empleados` AS select `e`.`cod` AS `cod`,`e`.`nombre` AS `Empleado`,`d`.`nombre` AS `Departamento`,timestampdiff(YEAR,`e`.`fecha_nacimiento`,curdate()) AS `idade`,timestampdiff(YEAR,`e`.`fecha_ingreso`,curdate()) AS `leva_empresa`,`e`.`salario` AS `salario` from (`empleados` `e` join `departamentos` `d` on(`e`.`departamento` = `d`.`numero`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-01 13:48:50
