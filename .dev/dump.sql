-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: cmcintosh
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.2

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
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `answer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `stack_id` int unsigned NOT NULL,
  `question_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `answer_text` text NOT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`answer_id`),
  UNIQUE KEY `uq_ans` (`stack_id`,`question_id`,`user_id`),
  KEY `stack_id` (`stack_id`),
  KEY `question_id` (`question_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_ans_q` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ans_stack` FOREIGN KEY (`stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ans_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (1,1,1,1,'This stack serves modern browsers like Chrome/Firefox/Edge.','2025-09-20 18:23:29'),(2,1,2,1,'Baseline is evergreen browser support, no IE11.','2025-09-20 18:23:29'),(3,1,3,1,'Client requires JS-enabled browsers.','2025-09-20 18:23:29'),(4,1,4,1,'Thin client – server renders most content, PHP templates.','2025-09-20 18:23:29'),(5,1,10,1,'HTML5 is used, templated via PHP.','2025-09-20 18:23:29'),(6,1,20,1,'CSS framework is Bootstrap for rapid prototyping.','2025-09-20 18:23:29');
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `critiques`
--

DROP TABLE IF EXISTS `critiques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `critiques` (
  `critique_id` int unsigned NOT NULL AUTO_INCREMENT,
  `stack_id` int unsigned NOT NULL,
  `author_user_id` int unsigned NOT NULL,
  `critique_text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`critique_id`),
  KEY `stack_id` (`stack_id`),
  KEY `author_user_id` (`author_user_id`),
  CONSTRAINT `fk_cr_stack` FOREIGN KEY (`stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cr_user` FOREIGN KEY (`author_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `critiques`
--

LOCK TABLES `critiques` WRITE;
/*!40000 ALTER TABLE `critiques` DISABLE KEYS */;
INSERT INTO `critiques` VALUES (1,1,2,'LAMP is solid but scaling PHP beyond a few servers requires careful caching.','2025-09-20 18:23:29'),(2,2,3,'MERN works great for SPAs, but MongoDB schema flexibility can cause long-term issues.','2025-09-20 18:23:29'),(3,3,4,'Adding Vue to LAMP makes sense, but watch out for hydration mismatches with SSR.','2025-09-20 18:23:29');
/*!40000 ALTER TABLE `critiques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `element_answers`
--

DROP TABLE IF EXISTS `element_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `element_answers` (
  `element_answer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `tech_id` int unsigned NOT NULL,
  `element_question_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `answer_text` text NOT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`element_answer_id`),
  UNIQUE KEY `uq_elem_ans` (`tech_id`,`element_question_id`,`user_id`),
  KEY `tech_id` (`tech_id`),
  KEY `element_question_id` (`element_question_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_ea_eq` FOREIGN KEY (`element_question_id`) REFERENCES `element_questions` (`element_question_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ea_tech` FOREIGN KEY (`tech_id`) REFERENCES `technologies` (`tech_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ea_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element_answers`
--

LOCK TABLES `element_answers` WRITE;
/*!40000 ALTER TABLE `element_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `element_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `element_questions`
--

DROP TABLE IF EXISTS `element_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `element_questions` (
  `element_question_id` int unsigned NOT NULL AUTO_INCREMENT,
  `tech_id` int unsigned NOT NULL,
  `question_category` varchar(50) NOT NULL,
  `question_text` text NOT NULL,
  `is_required` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`element_question_id`),
  KEY `tech_id` (`tech_id`),
  CONSTRAINT `fk_eq_tech` FOREIGN KEY (`tech_id`) REFERENCES `technologies` (`tech_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element_questions`
--

LOCK TABLES `element_questions` WRITE;
/*!40000 ALTER TABLE `element_questions` DISABLE KEYS */;
INSERT INTO `element_questions` VALUES (1,8,'Core Info','What is Bootstrap in one sentence?',1),(2,8,'Core Info','What is the primary use case for Bootstrap?',1),(3,8,'Setup & Installation','How do you install Bootstrap (CDN, npm, package managers)?',1),(4,8,'Setup & Installation','What is the minimal \"Hello World\" example?',1),(5,8,'Common Gotchas','What are common mistakes developers make with Bootstrap?',0),(6,8,'Compatibility','What frameworks or build tools does Bootstrap work best with?',1),(7,8,'Wisdom & Tips','What is the most valuable tip when using Bootstrap effectively?',0),(8,19,'Core Info','What is MySQL in one sentence?',1),(9,19,'Core Info','What is the primary use case for MySQL?',1),(10,19,'Setup & Installation','How do you install and configure MySQL?',1),(11,19,'Setup & Installation','What is the minimal \"Hello World\" SQL example?',1),(12,19,'Common Gotchas','What are common schema or query pitfalls with MySQL?',0),(13,19,'Compatibility','What app frameworks pair best with MySQL?',1),(14,19,'Wisdom & Tips','What indexing/optimization advice is essential for MySQL?',0);
/*!40000 ALTER TABLE `element_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layers`
--

DROP TABLE IF EXISTS `layers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `layers` (
  `layer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `layer_name` varchar(50) NOT NULL,
  `layer_type` enum('Architectural','Operational') NOT NULL,
  `icon_code` varchar(5) DEFAULT NULL,
  `color_hex` varchar(7) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`layer_id`),
  UNIQUE KEY `layer_name` (`layer_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layers`
--

LOCK TABLES `layers` WRITE;
/*!40000 ALTER TABLE `layers` DISABLE KEYS */;
INSERT INTO `layers` VALUES (1,'Client','Architectural','C','#ADD8E6','User-facing component.'),(2,'HTML','Architectural','H','#F8F8FF','Structural skeleton.'),(3,'CSS','Architectural','S','#008080','Style & presentation.'),(4,'JavaScript','Architectural','J','#FFD700','Dynamic interactivity.'),(5,'Web/File Server','Architectural','W','#708090','Handles incoming requests.'),(6,'Programming Model','Architectural','L','#4B0082','Server-side logic & frameworks.'),(7,'Data Sources','Architectural','D','#8B0000','Databases & persistence.'),(8,'Operating System','Architectural','O','#2F4F4F','OS foundation.'),(9,'Productivity & Admin','Operational','P','#CC5500','Developer tools.'),(10,'Testing','Operational','T','#32CD32','Testing & QA tools.'),(11,'Documentation','Operational','C2','#F5DEB3','Documentation tools.'),(12,'Deployment & Maintenance','Operational','M','#4682B4','CI/CD & infra.');
/*!40000 ALTER TABLE `layers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `question_id` int unsigned NOT NULL AUTO_INCREMENT,
  `layer_id` int unsigned NOT NULL,
  `question_category` varchar(50) NOT NULL,
  `question_text` text NOT NULL,
  `is_required` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`question_id`),
  KEY `layer_id` (`layer_id`),
  CONSTRAINT `fk_q_layer` FOREIGN KEY (`layer_id`) REFERENCES `layers` (`layer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,1,'Core Specification','What is the primary type of client this stack serves? (e.g., Web Browser, Native Mobile App, IoT Device, CLI, API)',1),(2,1,'Core Specification','If the client is a web browser, what is the baseline level of support? (e.g., modern evergreen browsers, DOM levels, legacy IE11)',1),(3,1,'Core Specification','What key technologies or runtimes are required by the client? (e.g., mobile OS version, browser with JavaScript enabled)',1),(4,1,'Role in Application','What is the client’s main responsibility? (Thin client rendering server-sent data vs. thick client SPA handling logic/state)',1),(5,1,'Role in Application','Describe the intended user environment. What assumptions are made about network, offline mode, or screen resolution?',1),(6,1,'Role in Application','How does the application handle authentication from the client side? (e.g., login forms, JWTs in local storage, session cookies)',1),(7,1,'Connectivity','How does the client make its initial request to the server? What is the first endpoint hit to bootstrap the app?',1),(8,1,'Connectivity','How does the client process the server payload? (e.g., render HTML, execute JS bundle to build UI)',1),(9,1,'Connectivity','What communication protocol is used between client and backend? (e.g., HTTPS, WebSockets)',1),(10,2,'Core Specification','What version of HTML is being used (e.g., HTML5)?',1),(11,2,'Core Specification','How is the HTML generated? (Static files, SSR via PHP, CSR via JS framework)',1),(12,2,'Role in Application','Describe the primary document structure. What key semantic elements (<main>, <nav>, <aside>) represent what?',1),(13,2,'Role in Application','What is the accessibility strategy? (e.g., ARIA roles, alt text, WCAG compliance)',1),(14,2,'Role in Application','Is microdata/schema.org markup used? If so, what key info is exposed to search engines?',0),(15,2,'Connectivity','How are stylesheets linked? What is the loading strategy? (e.g., critical CSS in <head>, rest deferred)',1),(16,2,'Connectivity','Where are scripts loaded? (async/defer in <head>, end of <body>) What hooks (ids/data-*) exist for JS?',1),(17,2,'Connectivity','If server-templated, what dynamic variables or loops generate HTML content?',1),(18,3,'Core Specification','Are you using a CSS pre-processor (e.g., Sass, Less)? Why?',0),(19,3,'Core Specification','Are you using a CSS framework (e.g., Tailwind, Bootstrap, Bulma)? What is its role?',1),(20,3,'Core Specification','What organizational methodology is used? (e.g., BEM, SMACSS, feature-based separation)',1),(21,3,'Role in Application','What is the responsiveness strategy? (Mobile-first? Key breakpoints for core views?)',1),(22,3,'Role in Application','How is theming handled? (Light/dark mode, brand colors, custom properties/variables)',1),(23,3,'Role in Application','What is the most complex or critical UI component styled, and how does CSS enable it?',1),(24,3,'Connectivity','How tightly coupled is CSS to HTML structure? (Utility classes vs semantic classes)',1),(25,3,'Connectivity','How does JS interact with CSS? (Toggle classes, animations, dynamic CSS vars)',1),(26,3,'Connectivity','How are fonts, icons, and assets loaded in CSS? (e.g., @font-face, SVG backgrounds)',0),(27,4,'Core Specification','What ECMAScript version is targeted (e.g., ES6, ES2024)?',1),(28,4,'Core Specification','What is the primary framework/library? (React, Vue, Angular, Svelte, Vanilla) Why chosen?',1),(29,4,'Core Specification','How is JS bundled or built for production? (Vite, Webpack, Parcel, Rollup)',1),(30,4,'Role in Application','What is the state management strategy? (Local state, Redux, Zustand, URL-based)',1),(31,4,'Role in Application','What is the most significant interactive feature in the app (real-time updates, SPA nav, validation)?',1),(32,4,'Role in Application','How are user events handled? (Consistent event delegation pattern?)',1),(33,4,'Connectivity','How does JS manipulate the DOM? (Create elements, toggle classes, change styles)',1),(34,4,'Connectivity','How does JS communicate with the backend? (fetch, axios, WebSockets) What data format (JSON, XML)?',1),(35,4,'Connectivity','What client-side testing tools are used? (e.g., Jest, Cypress)',0),(36,5,'Core Specification','What web server software is used? (Apache, Nginx, IIS, Caddy)',1),(37,5,'Core Specification','What version and operating system is it running on?',1),(38,5,'Core Specification','How is the server configured? (conf files, htaccess, control panel)',1),(39,5,'Role in Application','What are the primary responsibilities? (Reverse proxy, static file serving, TLS termination, caching)',1),(40,5,'Role in Application','Describe folder/file structure for static assets (CSS, JS, images, fonts)',1),(41,5,'Role in Application','What security configurations exist? (Rate limiting, IP blocking, HSTS headers)',1),(42,5,'Connectivity','How are dynamic requests passed from server to app logic? (proxy_pass, mod_php, etc.)',1),(43,5,'Connectivity','How are client requests logged and monitored? (Access/error log format)',1),(44,5,'Connectivity','How is server config managed/deployed during updates? (Repo-managed or separate config)',1),(45,6,'Core Specification','What is the primary programming language and main framework/runtime? (e.g., PHP/Laravel, Python/Django, Node.js/Express)',1),(46,6,'Core Specification','What is the main architectural pattern? (Monolith MVC, Microservices, Serverless)',1),(47,6,'Core Specification','What package/dependency manager is used? (Composer, NPM, Pip, Maven)',1),(48,6,'Role in Application','What is the most critical business logic performed? (What function breaking would be catastrophic?)',1),(49,6,'Role in Application','What coding conventions/patterns must be followed? (camelCase, DI, Repository, Singleton)',1),(50,6,'Role in Application','How is application-level state or caching handled? (Redis, sessions, in-memory vars)',1),(51,6,'Connectivity','How does this layer connect/query the database? (ORM, query builder, raw SQL)? Where are DB credentials stored?',1),(52,6,'Connectivity','How does this layer receive HTTP request data from the web server? (POST body, URL params)',1),(53,6,'Connectivity','What is the shape of a typical API response (success/error)? (JSON/XML, error codes)',1),(54,7,'Core Specification','What is the primary data storage technology? (MySQL, PostgreSQL, MongoDB, Redis, flat files)',1),(55,7,'Core Specification','What version is used, and how is it hosted? (Local, managed service, cluster)',1),(56,7,'Core Specification','What is the data model paradigm? (Relational, Document, Key-Value, Graph)',1),(57,7,'Role in Application','Provide schema/structure for the three most important tables/collections. What do they represent?',1),(58,7,'Role in Application','What is the strategy for backups, migrations, disaster recovery?',1),(59,7,'Role in Application','Are triggers, stored procedures, or DB-level logic used? If so, for what purpose?',0),(60,7,'Connectivity','How does the application authenticate with the database? (User/pass, IAM roles)? Which drivers/libs are used?',1),(61,7,'Connectivity','What tools are recommended for developers to interact with the database? (phpMyAdmin, DBeaver, CLI)',0),(62,7,'Connectivity','How is test data managed? (Separate seeded DB vs mocked data layer)',1),(63,8,'Core Specification','What operating system is used? (Linux, Windows Server, BSD)',1),(64,8,'Core Specification','What version/distribution is deployed? (Ubuntu 22.04, RHEL 9, Debian 12)',1),(65,8,'Core Specification','How are OS-level updates managed? (Manual, automated patching, managed service)',1),(66,8,'Role in Application','What system-level configurations are critical? (firewall rules, kernel parameters, locale settings)',1),(67,8,'Role in Application','What OS services/processes must run for the app to function? (cron jobs, daemons, systemd services)',1),(68,8,'Role in Application','How is OS-level logging handled? (syslog, journald, log rotation)',1),(69,8,'Connectivity','How does the OS integrate with higher layers (network stack, file system, process management)?',1),(70,8,'Connectivity','What monitoring/alerting tools watch the OS layer? (top, Nagios, Prometheus exporters)',0),(71,8,'Connectivity','How is OS security enforced? (user/group permissions, SELinux, AppArmor)',1),(72,9,'Core Specification','What core developer/admin tools are required? (IDE, DB clients, CLI utilities)',1),(73,9,'Core Specification','What is the standard dev environment setup? (Local Docker, VMs, cloud workspaces)',1),(74,9,'Core Specification','What collaboration tools are used? (GitHub, Jira, Slack, Notion)',1),(75,9,'Role in Application','How do developers interact with the stack day-to-day? (debugging, local builds, testing workflows)',1),(76,9,'Role in Application','What is the onboarding process for a new developer? (Docs, environment setup steps)',1),(77,9,'Role in Application','What automation scripts or aliases exist to speed up development?',0),(78,9,'Connectivity','How does this layer connect with version control (Git branching strategy, CI hooks)?',1),(79,9,'Connectivity','What admin tools directly interface with DB, servers, or services?',1),(80,9,'Connectivity','How do productivity/admin tools integrate with deployment and monitoring?',0),(81,10,'Core Specification','What testing frameworks/tools are used? (Jest, PHPUnit, Cypress)',1),(82,10,'Core Specification','What levels of testing are implemented? (Unit, Integration, E2E)',1),(83,10,'Core Specification','What environments exist for testing? (Local, CI, staging)',1),(84,10,'Role in Application','What is the testing strategy for critical business logic?',1),(85,10,'Role in Application','How is test coverage measured and enforced? (Coverage %, thresholds)',0),(86,10,'Role in Application','How is test data seeded/managed across environments?',1),(87,10,'Connectivity','How are tests integrated with CI/CD pipelines?',1),(88,10,'Connectivity','What mocks, stubs, or fakes are used for external dependencies?',1),(89,10,'Connectivity','What happens when a test fails? (Blocking deploy, alerts, manual review)',1),(90,11,'Core Specification','What documentation tools/formats are used? (JSDoc, Swagger, Markdown, Sphinx)',1),(91,11,'Core Specification','Where is documentation stored? (Repo, wiki, site generator)',1),(92,11,'Core Specification','What audience is the documentation written for? (Developers, end-users, admins)',1),(93,11,'Role in Application','What is the minimum required documentation for this stack? (API refs, setup guides, architecture diagrams)',1),(94,11,'Role in Application','How is documentation kept current with code changes?',1),(95,11,'Role in Application','What style/structure guidelines are followed for docs?',0),(96,11,'Connectivity','How does documentation integrate with CI/CD or repo workflows? (Linting, auto-generation)',0),(97,11,'Connectivity','What diagrams or visuals are required? (ERD, sequence diagrams, deployment topology)',1),(98,11,'Connectivity','How does this layer support onboarding of new developers?',1),(99,12,'Core Specification','What deployment method is used? (Docker, Kubernetes, Ansible, manual SSH)',1),(100,12,'Core Specification','What environments exist? (Dev, staging, prod) and how are they structured?',1),(101,12,'Core Specification','What monitoring/observability stack is in place? (Prometheus, ELK, Grafana)',1),(102,12,'Role in Application','What is the rollback strategy if a deployment fails?',1),(103,12,'Role in Application','How are secrets and environment variables managed? (Vault, dotenv, AWS Secrets Manager)',1),(104,12,'Role in Application','What is the backup/restore process for critical infrastructure?',1),(105,12,'Connectivity','How do CI/CD pipelines interact with version control and testing layers?',1),(106,12,'Connectivity','How is infrastructure provisioned? (Terraform, Pulumi, CloudFormation)',1),(107,12,'Connectivity','What maintenance tasks are automated vs manual? (Cron jobs, alerts, auto-scaling)',1);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stack_layers`
--

DROP TABLE IF EXISTS `stack_layers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stack_layers` (
  `stack_layer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `stack_id` int unsigned NOT NULL,
  `layer_id` int unsigned NOT NULL,
  `tech_id` int unsigned NOT NULL,
  PRIMARY KEY (`stack_layer_id`),
  UNIQUE KEY `uq_stack_layer` (`stack_id`,`layer_id`),
  KEY `stack_id` (`stack_id`),
  KEY `layer_id` (`layer_id`),
  KEY `tech_id` (`tech_id`),
  CONSTRAINT `fk_sl_layer` FOREIGN KEY (`layer_id`) REFERENCES `layers` (`layer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sl_stack` FOREIGN KEY (`stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sl_tech` FOREIGN KEY (`tech_id`) REFERENCES `technologies` (`tech_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stack_layers`
--

LOCK TABLES `stack_layers` WRITE;
/*!40000 ALTER TABLE `stack_layers` DISABLE KEYS */;
INSERT INTO `stack_layers` VALUES (1,1,8,1),(2,1,5,1),(3,1,7,1),(4,1,6,2),(5,2,7,3),(6,2,6,3),(7,2,4,3),(8,2,2,1),(9,3,8,1),(10,3,5,1),(11,3,7,1),(12,3,6,2),(13,3,4,3);
/*!40000 ALTER TABLE `stack_layers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stacks`
--

DROP TABLE IF EXISTS `stacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stacks` (
  `stack_id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_user_id` int unsigned DEFAULT NULL,
  `stack_name` varchar(100) NOT NULL,
  `is_core_spec` tinyint(1) DEFAULT '0',
  `based_on_stack_id` int unsigned DEFAULT NULL,
  `status` enum('Draft','Published','Verified') DEFAULT 'Draft',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stack_id`),
  KEY `creator_user_id` (`creator_user_id`),
  KEY `based_on_stack_id` (`based_on_stack_id`),
  CONSTRAINT `fk_stack_parent` FOREIGN KEY (`based_on_stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_stack_user` FOREIGN KEY (`creator_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stacks`
--

LOCK TABLES `stacks` WRITE;
/*!40000 ALTER TABLE `stacks` DISABLE KEYS */;
INSERT INTO `stacks` VALUES (1,1,'LAMP Stack',1,NULL,'Published','2025-09-20 18:23:29'),(2,2,'MERN Stack',1,NULL,'Published','2025-09-20 18:23:29'),(3,3,'LAMP + Vue Remix',0,NULL,'Draft','2025-09-20 18:23:29');
/*!40000 ALTER TABLE `stacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technologies`
--

DROP TABLE IF EXISTS `technologies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technologies` (
  `tech_id` int unsigned NOT NULL AUTO_INCREMENT,
  `tech_name` varchar(100) NOT NULL,
  `default_layer_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`tech_id`),
  UNIQUE KEY `tech_name` (`tech_name`),
  KEY `default_layer_id` (`default_layer_id`),
  CONSTRAINT `fk_tech_layer` FOREIGN KEY (`default_layer_id`) REFERENCES `layers` (`layer_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technologies`
--

LOCK TABLES `technologies` WRITE;
/*!40000 ALTER TABLE `technologies` DISABLE KEYS */;
INSERT INTO `technologies` VALUES (1,'Chrome Browser',1),(2,'Firefox Browser',1),(3,'Safari Browser',1),(4,'HTML5',2),(5,'Pug',2),(6,'Handlebars',2),(7,'Bootstrap',3),(8,'PatternFly',3),(9,'Tailwind CSS',3),(10,'jQuery',4),(11,'Prototype.js',4),(12,'Angular',4),(13,'Apache HTTP Server',5),(14,'Nginx',5),(15,'Caddy',5),(16,'Python CGI',6),(17,'PHP',6),(18,'Node.js',6),(19,'MySQL',7),(20,'PostgreSQL',7),(21,'MongoDB',7),(22,'Linux (Ubuntu)',8),(23,'Windows Server',8),(24,'Red Hat Enterprise Linux',8),(25,'VS Code',9),(26,'phpMyAdmin',9),(27,'DBeaver',9),(28,'Jest',10),(29,'Cypress',10),(30,'PHPUnit',10),(31,'JSDoc',11),(32,'Swagger/OpenAPI',11),(33,'Sphinx',11),(34,'Docker',12),(35,'Kubernetes',12),(36,'Ansible',12);
/*!40000 ALTER TABLE `technologies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `hashed_password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'alice_dev','alice@example.com','$2b$12$w3GkxlG4KNMDe8ZnJd6q9OHucg.8hPPTd6kEwKNVjM5biKXw5TMyi','2025-09-20 18:23:29'),(2,'bob_arch','bob@example.com','$2b$12$w3GkxlG4KNMDe8ZnJd6q9OHucg.8hPPTd6kEwKNVjM5biKXw5TMyi','2025-09-20 18:23:29'),(3,'carol_ops','carol@example.com','$2b$12$w3GkxlG4KNMDe8ZnJd6q9OHucg.8hPPTd6kEwKNVjM5biKXw5TMyi','2025-09-20 18:23:29'),(4,'dave_tester','dave@example.com','$2b$12$w3GkxlG4KNMDe8ZnJd6q9OHucg.8hPPTd6kEwKNVjM5biKXw5TMyi','2025-09-20 18:23:29'),(5,'eve_doc','eve@example.com','$2b$12$w3GkxlG4KNMDe8ZnJd6q9OHucg.8hPPTd6kEwKNVjM5biKXw5TMyi','2025-09-20 18:23:29');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verifications`
--

DROP TABLE IF EXISTS `verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verifications` (
  `verification_id` int unsigned NOT NULL AUTO_INCREMENT,
  `stack_id` int unsigned NOT NULL,
  `verifier_user_id` int unsigned NOT NULL,
  `was_successful` tinyint(1) NOT NULL,
  `challenges_faced` text,
  `proof_url` varchar(255) DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`verification_id`),
  KEY `stack_id` (`stack_id`),
  KEY `verifier_user_id` (`verifier_user_id`),
  CONSTRAINT `fk_ver_stack` FOREIGN KEY (`stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ver_user` FOREIGN KEY (`verifier_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verifications`
--

LOCK TABLES `verifications` WRITE;
/*!40000 ALTER TABLE `verifications` DISABLE KEYS */;
INSERT INTO `verifications` VALUES (1,1,3,1,'Setup smooth, only needed php.ini tweaks.','https://github.com/example/lamp-demo','2025-09-20 18:23:29'),(2,2,1,1,'Got it running but had dependency conflicts with Node version.','https://github.com/example/mern-demo','2025-09-20 18:23:29'),(3,3,2,0,'Build failed due to mismatch between PHP templating and Vue bundling.',NULL,'2025-09-20 18:23:29');
/*!40000 ALTER TABLE `verifications` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-22 23:27:24
use stackdb;

INSERT INTO layers (code, name, color)
VALUES -- 1. Client
    ('Cl', 'Client', '#4285F4'),
    -- Browsers, Native Apps
    -- 2. HTML
    ('Ht', 'HTML', '#E34C26'),
    -- 3. CSS
    ('Cs', 'CSS', '#2965F1'),
    -- 4. JavaScript
    ('Js', 'JavaScript', '#F7DF1E'),
    -- 5. Operating System
    ('Os', 'Operating System', '#4CAF50'),
    -- 6. Web/File Server
    ('Ws', 'Web/File Server', '#A9A9A9'),
    -- 7. Programming Model
    ('Pm', 'Programming Model', '#6E4C1E'),
    -- 8. Data Sources
    ('Db', 'Data Sources', '#4479A1'),
    -- 9. Productivity & Admin
    ('Pa', 'Productivity & Admin', '#9C27B0'),
    -- 10. Documentation
    ('Dc', 'Documentation', '#FF9800'),
    -- 11. Testing
    ('Te', 'Testing', '#C21325'),
    -- 12. Deployment & Maintenance
    ('Dm', 'Deployment & Maintenance', '#2ECC71');


    CREATE TABLE `layers` (
  `layer_id` INT PRIMARY KEY,
  `layer_name` VARCHAR(50) NOT NULL,
  `layer_type` ENUM('Architectural', 'Operational') NOT NULL,
  `icon_code` VARCHAR(5) NOT NULL,
  `color_hex` VARCHAR(7) NOT NULL,
  `description` TEXT
);
 use stackdb;
CREATE TABLE layers (
  layer_id int primary key unsigned NOT NULL AUTO_INCREMENT,
  layer_name varchar(50) NOT NULL,
  layer_type enum('Architectural','Operational') NOT NULL,
  icon_code varchar(5) DEFAULT NULL,
  description text
);
