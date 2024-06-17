-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия на сървъра:            10.4.27-MariaDB - mariadb.org binary distribution
-- ОС на сървъра:                Win64
-- HeidiSQL Версия:              12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Дъмп на структурата на БД lessons
CREATE DATABASE IF NOT EXISTS `lessons` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `lessons`;

-- Дъмп структура за таблица lessons.classrooms
CREATE TABLE IF NOT EXISTS `classrooms` (
  `ClassroomID` int(11) NOT NULL AUTO_INCREMENT,
  `RoomNumber` varchar(10) DEFAULT NULL,
  `Capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`ClassroomID`),
  UNIQUE KEY `RoomNumber` (`RoomNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дъмп данни за таблица lessons.classrooms: ~0 rows (приблизително)

-- Дъмп структура за таблица lessons.courses
CREATE TABLE IF NOT EXISTS `courses` (
  `CourseID` int(11) NOT NULL AUTO_INCREMENT,
  `Language` varchar(50) NOT NULL,
  `Level` varchar(20) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `Schedule` varchar(100) DEFAULT NULL,
  `Classroom` varchar(50) DEFAULT NULL,
  `CourseFee` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дъмп данни за таблица lessons.courses: ~0 rows (приблизително)

-- Дъмп структура за изглед lessons.course_classroom_info
-- Създаване на временна таблица за преодоляване на грешката от зависимост на VIEW
CREATE TABLE `course_classroom_info` (
	`CourseID` INT(11) NOT NULL,
	`Language` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`Level` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci',
	`StartDate` DATE NULL,
	`EndDate` DATE NULL,
	`RoomNumber` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`Capacity` INT(11) NULL
) ENGINE=MyISAM;

-- Дъмп структура за таблица lessons.course_teacher
CREATE TABLE IF NOT EXISTS `course_teacher` (
  `CourseID` int(11) NOT NULL,
  `TeacherID` int(11) NOT NULL,
  PRIMARY KEY (`CourseID`,`TeacherID`),
  KEY `TeacherID` (`TeacherID`),
  CONSTRAINT `course_teacher_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`),
  CONSTRAINT `course_teacher_ibfk_2` FOREIGN KEY (`TeacherID`) REFERENCES `teachers` (`TeacherID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дъмп данни за таблица lessons.course_teacher: ~0 rows (приблизително)

-- Дъмп структура за изглед lessons.course_teacher_info
-- Създаване на временна таблица за преодоляване на грешката от зависимост на VIEW
CREATE TABLE `course_teacher_info` (
	`CourseID` INT(11) NOT NULL,
	`Language` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`Level` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci',
	`StartDate` DATE NULL,
	`EndDate` DATE NULL,
	`TeacherFirstName` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`TeacherLastName` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`TeacherEmail` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Дъмп структура за таблица lessons.enrollments
CREATE TABLE IF NOT EXISTS `enrollments` (
  `EnrollmentID` int(11) NOT NULL AUTO_INCREMENT,
  `StudentID` int(11) DEFAULT NULL,
  `CourseID` int(11) DEFAULT NULL,
  `EnrollmentDate` date DEFAULT NULL,
  PRIMARY KEY (`EnrollmentID`),
  KEY `StudentID` (`StudentID`),
  KEY `CourseID` (`CourseID`),
  CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`),
  CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дъмп данни за таблица lessons.enrollments: ~0 rows (приблизително)

-- Дъмп структура за таблица lessons.students
CREATE TABLE IF NOT EXISTS `students` (
  `StudentID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `ContactEmail` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `RegistrationDate` date DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`StudentID`),
  UNIQUE KEY `ContactEmail` (`ContactEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дъмп данни за таблица lessons.students: ~0 rows (приблизително)

-- Дъмп структура за изглед lessons.student_enrollment_info
-- Създаване на временна таблица за преодоляване на грешката от зависимост на VIEW
CREATE TABLE `student_enrollment_info` (
	`StudentID` INT(11) NOT NULL,
	`FirstName` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`LastName` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`ContactEmail` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci',
	`CourseID` INT(11) NULL,
	`CourseLanguage` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`CourseLevel` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci',
	`EnrollmentDate` DATE NULL
) ENGINE=MyISAM;

-- Дъмп структура за таблица lessons.teachers
CREATE TABLE IF NOT EXISTS `teachers` (
  `TeacherID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `ContactEmail` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `Qualifications` text DEFAULT NULL,
  `Specializations` text DEFAULT NULL,
  PRIMARY KEY (`TeacherID`),
  UNIQUE KEY `ContactEmail` (`ContactEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Дъмп данни за таблица lessons.teachers: ~0 rows (приблизително)

-- Дъмп структура за тригер lessons.after_insert_courses
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER after_insert_courses
AFTER INSERT ON courses
FOR EACH ROW
BEGIN
    INSERT INTO course_log (CourseID, Event) VALUES (NEW.CourseID, 'New course added');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дъмп структура за тригер lessons.after_insert_students
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER after_insert_students
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_log (StudentID, Event) VALUES (NEW.StudentID, 'New student added');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дъмп структура за тригер lessons.after_update_courses
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER after_update_courses
AFTER UPDATE ON courses
FOR EACH ROW
BEGIN
    INSERT INTO course_log (CourseID, Event) VALUES (NEW.CourseID, 'Course information updated');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дъмп структура за тригер lessons.after_update_students
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER after_update_students
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_log (StudentID, Event) VALUES (NEW.StudentID, 'Student information updated');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дъмп структура за тригер lessons.before_insert_courses
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER before_insert_courses
BEFORE INSERT ON courses
FOR EACH ROW
BEGIN
    IF NEW.StartDate > NEW.EndDate THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Start date must be before end date.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дъмп структура за тригер lessons.before_insert_students
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER before_insert_students
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    DECLARE email_count INT;
    SELECT COUNT(*) INTO email_count FROM students WHERE ContactEmail = NEW.ContactEmail;
    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дъмп структура за тригер lessons.before_update_courses
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER before_update_courses
BEFORE UPDATE ON courses
FOR EACH ROW
BEGIN
    IF NEW.StartDate > NEW.EndDate THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Start date must be before end date.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дъмп структура за тригер lessons.before_update_students
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER before_update_students
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
    DECLARE email_count INT;
    SELECT COUNT(*) INTO email_count FROM students WHERE ContactEmail = NEW.ContactEmail AND StudentID != OLD.StudentID;
    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дъмп структура за изглед lessons.course_classroom_info
-- Премахване на временната таблица и създаване на окончателна VIEW структура
DROP TABLE IF EXISTS `course_classroom_info`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `course_classroom_info` AS SELECT 
    c.CourseID, 
    c.Language, 
    c.Level, 
    c.StartDate, 
    c.EndDate, 
    cr.RoomNumber, 
    cr.Capacity
FROM 
    courses c
JOIN 
    classrooms cr ON c.Classroom = cr.RoomNumber ;

-- Дъмп структура за изглед lessons.course_teacher_info
-- Премахване на временната таблица и създаване на окончателна VIEW структура
DROP TABLE IF EXISTS `course_teacher_info`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `course_teacher_info` AS SELECT 
    c.CourseID, 
    c.Language, 
    c.Level, 
    c.StartDate, 
    c.EndDate, 
    t.FirstName AS TeacherFirstName, 
    t.LastName AS TeacherLastName, 
    t.ContactEmail AS TeacherEmail
FROM 
    courses c
JOIN 
    course_teacher ct ON c.CourseID = ct.CourseID
JOIN 
    teachers t ON ct.TeacherID = t.TeacherID ;

-- Дъмп структура за изглед lessons.student_enrollment_info
-- Премахване на временната таблица и създаване на окончателна VIEW структура
DROP TABLE IF EXISTS `student_enrollment_info`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `student_enrollment_info` AS SELECT 
    s.StudentID, 
    s.FirstName, 
    s.LastName, 
    s.ContactEmail, 
    e.CourseID, 
    c.Language AS CourseLanguage, 
    c.Level AS CourseLevel, 
    e.EnrollmentDate
FROM 
    students s
JOIN 
    enrollments e ON s.StudentID = e.StudentID
JOIN 
    courses c ON e.CourseID = c.CourseID ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
