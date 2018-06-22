DROP DATABASE IF EXISTS `HotelReservation`;

CREATE DATABASE `HotelReservation`;

USE `HotelReservation`;

CREATE TABLE IF NOT EXISTS `Customer` (
  `idCustomer` INT NOT NULL auto_increment,
  `firstName` VARCHAR(15) NOT NULL,
  `lastName` VARCHAR(15) NOT NULL,
  `phone` CHAR(10) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCustomer`));
  
CREATE TABLE IF NOT EXISTS `BillingDetails` (
  `idBillingDetails` INT NOT NULL auto_increment,
  `roomCharges` DECIMAL(7,2) NOT NULL,
  `meals` DECIMAL(7,2) NOT NULL,
  `addOn1` DECIMAL(7,2) NOT NULL,
  `addOn2` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`idBillingDetails`));
  
CREATE TABLE IF NOT EXISTS `Bill` (
  `idBill` INT NOT NULL auto_increment,
  `billingTotal` DECIMAL(10,2) NOT NULL,
  `tax` DECIMAL(5,2) NOT NULL,
  `idBillingDetails` INT NOT NULL,
  PRIMARY KEY (`idBill`),
  CONSTRAINT `fk_Bill_BillingDetails`
    FOREIGN KEY (`idBillingDetails`)
    REFERENCES `BillingDetails` (`idBillingDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
  
CREATE TABLE IF NOT EXISTS `Reservation` (
  `idReservation` INT NOT NULL auto_increment,
  `dateRangeStart` DATE NOT NULL,
  `dateRangeEnd` DATE NOT NULL,
  `listOfGuests` LONGTEXT NOT NULL,
  `idCustomer` INT NOT NULL,
  `idBill` INT NOT NULL,
  PRIMARY KEY (`idReservation`),
  CONSTRAINT `fk_Reservation_Customer`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `Customer` (`idCustomer`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_Bill`
    FOREIGN KEY (`idBill`)
    REFERENCES `Bill` (`idBill`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `RoomType` (
  `idRoomType` INT NOT NULL auto_increment,
  `roomTypeDesc` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idRoomType`));
  
CREATE TABLE IF NOT EXISTS `RoomRate` (
  `idRoomRate` INT NOT NULL auto_increment,
  `roomRate` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`idRoomRate`));
  
CREATE TABLE IF NOT EXISTS `Room` (
  `idRoom` INT NOT NULL auto_increment,
  `floor` INT NOT NULL,
  `number` INT NOT NULL,
  `occupancyLimit` INT NOT NULL,
  `idRoomType` INT NOT NULL,
  `idRoomRate` INT NOT NULL,
  PRIMARY KEY (`idRoom`),
  CONSTRAINT `fk_Room_RoomType`
    FOREIGN KEY (`idRoomType`)
    REFERENCES `RoomType` (`idRoomType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_RoomRate`
    FOREIGN KEY (`idRoomRate`)
    REFERENCES `RoomRate` (`idRoomRate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `PromotionalCode` (
  `idPromotionalCode` INT NOT NULL auto_increment,
  `percentageDiscount` DECIMAL(2,2) NOT NULL,
  `flatDiscount` TINYINT(255) NOT NULL,
  `dateRangeStart` DATE NOT NULL,
  `dateRangeEnd` DATE NOT NULL,
  PRIMARY KEY (`idPromotionalCode`));
  
CREATE TABLE IF NOT EXISTS `Amenity` (
  `idAmenity` INT NOT NULL AUTO_INCREMENT,
  `amenityName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idAmenity`));
  
CREATE TABLE IF NOT EXISTS `RoomAmenity` (
  `idRoom` INT NOT NULL,
  `idAmenity` INT NOT NULL,
  PRIMARY KEY (`idRoom`,`idAmenity`),
  CONSTRAINT `fk_RoomAmenity_Room`
    FOREIGN KEY (`idRoom`)
    REFERENCES `Room` (`idRoom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RoomAmenity_Amenity`
    FOREIGN KEY (`idAmenity`)
    REFERENCES `Amenity` (`idAmenity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `Guest` (
  `idGuest` INT NOT NULL auto_increment, 
  `firstName` VARCHAR(15) NOT NULL,
  `lastName` VARCHAR(15) NOT NULL,
  `age` TINYINT(115) NOT NULL,
  `idCustomer` INT NOT NULL,
  PRIMARY KEY (`idGuest`),
  CONSTRAINT `fk_Guest_Customer`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `ReservationRoom` (
  `idReservation` INT NOT NULL,
  `idRoom` INT NOT NULL,
  PRIMARY KEY (`idReservation`,`idRoom`),
  CONSTRAINT `fk_ReservationRoom_Reservation`
    FOREIGN KEY (`idReservation`)
    REFERENCES `Reservation` (`idReservation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationRoom_Room`
    FOREIGN KEY (`idRoom`)
    REFERENCES `Room` (`idRoom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `ReservationPromotionalCode` (
  `idReservation` INT NOT NULL,
  `idPromotionalCode` INT NOT NULL,
  PRIMARY KEY (`idReservation`,`idPromotionalCode`),
  CONSTRAINT `fk_ReservationPromotionalCode_Reservation`
    FOREIGN KEY (`idReservation`)
    REFERENCES `Reservation` (`idReservation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationPromotionalCode_PromotionalCode`
    FOREIGN KEY (`idPromotionalCode`)
    REFERENCES `PromotionalCode` (`idPromotionalCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `AddOn` (
  `idAddOn` INT NOT NULL auto_increment,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`idAddOn`));
  
CREATE TABLE IF NOT EXISTS `ReservationAddOn` (
  `idReservation` INT NOT NULL,
  `idAddOn` INT NOT NULL,
  PRIMARY KEY (`idReservation`,`idAddOn`),
  CONSTRAINT `fk_ReservatioAddOn_Reservation`
    FOREIGN KEY (`idReservation`)
    REFERENCES `Reservation` (`idReservation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationAddOn_AddOn`
    FOREIGN KEY (`idAddOn`)
    REFERENCES `AddOn` (`idAddOn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    
