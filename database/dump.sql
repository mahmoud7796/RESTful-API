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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_07_31_134201_create_personal_access_tokens_table',1),(5,'2026_07_31_145622_create_projects_table',1),(6,'2026_07_31_145623_create_tasks_table',1),(7,'2026_07_31_155352_add_overdue_notified_at_to_tasks_table',1),(8,'2026_07_31_155353_create_notifications_table',1),(9,'2026_07_31_161527_create_permission_tables',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(1,'App\\Models\\User',2),(1,'App\\Models\\User',3);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
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
INSERT INTO `notifications` VALUES ('0cf08ee4-ede4-49e5-a7ca-f3ffa8ff7989','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":50,\"title\":\"Et officia facere eius architecto.\",\"due_date\":\"2026-06-14\",\"project_id\":6}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('2411b7c5-15cf-4b68-bc8b-2cae2a559853','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":57,\"title\":\"Aut doloremque saepe rerum libero.\",\"due_date\":\"2026-06-05\",\"project_id\":6}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('2c2df5c0-169b-460e-be59-d17c2e5162c3','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":71,\"title\":\"Quis voluptatem necessitatibus eligendi.\",\"due_date\":\"2026-07-26\",\"project_id\":8}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('2d66fbdb-4002-4578-aff5-536aa79797d9','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":69,\"title\":\"Sit est commodi distinctio sit.\",\"due_date\":\"2026-07-21\",\"project_id\":8}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('44d5b821-dd37-4bd1-aada-76fe8fe2cf97','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":106,\"title\":\"Rerum iste fuga.\",\"due_date\":\"2026-06-03\",\"project_id\":3}',NULL,'2026-07-31 19:00:04','2026-07-31 19:00:04'),('4f751e24-49d5-4006-a6b3-dc5702b962a0','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":105,\"title\":\"Molestiae quod nihil.\",\"due_date\":\"2026-06-25\",\"project_id\":3}',NULL,'2026-07-31 19:00:04','2026-07-31 19:00:04'),('5045f177-b3b4-4b48-8428-4a65f1d58db5','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',3,'{\"task_id\":88,\"title\":\"Fugit voluptate amet est.\",\"due_date\":\"2026-06-28\",\"project_id\":10}',NULL,'2026-07-31 19:00:04','2026-07-31 19:00:04'),('55805591-487f-46e1-ad9b-82c9f71cf30c','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":33,\"title\":\"Omnis omnis vel.\",\"due_date\":\"2026-07-29\",\"project_id\":4}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('6cd0409f-342a-4121-a40b-f3c7c42541bd','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":38,\"title\":\"Accusamus iure maxime.\",\"due_date\":\"2026-06-03\",\"project_id\":4}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('8083a283-3984-4ce5-8d32-9bb5e105d3de','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":1,\"title\":\"Autem consequatur suscipit excepturi dolores.\",\"due_date\":\"2026-06-25\",\"project_id\":1}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('8e132262-7626-46ce-b532-2dab5df0f544','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',3,'{\"task_id\":102,\"title\":\"Sed eligendi harum consequatur.\",\"due_date\":\"2026-07-07\",\"project_id\":12}',NULL,'2026-07-31 19:00:04','2026-07-31 19:00:04'),('991b418b-92af-4086-8e1f-43a6f4aea0fe','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":35,\"title\":\"Quam fugiat architecto sunt.\",\"due_date\":\"2026-06-18\",\"project_id\":4}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('a94b7898-38ea-4bdf-b886-b839ae76df94','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":67,\"title\":\"Qui neque quo culpa culpa.\",\"due_date\":\"2026-06-21\",\"project_id\":8}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('aee8a657-c68e-42b2-a4ac-aa104bb2e087','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":16,\"title\":\"Est id commodi dolorum aut est.\",\"due_date\":\"2026-07-21\",\"project_id\":2}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('b42bc4bc-86ca-45ba-ba64-1cfcbd909048','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":18,\"title\":\"Magni aperiam consequatur in mollitia.\",\"due_date\":\"2026-07-25\",\"project_id\":3}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('b74f930d-7a6b-4c03-82ae-855a70212960','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":66,\"title\":\"Aut quo non eligendi sint inventore.\",\"due_date\":\"2026-07-04\",\"project_id\":8}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('bce09290-c757-46a6-a464-96dd2daf74fe','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":26,\"title\":\"Ipsa eaque voluptates reiciendis dicta.\",\"due_date\":\"2026-07-17\",\"project_id\":3}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('c3be2e6e-3cd7-4890-99df-2c1c9b0cbdb0','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',3,'{\"task_id\":85,\"title\":\"Incidunt voluptatem doloribus hic odit.\",\"due_date\":\"2026-07-26\",\"project_id\":10}',NULL,'2026-07-31 19:00:04','2026-07-31 19:00:04'),('c413812b-496e-44c9-bb04-bc181ae9586f','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":10,\"title\":\"Consequatur est voluptatum.\",\"due_date\":\"2026-07-21\",\"project_id\":1}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('c468357a-9f1e-4646-8dcc-8b0d7f4b3718','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":63,\"title\":\"Molestiae praesentium necessitatibus.\",\"due_date\":\"2026-06-30\",\"project_id\":7}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('ccfa2e1e-aba0-4388-8485-1e8bda98363a','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',3,'{\"task_id\":82,\"title\":\"Omnis quos vel omnis.\",\"due_date\":\"2026-06-26\",\"project_id\":9}',NULL,'2026-07-31 19:00:04','2026-07-31 19:00:04'),('d195236b-cb92-4f27-8fb2-ebbf51d15fdb','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":36,\"title\":\"Unde maxime amet.\",\"due_date\":\"2026-06-12\",\"project_id\":4}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('dd73e28c-55d8-40c3-940e-9aca99dba694','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',3,'{\"task_id\":101,\"title\":\"Enim totam in.\",\"due_date\":\"2026-07-05\",\"project_id\":12}',NULL,'2026-07-31 19:00:04','2026-07-31 19:00:04'),('e71095ec-1d4d-452d-8eae-028c825645c2','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":107,\"title\":\"Nisi ab quas itaque.\",\"due_date\":\"2026-06-13\",\"project_id\":3}',NULL,'2026-07-31 19:00:04','2026-07-31 19:00:04'),('f2437129-def0-4afb-9add-f0f85c53eb8d','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":53,\"title\":\"Atque sint at veritatis inventore.\",\"due_date\":\"2026-07-18\",\"project_id\":6}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('f78a7251-27d1-4e2a-a6d8-54432070fc54','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',2,'{\"task_id\":61,\"title\":\"Quia rerum dolorum repellendus assumenda suscipit.\",\"due_date\":\"2026-06-12\",\"project_id\":7}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03'),('fb2cae09-b9d8-491d-8c82-a66aa83d6e06','App\\Notifications\\TaskOverdueNotification','App\\Models\\User',1,'{\"task_id\":14,\"title\":\"Et quaerat vitae qui.\",\"due_date\":\"2026-06-20\",\"project_id\":2}',NULL,'2026-07-31 19:00:03','2026-07-31 19:00:03');
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
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'dashboard.view','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(2,'projects.index','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(3,'projects.store','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(4,'projects.show','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(5,'projects.update','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(6,'projects.destroy','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(7,'tasks.index','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(8,'tasks.store','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(9,'tasks.show','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(10,'tasks.update','web','2026-07-31 18:21:34','2026-07-31 18:21:34'),(11,'tasks.destroy','web','2026-07-31 18:21:34','2026-07-31 18:21:34');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (2,'App\\Models\\User',1,'auth','a1126c93285a0ae649213eda82d0cc6a7e6b0123e055f07510710b1c5d6b6c15','[\"*\"]','2026-07-31 18:24:31',NULL,'2026-07-31 18:22:51','2026-07-31 18:24:31'),(3,'App\\Models\\User',1,'auth','cb88691a524a9a0a13709bccafb9ee9e6df1b12959ddae17ca48df5e9d79a6c2','[\"*\"]','2026-07-31 18:38:41',NULL,'2026-07-31 18:30:04','2026-07-31 18:38:41');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,1,'Sunt ab facere.','Ut ratione assumenda excepturi adipisci sint. Ea suscipit ducimus aliquid adipisci itaque aut.','active','2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(2,1,'Vitae aut ex tempora.','Dolores enim fuga asperiores ea. Vero dolore suscipit assumenda accusantium assumenda aut tempore. Dicta recusandae voluptatum esse.','completed','2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(3,1,'Dolor sint.',NULL,'archived','2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(4,1,'Illo occaecati tenetur sint.','Dignissimos vel odit necessitatibus dolorem consequuntur. Iusto hic vitae accusantium.','completed','2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(5,2,'Doloremque cumque neque.',NULL,'active','2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(6,2,'Architecto reiciendis mollitia quo.','Eligendi voluptas quas animi alias fuga. Aut libero deleniti ratione. Quibusdam dignissimos aut voluptatem maiores placeat et natus esse.','completed','2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(7,2,'Tempore sequi rerum et.','Ab deserunt quia ratione aut voluptatem. Neque saepe sed autem atque non accusamus. Tempore porro impedit ipsum. Eveniet repellendus magnam voluptas numquam in. Sunt et dolor iure nemo iste voluptas eum.','archived','2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(8,2,'Aut recusandae facilis.','Explicabo aliquid dolores tempore eos et quis ea. Eum ratione amet ex ut suscipit assumenda error. A facilis praesentium voluptatibus rerum quibusdam debitis. Tenetur dolores odio blanditiis vitae cupiditate repudiandae.','active','2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(9,3,'Nostrum consequatur id autem.','Quas id dolore qui quisquam. Adipisci id earum optio quo. Et necessitatibus eum et doloribus et tenetur. Dolore sed error recusandae saepe harum. Praesentium optio distinctio libero et fugit.','active','2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(10,3,'Est dicta facere.','Et beatae iure veritatis impedit quia. Ipsum vero asperiores ipsum quas ipsa quidem. Est veniam omnis neque eum aperiam possimus sit. Est vel facere culpa amet assumenda rerum aperiam. Voluptate sint voluptate excepturi.','completed','2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(11,3,'Repudiandae id.','Blanditiis dolor harum voluptatum aut quae unde. Qui et qui enim vitae vitae. Eveniet aut deserunt voluptas nihil et et.','archived','2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(12,3,'Officiis enim dolores inventore.',NULL,'completed','2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(13,1,'Website Redesign','Q3 marketing site refresh','active','2026-07-31 18:24:22','2026-07-31 18:24:22',NULL),(14,1,'Website Redesign','Q3 marketing site refresh','active','2026-07-31 18:30:32','2026-07-31 18:30:32',NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'user','web','2026-07-31 18:21:34','2026-07-31 18:21:34');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,1,'Autem consequatur suscipit excepturi dolores.','Eum eligendi nemo quos provident soluta aut. Distinctio earum recusandae optio unde aperiam in culpa. Rerum id dolore ipsam hic omnis. At porro itaque aspernatur.','medium','in_progress','2026-06-25','2026-07-31 19:00:02','2026-07-31 18:21:35','2026-07-31 19:00:02',NULL),(2,1,'Quidem animi quis corrupti.','Iusto dicta qui in. Nihil autem atque dignissimos voluptas est minus. Eius quae aperiam aut qui nemo fugiat voluptas.','low','done','2026-09-22',NULL,'2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(3,1,'Odio recusandae officiis deleniti.',NULL,'high','done','2026-06-27',NULL,'2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(4,1,'Vitae aperiam rem pariatur laudantium.','Ullam et a aut expedita neque iure omnis. Reprehenderit atque non omnis dolorem ab veniam error. Iure ut quisquam repellendus officiis corrupti.','low','todo',NULL,NULL,'2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(5,1,'Laudantium et velit.',NULL,'medium','todo',NULL,NULL,'2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(6,1,'Ut fuga dignissimos est dolor.',NULL,'low','done',NULL,NULL,'2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(7,1,'Expedita odit omnis.',NULL,'low','done','2026-07-05',NULL,'2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(8,1,'Iste consectetur autem libero maxime.',NULL,'medium','done',NULL,NULL,'2026-07-31 18:21:35','2026-07-31 18:21:35',NULL),(9,1,'Quo laborum at consequatur.','Vel natus possimus dicta sit quaerat aut. Et libero enim libero delectus et et modi.','medium','todo','2026-09-19',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(10,1,'Consequatur est voluptatum.','Deleniti dolorem voluptatibus et eum corporis ut. Molestiae dolore consequatur aperiam voluptatibus veniam sint. Magnam harum error est maxime et aut.','high','in_progress','2026-07-21','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(11,1,'Dolor inventore magni tempora praesentium voluptate.','Voluptas dolores et accusamus hic. Quos porro veniam quam ut enim vel necessitatibus. Nobis culpa omnis earum sit eum.','high','in_progress',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(12,2,'Eligendi quam ratione.',NULL,'medium','done','2026-07-07',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(13,2,'Aperiam eos est architecto.','Non consectetur minima earum totam quia consectetur. Nobis ut exercitationem illo aut similique.','medium','in_progress','2026-08-21',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(14,2,'Et quaerat vitae qui.',NULL,'low','todo','2026-06-20','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(15,2,'Est exercitationem voluptate possimus quo.','Architecto nisi quae delectus alias est ea. Ut ea quas rerum corrupti est.','medium','done','2026-06-19',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(16,2,'Est id commodi dolorum aut est.','Consequuntur fugiat ab laudantium eum. Aliquid molestiae est non rerum deserunt minus. Consectetur modi eum soluta a eum vitae.','medium','todo','2026-07-21','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(17,2,'Non ex excepturi sit est perspiciatis.',NULL,'low','done',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(18,3,'Magni aperiam consequatur in mollitia.','Numquam omnis accusantium quis sit. Saepe perferendis voluptatum voluptas delectus.','low','in_progress','2026-07-25','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(19,3,'Sed debitis laboriosam rerum corporis aut.',NULL,'low','in_progress','2026-08-21',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(20,3,'Aspernatur vel aut et eligendi.',NULL,'medium','todo',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(21,3,'Et quia magni molestiae aliquid.',NULL,'high','done','2026-06-04',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(22,3,'Consequatur ex nemo repellendus.','Recusandae nostrum quo eveniet et numquam magni. Consequuntur velit eos assumenda soluta alias modi. Sed rerum nisi consectetur ipsa officia consectetur beatae.','low','todo','2026-09-15',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(23,3,'Doloremque suscipit minima facilis.',NULL,'low','done','2026-09-01',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(24,3,'Maxime vel sed enim quis.','Ut magni neque eum animi. Nulla rerum excepturi aut voluptas voluptatem consequatur sint. Eos enim aut debitis labore dolorem suscipit magni. Et quo iusto quas ut non repellendus ea velit.','medium','done','2026-06-01',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(25,3,'Et vel repudiandae expedita.','Consequatur facilis occaecati qui aut impedit quos qui. Nobis natus voluptatem autem nam quia quia sint. Eos quisquam est magni doloribus ab consequatur. Atque sit est quo qui incidunt.','high','done',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(26,3,'Ipsa eaque voluptates reiciendis dicta.',NULL,'medium','todo','2026-07-17','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(27,3,'In perspiciatis ut.',NULL,'high','in_progress','2026-09-21',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(28,3,'Asperiores dolores magnam totam fugiat et.','Molestiae illum recusandae voluptatem distinctio. Voluptatibus doloribus harum magni vel. Vel sed eveniet et ipsum in rerum ad.','low','todo',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(29,4,'Ab ab nihil porro.',NULL,'low','todo',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(30,4,'Cum earum temporibus non consequatur voluptatem.','Vero in nihil officiis vel eum voluptatem. Ex delectus quo ab ut ipsum explicabo nesciunt. Nisi omnis hic et totam qui. Quibusdam neque voluptatem optio ad id. Corporis facilis eligendi vel maxime similique assumenda.','low','todo','2026-08-14',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(31,4,'Sit quasi sit facere hic.','Aut numquam voluptatem itaque quia explicabo. Est ex ut culpa non architecto. Sed quia enim quo sit. Eveniet consequuntur quaerat earum aut debitis doloribus natus molestiae.','high','in_progress','2026-08-03',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(32,4,'Odio ut in soluta inventore possimus.',NULL,'high','done','2026-07-12',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(33,4,'Omnis omnis vel.','Praesentium repellendus libero laudantium incidunt qui ut. Qui qui doloremque voluptatum eum. Quaerat ut quia corporis perferendis. Commodi rem officiis deleniti dolorem.','medium','in_progress','2026-07-29','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(34,4,'Voluptatum nobis et temporibus.','Perspiciatis veniam cupiditate voluptatem. Deserunt ipsum accusantium optio nam et ratione cupiditate consequatur. At sed adipisci officiis quaerat commodi et illum. Temporibus tempora soluta ipsam error ipsa eos.','low','in_progress',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(35,4,'Quam fugiat architecto sunt.',NULL,'medium','in_progress','2026-06-18','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(36,4,'Unde maxime amet.','Facilis unde inventore ipsum laudantium enim ab quod. Aut nemo est consequuntur voluptates culpa. Blanditiis sed autem similique expedita.','high','in_progress','2026-06-12','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(37,4,'Amet iure alias ratione.',NULL,'medium','done',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(38,4,'Accusamus iure maxime.','Tempora provident ut quibusdam aut quis eligendi. Facilis ad omnis beatae id ex blanditiis. Perspiciatis amet eum quae nihil illo.','low','in_progress','2026-06-03','2026-07-31 19:00:02','2026-07-31 18:21:36','2026-07-31 19:00:02',NULL),(39,5,'Minima odit quaerat.','Explicabo at ad pariatur sit. Nisi et vel placeat aliquam. Sunt amet sequi dolores et totam asperiores. Et quia voluptates mollitia commodi voluptate deserunt.','high','in_progress','2026-08-30',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(40,5,'Minus et fuga sed illo.','Libero labore molestiae officiis. Modi labore qui id dolorem consequatur. Soluta quo pariatur sapiente architecto quam quidem commodi ipsa. Porro natus at veniam. Doloremque quis dicta dolorem nemo molestiae.','medium','todo','2026-09-08',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(41,5,'Et consequuntur sed.','Qui quia rerum enim et eveniet. Cupiditate at ipsum voluptates modi quo est quo. Odit rerum nesciunt odit. Ad ut ex consequatur debitis qui.','high','done',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(42,5,'Harum qui libero voluptate facere.',NULL,'medium','done','2026-09-03',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(43,5,'Voluptas id non fugiat excepturi.',NULL,'medium','todo',NULL,NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(44,5,'Omnis dolores et rerum dolorum.',NULL,'medium','in_progress','2026-08-06',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(45,5,'Incidunt aperiam eos tempora vero.','Ut fugit ut voluptas. Modi et velit ratione aliquid voluptatem. Ipsum rerum perspiciatis dolores accusamus occaecati non eaque. Distinctio quasi illum itaque molestiae dolores nam libero.','high','in_progress','2026-09-29',NULL,'2026-07-31 18:21:36','2026-07-31 18:21:36',NULL),(46,5,'Asperiores dolores sit adipisci.','Voluptatem ea non ut minus neque aut. Asperiores quis voluptas est eveniet est enim alias aliquid. Ea nihil dicta aliquid. Alias quos quia id quia dolor placeat ratione. Natus quis ut illo perferendis.','high','done','2026-06-13',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(47,5,'Aut nihil dicta.',NULL,'high','todo',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(48,6,'Qui aperiam omnis occaecati velit.','Et autem sint quisquam. Delectus earum laboriosam quam repudiandae qui voluptatibus. Sed dolore atque temporibus omnis distinctio cumque porro.','medium','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(49,6,'Rerum id aut sit saepe.',NULL,'high','todo',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(50,6,'Et officia facere eius architecto.',NULL,'high','todo','2026-06-14','2026-07-31 19:00:02','2026-07-31 18:21:37','2026-07-31 19:00:02',NULL),(51,6,'Atque numquam quia et assumenda.',NULL,'high','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(52,6,'Alias a libero quaerat.',NULL,'low','in_progress','2026-09-01',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(53,6,'Atque sint at veritatis inventore.',NULL,'high','in_progress','2026-07-18','2026-07-31 19:00:02','2026-07-31 18:21:37','2026-07-31 19:00:02',NULL),(54,6,'Autem laborum nulla ut.',NULL,'medium','todo','2026-09-26',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(55,6,'Aut omnis quidem ex debitis.',NULL,'high','done',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(56,6,'Voluptatibus sint possimus.',NULL,'high','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(57,6,'Aut doloremque saepe rerum libero.',NULL,'high','todo','2026-06-05','2026-07-31 19:00:02','2026-07-31 18:21:37','2026-07-31 19:00:02',NULL),(58,6,'Aut amet ut atque.',NULL,'medium','todo','2026-08-17',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(59,7,'Dolor accusamus in quidem possimus.','Eum dolorem quia sed velit earum. Et dolores a quod possimus autem unde. Perferendis et atque repellat perspiciatis esse eius.','medium','todo',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(60,7,'Modi qui voluptatibus error neque nihil.','Sed iusto ut sapiente quidem dolor voluptas. Ipsum in minima nostrum velit est iusto. Aliquam laboriosam est est.','low','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(61,7,'Quia rerum dolorum repellendus assumenda suscipit.','Illo fugiat minima consequatur velit nostrum. Doloribus repellendus iste illo est voluptate quia. Non neque autem aut dolores voluptatem vero.','high','todo','2026-06-12','2026-07-31 19:00:02','2026-07-31 18:21:37','2026-07-31 19:00:02',NULL),(62,7,'Asperiores tempora id provident voluptas autem.',NULL,'medium','todo','2026-09-05',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(63,7,'Molestiae praesentium necessitatibus.','Praesentium sed quia iure est nulla. Id rem qui ad in. Dicta optio quas temporibus consequatur voluptates laboriosam fugiat.','medium','todo','2026-06-30','2026-07-31 19:00:02','2026-07-31 18:21:37','2026-07-31 19:00:02',NULL),(64,8,'Minus magni ea.','Sunt beatae quisquam quia totam sed. Commodi eos minus fugit sint laudantium. Est voluptatem non nobis ut eos et repellat.','high','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(65,8,'Fugiat hic ut temporibus fugiat.',NULL,'medium','done',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(66,8,'Aut quo non eligendi sint inventore.',NULL,'medium','todo','2026-07-04','2026-07-31 19:00:02','2026-07-31 18:21:37','2026-07-31 19:00:02',NULL),(67,8,'Qui neque quo culpa culpa.',NULL,'medium','in_progress','2026-06-21','2026-07-31 19:00:03','2026-07-31 18:21:37','2026-07-31 19:00:03',NULL),(68,8,'In eligendi velit voluptates quis.','Ea labore sequi nobis hic et. Consequatur repellat id qui iure recusandae. Et officiis iste quaerat perspiciatis cumque in voluptas. Provident magni quam architecto temporibus officiis beatae corrupti.','low','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(69,8,'Sit est commodi distinctio sit.','Aut est qui ipsum ea cupiditate laborum. Voluptatem doloremque sequi hic culpa earum quod. Aliquid qui ut ex quibusdam nam.','medium','in_progress','2026-07-21','2026-07-31 19:00:03','2026-07-31 18:21:37','2026-07-31 19:00:03',NULL),(70,8,'Quidem ducimus ratione voluptas.','Distinctio et quia at autem ab omnis quia. Dicta velit tempora ut aut sed dolores qui consectetur. Quod inventore sunt qui qui enim.','medium','done','2026-06-27',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(71,8,'Quis voluptatem necessitatibus eligendi.',NULL,'low','todo','2026-07-26','2026-07-31 19:00:03','2026-07-31 18:21:37','2026-07-31 19:00:03',NULL),(72,8,'Alias est ea dicta modi consequatur.','Quasi labore qui est odio molestiae. Fuga reprehenderit illum quasi illum et. Adipisci quo et dicta dolores dolorum.','low','done','2026-06-29',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(73,9,'Reprehenderit veritatis tempora deleniti dolores.',NULL,'high','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(74,9,'Magnam repellat porro illo aut.','Hic qui praesentium accusantium. Quis in sunt sed voluptate distinctio.','low','done','2026-08-01',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(75,9,'Quo quis et.',NULL,'low','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(76,9,'Sed similique qui.',NULL,'high','done','2026-06-02',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(77,9,'Labore aut earum.',NULL,'high','todo','2026-08-05',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(78,9,'Aliquam fugit cupiditate dicta.','Et et consequuntur fugiat provident quam dignissimos nemo. Eum distinctio non expedita possimus fuga. Autem rem quia nihil voluptatem. Voluptatibus eligendi dolores numquam iste. Dolorem neque aut velit ex sapiente earum.','medium','todo','2026-08-11',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(79,9,'Repudiandae vero suscipit libero ratione quia.','Nobis minus omnis praesentium sapiente quas ipsa. Iste aut quae veritatis temporibus. Perferendis ex ipsum rerum dolorem deleniti nulla et reiciendis. Quos cumque autem accusantium neque tempore reiciendis.','medium','done','2026-07-25',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(80,9,'Itaque quas autem aspernatur impedit illo.','Quae deserunt aut dolorem molestiae nostrum doloremque aut. Libero porro est perspiciatis quo. Labore nihil non voluptatem tenetur occaecati. Dolorum dolorem quia consequatur magnam qui.','medium','todo','2026-08-03',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(81,9,'Aut ipsa explicabo ad nemo dicta.',NULL,'high','in_progress','2026-09-25',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(82,9,'Omnis quos vel omnis.','Qui reprehenderit nisi optio corrupti id quia dolorem. Quidem nobis consequuntur in sit quam aut tempora quia. Nisi voluptatem voluptas accusamus nobis at.','medium','in_progress','2026-06-26','2026-07-31 19:00:03','2026-07-31 18:21:37','2026-07-31 19:00:03',NULL),(83,9,'Sunt nostrum aspernatur iure.','Non dolorem mollitia ipsum ipsa quae. Sunt veritatis cupiditate in labore quis et sunt quis. Reiciendis expedita qui reprehenderit cumque qui. Est temporibus architecto voluptas ipsum et. A nemo tempore corporis dolor non fugiat quam.','high','todo','2026-09-10',NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(84,10,'Et odit ab.',NULL,'low','in_progress',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(85,10,'Incidunt voluptatem doloribus hic odit.','Est est optio consequatur non quam quibusdam. Tempora enim ut reprehenderit iusto. Sunt quia velit voluptatem commodi ut repellendus fugiat.','high','in_progress','2026-07-26','2026-07-31 19:00:03','2026-07-31 18:21:37','2026-07-31 19:00:03',NULL),(86,10,'Omnis molestias culpa sit.',NULL,'high','todo',NULL,NULL,'2026-07-31 18:21:37','2026-07-31 18:21:37',NULL),(87,10,'Laudantium aspernatur non quas similique.',NULL,'high','done','2026-06-14',NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(88,10,'Fugit voluptate amet est.','Labore corporis nemo quisquam. Deserunt dignissimos odit blanditiis rem repellat cum. Est consequatur voluptatem est voluptatibus.','high','in_progress','2026-06-28','2026-07-31 19:00:03','2026-07-31 18:21:38','2026-07-31 19:00:03',NULL),(89,10,'Iure hic quia et distinctio.','Repudiandae ex facilis cumque qui iure accusantium vitae. Consequatur autem odio voluptatem totam esse saepe sint.','medium','in_progress',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(90,10,'Dicta harum perferendis.','Animi eum aspernatur eius eligendi ullam. Eveniet voluptatum aliquid ipsam et blanditiis veniam. Fugit sit sapiente laborum.','medium','done',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(91,11,'Consequatur quia numquam labore voluptas quibusdam.',NULL,'medium','todo',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(92,11,'Odio facere est nesciunt doloribus.',NULL,'high','done',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(93,11,'Quis error sed quam excepturi.','Voluptas facilis ut ut aut laborum et. Provident et soluta soluta facilis. Sunt rerum ipsam dolores. Quos et nobis molestiae molestias molestiae velit natus ut.','medium','in_progress','2026-08-08',NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(94,11,'Qui qui id dolores.',NULL,'low','in_progress','2026-08-07',NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(95,11,'Earum sunt ad.','Rem qui aliquid quia fugiat error ut aut. Sapiente non at quae ut laborum rerum provident. Quibusdam perspiciatis assumenda facilis maiores ut aperiam et a.','high','todo',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(96,11,'Adipisci ipsa quasi omnis eum in.','Omnis in doloremque placeat recusandae eveniet dolorum. Ut iusto enim distinctio maxime consectetur nemo perferendis. Expedita architecto molestias cupiditate placeat natus.','low','done',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(97,11,'Itaque maxime et.',NULL,'high','todo','2026-09-21',NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(98,12,'Accusamus est maxime non voluptas.',NULL,'high','todo',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(99,12,'Explicabo accusamus corporis debitis maxime.','Dolores adipisci amet sunt eveniet magnam accusamus. Sapiente error ut magnam sapiente porro delectus tempora. Optio qui provident nihil commodi in repellat deserunt.','medium','done',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(100,12,'Illum veritatis debitis expedita reprehenderit non.',NULL,'low','todo',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(101,12,'Enim totam in.',NULL,'medium','todo','2026-07-05','2026-07-31 19:00:03','2026-07-31 18:21:38','2026-07-31 19:00:03',NULL),(102,12,'Sed eligendi harum consequatur.',NULL,'low','todo','2026-07-07','2026-07-31 19:00:03','2026-07-31 18:21:38','2026-07-31 19:00:03',NULL),(103,12,'Et omnis eum quisquam.',NULL,'low','in_progress',NULL,NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(104,12,'Optio laudantium quo voluptatem quos.',NULL,'low','todo','2026-09-22',NULL,'2026-07-31 18:21:38','2026-07-31 18:21:38',NULL),(105,3,'Molestiae quod nihil.',NULL,'low','in_progress','2026-06-25','2026-07-31 19:00:03','2026-07-31 18:21:38','2026-07-31 19:00:03',NULL),(106,3,'Rerum iste fuga.',NULL,'low','in_progress','2026-06-03','2026-07-31 19:00:03','2026-07-31 18:21:38','2026-07-31 19:00:03',NULL),(107,3,'Nisi ab quas itaque.','Delectus pariatur ratione rerum harum nostrum. Molestiae eius ut cupiditate et. Rerum dicta dolores quod optio rem commodi et nostrum.','low','todo','2026-06-13','2026-07-31 19:00:03','2026-07-31 18:21:38','2026-07-31 19:00:03',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Demo User','demo@example.com','2026-07-31 18:21:35','$2y$12$KmutH5RMzrVAIXY3yjbA0OluNkfIvcNIMrOKRq.wujBch9dXRJh3i','VQlDz83HSk','2026-07-31 18:21:35','2026-07-31 18:21:35'),(2,'Barton White DVM','qboyle@example.org','2026-07-31 18:21:35','$2y$12$fCJCvR6XCJmzyAKoUrHBcOzuWlkINgs1k801lX6oJoaJfL7B1Fsui','6shVID29Lp','2026-07-31 18:21:35','2026-07-31 18:21:35'),(3,'Vida Quitzon','missouri.feest@example.net','2026-07-31 18:21:35','$2y$12$fCJCvR6XCJmzyAKoUrHBcOzuWlkINgs1k801lX6oJoaJfL7B1Fsui','OFnSYiXHKq','2026-07-31 18:21:35','2026-07-31 18:21:35');
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

-- Dump completed on 2026-07-31 19:32:16
