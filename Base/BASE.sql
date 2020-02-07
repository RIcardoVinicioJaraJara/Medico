-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Persona` (
  `per_id` INT UNSIGNED NOT NULL,
  `per_cedula` VARCHAR(45) NULL,
  `per_nombre` VARCHAR(45) NULL,
  `per_apellido` VARCHAR(45) NULL,
  `per_direccion` VARCHAR(45) NULL,
  `per_telefono` VARCHAR(45) NULL,
  `per_correo` VARCHAR(45) NULL,
  `per_genero` VARCHAR(45) NULL,
  PRIMARY KEY (`per_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `pac_id` INT NOT NULL,
  `Persona_per_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`pac_id`),
  INDEX `fk_Paciente_Persona1_idx` (`Persona_per_id` ASC),
  CONSTRAINT `fk_Paciente_Persona1`
    FOREIGN KEY (`Persona_per_id`)
    REFERENCES `mydb`.`Persona` (`per_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `doc_id` INT NOT NULL,
  `doc_epecialidad` VARCHAR(45) NULL,
  `doc_area` VARCHAR(45) NULL,
  `Persona_per_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`doc_id`),
  INDEX `fk_Doctor_Persona_idx` (`Persona_per_id` ASC),
  CONSTRAINT `fk_Doctor_Persona`
    FOREIGN KEY (`Persona_per_id`)
    REFERENCES `mydb`.`Persona` (`per_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Turno` (
  `tur_id` INT NOT NULL,
  `Paciente_pac_id` INT NOT NULL,
  `Doctor_doc_id` INT NOT NULL,
  PRIMARY KEY (`tur_id`),
  INDEX `fk_Turno_Paciente1_idx` (`Paciente_pac_id` ASC),
  INDEX `fk_Turno_Doctor1_idx` (`Doctor_doc_id` ASC),
  CONSTRAINT `fk_Turno_Paciente1`
    FOREIGN KEY (`Paciente_pac_id`)
    REFERENCES `mydb`.`Paciente` (`pac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turno_Doctor1`
    FOREIGN KEY (`Doctor_doc_id`)
    REFERENCES `mydb`.`Doctor` (`doc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Receta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Receta` (
  `rec_id` INT NOT NULL,
  `rec_tipo_medicamento` VARCHAR(45) NULL,
  `rec_distribucion` VARCHAR(45) NULL,
  `rec_duracion` VARCHAR(45) NULL,
  `Doctor_doc_id` INT NOT NULL,
  `Paciente_pac_id` INT NOT NULL,
  PRIMARY KEY (`rec_id`),
  INDEX `fk_Receta_Doctor1_idx` (`Doctor_doc_id` ASC),
  INDEX `fk_Receta_Paciente1_idx` (`Paciente_pac_id` ASC),
  CONSTRAINT `fk_Receta_Doctor1`
    FOREIGN KEY (`Doctor_doc_id`)
    REFERENCES `mydb`.`Doctor` (`doc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Receta_Paciente1`
    FOREIGN KEY (`Paciente_pac_id`)
    REFERENCES `mydb`.`Paciente` (`pac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ficha_Medica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ficha_Medica` (
  `fic_med_id` INT NOT NULL,
  `fic_med_enfermedad` VARCHAR(45) NULL,
  `Paciente_pac_id` INT NOT NULL,
  `Doctor_doc_id` INT NOT NULL,
  PRIMARY KEY (`fic_med_id`),
  INDEX `fk_Ficha_Medica_Paciente1_idx` (`Paciente_pac_id` ASC),
  INDEX `fk_Ficha_Medica_Doctor1_idx` (`Doctor_doc_id` ASC),
  CONSTRAINT `fk_Ficha_Medica_Paciente1`
    FOREIGN KEY (`Paciente_pac_id`)
    REFERENCES `mydb`.`Paciente` (`pac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ficha_Medica_Doctor1`
    FOREIGN KEY (`Doctor_doc_id`)
    REFERENCES `mydb`.`Doctor` (`doc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
