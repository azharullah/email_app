-- MySQL dump 10.13  Distrib 8.0.13, for osx10.14 (x86_64)
--
-- Host: localhost    Database: email_app
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `drafts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_emails` json DEFAULT NULL,
  `subject` text COLLATE utf8mb4_general_ci NOT NULL,
  `body` text COLLATE utf8mb4_general_ci NOT NULL,
  `sent_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_emails` json DEFAULT NULL,
  `subject` text COLLATE utf8mb4_general_ci NOT NULL,
  `body` text COLLATE utf8mb4_general_ci NOT NULL,
  `seen_by` json DEFAULT NULL,
  `forwarded_to` json DEFAULT NULL,
  `forwarded_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reply_email` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `sent_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
INSERT INTO `emails` VALUES (1,'shariffazharullah@gmail.com','[\"12345@gmail.com\", \"abcde@gmail.com\"]','Hi There','My name is Azhar','[\"shariffazharullah@gmail.com\"]',NULL,NULL,NULL,1,'2019-01-18 21:43:51'),(2,'shariffazharullah@gmail.com','[\"12345@gmail.com\", \"abcde@gmail.com\"]','Hi There','My name is Azhar','[\"shariffazharullah@gmail.com\"]',NULL,NULL,NULL,0,'2019-01-18 21:43:52'),(3,'shariffazharullah@gmail.com','[\"xyz@gmail.com\"]','Hi There','My name is Azhar','[\"xyz@gmail.com\"]',NULL,NULL,NULL,1,'2019-01-19 11:22:02'),(4,'shariffazharullah@gmail.com','[\"shariffazharullah@gmail.com\", \"abcde@gmail.com\"]','dfuvkdfvkf','fbjkhb ekfber hberjrheb','[\"shariffazharullah@gmail.com\"]',NULL,NULL,NULL,1,'2019-01-19 18:31:06'),(5,'shariffazharullah@gmail.com','[\"shariffazharullah@gmail.com\", \"xyz@gmail.com\"]','Testing mark as read','same','[\"shariffazharullah@gmail.com\"]',NULL,NULL,NULL,1,'2019-01-19 19:15:39'),(6,'shariffazharullah@gmail.com','[\"shariffazharullah@gmail.com\", \"xyz@gmail.com\"]','dfjhvbfdjhvb','djfvb dkjfv','[\"shariffazharullah@gmail.com\"]',NULL,NULL,NULL,0,'2019-01-19 19:38:58'),(7,'xyz@gmail.com','[\"shariffazharullah@gmail.com\"]','dvndkfb','kdbvkdfbvdf',NULL,NULL,NULL,NULL,0,'2019-01-19 19:40:08');
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trash`
--

DROP TABLE IF EXISTS `trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `trash` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_emails` json DEFAULT NULL,
  `subject` text COLLATE utf8mb4_general_ci NOT NULL,
  `body` text COLLATE utf8mb4_general_ci NOT NULL,
  `forwarded_to` json DEFAULT NULL,
  `forwarded_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reply_email` int(11) DEFAULT NULL,
  `sent_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trash`
--

LOCK TABLES `trash` WRITE;
/*!40000 ALTER TABLE `trash` DISABLE KEYS */;
/*!40000 ALTER TABLE `trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('12345@gmail.com','12345','12345678','2019-01-18 20:41:05'),('abcde@gmail.com','abcde','12345678','2019-01-18 20:41:08'),('shariffazharullah@gmail.com','azharullah','12345678','2019-01-18 18:58:28'),('xyz@gmail.com','xyz','12345678','2019-01-18 20:41:10');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-20  1:24:47
