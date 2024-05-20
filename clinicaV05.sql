CREATE DATABASE  IF NOT EXISTS `clinica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `clinica`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinica
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cobertura`
--

DROP TABLE IF EXISTS `cobertura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cobertura` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cobertura`
--

LOCK TABLES `cobertura` WRITE;
/*!40000 ALTER TABLE `cobertura` DISABLE KEYS */;
INSERT INTO `cobertura` VALUES (1,'Osde'),(2,'Pampa Salud'),(3,'Swiss Medical'),(4,'IOMA'),(5,'Galeno'),(6,'Sin Cobertura');
/*!40000 ALTER TABLE `cobertura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coberturaestudio`
--

DROP TABLE IF EXISTS `coberturaestudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coberturaestudio` (
  `Cobertura_id` int(11) NOT NULL,
  `Estudio_id` int(11) NOT NULL,
  `Monto` int(11) DEFAULT NULL,
  PRIMARY KEY (`Cobertura_id`,`Estudio_id`),
  KEY `fk_Cobertura_has_Estudio_Estudio1` (`Estudio_id`),
  CONSTRAINT `fk_Cobertura_has_Estudio_Cobertura1` FOREIGN KEY (`Cobertura_id`) REFERENCES `cobertura` (`id`),
  CONSTRAINT `fk_Cobertura_has_Estudio_Estudio1` FOREIGN KEY (`Estudio_id`) REFERENCES `estudio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coberturaestudio`
--

LOCK TABLES `coberturaestudio` WRITE;
/*!40000 ALTER TABLE `coberturaestudio` DISABLE KEYS */;
INSERT INTO `coberturaestudio` VALUES (1,1,500),(1,2,300),(1,3,200),(1,4,100),(1,5,0),(2,1,400),(2,2,250),(2,3,150),(2,4,50),(2,5,0),(3,1,300),(3,2,200),(3,3,100),(3,4,0),(3,5,0),(4,1,200),(4,2,150),(4,3,50),(4,4,0),(4,5,0),(5,1,100),(5,2,50),(5,3,0),(5,4,0),(5,5,0),(6,1,9000),(6,2,90000),(6,3,90000),(6,4,90000),(6,5,90000);
/*!40000 ALTER TABLE `coberturaestudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudio`
--

DROP TABLE IF EXISTS `estudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(45) DEFAULT NULL,
  `RequiereTurno` tinyint(1) NOT NULL,
  `RequiereAyuno` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudio`
--

LOCK TABLES `estudio` WRITE;
/*!40000 ALTER TABLE `estudio` DISABLE KEYS */;
INSERT INTO `estudio` VALUES (1,'Análisis de Sangre (con ayuno)',0,1),(2,'Análisis Dengue (sin ayuno)',0,0),(3,'Ecografia',1,0),(4,'Electrocardiograma',1,0),(5,'Radiografia',1,0),(6,'Tomografia',1,0);
/*!40000 ALTER TABLE `estudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiolugardeatencion`
--

DROP TABLE IF EXISTS `estudiolugardeatencion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiolugardeatencion` (
  `Estudio_id` int(11) NOT NULL,
  `LugarDeAtencion_id` int(11) NOT NULL,
  PRIMARY KEY (`Estudio_id`,`LugarDeAtencion_id`),
  KEY `fk_EstudioLugarDeAtencion1` (`LugarDeAtencion_id`),
  CONSTRAINT `fk_EstudioLugarDeAtencion1` FOREIGN KEY (`LugarDeAtencion_id`) REFERENCES `lugardeatencion` (`id`),
  CONSTRAINT `fk_LugarDeAtencionEstudio1` FOREIGN KEY (`Estudio_id`) REFERENCES `estudio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiolugardeatencion`
--

LOCK TABLES `estudiolugardeatencion` WRITE;
/*!40000 ALTER TABLE `estudiolugardeatencion` DISABLE KEYS */;
INSERT INTO `estudiolugardeatencion` VALUES (1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,4),(3,5),(3,6),(4,4),(4,5),(4,6),(5,7),(6,8);
/*!40000 ALTER TABLE `estudiolugardeatencion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Estudio_id` int(11) NOT NULL,
  `Cobertura_id` int(11) NOT NULL,
  `Paciente_id` int(11) NOT NULL,
  `Monto` float DEFAULT NULL,
  `MetodoPago` int(11) DEFAULT NULL,
  `FacturaStatus` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Factura_Estudio1` (`Estudio_id`),
  KEY `fk_Factura_Cobertura1` (`Cobertura_id`),
  KEY `fk_Factura_Paciente1` (`Paciente_id`),
  CONSTRAINT `fk_Factura_Cobertura1` FOREIGN KEY (`Cobertura_id`) REFERENCES `cobertura` (`id`),
  CONSTRAINT `fk_Factura_Estudio1` FOREIGN KEY (`Estudio_id`) REFERENCES `estudio` (`id`),
  CONSTRAINT `fk_Factura_Paciente1` FOREIGN KEY (`Paciente_id`) REFERENCES `paciente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,1,1,1,1000,1,1),(2,2,2,2,800,2,2),(3,3,3,3,600,1,0),(4,4,4,4,400,2,0),(5,5,5,5,200,0,1),(6,5,2,6,0,0,0);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lugardeatencion`
--

DROP TABLE IF EXISTS `lugardeatencion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lugardeatencion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lugardeatencion`
--

