CREATE SCHEMA IF NOT EXISTS `data` DEFAULT CHARACTER SET utf8 ;
USE `data` ;

-- -----------------------------------------------------
-- Table `data`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Users` (
  `UserID` INT(11) NOT NULL,
  `FullName` TEXT NOT NULL,
  `e-mail` TEXT NOT NULL,
  `UserStatus` TINYINT(1) NOT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `data`.`Groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Groups` (
  `GroupID` INT(11) NOT NULL,
  `GroupName` TEXT NOT NULL,
  `CreatorID` INT(11) NOT NULL,
  PRIMARY KEY (`GroupID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data`.`Assignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Assignments` (
  `AssignmentID` INT(11) NOT NULL,
  `Description` LONGTEXT NOT NULL,
  `GroupID` INT(11) NOT NULL,
  `DueDate` DATETIME NOT NULL,
  PRIMARY KEY (`AssignmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data`.`Tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Tasks` (
  `TaskID` INT(11) NOT NULL,
  `AssignmentID` INT(11) NOT NULL,
  `Description` LONGTEXT NOT NULL,
  PRIMARY KEY (`TaskID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Students` (
  `StudentID` INT(11) NOT NULL,
  `UserID` INT(11) NOT NULL,
  `GroupID` INT(11) NOT NULL,
  PRIMARY KEY (`UserID`, `GroupID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data`.`Submissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Submissions` (
  `SubmissionID` INT(11) NOT NULL,
  `TaskID` INT(11) NOT NULL,
  `StudentID` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Content` LONGTEXT NOT NULL,
  PRIMARY KEY (`TaskID`, `StudentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data`.`Teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Teachers` (
  `TeacherID` INT(11) NOT NULL,
  `UserID` INT(11) NOT NULL,
  `GroupID` INT(11) NOT NULL,
  PRIMARY KEY (`UserID`, `GroupID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `data`.`Supervisors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Supervisors` (
  `SupervisorID` INT(11) NOT NULL,
  `TeacherID` INT(11) NOT NULL,
  `SubmissionID` INT(11) NOT NULL,
  PRIMARY KEY (`TeacherID`, `SubmissionID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `data`.`Grades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`Grades` (
  `GradeID` INT(11) NOT NULL,
  `SupervisorID` INT(11) NOT NULL,
  `Grade` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`GradeID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `data`.`SupervisorsComments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`SupervisorsComments` (
  `CommentID` INT(11) NOT NULL,
  `SupervisorID` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Comment` LONGTEXT NOT NULL,
  PRIMARY KEY (`CommentID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `data`.`StudentsComments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data`.`StudentsComments` (
  `CommentID` INT(11) NOT NULL,
  `SubmissionID` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Comment` LONGTEXT NOT NULL,
  PRIMARY KEY (`CommentID`))
ENGINE = InnoDB;