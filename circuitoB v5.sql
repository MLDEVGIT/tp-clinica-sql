-- v5 remuevo las tablas que eran solo para status: TurnoStatus, FacturaStatus, MetodoPago
/* Turno status
0 = "No disponible"
1 = "Disponible"
2 = "Ocupado"

Factura status
0 = "Pendiente"
1 = "Pagada"
2 = "Anulada"

Metodo de pago
0 = "Pago por Cobertura"
1 = "Efectivo"
2 = "Tarjeta de Débito"

*/
-- v4 cambio estructura de turno
-- v3 remuevo indexes y campos denormalizados, agrego campo de Historia Clínica
-- y renombro campos de nombre a descripcion
-- v2 versión simplificando las primary keys y foreign keys

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema CircuitoB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CircuitoB` ;

-- -----------------------------------------------------
-- Schema CircuitoB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CircuitoB` ;
USE `CircuitoB` ;

-- -----------------------------------------------------
-- Table `CircuitoB`.`Cobertura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Cobertura` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Cobertura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`Paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Paciente` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Paciente` (
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
    REFERENCES `CircuitoB`.`Cobertura` (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`Estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Estudio` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`LugarDeAtencion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`LugarDeAtencion` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`LugarDeAtencion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL,
  `Estudio_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_LugarDeAtencion_Estudio1`
    FOREIGN KEY (`Estudio_id`)
    REFERENCES `CircuitoB`.`Estudio` (`id`));


 
-- -----------------------------------------------------
-- Table `CircuitoB`.`Turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Turno` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Turno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Hora` TIME NOT NULL,
  `LugarDeAtencion_id` INT NOT NULL,
  `Paciente_id` INT NULL,
  `TurnoStatus` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Turno_Paciente1`
    FOREIGN KEY (`Paciente_id`)
    REFERENCES `CircuitoB`.`Paciente` (`id`),
    CONSTRAINT `fk_Turno_LugarDeAtencion1`
    FOREIGN KEY (`LugarDeAtencion_id`)
    REFERENCES `CircuitoB`.`LugarDeAtencion` (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`SalaDeEspera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`SalaDeEspera` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`SalaDeEspera` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `FechaHoraAcreditacion` DATETIME NULL,
  `Turno_id` INT NOT NULL,
  `Prioridad` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_SalaDeEspera_Turno1`
    FOREIGN KEY (`Turno_id`)
    REFERENCES `CircuitoB`.`Turno` (`id`));


 

 

-- -----------------------------------------------------
-- Table `CircuitoB`.`Factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Factura` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Factura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Turno_id` INT NOT NULL,
  `Paciente_id` INT NOT NULL,
  `Monto` FLOAT NULL,
  `MetodoPago` INT NULL,
  `FacturaStatus` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Factura_Turno1`
    FOREIGN KEY (`Turno_id`)
    REFERENCES `CircuitoB`.`Turno` (`id`),
  CONSTRAINT `fk_Factura_Paciente1`
    FOREIGN KEY (`Paciente_id`)
    REFERENCES `CircuitoB`.`Paciente` (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`CoberturaEstudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`CoberturaEstudio` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`CoberturaEstudio` (
  `Cobertura_id` INT NOT NULL,
  `Estudio_id` INT NOT NULL,
  `Monto` INT NULL,
  PRIMARY KEY (`Cobertura_id`, `Estudio_id`),
  CONSTRAINT `fk_Cobertura_has_Estudio_Cobertura1`
    FOREIGN KEY (`Cobertura_id`)
    REFERENCES `CircuitoB`.`Cobertura` (`id`),
  CONSTRAINT `fk_Cobertura_has_Estudio_Estudio1`
    FOREIGN KEY (`Estudio_id`)
    REFERENCES `CircuitoB`.`Estudio` (`id`));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- -----------------------------------------------------


INSERT INTO CircuitoB.Cobertura (Nombre) VALUES
('Osde'),
('Pampa Salud'),
('Swiss Medical'),
('IOMA'),
('Galeno'),
('Sin Cobertura');

INSERT INTO CircuitoB.Paciente (Nombre, Apellido, DNI, Direccion, Email, Cobertura_id, Historia_clinica) VALUES
('Juan', 'Perez', '30123456', 'Calle falsa 123', 'jperez@email.com', 1,'Historia clínica de Juan'),
('Maria', 'Gonzalez', '27890123', 'Calle real 456', 'mgonzalez@email.com', 2, 'Historia clínica de Maria'),
('Pedro', 'Diaz', '31456789', 'Avenida siempreviva 789', 'pdiaz@email.com', 3, 'Historia clínica de Pedro'),
('Ana', 'Lopez', '28901234', 'Calle norte 1011', 'alopez@email.com', 4, 'Historia clínica de Ana'),
('Luis', 'Fernandez', '32567890', 'Calle sur 1213', 'lfernandez@email.com', 5, 'Historia clínica de Luis');


INSERT INTO CircuitoB.Estudio (Descripcion) VALUES
('Ecografia'),
('Analisis de Sangre'),
('Radiografia'),
('Electrocardiograma'),
('Tomografia');


INSERT INTO CircuitoB.LugarDeAtencion (Descripcion, Estudio_id) VALUES
('Consultorio 1', 1),
('Consultorio 2', 1),
('Box Laboratorio 1', 2),
('Box Laboratorio 2', 2),
('Box Laboratorio 3', 2),
('Sala de Rayos X', 3),
('Consultorio 3', 4),
('Tomógrafo', 5);
 

-- Table `Turno`

INSERT INTO CircuitoB.Turno (Fecha, Hora, LugarDeAtencion_id,  Paciente_id, TurnoStatus) VALUES
('2024-05-07', '10:30:00', 1,  1,  2),
('2024-05-08', '11:30:00', 2,  2,  2),
('2024-05-09', '12:30:00', 3,  3,  2),
('2024-05-10', '13:30:00', 4,  4,  2),
('2024-05-11', '14:30:00', 5,  5,  2),
('2024-05-11', '14:30:00', 6,  5,  2);

-- Table `SalaDeEspera`

INSERT INTO CircuitoB.SalaDeEspera (FechaHoraAcreditacion, Turno_id, Prioridad) VALUES
('2024-05-07 09:45:00', 1, 1),
('2024-05-08 10:45:00', 2, 1),
('2024-05-09 11:45:00', 3, 1),
('2024-05-10 12:45:00', 4, 1),
('2024-05-11 13:45:00', 5, 1);

 
 

INSERT INTO CircuitoB.Factura (Turno_id, Paciente_id, Monto, MetodoPago, FacturaStatus) VALUES
(1, 1, 1000.00, 1, 1),
(2, 2, 800.00, 2, 2),
(3, 3, 600.00, 1, 0),
(4, 4, 400.00, 2, 0),
(5, 5, 200.00, 0, 1);

INSERT INTO CircuitoB.CoberturaEstudio (Cobertura_id, Estudio_id, Monto) VALUES
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
(5, 5, 0);