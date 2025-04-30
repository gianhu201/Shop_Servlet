-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: Servlet_ClothingShop
-- ------------------------------------------------------
-- Server version	8.0.39

-- login user: 
-- admin@gmail.com pass: 123456
-- user1@gmail.com pass: 123456 hoac login google

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'pending',
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (11,2,12,3,'M','─Éen','pending'),(12,2,8,1,'S','─Éen','pending'),(14,2,8,1,'L','─Éen','pending');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Nß╗»'),(2,'Nam'),(3,'Thß╗¥i trang trß║╗ em'),(4,'Mß╗╣ phß║⌐m'),(5,'Phß╗Ñ kiß╗çn'),(7,'hi');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `level` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `order_detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `order_details_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (21,14,7,1,400000.00,'Trß║»ng','M'),(22,15,7,1,400000.00,'Trß║»ng','S'),(23,16,8,1,390000.00,'Trß║»ng','M'),(24,17,8,1,390000.00,'Trß║»ng','S'),(25,18,9,1,320000.00,'─Éen','S'),(26,19,9,3,320000.00,'Trß║»ng','M'),(27,20,12,1,600000.00,'─Éen','M'),(28,21,9,1,320000.00,'Trß║»ng','S'),(29,22,9,1,320000.00,'Trß║»ng','S'),(30,23,9,1,320000.00,'Trß║»ng','S'),(31,24,8,1,390000.00,'Trß║»ng','M'),(32,25,9,2,320000.00,'Trß║»ng','L'),(33,26,9,1,320000.00,'Trß║»ng','M'),(34,27,8,1,390000.00,'Trß║»ng','M'),(35,28,8,1,390000.00,'Trß║»ng','M'),(36,29,8,1,390000.00,'Trß║»ng','L'),(37,30,8,1,390000.00,'Xanh','L'),(38,31,9,1,320000.00,'Trß║»ng','L'),(39,32,8,1,390000.00,'Trß║»ng','M'),(40,33,8,1,390000.00,'Trß║»ng','L'),(41,34,8,1,390000.00,'Trß║»ng','M'),(42,34,9,1,320000.00,'Trß║»ng','M'),(43,34,8,1,390000.00,'─Éen','M'),(44,35,8,1,390000.00,'Trß║»ng','M'),(45,35,9,1,320000.00,'Trß║»ng','M'),(46,35,8,1,390000.00,'─Éen','M'),(47,36,8,1,390000.00,'Trß║»ng','S');
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('processing','completed','failed') DEFAULT 'processing',
  `recipient_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text,
  `payment_method` varchar(255) DEFAULT NULL,
  `email_confirmed` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (14,6,'2025-04-22 20:54:32',400000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(15,6,'2025-04-22 20:58:03',400000.00,'processing','gia nhu','0347959824','1234 Nguyen hue','cod',NULL),(16,6,'2025-04-22 20:59:01',390000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(17,6,'2025-04-22 21:04:24',390000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(18,6,'2025-04-22 21:11:55',320000.00,'processing','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(19,6,'2025-04-22 21:13:58',960000.00,'processing','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(20,6,'2025-04-22 21:19:28',600000.00,'processing','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(21,6,'2025-04-22 21:31:07',320000.00,'processing','gia nhu','0347959824','1234 Nguyen hue',NULL,NULL),(22,6,'2025-04-22 21:31:22',320000.00,'processing','gia nhu','0347959824','1234 Nguyen hue',NULL,NULL),(23,6,'2025-04-22 21:31:30',320000.00,'processing','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(24,6,'2025-04-22 21:40:31',390000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(25,6,'2025-04-22 21:44:16',640000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(26,6,'2025-04-22 21:47:36',320000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(27,6,'2025-04-22 21:54:09',390000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(28,6,'2025-04-22 21:56:42',390000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(29,6,'2025-04-22 22:00:24',390000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(30,6,'2025-04-22 22:02:17',390000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(31,6,'2025-04-22 22:09:58',320000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(32,6,'2025-04-22 22:19:05',390000.00,'failed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(33,6,'2025-04-22 22:25:38',390000.00,'completed','gia nhu','0347959824','1234 Nguyen hue','vnpay',NULL),(34,6,'2025-04-23 03:26:45',1100000.00,'processing','gia nhu','0347959824','1234 Nguyen hue','vnpay','trangianhu184@gmail.com'),(35,6,'2025-04-23 03:27:51',1100000.00,'completed','gia nhu','0347959824','1234 Nguyen hue','vnpay','trangianhu184@gmail.com'),(36,6,'2025-04-23 03:30:05',390000.00,'processing','gia nhu','0347959824','1234 Nguyen hue','cod','trangianhu184@gmail.com');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `method` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `paid_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variants` (
  `variant_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant_quantity` int NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`variant_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `product_variants_chk_1` CHECK ((`variant_quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variants`
--

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
INSERT INTO `product_variants` VALUES (337,7,'XS','Trang',0,NULL),(338,7,'M','Trang',50,NULL),(339,7,'L','Trang',0,NULL),(340,7,'S','Den',0,NULL),(341,7,'s','vang',0,NULL),(342,7,'XS','Den',185,NULL),(343,7,'s','hong',5,NULL),(344,7,'xl','hong',0,NULL),(345,8,'xl','hong',0,NULL);
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (7,'V├íy dß╗▒ tiß╗çc ','V├íy phong c├ích sang trß╗ìng, quy phai',400000.00,'AVATA.jpg',3,'2025-04-09 10:01:45','2025-04-13 01:51:55',1),(8,'V├íy c├┤ng sß╗ƒ trß║»ng','Phong c├ích lß╗ïch sß╗▒, ph├╣ hß╗úp m├┤i tr╞░ß╗¥ng v─ân ph├▓ng.',390000.00,'women2.jpg',1,'2025-04-09 10:01:45','2025-04-13 01:51:55',1),(9,'├üo s╞í mi nam','├üo s╞í mi cao cß║Ñp, vß║úi tho├íng m├ít, dß╗à chß╗ïu.',320000.00,'men1.jpg',2,'2025-04-09 10:01:45','2025-04-13 01:51:55',1),(10,'Quß║ºn jeans nam','Quß║ºn jeans kiß╗âu d├íng hiß╗çn ─æß║íi, n─âng ─æß╗Öng.',500000.00,'men2.jpg',2,'2025-04-09 10:01:45','2025-04-13 01:51:55',1),(11,'T├║i x├ích thß╗¥i trang','T├║i da PU cao cß║Ñp, nhiß╗üu ng─ân tiß╗çn dß╗Ñng.',250000.00,'women3.jpg',5,'2025-04-09 10:01:45','2025-04-13 01:51:55',1),(12,'Gi├áy sneaker trß║»ng','Gi├áy thß╗â thao phong c├ích H├án Quß╗æc.',600000.00,'men3.jpg',5,'2025-04-09 10:01:45','2025-04-13 01:51:55',1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recaptcha_tokens`
--

DROP TABLE IF EXISTS `recaptcha_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recaptcha_tokens` (
  `token_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `recaptcha_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recaptcha_tokens`
--

LOCK TABLES `recaptcha_tokens` WRITE;
/*!40000 ALTER TABLE `recaptcha_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `recaptcha_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `user_id` int NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text,
  `birthday` date DEFAULT NULL,
  `gender` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1,'0123456789','H├á Nß╗Öi','1990-01-01','Nam');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1),(2,2),(6,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `gmail_id` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `full_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@gmail.com','123456',1,NULL,'2025-04-08 08:38:49','admin_name'),(2,'user1@gmail.com','123456',1,NULL,'2025-04-08 09:37:47','user1_name'),(6,'trangianhu184@gmail.com',NULL,1,NULL,'2025-04-21 17:27:48','Nh╞░ Trß║ºn');
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

-- Dump completed on 2025-04-23 12:54:53
