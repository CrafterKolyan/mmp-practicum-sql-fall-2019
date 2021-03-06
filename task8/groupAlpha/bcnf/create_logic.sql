-- MySQL Script generated by MySQL Workbench
-- Tue Dec 10 18:52:12 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema logic
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `logic` ;

-- -----------------------------------------------------
-- Schema logic
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `logic` DEFAULT CHARACTER SET utf8 ;
USE `logic` ;

-- -----------------------------------------------------
-- Table `logic`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`User` (
  `UserID` INT(11) NOT NULL,
  `FullName` TEXT NOT NULL,
  `e-mail` TEXT NOT NULL,
  `UserStatus` TINYINT(1) NOT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Student` (
  `StudentID` VARCHAR(45) NOT NULL,
  `GroupID` INT(11) NULL,
  `UserID` INT(11) NOT NULL,
  INDEX `fk_Students_Users_idx` (`UserID` ASC) VISIBLE,
  PRIMARY KEY (`StudentID`, `UserID`),
  CONSTRAINT `fk_Students_Users`
    FOREIGN KEY (`UserID`)
    REFERENCES `logic`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Group` (
  `GroupID` INT(11) NOT NULL,
  `GroupName` TEXT NULL,
  `CreatorID` INT(11) NULL,
  PRIMARY KEY (`GroupID`),
  INDEX `fk_Group_User1_idx` (`CreatorID` ASC) VISIBLE,
  CONSTRAINT `fk_Group_User1`
    FOREIGN KEY (`CreatorID`)
    REFERENCES `logic`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Assignment` (
  `AssignmentID` INT(11) NOT NULL,
  `Description` LONGTEXT NULL,
  `GroupID` INT(11) NOT NULL,
  `DueDate` DATETIME NULL,
  PRIMARY KEY (`AssignmentID`),
  INDEX `fk_Assigmnet_Group1_idx` (`GroupID` ASC) VISIBLE,
  CONSTRAINT `fk_Assigmnet_Group1`
    FOREIGN KEY (`GroupID`)
    REFERENCES `logic`.`Group` (`GroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Task` (
  `TaskID` INT(11) NOT NULL,
  `AssignmentID` INT(11) NOT NULL,
  `Description` LONGTEXT NULL,
  PRIMARY KEY (`TaskID`),
  INDEX `fk_Task_Course1_idx` (`AssignmentID` ASC) VISIBLE,
  CONSTRAINT `fk_Task_Course1`
    FOREIGN KEY (`AssignmentID`)
    REFERENCES `logic`.`Assignment` (`AssignmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Students` (
  `StudentID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserID` INT(11) NOT NULL,
  `GroupID` INT(11) NOT NULL,
  INDEX `fk_Participants_Group1_idx` (`GroupID` ASC) VISIBLE,
  INDEX `fk_Participants_User2_idx` (`UserID` ASC) VISIBLE,
  PRIMARY KEY (`UserID`, `GroupID`),
  UNIQUE INDEX `StudentID_UNIQUE` (`StudentID` ASC) VISIBLE,
  CONSTRAINT `fk_Participants_Group1`
    FOREIGN KEY (`GroupID`)
    REFERENCES `logic`.`Group` (`GroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participants_User2`
    FOREIGN KEY (`UserID`)
    REFERENCES `logic`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Submissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Submissions` (
  `SubmissionID` INT(11) NOT NULL AUTO_INCREMENT,
  `TaskID` INT(11) NOT NULL,
  `StudentID` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Content` LONGTEXT NOT NULL,
  INDEX `fk_Solution_Task1_idx` (`TaskID` ASC) VISIBLE,
  INDEX `fk_Submissions_Participants1_idx` (`StudentID` ASC) VISIBLE,
  PRIMARY KEY (`TaskID`, `StudentID`),
  UNIQUE INDEX `SubmissionID_UNIQUE` (`SubmissionID` ASC) VISIBLE,
  CONSTRAINT `fk_Solution_Task1`
    FOREIGN KEY (`TaskID`)
    REFERENCES `logic`.`Task` (`TaskID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Submissions_Participants1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `logic`.`Students` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Teachers` (
  `TeacherID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserID` INT(11) NOT NULL,
  `GroupID` INT(11) NOT NULL,
  INDEX `fk_Teachers_Group1_idx` (`GroupID` ASC) VISIBLE,
  PRIMARY KEY (`UserID`, `GroupID`),
  UNIQUE INDEX `TeacherID_UNIQUE` (`TeacherID` ASC) VISIBLE,
  CONSTRAINT `fk_Teachers_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `logic`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teachers_Group1`
    FOREIGN KEY (`GroupID`)
    REFERENCES `logic`.`Group` (`GroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Supervisors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Supervisors` (
  `SupervisorID` INT(11) NOT NULL AUTO_INCREMENT,
  `TeacherID` INT(11) NOT NULL,
  `SubmissionID` INT(11) NOT NULL,
  INDEX `fk_Supervisors_Submissions1_idx` (`SubmissionID` ASC) VISIBLE,
  UNIQUE INDEX `SupervisorID_UNIQUE` (`SupervisorID` ASC) VISIBLE,
  PRIMARY KEY (`TeacherID`, `SubmissionID`),
  CONSTRAINT `fk_Supervisors_Teachers1`
    FOREIGN KEY (`TeacherID`)
    REFERENCES `logic`.`Teachers` (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supervisors_Submissions1`
    FOREIGN KEY (`SubmissionID`)
    REFERENCES `logic`.`Submissions` (`SubmissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`Grades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`Grades` (
  `GradeID` INT(11) NOT NULL,
  `SupervisorID` INT(11) NOT NULL,
  `Grade` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  INDEX `fk_Grades_Supervisors1_idx` (`SupervisorID` ASC) VISIBLE,
  PRIMARY KEY (`GradeID`),
  CONSTRAINT `fk_Grades_Supervisors1`
    FOREIGN KEY (`SupervisorID`)
    REFERENCES `logic`.`Supervisors` (`SupervisorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`SupervisorComment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`SupervisorComment` (
  `CommentID` INT(11) NOT NULL,
  `SupervisorID` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Comment` LONGTEXT NOT NULL,
  PRIMARY KEY (`CommentID`),
  INDEX `fk_SupervisorComment_Supervisors1_idx` (`SupervisorID` ASC) VISIBLE,
  CONSTRAINT `fk_SupervisorComment_Supervisors1`
    FOREIGN KEY (`SupervisorID`)
    REFERENCES `logic`.`Supervisors` (`SupervisorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logic`.`StudentComment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logic`.`StudentComment` (
  `CommentID` INT(11) NOT NULL,
  `SubmissionID` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Comment` LONGTEXT NULL,
  INDEX `fk_StudentComment_Submissions1_idx` (`SubmissionID` ASC) VISIBLE,
  PRIMARY KEY (`CommentID`),
  CONSTRAINT `fk_StudentComment_Submissions1`
    FOREIGN KEY (`SubmissionID`)
    REFERENCES `logic`.`Submissions` (`SubmissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
