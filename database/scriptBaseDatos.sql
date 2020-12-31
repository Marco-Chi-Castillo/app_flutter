-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bdReservaciones
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdReservaciones
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdReservaciones` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema bdreservaciones
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdreservaciones
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdreservaciones` DEFAULT CHARACTER SET utf8 ;
USE `bdReservaciones` ;

-- -----------------------------------------------------
-- Table `bdReservaciones`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdReservaciones`.`roles` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `Rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdReservaciones`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdReservaciones`.`usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `contrasenia` VARCHAR(45) NOT NULL,
  `roles_idRol` INT NOT NULL,
  PRIMARY KEY (`idUsuarios`),
  INDEX `fk_usuarios_roles_idx` (`roles_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_roles`
    FOREIGN KEY (`roles_idRol`)
    REFERENCES `bdReservaciones`.`roles` (`idRol`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdReservaciones`.`edificios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdReservaciones`.`edificios` (
  `idEdificios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEdificios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdReservaciones`.`espacios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdReservaciones`.`espacios` (
  `idespacios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NULL,
  `capacidad` INT NOT NULL,
  `estatus` TINYINT NOT NULL COMMENT '1.-Disponible\n0.-No disponible',
  `imagen` VARCHAR(255) NULL,
  `edificios_idedificios` INT NOT NULL,
  PRIMARY KEY (`idespacios`),
  INDEX `fk_espacios_edificios1_idx` (`edificios_idedificios` ASC) VISIBLE,
  CONSTRAINT `fk_espacios_edificios1`
    FOREIGN KEY (`edificios_idedificios`)
    REFERENCES `bdReservaciones`.`edificios` (`idEdificios`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdReservaciones`.`reservaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdReservaciones`.`reservaciones` (
  `idReservaciones` INT NOT NULL AUTO_INCREMENT,
  `fechaReservacion` DATE NOT NULL,
  `detalle` VARCHAR(255) NULL,
  `horaInicio` TIME NOT NULL,
  `horaTermino` TIME NOT NULL,
  `numAsistentes` INT NULL,
  `usuarios_idusuarios` INT NOT NULL,
  `espacios_idespacios` INT NOT NULL,
  PRIMARY KEY (`idReservaciones`),
  INDEX `fk_reservaciones_usuarios1_idx` (`usuarios_idusuarios` ASC) VISIBLE,
  INDEX `fk_reservaciones_espacios1_idx` (`espacios_idespacios` ASC) VISIBLE,
  CONSTRAINT `fk_reservaciones_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios`)
    REFERENCES `bdReservaciones`.`usuarios` (`idUsuarios`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reservaciones_espacios1`
    FOREIGN KEY (`espacios_idespacios`)
    REFERENCES `bdReservaciones`.`espacios` (`idespacios`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `bdreservaciones` ;

-- -----------------------------------------------------
-- Table `bdreservaciones`.`edificios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdreservaciones`.`edificios` (
  `idEdificios` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEdificios`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bdreservaciones`.`espacios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdreservaciones`.`espacios` (
  `idespacios` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `capacidad` INT(11) NOT NULL,
  `estatus` TINYINT(4) NOT NULL COMMENT '1.-Disponible\\n0.-No disponible',
  `imagen` VARCHAR(255) NULL DEFAULT NULL,
  `edificios_idedificios` INT(11) NOT NULL,
  PRIMARY KEY (`idespacios`),
  INDEX `fk_espacios_edificios1_idx` (`edificios_idedificios` ASC) VISIBLE,
  CONSTRAINT `fk_espacios_edificios1`
    FOREIGN KEY (`edificios_idedificios`)
    REFERENCES `bdreservaciones`.`edificios` (`idEdificios`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bdreservaciones`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdreservaciones`.`roles` (
  `idRol` INT(11) NOT NULL AUTO_INCREMENT,
  `Rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bdreservaciones`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdreservaciones`.`usuarios` (
  `idUsuarios` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `contrasenia` VARCHAR(45) NOT NULL,
  `roles_idRol` INT(11) NOT NULL,
  PRIMARY KEY (`idUsuarios`),
  INDEX `fk_usuarios_roles_idx` (`roles_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_roles`
    FOREIGN KEY (`roles_idRol`)
    REFERENCES `bdreservaciones`.`roles` (`idRol`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bdreservaciones`.`reservaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdreservaciones`.`reservaciones` (
  `idReservaciones` INT(11) NOT NULL AUTO_INCREMENT,
  `fechaReservacion` DATE NOT NULL,
  `detalle` VARCHAR(255) NULL DEFAULT NULL,
  `horaInicio` TIME NOT NULL,
  `horaTermino` TIME NOT NULL,
  `numAsistentes` INT(11) NULL DEFAULT NULL,
  `usuarios_idusuarios` INT(11) NOT NULL,
  `espacios_idespacios` INT(11) NOT NULL,
  PRIMARY KEY (`idReservaciones`),
  INDEX `fk_reservaciones_usuarios1_idx` (`usuarios_idusuarios` ASC) VISIBLE,
  INDEX `fk_reservaciones_espacios1_idx` (`espacios_idespacios` ASC) VISIBLE,
  CONSTRAINT `fk_reservaciones_espacios1`
    FOREIGN KEY (`espacios_idespacios`)
    REFERENCES `bdreservaciones`.`espacios` (`idespacios`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reservaciones_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios`)
    REFERENCES `bdreservaciones`.`usuarios` (`idUsuarios`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `bdreservaciones`;

DELIMITER $$
USE `bdreservaciones`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `bdreservaciones`.`before_reservaciones_insert`
BEFORE INSERT ON `bdreservaciones`.`reservaciones`
FOR EACH ROW
BEGIN
    IF EXISTS ( SELECT * FROM reservaciones
				WHERE NEW.idReservaciones <> idReservaciones AND NEW.fechaReservacion= fechaReservacion
			    AND NEW.espacios_idespacios = espacios_idespacios AND
                (NEW.horaInicio BETWEEN horaInicio AND horaTermino OR
                NEW.horaTermino BETWEEN horaInicio AND horaTermino OR
                (NEW.horaInicio <= horaInicio AND NEW.horatermino > horaTermino))
    
			  )
              THEN 
              SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is already a reservation on that date and time';
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
