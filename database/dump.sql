-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: task_management
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_07_31_134201_create_personal_access_tokens_table',1),(5,'2026_07_31_145622_create_projects_table',1),(6,'2026_07_31_145623_create_tasks_table',1),(7,'2026_07_31_155352_add_overdue_notified_at_to_tasks_table',2),(8,'2026_07_31_155353_create_notifications_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',4,'auth','55331d9d8760f50afaa443bb65cababff224c2d830f66439142bffd62e63867e','[\"*\"]',NULL,NULL,'2026-07-31 15:17:18','2026-07-31 15:17:18');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_user_id_status_index` (`user_id`,`status`),
  KEY `projects_deleted_at_index` (`deleted_at`),
  CONSTRAINT `projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,1,'Ducimus voluptatum atque voluptatum.',NULL,'active','2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(2,1,'Iure ut deserunt dolor.','Illo sed ut minima rerum. Aut enim nihil voluptates ex minima. Sit doloremque nobis nesciunt officiis est voluptas nulla.','completed','2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(3,1,'Ea reiciendis fugit nam.',NULL,'archived','2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(4,1,'Assumenda excepturi sunt sed.','Quos eum earum sit aliquam quas. Quia eius et accusantium perspiciatis cumque. Tempore autem optio ut odio.','active','2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(5,2,'Sint reiciendis delectus ut.','Distinctio quo ut ipsa qui. Quia aut est sit delectus voluptas culpa rem. Et omnis eveniet sed rerum repellat.','active','2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(6,2,'Consequuntur nulla cupiditate tempora.','Corrupti ad eveniet quia alias ea explicabo non. Dolorem error consequuntur et tempore porro. Minima non et libero sunt in vel est. Consequatur quasi doloremque reiciendis est molestiae et.','completed','2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(7,2,'Ratione maxime.','Qui est quis sit eaque. Excepturi aspernatur consequatur mollitia ducimus nihil voluptatem excepturi. Nobis aut voluptatem eos adipisci labore. Voluptas et sint quos.','archived','2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(8,2,'Consectetur officiis.','Ea est voluptatum sunt provident. Sapiente cupiditate delectus voluptates. Necessitatibus hic rerum vitae tempore nihil voluptatem tenetur eligendi. Enim amet magni consequatur et.','completed','2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(9,3,'Sunt nihil quo sed.',NULL,'active','2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(10,3,'Non consequatur aut atque.',NULL,'completed','2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(11,3,'Fugit occaecati ratione.',NULL,'archived','2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(12,3,'Magnam sit natus.',NULL,'completed','2026-07-31 15:13:53','2026-07-31 15:13:53',NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `priority` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'todo',
  `due_date` date DEFAULT NULL,
  `overdue_notified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_project_id_status_index` (`project_id`,`status`),
  KEY `tasks_project_id_priority_index` (`project_id`,`priority`),
  KEY `tasks_due_date_index` (`due_date`),
  KEY `tasks_deleted_at_index` (`deleted_at`),
  CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,1,'Nesciunt tempora deleniti illum mollitia et.','Impedit voluptatibus ipsam in fugit. Et id quidem delectus incidunt in dicta. Odio ullam accusamus odit aut voluptatem ea. Aut fuga beatae quis nostrum reiciendis neque quod.','medium','todo','2026-07-07',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(2,1,'Expedita voluptate odio cumque quod.',NULL,'high','todo','2026-08-06',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(3,1,'Nisi illo doloremque facilis ut.',NULL,'low','done','2026-09-17',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(4,1,'Nesciunt rem non.','Distinctio dicta eveniet consequatur perferendis officia. Est neque quod alias et nulla repudiandae nam sapiente. Id tenetur voluptates quia doloribus consequatur. Occaecati at qui dolor.','high','done','2026-08-10',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(5,1,'Facilis deserunt consectetur cupiditate doloribus.',NULL,'low','todo','2026-08-03',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(6,1,'Officiis perspiciatis rerum quod cumque hic.','Et repudiandae maxime eum laborum libero nulla esse. Vitae tempora voluptatibus molestiae omnis non. Officia id placeat aperiam sint vel esse eius. Qui quis sequi quo iusto sapiente et.','high','todo','2026-09-16',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(7,2,'Accusamus eius quam.',NULL,'low','done',NULL,NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(8,2,'Vel sed corrupti delectus.',NULL,'high','in_progress','2026-09-04',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(9,2,'Dolores ut nostrum repellat aut sit.',NULL,'high','in_progress','2026-06-30',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(10,2,'Fugit nobis qui fugiat corrupti.','Facilis sint ea quis qui sit consectetur. Quia unde asperiores ut qui voluptatem.','high','in_progress','2026-08-11',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(11,2,'Eum et magni quia ut.','Odio in inventore nihil et. Rerum exercitationem itaque est distinctio. Autem dolores aut cum quis saepe iusto placeat.','high','in_progress','2026-09-27',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(12,3,'Corporis ab eos nesciunt ipsum.',NULL,'high','done','2026-09-18',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(13,3,'Reiciendis vero et optio.','Fugit non praesentium provident quisquam qui incidunt. Veniam repudiandae aut facere occaecati. Incidunt repudiandae maxime cumque quia molestias minus.','medium','done',NULL,NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(14,3,'Eum qui suscipit esse itaque.',NULL,'low','in_progress','2026-08-29',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(15,3,'Cupiditate sit eos magnam.','Voluptatem ea non nulla. Quo quod est rerum. Maiores rem temporibus est ducimus ratione esse ea facere.','medium','done','2026-06-15',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(16,3,'Aperiam aut sint enim itaque qui.','Dolore repellat in dignissimos nam assumenda laboriosam est. Quam repudiandae nemo ut voluptas ipsum.','high','todo',NULL,NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(17,3,'Iste eum mollitia quae.',NULL,'high','todo','2026-09-17',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(18,3,'Ut et sed qui.',NULL,'medium','done','2026-08-17',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(19,3,'Sunt aliquam consequatur soluta.','Sequi mollitia nesciunt officia. Dolores nesciunt qui omnis facere doloremque. Expedita quo laborum deleniti dolor.','high','done','2026-09-06',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(20,3,'Minus quo veniam est.','Magnam iste minus amet ipsam aut quis earum. Vero exercitationem quasi laudantium quidem quia. Est iste eum nobis aut quia corrupti est laudantium.','high','done','2026-09-27',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(21,3,'In ex nesciunt amet expedita.','Facilis et praesentium excepturi dolores ullam. Voluptate quam facere consectetur sequi dolorem iure doloremque. Ad eos nihil impedit ea.','high','in_progress','2026-08-27',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(22,3,'Ipsam omnis asperiores ut assumenda exercitationem.',NULL,'low','in_progress',NULL,NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(23,3,'Qui occaecati neque asperiores cupiditate.',NULL,'low','in_progress',NULL,NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(24,4,'Sed qui eos tempore cum.',NULL,'medium','in_progress',NULL,NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(25,4,'Voluptas odio iste omnis.',NULL,'medium','done','2026-07-09',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(26,4,'Vero perspiciatis tempora delectus.',NULL,'high','done','2026-07-01',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(27,4,'Molestiae dignissimos eum et consequatur.',NULL,'medium','todo','2026-06-21',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(28,4,'Voluptas veritatis debitis iusto qui consequatur.','Et quis dolorum optio corrupti aut. Debitis qui et perspiciatis libero. At et odit fugiat ipsum.','medium','todo','2026-09-08',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(29,4,'In excepturi a et.',NULL,'high','todo',NULL,NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(30,5,'Voluptas eius provident non et.','Est odio facere maiores excepturi. Ex est incidunt dignissimos quae. Et corrupti delectus animi ut ducimus. Fugit animi exercitationem consequatur nemo eveniet quia.','high','in_progress',NULL,NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(31,5,'Adipisci expedita excepturi autem at.','Veniam reprehenderit illum reprehenderit consequatur. Corrupti sed soluta incidunt fuga nemo est et. Nobis nihil et voluptate a voluptates et. Quasi soluta consequatur id neque aut temporibus.','medium','todo','2026-08-28',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(32,5,'Tempore ea aspernatur.',NULL,'high','in_progress','2026-06-10',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(33,5,'Ducimus laudantium laborum in eum.','Ex voluptatibus dolorum dolorem sed. Quae expedita laborum est quae. Nostrum harum eum non cupiditate similique. Hic optio rerum corporis nemo modi quia recusandae.','high','done','2026-08-10',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(34,5,'Aut illo voluptatem earum sit.','Sit et sunt velit et ipsa commodi incidunt. Et et et doloribus est. Voluptas et delectus delectus enim ea sed et.','high','done','2026-06-11',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(35,5,'Natus soluta qui.',NULL,'medium','done','2026-06-21',NULL,'2026-07-31 15:13:52','2026-07-31 15:13:52',NULL),(36,5,'Reiciendis ut ut labore.',NULL,'medium','in_progress','2026-08-24',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(37,6,'Et repellat distinctio eligendi sit.','Odit cupiditate nemo vero nam rerum doloremque. Saepe sit vel maiores magni ab totam. Cupiditate pariatur voluptas occaecati dolor sapiente eius. Quia at tempora consectetur laudantium id iusto fugiat.','high','in_progress',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(38,6,'Nobis minus dolor doloribus corporis.',NULL,'medium','todo','2026-07-20',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(39,6,'Architecto vel dolor est.','Atque voluptatibus explicabo dolorem corporis adipisci necessitatibus libero. Et exercitationem sint nihil.','high','todo','2026-08-07',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(40,6,'Et nesciunt corporis eligendi unde illum.',NULL,'medium','done','2026-06-03',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(41,6,'Repellat exercitationem dignissimos voluptatum.','Dolor eos officiis voluptatibus rerum nisi soluta nemo sit. Quam eum nostrum perferendis qui aut illo. Eveniet rem est asperiores eaque ut autem esse.','low','done','2026-09-20',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(42,6,'Ut et dolorem reprehenderit placeat.','Ullam quo reiciendis consectetur quibusdam nihil quia. Veritatis facilis ea itaque eum. Voluptatibus ullam quod velit provident voluptatem sit voluptatum blanditiis.','high','in_progress',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(43,6,'Consequatur animi aut quod quos.','Odio reiciendis sed voluptate delectus. Sunt voluptas corporis sed in.','high','in_progress','2026-08-07',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(44,6,'Fuga voluptatem reiciendis quia.',NULL,'high','todo',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(45,6,'Aut ad accusamus.','Voluptas excepturi error quis. Aut adipisci et accusantium eligendi delectus quisquam. Quaerat ratione temporibus voluptas eos iste quibusdam. Vel voluptatem dolorum non.','low','done',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(46,7,'Eos odit nisi consequatur aut vel.',NULL,'low','in_progress','2026-08-01',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(47,7,'Veritatis et nisi.',NULL,'high','todo',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(48,7,'Ut consequatur error corrupti tempore.','Beatae quo voluptatem assumenda in recusandae delectus vero. Dolore velit sed non iste nulla. Quia eum officia doloremque quam earum laborum odio.','high','done','2026-09-01',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(49,7,'Debitis eum autem consequatur.','Quia dicta sit suscipit aperiam. Eligendi impedit tenetur qui dolorum delectus similique rerum aut. Fugit sed sit repudiandae minus quo. Dolore rerum blanditiis dolore consequatur consequuntur.','medium','done','2026-06-17',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(50,7,'Atque quos sed beatae.',NULL,'high','todo','2026-06-21',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(51,7,'Est ut necessitatibus fuga.','Non ipsum voluptatibus illum necessitatibus ut. Molestiae soluta suscipit unde deleniti quisquam accusamus animi. Rem facilis sunt nobis consequatur consequatur.','low','in_progress','2026-07-21',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(52,7,'Dolore voluptas et.',NULL,'medium','todo','2026-09-23',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(53,7,'Non dolorum ab sunt.','Nostrum illo non officiis cupiditate. Deserunt et aut adipisci dolore quia ullam. Modi accusantium provident voluptatem quibusdam culpa qui. Maiores at voluptatem quia expedita impedit.','low','done','2026-06-29',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(54,7,'Dolore totam qui numquam.','Omnis molestias optio placeat ut possimus et nemo. Magnam voluptatem fugit et perspiciatis. Voluptatem neque molestiae quidem et.','high','todo','2026-09-20',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(55,8,'Vero perferendis nemo blanditiis fugiat.',NULL,'high','todo',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(56,8,'Vero ea excepturi officiis vel.','Veritatis iure labore cumque necessitatibus recusandae accusamus. Magni dolorem consequuntur modi. Et aut explicabo excepturi soluta voluptatem sed odio.','low','done','2026-09-04',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(57,8,'Natus ut ut occaecati sit aut.','Nisi et ratione ea excepturi qui dicta architecto. Fugit nostrum pariatur accusamus accusantium impedit quaerat temporibus. Qui quod voluptate fugiat enim nulla qui. Qui omnis sapiente non modi.','medium','done',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(58,8,'Eveniet voluptatum cupiditate modi dolorem modi.','Nobis quia praesentium excepturi maiores ducimus animi. Consequatur non architecto quo laudantium eos possimus. Consectetur eos est aut. Voluptatum ducimus reprehenderit qui necessitatibus.','high','done','2026-06-16',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(59,8,'Dolorem voluptatem non iure beatae excepturi.','Placeat qui temporibus incidunt aut. Nemo aut dolores quo dolor tempore quia.','high','todo',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(60,8,'Consequatur quaerat hic sit.','Deserunt consequatur asperiores doloribus neque eius praesentium impedit. Autem minus nam pariatur est. Voluptatem aspernatur ea neque doloribus ea labore. Repellendus unde nesciunt eveniet a voluptatem provident veritatis.','low','in_progress',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(61,9,'Porro consectetur ex voluptatum eos.','Et est consequatur non. Officia ea consequatur et. Sed et voluptatem quia accusamus. Nam delectus reiciendis a dolorem dicta eos temporibus.','high','in_progress','2026-09-05',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(62,9,'Alias eum in quae minima omnis.',NULL,'high','in_progress','2026-06-16',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(63,9,'Eum quia voluptate suscipit.','Quae quos magnam est veritatis repudiandae quod cum. Ipsa quo aperiam et repellat atque magni. Dolorem aut minima esse qui aspernatur voluptas.','medium','done','2026-07-27',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(64,9,'Officia illum et nisi at.',NULL,'medium','todo','2026-07-09',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(65,9,'Modi sunt quas consequatur.',NULL,'low','todo','2026-08-24',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(66,9,'Autem vel qui dolorem.','Accusamus et repellat nemo fugiat explicabo autem ut autem. Ducimus rem est vel ducimus fugiat mollitia non. Quam debitis et rerum corrupti.','high','todo','2026-07-13',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(67,10,'Perferendis saepe et.',NULL,'high','todo','2026-07-12',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(68,10,'Nihil consequatur non non aliquam.','Autem eveniet sed accusamus debitis sed distinctio. Sit nihil eum eum aut tenetur doloremque. Iste sed nemo sunt voluptatum vel rerum eum. Modi officia neque consequatur ratione laudantium.','high','todo','2026-07-27',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(69,10,'Aut eum nemo necessitatibus.',NULL,'high','todo','2026-08-02',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(70,10,'Quia itaque repudiandae illo et.','Dolores nostrum repudiandae aut assumenda odit. Sed voluptatem dolore quis nobis sed velit velit. Veritatis sunt repellendus neque corporis voluptates.','low','todo','2026-07-17',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(71,10,'Sint voluptas et voluptas.','Et voluptas nihil perferendis magnam. Necessitatibus ut repellat ipsam cum doloribus. Et molestias velit dolores quam eligendi. Sit sapiente consequatur quasi voluptatum quo.','high','done',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(72,10,'Quis vel rerum aut accusamus ut.','Ut quo voluptatem officia ut. Ut qui est corrupti doloribus ipsa voluptatem velit. Earum sint reprehenderit occaecati labore officiis ut.','medium','in_progress',NULL,NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(73,10,'Veniam accusamus qui velit.',NULL,'low','done','2026-06-17',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(74,10,'Rerum necessitatibus perferendis et laborum.',NULL,'low','todo','2026-08-31',NULL,'2026-07-31 15:13:53','2026-07-31 15:13:53',NULL),(75,10,'Saepe nulla earum beatae incidunt numquam.',NULL,'medium','done',NULL,NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(76,11,'Consectetur dignissimos sint possimus est sed.','Ab eligendi explicabo possimus temporibus autem modi qui. Cumque labore quis dignissimos porro exercitationem. Perspiciatis quae temporibus dolorum eligendi a quo.','medium','in_progress',NULL,NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(77,11,'Fugit corrupti cupiditate.',NULL,'medium','todo','2026-09-15',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(78,11,'Id perspiciatis sed.',NULL,'medium','done','2026-07-12',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(79,11,'Occaecati explicabo et similique maxime.',NULL,'high','in_progress',NULL,NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(80,11,'Deleniti fuga cum dolores.',NULL,'low','in_progress','2026-06-04',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(81,11,'Distinctio qui ex.','Vel aut cupiditate mollitia omnis doloremque quidem ut. Quos voluptatem omnis iure labore. Dicta excepturi est cupiditate. Sapiente repellendus est voluptas at numquam et magni.','medium','done','2026-07-07',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(82,11,'Aut nulla nesciunt quaerat.',NULL,'high','in_progress','2026-06-11',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(83,11,'Sapiente sit dolore libero beatae.','Nemo quia rerum eius repellendus quo dolorem. Aut vel aut voluptatum commodi dolorem doloremque. Alias possimus ex ab sunt unde. Nesciunt corporis harum provident vel.','medium','done','2026-08-05',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(84,12,'Qui omnis ut velit enim esse.','Distinctio omnis quasi odit iste accusantium placeat dignissimos. Iste illo ratione excepturi sapiente et nihil qui non.','low','done',NULL,NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(85,12,'Porro deserunt exercitationem iure.','Dicta aliquid consequuntur est non voluptate optio sit. Et alias odio omnis et aut rerum quia. Molestiae atque nesciunt pariatur enim aut quam. Sequi ut officia possimus. Assumenda sit consequuntur nihil facere ut.','high','done','2026-09-25',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(86,12,'Iusto eum tenetur reiciendis.',NULL,'medium','todo','2026-07-17',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(87,12,'Quod voluptas sed ipsam tempora.',NULL,'low','done','2026-06-29',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(88,12,'At ab magni.','Explicabo dolor qui odio facere. Odit consequatur nobis dignissimos vero magnam. Illo aut debitis totam id ut. Ipsa id at animi commodi vero repellendus natus.','low','todo','2026-09-13',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(89,12,'Eos qui iste consequatur.',NULL,'low','todo','2026-08-20',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(90,12,'Dolores esse dolorum autem expedita.',NULL,'low','in_progress','2026-09-26',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(91,12,'Cumque cumque provident repellat et dolorem.','Hic commodi excepturi unde molestiae. Molestiae vitae quisquam mollitia saepe quos corporis autem.','medium','todo','2026-08-16',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(92,12,'Eos sed voluptatum optio officiis.',NULL,'low','todo','2026-06-04',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(93,12,'Sunt aut iure.','Provident nihil cupiditate labore cum perferendis voluptatum. Ad qui rerum ea architecto est praesentium consequatur. Expedita est non pariatur aut rerum. Id reprehenderit maxime molestiae nisi et blanditiis modi fugit. Deleniti voluptate voluptate aut doloribus autem sit.','medium','done',NULL,NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(94,1,'Quasi et suscipit molestiae autem qui.','Sint hic ratione consequatur in et eos. Soluta voluptatem officiis impedit ut nam. Ipsam dolores sunt suscipit nostrum perspiciatis.','low','in_progress','2026-06-08',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(95,1,'Eveniet natus facere et et ab.','Quo repellat fugiat officiis ut ut praesentium alias. Quis ut qui iure ipsam vero. Dolorem mollitia et et earum itaque fugit. Unde distinctio voluptatibus consequuntur. Voluptas repellat consequatur dolorem.','low','todo','2026-06-04',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL),(96,1,'Eum aperiam veritatis sequi.','Expedita molestiae natus autem adipisci aperiam blanditiis enim. Qui doloribus corporis ut. Illum enim perspiciatis sint dolor rem delectus.','low','in_progress','2026-06-04',NULL,'2026-07-31 15:13:54','2026-07-31 15:13:54',NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Demo User','demo@example.com','2026-07-31 15:13:51','$2y$12$yrHGpNr/a2NzfnnpHlcIJ.LwW5ua0ESU4NdNGEj.tjzGML9lVs9dW','COTAoQE3Tl','2026-07-31 15:13:51','2026-07-31 15:13:51'),(2,'Webster Brakus','edna.casper@example.net','2026-07-31 15:13:51','$2y$12$y6sscX0BXkazubUlY0443eYd2inJEGx3wOoTiUGuOR4vlg9hFKk6i','ULAY7iFYTK','2026-07-31 15:13:51','2026-07-31 15:13:51'),(3,'Astrid Schinner','goodwin.twila@example.org','2026-07-31 15:13:51','$2y$12$y6sscX0BXkazubUlY0443eYd2inJEGx3wOoTiUGuOR4vlg9hFKk6i','oAifUT48t9','2026-07-31 15:13:52','2026-07-31 15:13:52'),(4,'Raven Heaney','t@test.com','2026-07-31 15:17:18','$2y$12$3is9vNpcg36QkUGdN0IMwuqn0HCB66S1gP4Xv3zfkJcUBQ/8dH2r.','8TtC8q9Uvr','2026-07-31 15:17:18','2026-07-31 15:17:18');
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

-- Dump completed on 2026-07-31 15:58:28
