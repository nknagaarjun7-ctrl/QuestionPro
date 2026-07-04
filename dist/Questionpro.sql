-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: questionpro
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin123'),(2,'Arjun','Arjun@123');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Aptitude'),(2,'Reasoning'),(3,'Programming'),(4,'General Knowledge'),(5,'Technical');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `option_a` varchar(255) DEFAULT NULL,
  `option_b` varchar(255) DEFAULT NULL,
  `option_c` varchar(255) DEFAULT NULL,
  `option_d` varchar(255) DEFAULT NULL,
  `correct_answer` char(1) DEFAULT NULL,
  `question_text` text,
  `category` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Programming Language','Browser','Database','Operating System','A',NULL,NULL),(2,'3','4','5','6','B','What is 2 + 2?','Aptitude'),(3,'Mumbai','Chennai','Delhi','Kolkata','C','What is the capital of India?','General Knowledge'),(4,'Einstein','Newton','Charles Babbage','Edison','C','Who invented the computer?','Technical'),(5,'Oxygen','Hydrogen','Water','Carbon','C','What is H2O?','General Knowledge'),(6,'5','6','8','7','D','How many days in a week?','Aptitude'),(7,'10','100','1000','110','B','What is 10 x 10?','Aptitude'),(8,'Read Access Memory','Random Access Memory','Run Access Memory','None','B','RAM stands for?','Technical'),(9,'C++','Java','HTML','Python','C','Which language is used for web pages?','Programming'),(10,'0','1','2','2.5','B','What is the output of 5%2?','Programming'),(11,'Bill Gates','Steve Jobs','Charles Babbage','Alan Turing','C','Who is the father of Computer?','Technical'),(12,'6','7','8','9','C','What is 5 + 3?','Aptitude'),(13,'2','3','4','5','C','What is the square root of 16?','Aptitude'),(14,'Earth','Mars','Venus','Mercury','D','Which planet is closest to the Sun?','General Knowledge'),(15,'Control Process Unit','Central Process Unit','Central Processing Unit','Core Processing Unit','C','What is the full form of CPU?','Technical'),(16,'Swift','Kotlin','PHP','Ruby','B','Which language is used for Android development?','Programming'),(17,'124','144','134','154','B','What is 12 x 12?','Aptitude'),(18,'Steve Jobs','Bill Gates','Elon Musk','Mark Zuckerberg','B','Who is the founder of Microsoft?','General Knowledge'),(19,'Hyper Text Makeup Language','Hyper Transfer Markup Language','Hyper Text Markup Language','High Text Markup Language','C','What does HTML stand for?','Programming'),(20,'Read Access Memory','Random Access Memory','Run Access Memory','Real Access Memory','B','What is RAM?','Technical'),(21,'HTML','CSS','Python','Photoshop','C','Which of these is a programming language?','Programming'),(22,'20','25','30','35','C','What is 15% of 200?','Aptitude'),(23,'4','8','16','32','B','How many bits in a byte?','Technical'),(24,'Edison','Tesla','Graham Bell','Marconi','C','Who invented the telephone?','General Knowledge'),(25,'128','256','512','1024','B','What is the output of 2^8?','Technical'),(26,'Queue','Stack','Tree','Graph','B','Which data structure uses LIFO?','Programming');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `total_questions` int DEFAULT NULL,
  `exam_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'naga arjun','nagarjunnk31@gmail.com','Arjun@123','2026-06-14 07:06:59','9344220388'),(2,'muthu','muthuarjun@gmail.com','muthu@123','2026-06-27 04:39:57','9344731659'),(3,'Krishna moorthy','krishna@gmail.com','$2a$10$m2KGCEP1qNaANs1Jdpg6B.w0790cCO0uCaanGbKbJYfxVy/sUz9rq','2026-07-03 13:13:35','8925825783');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-04 11:43:40
