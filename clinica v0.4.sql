
/* Turno status
0 = "No disponible"
1 = "Disponible"
2 = "Ocupado"

Prioridad
0 = "Urgente"
1 = "Normal"

Factura status
0 = "Sin Pago"
1 = "Pagada"
2 = "Pendiente"

Metodo de pago
0 = "Sin Pago"
1 = "Efectivo"
2 = "Tarjeta de Débito"

*/


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema Clinica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Clinica` ;

-- -----------------------------------------------------
-- Schema Clinica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Clinica` ;
USE `Clinica` ;

-- -----------------------------------------------------
-- Table `Clinica`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`Usuario` (
`id` INT NOT NULL AUTO_INCREMENT,
`Nombre` VARCHAR (45) NOT NULL,
`Pass` VARCHAR (45) NOT NULL,
`Rol` INT NOT NULL,
 PRIMARY KEY (`id`));

insert into Clinica.Usuario (Nombre,Pass,Rol) values
('Admin','1234',1),
('Recepcion', '1234', 2),
('Especialista', '1234', 3);

-- -----------------------------------------------------
-- Table `Clinica`.`Cobertura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`Cobertura` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`Cobertura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `Clinica`.`Paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`Paciente` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`Paciente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  `DNI` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Cobertura_id` INT NOT NULL,
  `Historia_clinica` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Paciente_Cobertura1`
    FOREIGN KEY (`Cobertura_id`)
    REFERENCES `Clinica`.`Cobertura` (`id`));


-- -----------------------------------------------------
-- Table `Clinica`.`Estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`Estudio` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`Estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL,
  `RequiereTurno` boolean NOT NULL,
  `RequiereAyuno` boolean NOT NULL,
  PRIMARY KEY (`id`));

-- -----------------------------------------------------
-- Table `Clinica`.`LugarDeAtencion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`LugarDeAtencion` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`LugarDeAtencion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

-- -----------------------------------------------------
-- Table `Clinica`.`EstudioLugarDeAtencion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`EstudioLugarDeAtencion` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`EstudioLugarDeAtencion` (
  `Estudio_id` INT NOT NULL,
  `LugarDeAtencion_id` INT NOT NULL,
  PRIMARY KEY (`Estudio_id`, `LugarDeAtencion_id`),
  CONSTRAINT `fk_EstudioLugarDeAtencion1`
    FOREIGN KEY (`LugarDeAtencion_id`)
    REFERENCES `Clinica`.`LugarDeAtencion` (`id`),
  CONSTRAINT `fk_LugarDeAtencionEstudio1`
    FOREIGN KEY (`Estudio_id`)
    REFERENCES `Clinica`.`Estudio` (`id`));

 
-- -----------------------------------------------------
-- Table `Clinica`.`Turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`Turno` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`Turno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Hora` TIME NOT NULL,
  `LugarDeAtencion_id` INT NOT NULL,
  `Paciente_id` INT NULL,
  `TurnoStatus` INT NOT NULL,
  `Estudio_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Turno_Paciente1`
    FOREIGN KEY (`Paciente_id`)
    REFERENCES `Clinica`.`Paciente` (`id`),
    CONSTRAINT `fk_Turno_LugarDeAtencion1`
    FOREIGN KEY (`LugarDeAtencion_id`)
    REFERENCES `Clinica`.`LugarDeAtencion` (`id`));


-- -----------------------------------------------------
-- Table `Clinica`.`SalaDeEspera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`SalaDeEspera` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`SalaDeEspera` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `FechaHoraAcreditacion` DATETIME NULL,
  `Paciente_id` INT NOT NULL,
  `Estudio_id` INT NOT NULL,  
  `LugarDeAtencion_id` INT NOT NULL,
  `Prioridad` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_SalaDeEspera_Paciente1`
    FOREIGN KEY (`Paciente_id`)
    REFERENCES `Clinica`.`Paciente` (`id`),
    CONSTRAINT `fk_SalaDeEspera_Estudio1`
    FOREIGN KEY (`Estudio_id`)
    REFERENCES `Clinica`.`Estudio` (`id`),
    CONSTRAINT `fk_SalaDeEspera_LugarDeAtencion1`
    FOREIGN KEY (`LugarDeAtencion_id`)
    REFERENCES `Clinica`.`LugarDeAtencion` (`id`));


 

 

-- -----------------------------------------------------
-- Table `Clinica`.`Factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`Factura` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`Factura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Estudio_id` INT NOT NULL,
  `Cobertura_id` INT NOT NULL,
  `Paciente_id` INT NOT NULL,
  `Monto` FLOAT NULL,
  `MetodoPago` INT NULL,
  `FacturaStatus` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Factura_Estudio1`
    FOREIGN KEY (`Estudio_id`)
    REFERENCES `Clinica`.`Estudio` (`id`),
  CONSTRAINT `fk_Factura_Cobertura1`
    FOREIGN KEY (`Cobertura_id`)
    REFERENCES `Clinica`.`Cobertura` (`id`),
  CONSTRAINT `fk_Factura_Paciente1`
    FOREIGN KEY (`Paciente_id`)
    REFERENCES `Clinica`.`Paciente` (`id`));


-- -----------------------------------------------------
-- Table `Clinica`.`CoberturaEstudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Clinica`.`CoberturaEstudio` ;

