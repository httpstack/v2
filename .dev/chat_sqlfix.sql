-- stackdb_clean.sql
-- MySQL 8.0+ ready SQL for "Stack-Wrangler" project (cleaned & ordered)
-- Charset / Collation: utf8mb4_0900_ai_ci
-- IDs use INT UNSIGNED AUTO_INCREMENT for clarity and compatibility.

SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `stackdb`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE `stackdb`;

-- -----------------------
-- 1) USERS
-- -----------------------
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `hashed_password` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ux_users_username` (`username`),
  UNIQUE KEY `ux_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------
-- 2) LAYERS (canonical 12 layers)
-- -----------------------
CREATE TABLE IF NOT EXISTS `layers` (
  `layer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `layer_code` VARCHAR(4) NOT NULL,      -- periodic-like short code (Cl, Ht, etc.)
  `layer_name` VARCHAR(50) NOT NULL,
  `layer_type` ENUM('Architectural','Operational') NOT NULL,
  `icon_code` VARCHAR(5) DEFAULT NULL,   -- optional icon or glyph
  `color_hex` VARCHAR(7) DEFAULT NULL,
  `description` TEXT,
  PRIMARY KEY (`layer_id`),
  UNIQUE KEY `ux_layers_code` (`layer_code`),
  UNIQUE KEY `ux_layers_name` (`layer_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed the canonical 12 layers with two-letter codes (periodic-like)
INSERT INTO `layers` (layer_code, layer_name, layer_type, icon_code, color_hex, description)
VALUES
  ('Cl','Client','Architectural','Cl','#4285F4','User-facing component (browsers, native apps).'),
  ('Ht','HTML','Architectural','Ht','#E34C26','Structural skeleton and markup generation.'),
  ('Cs','CSS','Architectural','Cs','#2965F1','Style & presentation (preprocessors, frameworks).'),
  ('Js','JavaScript','Architectural','Js','#F7DF1E','Client-side interactivity & behaviour.'),
  ('Ws','Web/File Server','Architectural','Ws','#A9A9A9','Reverse-proxy, static file serving, TLS termination.'),
  ('Pm','Programming Model','Architectural','Pm','#6E4C1E','Server-side runtime and frameworks (app logic).'),
  ('Db','Data Sources','Architectural','Db','#4479A1','Databases, caches, object stores.'),
  ('Os','Operating System','Architectural','Os','#4CAF50','Host OS and system-level runtime.'),
  ('Pa','Productivity & Admin','Operational','Pa','#9C27B0','Developer tools and admin utilities.'),
  ('Dc','Documentation','Operational','Dc','#FF9800','Docs generation and storage (Swagger, Markdown).'),
  ('Te','Testing','Operational','Te','#C21325','Unit, integration, E2E testing tools and frameworks.'),
  ('Dm','Deployment & Maintenance','Operational','Dm','#2ECC71','CI/CD, infra, monitoring and rollback strategies.');
DROP TABLE IF EXISTS `layers`;

CREATE TABLE `layers` (
  `layer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `layer_code` VARCHAR(4) NOT NULL,
  `layer_name` VARCHAR(50) NOT NULL,
  `layer_type` ENUM('Architectural','Operational') NOT NULL,
  `icon_code` VARCHAR(5) DEFAULT NULL,
  `color_hex` VARCHAR(7) DEFAULT NULL,
  `description` TEXT,
  PRIMARY KEY (`layer_id`),
  UNIQUE KEY `ux_layers_code` (`layer_code`),
  UNIQUE KEY `ux_layers_name` (`layer_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `layers` (layer_code, layer_name, layer_type, icon_code, color_hex, description)
VALUES
  ('Cl','Client','Architectural','Cl','#4285F4','User-facing component (browsers, native apps).'),
  ('Ht','HTML','Architectural','Ht','#E34C26','Structural skeleton and markup generation.'),
  ('Cs','CSS','Architectural','Cs','#2965F1','Style & presentation (preprocessors, frameworks).'),
  ('Js','JavaScript','Architectural','Js','#F7DF1E','Client-side interactivity & behaviour.'),
  ('Ws','Web/File Server','Architectural','Ws','#A9A9A9','Reverse-proxy, static file serving, TLS termination.'),
  ('Pm','Programming Model','Architectural','Pm','#6E4C1E','Server-side runtime and frameworks (app logic).'),
  ('Db','Data Sources','Architectural','Db','#4479A1','Databases, caches, object stores.'),
  ('Os','Operating System','Architectural','Os','#4CAF50','Host OS and system-level runtime.'),
  ('Pa','Productivity & Admin','Operational','Pa','#9C27B0','Developer tools and admin utilities.'),
  ('Dc','Documentation','Operational','Dc','#FF9800','Docs generation and storage (Swagger, Markdown).'),
  ('Te','Testing','Operational','Te','#C21325','Unit, integration, E2E testing tools and frameworks.'),
  ('Dm','Deployment & Maintenance','Operational','Dm','#2ECC71','CI/CD, infra, monitoring and rollback strategies.');

-- -----------------------
-- 3) TECHNOLOGIES (master list)
-- -----------------------
CREATE TABLE IF NOT EXISTS `technologies` (
  `tech_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tech_name` VARCHAR(100) NOT NULL,
  `default_layer_id` INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`tech_id`),
  UNIQUE KEY `ux_tech_name` (`tech_name`),
  KEY `ix_tech_default_layer` (`default_layer_id`),
  CONSTRAINT `fk_tech_layer` FOREIGN KEY (`default_layer_id`) REFERENCES `layers` (`layer_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed useful technologies (minimal set for demo)
INSERT INTO `technologies` (tech_name, default_layer_id) VALUES
  ('Chrome Browser', 1),
  ('Firefox Browser', 1),
  ('HTML5', 2),
  ('Pug (templating)', 2),
  ('Bootstrap', 3),
  ('Tailwind CSS', 3),
  ('jQuery', 4),
  ('React', 4),
  ('Apache HTTP Server', 5),
  ('Nginx', 5),
  ('PHP', 6),
  ('Node.js', 6),
  ('MySQL', 7),
  ('PostgreSQL', 7),
  ('MongoDB', 7),
  ('Linux (Ubuntu)', 8),
  ('VS Code', 9),
  ('phpMyAdmin', 9),
  ('Jest', 11),
  ('Cypress', 11),
  ('JSDoc', 10),
  ('Docker', 12),
  ('Kubernetes', 12),
  ('Ansible', 12);

-- -----------------------
-- 4) STACKS (top-level stack definitions)
-- -----------------------
CREATE TABLE IF NOT EXISTS `stacks` (
  `stack_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_user_id` INT UNSIGNED DEFAULT NULL,
  `stack_name` VARCHAR(100) NOT NULL,
  `is_core_spec` TINYINT(1) DEFAULT 0,
  `based_on_stack_id` INT UNSIGNED DEFAULT NULL,
  `status` ENUM('Draft','Published','Verified') DEFAULT 'Draft',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stack_id`),
  KEY `ix_stacks_creator` (`creator_user_id`),
  KEY `ix_stacks_parent` (`based_on_stack_id`),
  CONSTRAINT `fk_stacks_creator` FOREIGN KEY (`creator_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_stacks_parent` FOREIGN KEY (`based_on_stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------
-- 5) STACK_LAYERS (composition of a stack)
-- -----------------------
CREATE TABLE IF NOT EXISTS `stack_layers` (
  `stack_layer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `stack_id` INT UNSIGNED NOT NULL,
  `layer_id` INT UNSIGNED NOT NULL,
  `tech_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`stack_layer_id`),
  UNIQUE KEY `uq_stack_layer` (`stack_id`,`layer_id`),
  KEY `ix_sl_stack` (`stack_id`),
  KEY `ix_sl_layer` (`layer_id`),
  KEY `ix_sl_tech` (`tech_id`),
  CONSTRAINT `fk_sl_stack` FOREIGN KEY (`stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sl_layer` FOREIGN KEY (`layer_id`) REFERENCES `layers` (`layer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sl_tech` FOREIGN KEY (`tech_id`) REFERENCES `technologies` (`tech_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------
-- 6) QUESTIONS (layer-level doc questions)
-- -----------------------
CREATE TABLE IF NOT EXISTS `questions` (
  `question_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `layer_id` INT UNSIGNED NOT NULL,
  `question_category` VARCHAR(50) NOT NULL,
  `question_text` TEXT NOT NULL,
  `is_required` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`question_id`),
  KEY `ix_q_layer` (`layer_id`),
  CONSTRAINT `fk_q_layer` FOREIGN KEY (`layer_id`) REFERENCES `layers` (`layer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- (You can seed questions programmatically; the original dump you provided already had many - consider reusing them.)

-- -----------------------
-- 7) ELEMENT_QUESTIONS (tech-specific questions)
-- -----------------------
CREATE TABLE IF NOT EXISTS `element_questions` (
  `element_question_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tech_id` INT UNSIGNED NOT NULL,
  `question_category` VARCHAR(50) NOT NULL,
  `question_text` TEXT NOT NULL,
  `is_required` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`element_question_id`),
  KEY `ix_eq_tech` (`tech_id`),
  CONSTRAINT `fk_eq_tech` FOREIGN KEY (`tech_id`) REFERENCES `technologies` (`tech_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------
-- 8) ANSWERS (stack-level answers to questions)
-- -----------------------
CREATE TABLE IF NOT EXISTS `answers` (
  `answer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `stack_id` INT UNSIGNED NOT NULL,
  `question_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `answer_text` TEXT NOT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`answer_id`),
  UNIQUE KEY `uq_ans` (`stack_id`,`question_id`,`user_id`),
  KEY `ix_ans_stack` (`stack_id`),
  KEY `ix_ans_question` (`question_id`),
  KEY `ix_ans_user` (`user_id`),
  CONSTRAINT `fk_ans_stack` FOREIGN KEY (`stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ans_q` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ans_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------
-- 9) ELEMENT_ANSWERS (tech-specific answers)
-- -----------------------
CREATE TABLE IF NOT EXISTS `element_answers` (
  `element_answer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tech_id` INT UNSIGNED NOT NULL,
  `element_question_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `answer_text` TEXT NOT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`element_answer_id`),
  UNIQUE KEY `uq_elem_ans` (`tech_id`,`element_question_id`,`user_id`),
  KEY `ix_ea_tech` (`tech_id`),
  KEY `ix_ea_elemq` (`element_question_id`),
  KEY `ix_ea_user` (`user_id`),
  CONSTRAINT `fk_ea_tech` FOREIGN KEY (`tech_id`) REFERENCES `technologies` (`tech_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ea_eq` FOREIGN KEY (`element_question_id`) REFERENCES `element_questions` (`element_question_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ea_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------
-- 10) CRITIQUES
-- -----------------------
CREATE TABLE IF NOT EXISTS `critiques` (
  `critique_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `stack_id` INT UNSIGNED NOT NULL,
  `author_user_id` INT UNSIGNED NOT NULL,
  `critique_text` TEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`critique_id`),
  KEY `ix_cr_stack` (`stack_id`),
  KEY `ix_cr_author` (`author_user_id`),
  CONSTRAINT `fk_cr_stack` FOREIGN KEY (`stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cr_user` FOREIGN KEY (`author_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------
-- 11) VERIFICATIONS
-- -----------------------
CREATE TABLE IF NOT EXISTS `verifications` (
  `verification_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `stack_id` INT UNSIGNED NOT NULL,
  `verifier_user_id` INT UNSIGNED NOT NULL,
  `was_successful` TINYINT(1) NOT NULL,
  `challenges_faced` TEXT,
  `proof_url` VARCHAR(255) DEFAULT NULL,
  `verified_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`verification_id`),
  KEY `ix_ver_stack` (`stack_id`),
  KEY `ix_ver_user` (`verifier_user_id`),
  CONSTRAINT `fk_ver_stack` FOREIGN KEY (`stack_id`) REFERENCES `stacks` (`stack_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ver_user` FOREIGN KEY (`verifier_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------
-- 12) Optional: add example seed users and example stacks/stories
-- -----------------------
INSERT INTO `users` (username, email, hashed_password) VALUES
  ('alice_dev','alice@example.com','$2b$12$placeholderhash...'),
  ('bob_arch','bob@example.com','$2b$12$placeholderhash...'),
  ('carol_ops','carol@example.com','$2b$12$placeholderhash...'),
  ('dave_tester','dave@example.com','$2b$12$placeholderhash...'),
  ('eve_doc','eve@example.com','$2b$12$placeholderhash...');

-- Example stacks (creator_user_id references the user above)
INSERT INTO `stacks` (creator_user_id, stack_name, is_core_spec, status) VALUES
  (1,'LAMP Stack',1,'Published'),
  (2,'MERN Stack',1,'Published'),
  (3,'LAMP + Vue Remix',0,'Draft');

-- Example stack_layers (linking a stack to a layer and a specific technology)
-- Note: adjust tech_id values if you changed seeded techs earlier.
-- We will insert a small example set:
INSERT INTO `stack_layers` (stack_id, layer_id, tech_id) VALUES
  (1, 2, 3),  -- LAMP: HTML5 in HTML layer
  (1, 5, 9),  -- LAMP: Apache in Web/File Server layer
  (1, 7, 13), -- LAMP: MySQL in Data Sources
  (1, 6, 11); -- LAMP: PHP in Programming Model

INSERT INTO `stack_layers` (stack_id, layer_id, tech_id) VALUES
  (2, 7, 21), -- MERN: MongoDB
  (2, 6, 18), -- MERN: Node.js
  (2, 4, 8),  -- MERN: React
  (2, 2, 3);  -- MERN: HTML5

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

-- -----------------------
-- Stored helper: generate MD5 signature for a stack
-- -----------------------
-- This function returns an MD5 hash computed from the ordered list of technology names
-- chosen for a stack. It's intended purely as a branding/signature aid (not a security measure).
DROP FUNCTION IF EXISTS `get_stack_signature`;
DELIMITER $$
CREATE FUNCTION `get_stack_signature`(sid INT UNSIGNED) RETURNS CHAR(32)
DETERMINISTIC
BEGIN
  DECLARE sig CHAR(32);
  -- use GROUP_CONCAT ordered by layer_id to build a deterministic string:
  SELECT MD5(GROUP_CONCAT(t.tech_name ORDER BY sl.layer_id SEPARATOR ',')) INTO sig
    FROM stack_layers sl
    JOIN technologies t ON t.tech_id = sl.tech_id
    WHERE sl.stack_id = sid;
  RETURN COALESCE(sig, '');
END$$
DELIMITER ;

-- Usage example (run in SQL): SELECT get_stack_signature(1) AS sig;

-- End of stackdb_clean.sql
