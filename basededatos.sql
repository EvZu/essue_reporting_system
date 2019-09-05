-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_registro_incidentes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_registro_incidentes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_registro_incidentes` DEFAULT CHARACTER SET latin1 ;
USE `db_registro_incidentes` ;

-- -----------------------------------------------------
-- Table `db_registro_incidentes`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_registro_incidentes`.`usuario` (
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_registro_incidentes`.`asignacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_registro_incidentes`.`asignacion` (
  `id_asignacion` INT(11) NOT NULL,
  `fecha_asignacion` DATE NULL DEFAULT NULL,
  `categoria` VARCHAR(45) NULL DEFAULT NULL,
  `departamento` VARCHAR(45) NULL DEFAULT NULL,
  `id_usuario_asignado` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_asignacion`),
  INDEX `FK_historial_asignacion_id_usuario` (`id_usuario_asignado` ASC) VISIBLE,
  CONSTRAINT `FK_historial_asignacion_id_usuario`
    FOREIGN KEY (`id_usuario_asignado`)
    REFERENCES `db_registro_incidentes`.`usuario` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_registro_incidentes`.`edificio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_registro_incidentes`.`edificio` (
  `id_edificio` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `sede` VARCHAR(45) NULL DEFAULT NULL,
  `nivel` VARCHAR(45) NULL DEFAULT NULL,
  `aula` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_edificio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_registro_incidentes`.`incidencias_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_registro_incidentes`.`incidencias_tipo` (
  `id_incidencia_tipo` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_incidencia` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_incidencia_tipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_registro_incidentes`.`incidencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_registro_incidentes`.`incidencias` (
  `id_incidencias` INT(11) NOT NULL,
  `fecha_inicia` DATE NULL DEFAULT NULL,
  `fecha_fin` DATE NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `id_incidencia_tipo` INT(11) NULL DEFAULT NULL,
  `id_edificio` INT(11) NULL DEFAULT NULL,
  `id_asignacion` INT(11) NULL DEFAULT NULL,
  `id_usuario_creador` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_incidencias`),
  INDEX `FK_incidecias_asignacion` (`id_asignacion` ASC) VISIBLE,
  INDEX `FK_incidecias_tipo_id_incidencia` (`id_incidencia_tipo` ASC) VISIBLE,
  INDEX `FK_incidecias_edificio_id_edificio` (`id_edificio` ASC) VISIBLE,
  INDEX `FK_incidecias_usuario_id_usuario_creador` (`id_usuario_creador` ASC) VISIBLE,
  CONSTRAINT `FK_incidecias_asignacion`
    FOREIGN KEY (`id_asignacion`)
    REFERENCES `db_registro_incidentes`.`asignacion` (`id_asignacion`),
  CONSTRAINT `FK_incidecias_edificio_id_edificio`
    FOREIGN KEY (`id_edificio`)
    REFERENCES `db_registro_incidentes`.`edificio` (`id_edificio`),
  CONSTRAINT `FK_incidecias_tipo_id_incidencia`
    FOREIGN KEY (`id_incidencia_tipo`)
    REFERENCES `db_registro_incidentes`.`incidencias_tipo` (`id_incidencia_tipo`),
  CONSTRAINT `FK_incidecias_usuario_id_usuario_creador`
    FOREIGN KEY (`id_usuario_creador`)
    REFERENCES `db_registro_incidentes`.`usuario` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_registro_incidentes`.`adjunto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_registro_incidentes`.`adjunto` (
  `id_adjunto` INT(11) NOT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `id_incidencias` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_adjunto`),
  INDEX `FK_adjunto_incidencia_id_adjunto` (`id_incidencias` ASC) VISIBLE,
  CONSTRAINT `FK_adjunto_incidencia_id_adjunto`
    FOREIGN KEY (`id_incidencias`)
    REFERENCES `db_registro_incidentes`.`incidencias` (`id_incidencias`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_registro_incidentes`.`historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_registro_incidentes`.`historial` (
  `id_historial` INT(11) NOT NULL,
  `comentario` DATE NULL DEFAULT NULL,
  `id_usuario_modifica` INT(11) NULL DEFAULT NULL,
  `id_incidencias` INT(11) NULL DEFAULT NULL,
  `evento` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_historial`),
  INDEX `FK_incidentes_incidente` (`id_incidencias` ASC) VISIBLE,
  INDEX `FK_historial_usuario_id_usuario_modifica` (`id_usuario_modifica` ASC) VISIBLE,
  CONSTRAINT `FK_historial_usuario_id_usuario_modifica`
    FOREIGN KEY (`id_usuario_modifica`)
    REFERENCES `db_registro_incidentes`.`usuario` (`id_usuario`),
  CONSTRAINT `FK_incidentes_incidente`
    FOREIGN KEY (`id_incidencias`)
    REFERENCES `db_registro_incidentes`.`incidencias` (`id_incidencias`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
