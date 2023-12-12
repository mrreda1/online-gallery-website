-- MariaDB dump 10.19-11.2.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: gallery
-- ------------------------------------------------------
-- Server version	11.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` varchar(10) NOT NULL,
  `cat_name` varchar(50) NOT NULL,
  `cat_image` varchar(50) NOT NULL DEFAULT 'default_cat.jpg',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
('AN','Animals','Animals.png'),
('AR','Art','Art.jpg'),
('BE','Beauty','Beauty.jpg'),
('DE','Decoration','Decoration.jpg'),
('FO','Food','Food.png'),
('GR','Graphics','Graphics.jpeg'),
('HI','Hijab','Hijab.jpg'),
('NA','Nature','Nature.jpg'),
('TR','Travel','Travel.jpg');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `post_time` datetime NOT NULL,
  `image_file` varchar(50) NOT NULL,
  `category_id` varchar(10) NOT NULL,
  `publisher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `publisher_id` (`publisher_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES
(10,'Flowers','Flowers on a boat.','2023-12-06 07:48:18','8074e545cde9eef4.jpg','NA',3),
(11,'Drawings','Drawings on wall.','2023-12-06 07:49:33','58e9d3389f6bc152.jpg','AR',3),
(12,'Landscape','Sunrise in a beautiful lanscape.','2023-12-06 07:51:36','c69bed866d6fd475.jpg','NA',3),
(13,'Beach','A girls reading a book infront of the beach.','2023-12-06 07:52:41','5ee09f57485457ce.jpg','NA',3),
(14,'Passwords','Two persons cary two passwords in the airport.','2023-12-06 07:53:50','e39082e1d5f605d7.jpg','TR',3),
(15,'Living room','Neat and clean Living room.','2023-12-06 07:54:57','71ed2a2b58e1f36d.jpg','DE',3),
(16,'Magazine\'s cover','Lose your mind magazine\'s cover.','2023-12-06 07:57:52','c5b47747fdf3ac78.jpg','GR',3),
(17,'Beautiful Landscape','Beautiful Landscape.','2023-12-06 07:59:18','3baa9c69d7595e00.jpg','NA',3),
(18,'Sea','Beautiful Sea.','2023-12-06 08:02:21','d8ef2e27490c1e90.jpg','TR',3),
(19,'Natual view','Breakfast infront of the sea.','2023-12-06 08:05:56','9df7f0f0c009e11a.jpg','NA',3),
(20,'Creative cover','Creative magazine\'s cover.','2023-12-06 08:07:15','078aa6a9fa3a3fa2.jpg','GR',3),
(21,'Girl painting','Girl sitting down painting.','2023-12-06 08:07:43','2811ec103ace8fc4.jpg','AR',3),
(22,'Yummy Food','Delicious Food.','2023-12-06 08:08:17','7f075d0e35c1de3b.jpg','FO',3),
(23,'Plane','Plane flying around the clouds.','2023-12-06 08:09:45','74233ca89de45c66.jpg','TR',3),
(24,'Delicious Food','Very delicious food.','2023-12-06 08:10:58','765258f7c33c48e9.jpg','FO',3),
(25,'Yummy Food','Good quality food.','2023-12-06 08:11:29','253b59800bb645a5.jpg','FO',3),
(26,'Living room decoration','Clean and tidy living room.','2023-12-06 08:12:13','86f5f8b2bad2ae76.jpg','DE',3),
(27,'Bedroom room ','Night\'s bedroom decoration.','2023-12-06 08:14:33','d2ec5bc12a709f0e.jpg','DE',3),
(28,'Cute animal','Cute animal.','2023-12-06 08:20:47','de8bbe0b0b2fcb5c.jpg','AN',3),
(29,'Hijabi girl ','Cute Hijabi girl.','2023-12-06 08:21:37','3a42604060d09b68.jpg','HI',3),
(30,'Hijabi girl ','Cute Hijabi girl.','2023-12-06 08:22:00','cfb1142664c37ae2.jpg','HI',3),
(31,'Dog','Cute Dog.','2023-12-06 08:22:29','1483a4cb0f948a58.jpg','AN',3),
(32,'Makeup ','Professional Makeup ','2023-12-06 08:23:34','f0cc578dd98937fa.jpg','BE',3),
(33,'Baby tiger','Cute baby tiger.','2023-12-06 08:24:05','7cb2a11c61d7574a.jpg','AN',3),
(34,'turtle','Cute little turtle on the beach.','2023-12-06 08:24:40','2cd5873da5b8f57d.jpg','AN',3),
(35,'Cute cat ','Cute cat.','2023-12-06 08:25:06','cbf59304fb1d6992.jpg','AN',3),
(36,'Cute hijabi girl ','Cute hijabi girl.','2023-12-06 08:25:34','ef1d5b15d650718e.jpg','HI',3),
(37,'Beautiful girl','Beautiful girl carrying perfum bottle.','2023-12-06 08:26:20','7fa4368fb3809ea5.jpg','BE',3),
(38,'Makeup','Girl and makeup.','2023-12-06 08:27:11','da4d397717ed715f.jpg','BE',3),
(39,'Cute hijabi girl','Cute hijabi girl sitting in a cafe.','2023-12-06 08:28:06','ee26f7c87f652bde.jpg','HI',3),
(41,'my decoration','i made this ','2023-12-06 08:50:37','9f5d2bec1fc44934.jpeg','AR',4),
(42,'burgers','.','2023-12-06 08:54:02','7073be601f3ea344.jpeg','FO',4),
(46,'sea','..','2023-12-06 09:57:45','d1c92f3991110383.jpeg','NA',4),
(47,'night','..','2023-12-06 09:58:47','b21ca76d5d5b0937.jpeg','TR',4),
(48,'paris ','..','2023-12-06 09:59:41','ee49a0564eb32f52.jpeg','TR',4),
(49,'pizza','..','2023-12-06 10:01:37','ccdcc3f99eb8d16f.jpeg','FO',4),
(50,'the weeknd','..','2023-12-06 10:02:54','bc3deeebffe1dabb.jpeg','GR',4),
(51,'lol','..','2023-12-06 10:04:23','5a346fd9486733f2.jpeg','AN',4),
(52,'pink butterfly ','..','2023-12-06 10:05:31','b898e3661ab42a27.jpeg','AR',4),
(53,'flowers decoration','..','2023-12-06 10:07:29','cc50876949e83192.jpeg','DE',4),
(54,'wallpaper ','..','2023-12-06 10:10:55','c488a7a25b8aca0c.jpeg','AR',4),
(59,'AHHhHHHH','YESSSS AHAHHAHAHA','2023-12-11 13:27:45','4ff4051ba9a4af9c.jpg','AN',1),
(61,'Overthinking','The solve for all your problems and sad feelings','2023-12-11 13:30:54','fefbdddc7daa2312.png','AR',5),
(63,'AAAaaAHHhHHHhH','Give mee  your moneeeyyyyy!!','2023-12-11 13:34:28','91cfd1feec6caefc.jpg','AN',1),
(64,'Cute cate','Cat and the moon <3','2023-12-11 13:39:03','f68749ad750c7f38.jpg','AN',3),
(65,'GGGRRRHH!','ONE PUNCH MEAWWWW!','2023-12-11 13:39:12','9fd6505a1177eb9f.jpg','AN',1),
(69,'...','Segma meaw','2023-12-11 14:08:55','9885f9766652ac18.jpg','AN',1),
(70,'First 4k photo','Hold my quality.','2023-12-11 22:43:30','f1c646b58894dd44.jpg','NA',13),
(71,'Girl','Cute girl standing <3','2023-12-12 01:13:00','39081e4af8d08000.jpg','BE',14),
(73,'Mmm','Mmmm','2023-12-12 02:47:43','fabf83263b0b6aa6.jpg','NA',6),
(74,'Food','Recipe ','2023-12-12 02:54:01','f0780060e718926c.jpg','FO',6),
(76,'Nnn','Mmmm','2023-12-12 02:57:22','68038de7b540757e.jpg','AN',6);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_posts`
--

DROP TABLE IF EXISTS `saved_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_posts` (
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `saved_posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `saved_posts_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_posts`
--

LOCK TABLES `saved_posts` WRITE;
/*!40000 ALTER TABLE `saved_posts` DISABLE KEYS */;
INSERT INTO `saved_posts` VALUES
(1,70),
(1,71),
(1,74),
(1,76),
(3,76);
/*!40000 ALTER TABLE `saved_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_preferred_categories`
--

DROP TABLE IF EXISTS `user_preferred_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_preferred_categories` (
  `user_id` int(11) NOT NULL,
  `category_id` varchar(10) NOT NULL,
  PRIMARY KEY (`user_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `user_preferred_categories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_preferred_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferred_categories`
--

LOCK TABLES `user_preferred_categories` WRITE;
/*!40000 ALTER TABLE `user_preferred_categories` DISABLE KEYS */;
INSERT INTO `user_preferred_categories` VALUES
(14,'AN'),
(14,'AR'),
(14,'BE'),
(14,'DE'),
(13,'FO'),
(14,'FO'),
(13,'GR'),
(14,'GR'),
(13,'HI'),
(13,'NA'),
(13,'TR');
/*!40000 ALTER TABLE `user_preferred_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `pfp` varchar(50) NOT NULL DEFAULT 'default_pfp.jpg',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'Mohamed','Reda','mohamed_reda13','mohamedredaelsaid0@gmail.com','$2b$12$OTJuIYkI1hpcCQeISATdWOkqykmJsAflwuNPrCnsiKlPNXZc5xFjq','c3a2111a1085f674.jpg'),
(3,'Rawan','Hesham','rawan_hesham','rawanhesham8289@gmail.com','$2b$12$na4ZlMuede.HGDaGQbGl7eQzjDIZnpS6.J2vtalleVDDqgdKCvesS','045481dfa68d3818.jpeg'),
(4,'menna','esmat','menna_esmat','mennaaesmaat111@gmail.com','$2b$12$z5MSPGmTfSlDp7hEY/QPKOikx59joeIqow345Q03VdO1RTqm32rTC','default_pfp.jpg'),
(5,'Mohamed','seif','mohamed_seif_pv','mohamedseif.a1@gmail.com','$2b$12$RcCJwyYT83EhjszRiYb6/OVFtfeN1eErkAlEn5NhzZG5iHiHOHESa','01e0b036fcd7adb6.jpg'),
(6,'Malak','Hossam','malk_001','drmalakhossam@gmail.com','$2b$12$6OMsDkZol2Bxs3ahk0boTe6fc/kkQLH663TlQfVihfVs4MnobENxa','fe79eda8dcace912.jpg'),
(7,'Roro','Hesham','rorostyle','rawan@gmail.com','$2b$12$dby1L3HQlS1TiUDvqw03NOUHJJhlQGyDumzpLYN0dCI95Nab/lhza','default_pfp.jpg'),
(8,'Menna','Mohamed','mbbg','mennakhalifa683@yahoo.com','$2b$12$oCKesyKVkX3fpf99.9ytkeY.Vr2vfCpa1HH4vn2ip3lfPogRPoN5C','default_pfp.jpg'),
(13,'abcd','efg','abcdefg','a@g.c','$2b$12$udA.65AHYEXlj8DAv9uQNuvwiLET6j6cFWzoQgImLddgQVCZN.ltC','default_pfp.jpg'),
(14,'wooz','world','wooz123','wooz@gmail.com','$2b$12$5HzlY/rKOyaqrdS7ZqGfx.njid/oX5MTripnhXqz1sPQfIo5AbpCi','e4ffce3bb6d0bff1.jpeg'),
(15,'.....','.....','wooz1','ww@gmail.com','$2b$12$Na0C1aqBoSJXI/aOt3ItwOnlADeSZnoeF5.4v7xFJ779HTdMSH6p.','default_pfp.jpg');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes` (
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `vote_type` smallint(6) NOT NULL,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes`
--

LOCK TABLES `votes` WRITE;
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
INSERT INTO `votes` VALUES
(1,41,1),
(1,51,1),
(1,54,1),
(1,59,1),
(1,61,1),
(1,63,1),
(1,65,1),
(1,70,1),
(1,73,1),
(3,20,1),
(3,34,1),
(3,36,1),
(3,38,1),
(3,50,1),
(3,51,1),
(3,59,1),
(3,71,1),
(5,10,1),
(5,14,1),
(5,16,1),
(5,20,1),
(5,23,1),
(5,47,1),
(5,50,1),
(5,51,1),
(5,54,1),
(5,59,1),
(5,61,1),
(5,63,-1),
(5,64,-1),
(5,65,-1),
(5,69,1),
(5,70,1),
(6,21,1),
(6,54,1),
(6,71,1),
(6,73,1),
(7,61,1),
(8,65,-1),
(14,69,-1),
(14,71,1);
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-12  5:46:18
