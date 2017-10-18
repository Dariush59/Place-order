-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: shop
-- ------------------------------------------------------
-- Server version	5.7.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `courier_charges`
--

DROP TABLE IF EXISTS `courier_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courier_charges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `package` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier_charges`
--

LOCK TABLES `courier_charges` WRITE;
/*!40000 ALTER TABLE `courier_charges` DISABLE KEYS */;
INSERT INTO `courier_charges` VALUES (1,'0 to 200g',5.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(2,'200g to 500g',10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(3,'500g to 1000g',15.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(4,'1000g to 5000g ',20.00,'2017-10-17 16:53:10',NULL);
/*!40000 ALTER TABLE `courier_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2017_10_17_051037_create_courier_charges_table',1),(4,'2017_10_17_152207_create_products_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `weight` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Item 1',10.00,200.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(2,'Item 2',100.00,20.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(3,'Item 3',30.00,300.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(4,'Item 4',20.00,500.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(5,'Item 5',30.00,250.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(6,'Item 6',40.00,10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(7,'Item 7',200.00,10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(8,'Item 8',120.00,500.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(9,'Item 9',130.00,790.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(10,'Item 10',20.00,100.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(11,'Item 11',10.00,340.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(12,'Item 12',4.00,800.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(13,'Item 13',5.00,200.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(14,'Item 14',240.00,20.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(15,'Item 15',123.00,700.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(16,'Item 16',245.00,10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(17,'Item 17',230.00,20.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(18,'Item 18',110.00,200.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(19,'Item 19',45.00,200.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(20,'Item 20',67.00,20.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(21,'Item 21',88.00,300.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(22,'Item 22',10.00,500.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(23,'Item 23',17.00,250.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(24,'Item 24',19.00,10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(25,'Item 25',89.00,10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(26,'Item 26',45.00,500.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(27,'Item 27',99.00,790.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(28,'Item 28',125.00,100.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(29,'Item 29',198.00,340.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(30,'Item 30',220.00,800.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(31,'Item 31',249.00,200.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(32,'Item 32',230.00,20.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(33,'Item 33',190.00,700.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(34,'Item 34',45.00,10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(35,'Item 35',12.00,20.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(36,'Item 36',5.00,200.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(37,'Item 37',2.00,200.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(38,'Item 38',90.00,20.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(39,'Item 39',12.00,300.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(40,'Item 40',167.00,500.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(41,'Item 41',12.00,250.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(42,'Item 42',8.00,10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(43,'Item 43',2.00,10.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(44,'Item 44',9.00,500.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(45,'Item 45',210.00,790.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(46,'Item 46',167.00,100.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(47,'Item 47',23.00,340.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(48,'Item 48',190.00,800.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(49,'Item 49',199.00,200.00,'2017-10-17 16:53:10','2017-10-17 16:53:10'),(50,'Item 50',12.00,20.00,'2017-10-17 16:53:10','2017-10-17 16:53:10');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2017-10-19  2:37:47