CREATE TABLE IF NOT EXISTS `Clinica`.`CoberturaEstudio` (
  `Cobertura_id` INT NOT NULL,
  `Estudio_id` INT NOT NULL,
  `Monto` INT NULL,
  PRIMARY KEY (`Cobertura_id`, `Estudio_id`),
  CONSTRAINT `fk_Cobertura_has_Estudio_Cobertura1`
    FOREIGN KEY (`Cobertura_id`)
    REFERENCES `Clinica`.`Cobertura` (`id`),
  CONSTRAINT `fk_Cobertura_has_Estudio_Estudio1`
    FOREIGN KEY (`Estudio_id`)
    REFERENCES `Clinica`.`Estudio` (`id`));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- -----------------------------------------------------


INSERT INTO Clinica.Cobertura (Nombre) VALUES
('Osde'),
('Pampa Salud'),
('Swiss Medical'),
('IOMA'),
('Galeno'),
('Sin Cobertura');

INSERT INTO Clinica.Paciente (Nombre, Apellido, DNI, Direccion, Email, Cobertura_id, Historia_clinica) VALUES
('Juan', 'Perez', '30123456', 'Calle falsa 123', 'jperez@email.com', 1,'Historia clínica de Juan'),
('Maria', 'Gonzalez', '27890123', 'Calle real 456', 'mgonzalez@email.com', 2, 'Historia clínica de Maria'),
('Pedro', 'Diaz', '31456789', 'Avenida siempreviva 789', 'pdiaz@email.com', 3, 'Historia clínica de Pedro'),
('Ana', 'Lopez', '28901234', 'Calle norte 1011', 'alopez@email.com', 4, 'Historia clínica de Ana'),
('Luis', 'Fernandez', '32567890', 'Calle sur 1213', 'lfernandez@email.com', 5, 'Historia clínica de Luis');


INSERT INTO Clinica.Estudio (Descripcion, RequiereTurno, RequiereAyuno) VALUES
('Análisis de Sangre (con ayuno)', 0, 1),
('Análisis Dengue (sin ayuno)', 0, 0),
('Ecografia', 1, 0),
('Electrocardiograma', 1, 0),
('Radiografia', 1, 0),
('Tomografia', 1, 0);


INSERT INTO Clinica.LugarDeAtencion (Descripcion) VALUES
('Box Laboratorio 1'),
('Box Laboratorio 2'),
('Box Laboratorio 3'),
('Consultorio 1'),
('Consultorio 2'),
('Consultorio 3'),
('Sala de Rayos X'),
('Tomógrafo');
 
INSERT INTO Clinica.EstudioLugarDeAtencion (Estudio_id, LugarDeAtencion_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(3, 4),
(3, 5),
(3, 6),
(4, 4),
(4, 5),
(4, 6),
(5, 7),
(6, 8);

-- Table `Turno`

INSERT INTO Clinica.Turno (Fecha, Hora, LugarDeAtencion_id,  Paciente_id, TurnoStatus, Estudio_id) VALUES
('2024-05-07', '10:30:00', 4,  1,  2, 3),
('2024-05-08', '11:30:00', 5,  2,  2, 4),
('2024-05-09', '12:30:00', 4,  3,  2, 3),
('2024-05-10', '13:30:00', 5,  4,  2, 4),
('2024-05-11', '14:30:00', 7,  5,  2, 5),
('2024-05-11', '14:30:00', 8,  1,  2, 6);
 

-- Table `SalaDeEspera`

INSERT INTO Clinica.SalaDeEspera (FechaHoraAcreditacion, Paciente_id, Estudio_id, LugarDeAtencion_id, Prioridad) VALUES
('2024-05-07 09:45:00', 1, 1, 1, 1),
('2024-05-08 10:45:00', 2, 2 ,1, 1),
('2024-05-09 11:45:00', 3, 3, 4, 1),
('2024-05-10 12:45:00', 4, 5, 5, 1),
('2024-05-11 13:45:00', 5, 5, 7, 1);

 
 

INSERT INTO Clinica.Factura (Estudio_id, Cobertura_id, Paciente_id, Monto, MetodoPago, FacturaStatus) VALUES
(1, 1, 1, 1000.00, 1, 1),
(2, 2, 2, 800.00, 2, 2),
(3, 3, 3, 600.00, 1, 0),
(4, 4, 4, 400.00, 2, 0),
(5, 5, 5, 200.00, 0, 1);

INSERT INTO Clinica.CoberturaEstudio (Cobertura_id, Estudio_id, Monto) VALUES
(1, 1, 500),
(1, 2, 300),
(1, 3, 200),
(1, 4, 100),
(1, 5, 0),
(2, 1, 400),
(2, 2, 250),
(2, 3, 150),
(2, 4, 50),
(2, 5, 0),
(3, 1, 300),
(3, 2, 200),
(3, 3, 100),
(3, 4, 0),
(3, 5, 0),
(4, 1, 200),
(4, 2, 150),
(4, 3, 50),
(4, 4, 0),
(4, 5, 0),
(5, 1, 100),
(5, 2, 50),
(5, 3, 0),
(5, 4, 0),
(5, 5, 0),
(6, 1, 9000),
(6, 2, 90000),
(6, 3, 90000),
(6, 4, 90000),
(6, 5, 90000);