-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for duongduaeducation
CREATE DATABASE IF NOT EXISTS `duongduaeducation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `duongduaeducation`;

-- Dumping structure for table duongduaeducation.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `role` int DEFAULT NULL COMMENT '1 - Admin, 2 - Teacher, 3 - Culi, 4 - Student',
  `name` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `certificates` varchar(255) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `class_id` int DEFAULT NULL,
  `parents_name` varchar(50) DEFAULT NULL,
  `parents_email` varchar(50) DEFAULT NULL,
  `parents_phone` varchar(10) DEFAULT NULL,
  `fee` int DEFAULT NULL,
  `status` int DEFAULT NULL COMMENT '1 - Đang theo học, 2 - Đã nghỉ học',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_accounts_classes` (`class_id`),
  CONSTRAINT `FK_accounts_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table duongduaeducation.accounts: ~5 rows (approximately)
INSERT INTO `accounts` (`id`, `email`, `password`, `role`, `name`, `age`, `gender`, `phone`, `address`, `certificates`, `salary`, `class_id`, `parents_name`, `parents_email`, `parents_phone`, `fee`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Admin@gmail.com', 'admin', 1, 'Admin', 30, 'Bê đê', '18001000', 'Hà Nội', NULL, 1000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'duongdua@gmail.com', '1', 2, 'Đuông dừa', 21, '', '19000000', 'Hà Nội', NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'gaotrang@gmail.com', '1', 3, 'Gao trắng', 20, 'Bê đê', '12345678', 'Hải Phòng', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 'gaosoibac@gmail.com', '1', 4, 'Gao sói bạc', 20, 'Trai', '12333333', 'Hà Nội', NULL, NULL, 1, 'Gao sói trắng', 'gaosoitrang@gmail.com', '46375747', 100, NULL, NULL, NULL),
	(7, 'hsngoan@gmail.com', '1', 4, 'Học sinh ngoan', 13, 'Gái', '00012312', 'Hà Nội', NULL, NULL, 3, 'Gao sói đen', 'gaosoiden@gmail.com', '32523525', 120, NULL, NULL, NULL);

-- Dumping structure for table duongduaeducation.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `price` int DEFAULT NULL,
  `status` int DEFAULT NULL COMMENT '1 - chưa thanh toán, 2 - đã thanh toán',
  PRIMARY KEY (`id`),
  KEY `FK_bills_employees` (`account_id`) USING BTREE,
  CONSTRAINT `FK_bills_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table duongduaeducation.bills: ~0 rows (approximately)

-- Dumping structure for table duongduaeducation.classes
CREATE TABLE IF NOT EXISTS `classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_classes_employees` (`teacher_id`),
  CONSTRAINT `FK_classes_accounts` FOREIGN KEY (`teacher_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table duongduaeducation.classes: ~3 rows (approximately)
INSERT INTO `classes` (`id`, `teacher_id`, `name`) VALUES
	(1, 2, '22CN5'),
	(2, 2, '22SQL1'),
	(3, 3, '21CN3');

-- Dumping structure for table duongduaeducation.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_comments_accounts` (`student_id`),
  KEY `FK_comments_lessons` (`lesson_id`),
  CONSTRAINT `FK_comments_accounts` FOREIGN KEY (`student_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `FK_comments_lessons` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table duongduaeducation.comments: ~0 rows (approximately)
INSERT INTO `comments` (`id`, `student_id`, `lesson_id`, `comment`) VALUES
	(1, 4, 1, 'con hăng hái, đã làm bài tập về nhà');

-- Dumping structure for table duongduaeducation.lessons
CREATE TABLE IF NOT EXISTS `lessons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_lessons_classes` (`class_id`),
  CONSTRAINT `FK_lessons_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table duongduaeducation.lessons: ~1 rows (approximately)
INSERT INTO `lessons` (`id`, `class_id`, `title`, `content`) VALUES
	(1, 1, 'tuesday 19-11-24 ', 'Grammar: câu gián tiếp');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