LOCK TABLES `lugardeatencion` WRITE;
/*!40000 ALTER TABLE `lugardeatencion` DISABLE KEYS */;
INSERT INTO `lugardeatencion` VALUES (1,'Box Laboratorio 1'),(2,'Box Laboratorio 2'),(3,'Box Laboratorio 3'),(4,'Consultorio 1'),(5,'Consultorio 2'),(6,'Consultorio 3'),(7,'Sala de Rayos X'),(8,'Tomógrafo');
/*!40000 ALTER TABLE `lugardeatencion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paciente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) DEFAULT NULL,
  `Apellido` varchar(45) DEFAULT NULL,
  `DNI` varchar(45) DEFAULT NULL,
  `Direccion` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Cobertura_id` int(11) NOT NULL,
  `Historia_clinica` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Paciente_Cobertura1` (`Cobertura_id`),
  CONSTRAINT `fk_Paciente_Cobertura1` FOREIGN KEY (`Cobertura_id`) REFERENCES `cobertura` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
INSERT INTO `paciente` VALUES (1,'Juan','Perez','30123456','Calle falsa 123','jperez@email.com',1,'Historia clínica de Juan'),(2,'Maria','Gonzalez','27890123','Calle real 456','mgonzalez@email.com',2,'Historia clínica de Maria'),(3,'Pedro','Diaz','31456789','Avenida siempreviva 789','pdiaz@email.com',3,'Historia clínica de Pedro'),(4,'Ana','Lopez','28901234','Calle norte 1011','alopez@email.com',4,'Historia clínica de Ana\n> Paciente atendido - 5/17/2024 5:49:02 PM - Consultorio 2.'),(5,'Luis','Fernandez','32567890','Calle sur 1213','lfernandez@email.com',5,'Historia clínica de Luis'),(6,'Ana ','Perez','45633234','San Martin 3323','anaperez@gmail.com',2,'Inscripto el día: 5/17/2024 5:47:34 PM'),(7,'Laura','Gomez','41876543','Juncal 3900','lgomez@gmail.com',3,'Inscripto el día: 5/20/2024 1:40:36 PM');
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesional`
--

DROP TABLE IF EXISTS `profesional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesional` (
  `id_Matricula` int(11) NOT NULL,
  `DNI` int(11) DEFAULT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Telefono` varchar(50) NOT NULL,
  `Especialidad` varchar(50) NOT NULL,
  PRIMARY KEY (`id_Matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesional`
--

LOCK TABLES `profesional` WRITE;
/*!40000 ALTER TABLE `profesional` DISABLE KEYS */;
INSERT INTO `profesional` VALUES (89654,17865234,'Mario','Sokoliti','1159437896','Pediatría'),(165437,18675439,'Maria','Romero','1154678912','Kinesiología'),(326435,26734567,'Alejandro','Girardi','1169875432','Traumatología'),(336754,29543678,'Mercedes','Alvarez','1149887234','Neurología'),(765432,36934567,'Aldana','Borges','1153289456','Salud Mental');
/*!40000 ALTER TABLE `profesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saladeespera`
--

DROP TABLE IF EXISTS `saladeespera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saladeespera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `FechaHoraAcreditacion` datetime DEFAULT NULL,
  `Paciente_id` int(11) NOT NULL,
  `Estudio_id` int(11) NOT NULL,
  `LugarDeAtencion_id` int(11) NOT NULL,
  `Prioridad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_SalaDeEspera_Paciente1` (`Paciente_id`),
  KEY `fk_SalaDeEspera_Estudio1` (`Estudio_id`),
  KEY `fk_SalaDeEspera_LugarDeAtencion1` (`LugarDeAtencion_id`),
  CONSTRAINT `fk_SalaDeEspera_Estudio1` FOREIGN KEY (`Estudio_id`) REFERENCES `estudio` (`id`),
  CONSTRAINT `fk_SalaDeEspera_LugarDeAtencion1` FOREIGN KEY (`LugarDeAtencion_id`) REFERENCES `lugardeatencion` (`id`),
  CONSTRAINT `fk_SalaDeEspera_Paciente1` FOREIGN KEY (`Paciente_id`) REFERENCES `paciente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saladeespera`
--

LOCK TABLES `saladeespera` WRITE;
/*!40000 ALTER TABLE `saladeespera` DISABLE KEYS */;
INSERT INTO `saladeespera` VALUES (1,'2024-05-07 09:45:00',1,1,1,1),(2,'2024-05-08 10:45:00',2,2,1,1),(3,'2024-05-09 11:45:00',3,3,4,1),(5,'2024-05-11 13:45:00',5,5,7,1),(6,'2024-05-17 17:48:43',6,5,7,1);
/*!40000 ALTER TABLE `saladeespera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno`
--

DROP TABLE IF EXISTS `turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turno` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL,
  `LugarDeAtencion_id` int(11) NOT NULL,
  `Paciente_id` int(11) DEFAULT NULL,
  `TurnoStatus` int(11) NOT NULL,
  `Estudio_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Turno_Paciente1` (`Paciente_id`),
  KEY `fk_Turno_LugarDeAtencion1` (`LugarDeAtencion_id`),
  CONSTRAINT `fk_Turno_LugarDeAtencion1` FOREIGN KEY (`LugarDeAtencion_id`) REFERENCES `lugardeatencion` (`id`),
  CONSTRAINT `fk_Turno_Paciente1` FOREIGN KEY (`Paciente_id`) REFERENCES `paciente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
INSERT INTO `turno` VALUES (1,'2024-05-07','10:30:00',4,1,2,3),(2,'2024-05-08','11:30:00',5,2,2,4),(3,'2024-05-09','12:30:00',4,3,2,3),(4,'2024-05-10','13:30:00',5,4,2,4),(5,'2024-05-11','14:30:00',7,5,2,5),(6,'2024-05-11','14:30:00',8,1,2,6);
/*!40000 ALTER TABLE `turno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Pass` varchar(45) NOT NULL,
  `Rol` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Admin','1234',1),(2,'Recepcion','1234',2),(3,'Especialista','1234',3);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-20 19:55:53
