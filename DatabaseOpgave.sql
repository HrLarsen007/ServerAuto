-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema MortenDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MortenDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MortenDB` ;
USE `MortenDB` ;

-- -----------------------------------------------------
-- Table `MortenDB`.`ZipCodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`ZipCodes` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`ZipCodes` (
  `_ZipCode` INT(4) NOT NULL DEFAULT 0000,
  `_City` VARCHAR(50) NULL,
  PRIMARY KEY (`_ZipCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MortenDB`.`Hotel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`Hotel` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`Hotel` (
  `_ID` INT NOT NULL DEFAULT 0000,
  `_Name` VARCHAR(30) NOT NULL DEFAULT '0000',
  `_Address` VARCHAR(50) NULL,
  `ZipCodes__ZipCode` INT(4) NOT NULL DEFAULT 0000,
  PRIMARY KEY (`_ID`, `_Name`),
  CONSTRAINT `fk_Hotel_ZipCodes`
    FOREIGN KEY (`ZipCodes__ZipCode`)
    REFERENCES `MortenDB`.`ZipCodes` (`_ZipCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Hotel_ZipCodes_idx` ON `MortenDB`.`Hotel` (`ZipCodes__ZipCode` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `MortenDB`.`Kunde`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`Kunde` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`Kunde` (
  `Kundenummer` INT NOT NULL DEFAULT 0000,
  `Navn` VARCHAR(50) NULL,
  `Address` VARCHAR(50) NULL,
  `Telefon` VARCHAR(50) NULL,
  `Email` VARCHAR(50) NULL,
  `Bemærkning` VARCHAR(50) NULL,
  `Hotel__ID` INT NOT NULL DEFAULT 0000,
  `Hotel__Name` VARCHAR(30) NOT NULL DEFAULT '0000',
  PRIMARY KEY (`Kundenummer`),
  CONSTRAINT `fk_Gæster_Hotel1`
    FOREIGN KEY (`Hotel__ID` , `Hotel__Name`)
    REFERENCES `MortenDB`.`Hotel` (`_ID` , `_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Gæster_Hotel1_idx` ON `MortenDB`.`Kunde` (`Hotel__ID` ASC, `Hotel__Name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `MortenDB`.`Rabat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`Rabat` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`Rabat` (
  `RabatNavn` VARCHAR(50) NOT NULL DEFAULT '0000',
  `RabatPercent` DOUBLE NULL,
  PRIMARY KEY (`RabatNavn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MortenDB`.`Booking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`Booking` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`Booking` (
  `Booking_ID` INT NOT NULL DEFAULT 0000,
  `Kunde_Kundenummer` INT NOT NULL DEFAULT 0000,
  `Rabat_RabatNavn` VARCHAR(50) NOT NULL DEFAULT 'Ingen',
  `FraDato` DATE NULL,
  `TilDato` DATE NULL,
  PRIMARY KEY (`Booking_ID`),
  CONSTRAINT `fk_Booking_Kunde1`
    FOREIGN KEY (`Kunde_Kundenummer`)
    REFERENCES `MortenDB`.`Kunde` (`Kundenummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Booking_Rabat1`
    FOREIGN KEY (`Rabat_RabatNavn`)
    REFERENCES `MortenDB`.`Rabat` (`RabatNavn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Booking_Kunde1_idx` ON `MortenDB`.`Booking` (`Kunde_Kundenummer` ASC) VISIBLE;

CREATE INDEX `fk_Booking_Rabat1_idx` ON `MortenDB`.`Booking` (`Rabat_RabatNavn` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `MortenDB`.`Rum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`Rum` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`Rum` (
  `_ID` INT NOT NULL AUTO_INCREMENT,
  `Hotel__ID` INT NOT NULL DEFAULT 0,
  `Hotel__Name` VARCHAR(30) NOT NULL DEFAULT 'Unknown',
  `_RoomNr` INT NULL,
  `_Type` VARCHAR(45) NULL,
  `_Price` DECIMAL(4) NULL,
  `Booked` TINYINT NOT NULL DEFAULT 0,
  `Booking_Booking_ID` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`_ID`),
  CONSTRAINT `fk_Rum_Hotel1`
    FOREIGN KEY (`Hotel__ID` , `Hotel__Name`)
    REFERENCES `MortenDB`.`Hotel` (`_ID` , `_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rum_Booking1`
    FOREIGN KEY (`Booking_Booking_ID`)
    REFERENCES `MortenDB`.`Booking` (`Booking_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Rum_Hotel1_idx` ON `MortenDB`.`Rum` (`Hotel__ID` ASC, `Hotel__Name` ASC) VISIBLE;

CREATE INDEX `fk_Rum_Booking1_idx` ON `MortenDB`.`Rum` (`Booking_Booking_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `MortenDB`.`HotelPersonale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`HotelPersonale` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`HotelPersonale` (
  `PersonaleID` INT NOT NULL DEFAULT 0000,
  `Navn` VARCHAR(45) NULL,
  `Job` VARCHAR(45) NULL,
  `Telefon` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Hotel__ID` INT NOT NULL,
  `Hotel__Name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`PersonaleID`),
  CONSTRAINT `fk_HotelPersonale_Hotel1`
    FOREIGN KEY (`Hotel__ID` , `Hotel__Name`)
    REFERENCES `MortenDB`.`Hotel` (`_ID` , `_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_HotelPersonale_Hotel1_idx` ON `MortenDB`.`HotelPersonale` (`Hotel__ID` ASC, `Hotel__Name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `MortenDB`.`Bikes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`Bikes` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`Bikes` (
  `_ID` INT NOT NULL DEFAULT 000,
  `_Type` VARCHAR(45) NULL,
  `Booking_Booking_ID` INT NOT NULL DEFAULT 0000,
  `Booked` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`_ID`),
  CONSTRAINT `fk_Cykler_Booking1`
    FOREIGN KEY (`Booking_Booking_ID`)
    REFERENCES `MortenDB`.`Booking` (`Booking_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cykler_Booking1_idx` ON `MortenDB`.`Bikes` (`Booking_Booking_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `MortenDB`.`Konferencerum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MortenDB`.`Konferencerum` ;

CREATE TABLE IF NOT EXISTS `MortenDB`.`Konferencerum` (
  `_ID` INT NOT NULL DEFAULT 0000,
  `AntalPersoner` INT NULL,
  `Booking_Booking_ID` INT NOT NULL DEFAULT 0000,
  `Booked` TINYINT NOT NULL DEFAULT 0,
  `Service` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`_ID`),
  CONSTRAINT `fk_Konferencerum_Booking1`
    FOREIGN KEY (`Booking_Booking_ID`)
    REFERENCES `MortenDB`.`Booking` (`Booking_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Konferencerum_Booking1_idx` ON `MortenDB`.`Konferencerum` (`Booking_Booking_ID` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `MortenDB`.`ZipCodes`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`ZipCodes` (`_ZipCode`, `_City`) VALUES (1111, 'Bispeborg');
INSERT INTO `MortenDB`.`ZipCodes` (`_ZipCode`, `_City`) VALUES (2222, 'Hjemby');
INSERT INTO `MortenDB`.`ZipCodes` (`_ZipCode`, `_City`) VALUES (3333, 'Lilleby');
INSERT INTO `MortenDB`.`ZipCodes` (`_ZipCode`, `_City`) VALUES (4444, 'Borgerslev');
INSERT INTO `MortenDB`.`ZipCodes` (`_ZipCode`, `_City`) VALUES (6666, 'Roslev');

COMMIT;


-- -----------------------------------------------------
-- Data for table `MortenDB`.`Hotel`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`Hotel` (`_ID`, `_Name`, `_Address`, `ZipCodes__ZipCode`) VALUES (1, 'The Pope', 'Vatikangade 1', 1111);
INSERT INTO `MortenDB`.`Hotel` (`_ID`, `_Name`, `_Address`, `ZipCodes__ZipCode`) VALUES (2, 'Lucky Star', 'Bredgade 12', 2222);
INSERT INTO `MortenDB`.`Hotel` (`_ID`, `_Name`, `_Address`, `ZipCodes__ZipCode`) VALUES (3, 'Discount', 'Billigvej 7', 3333);
INSERT INTO `MortenDB`.`Hotel` (`_ID`, `_Name`, `_Address`, `ZipCodes__ZipCode`) VALUES (4, 'deLuxe', 'Kapital Avenue 99', 4444);
INSERT INTO `MortenDB`.`Hotel` (`_ID`, `_Name`, `_Address`, `ZipCodes__ZipCode`) VALUES (5, 'Discount', 'Billiggade 12', 6666);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MortenDB`.`Kunde`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`Kunde` (`Kundenummer`, `Navn`, `Address`, `Telefon`, `Email`, `Bemærkning`, `Hotel__ID`, `Hotel__Name`) VALUES (1, 'Pope Frans', 'KatolKirken', '020201231', 'popethefrans@godmail.heaven', 'Ingen', 1, 'The Pope');
INSERT INTO `MortenDB`.`Kunde` (`Kundenummer`, `Navn`, `Address`, `Telefon`, `Email`, `Bemærkning`, `Hotel__ID`, `Hotel__Name`) VALUES (0, 'Bob Doe Jr', 'Space', '0', '0', 'Ingen', 1, 'The Pope');

COMMIT;


-- -----------------------------------------------------
-- Data for table `MortenDB`.`Rabat`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`Rabat` (`RabatNavn`, `RabatPercent`) VALUES ('FDM', 0.88);
INSERT INTO `MortenDB`.`Rabat` (`RabatNavn`, `RabatPercent`) VALUES ('Online', 0.90);
INSERT INTO `MortenDB`.`Rabat` (`RabatNavn`, `RabatPercent`) VALUES ('Ingen', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MortenDB`.`Booking`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (1, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (2, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (3, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (4, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (5, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (6, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (7, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (8, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (9, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (10, 1, 'Online', '31-05-22', '10-06-22');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (0, 0, 'ingen', '00-00-00', '00-00-00');
INSERT INTO `MortenDB`.`Booking` (`Booking_ID`, `Kunde_Kundenummer`, `Rabat_RabatNavn`, `FraDato`, `TilDato`) VALUES (11, 1, 'Online', '31-05-22', '10-06-22');

COMMIT;


-- -----------------------------------------------------
-- Data for table `MortenDB`.`Rum`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (1, 1, 'The Pope', 1, 'D', 200, 0, 0);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (2, 1, 'The Pope', 2, 'D', 200, 0, 0);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (3, 1, 'The Pope', 11, 'S', 150, 0, 0);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (4, 1, 'The Pope', 21, 'F', 220, 1, 1);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (5, 2, 'Lucky Star', 1, 'D', 230, 0, 0);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (6, 2, 'Lucky Star', 2, 'D', 230, 0, 0);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (7, 2, 'Lucky Star', 11, 'S', 180, 0, 0);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (8, 2, 'Lucky Star', 21, 'F', 300, 0, 0);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (9, 3, 'Discount', 1, 'D', 175, 0, 0);
INSERT INTO `MortenDB`.`Rum` (`_ID`, `Hotel__ID`, `Hotel__Name`, `_RoomNr`, `_Type`, `_Price`, `Booked`, `Booking_Booking_ID`) VALUES (10, 5, 'Discount', 2, 'D', 170, 0, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MortenDB`.`HotelPersonale`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (1, 'John Doe', 'rengøringsmedhjælper ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (2, 'Jane Doe', 'rengøringsmedhjælper ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (3, 'Bob Doe', 'rengøringsmedhjælper ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (4, 'Jill Doe', 'receptionspersonale ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (5, 'Joy Doe', 'receptionspersonale ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (6, 'Wu Doe', 'receptionspersonale ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (7, 'Kent Doe', 'receptionspersonale ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (8, 'Mads Doe', 'receptionspersonale ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (9, 'Sune Doe', 'receptionspersonale ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (10, 'Rim Doe', 'receptionspersonale ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (11, 'Teo Doe', 'receptionspersonale ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (12, 'Daniel Doe', 'betjeningspersonale', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (13, 'Christian Doe', 'betjeningspersonale', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (14, 'Roald Doe', 'betjeningspersonale', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (15, 'ZBC Doe', 'betjeningspersonale', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (16, 'Ole Doe', 'betjeningspersonale', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (17, 'Jule Doe', 'betjeningspersonale', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (18, 'Rose Doe', 'betjeningspersonale', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (19, 'Kim Doe', 'betjeningspersonale', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (20, 'Jil Doe', 'ledere ', NULL, NULL, 1, 'The Pope');
INSERT INTO `MortenDB`.`HotelPersonale` (`PersonaleID`, `Navn`, `Job`, `Telefon`, `Email`, `Hotel__ID`, `Hotel__Name`) VALUES (21, 'Dorte Doe', 'ledere ', NULL, NULL, 1, 'The Pope');

COMMIT;


-- -----------------------------------------------------
-- Data for table `MortenDB`.`Bikes`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (1, 'EL', 2, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (2, 'EL', 3, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (3, 'EL', 4, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (4, 'EL', 5, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (5, 'EL', 6, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (6, 'Lad', 7, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (7, 'Lad', 8, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (8, 'Lad', 9, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (9, 'Lad', 10, 1);
INSERT INTO `MortenDB`.`Bikes` (`_ID`, `_Type`, `Booking_Booking_ID`, `Booked`) VALUES (10, 'Lad', 11, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MortenDB`.`Konferencerum`
-- -----------------------------------------------------
START TRANSACTION;
USE `MortenDB`;
INSERT INTO `MortenDB`.`Konferencerum` (`_ID`, `AntalPersoner`, `Booking_Booking_ID`, `Booked`, `Service`) VALUES (1, 50, 11, 1, DEFAULT);

COMMIT;

