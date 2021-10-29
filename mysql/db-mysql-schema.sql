-- -----------------------------------------------------
-- Schema pentesting
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pentesting
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pentesting` DEFAULT CHARACTER SET utf8;
USE `pentesting`;
-- -----------------------------------------------------
-- Table `pentesting`.`persons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`persons`;
CREATE TABLE IF NOT EXISTS `pentesting`.`persons` (
  `id_person` BIGINT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `pwd` VARCHAR(255) NOT NULL,
  `avatar` VARCHAR(255) NULL,
  `phone` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_person`)
);
CREATE UNIQUE INDEX `email_UNIQUE` ON `pentesting`.`persons` (`email` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`role_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`role_types`;
CREATE TABLE IF NOT EXISTS `pentesting`.`role_types` (
  `id_role_type` BIGINT NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_role_type`)
);
CREATE UNIQUE INDEX `name_UNIQUE` ON `pentesting`.`role_types` (`slug` ASC);
CREATE UNIQUE INDEX `title_UNIQUE` ON `pentesting`.`role_types` (`title` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`roles`;
CREATE TABLE IF NOT EXISTS `pentesting`.`roles` (
  `id_role` BIGINT NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `id_role_type` BIGINT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_role`, `id_role_type`),
  CONSTRAINT `fk_roles_role_types1` FOREIGN KEY (`id_role_type`) REFERENCES `pentesting`.`role_types` (`id_role_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_roles_role_types1_idx` ON `pentesting`.`roles` (`id_role_type` ASC);
CREATE UNIQUE INDEX `name_UNIQUE` ON `pentesting`.`roles` (`slug` ASC);
CREATE UNIQUE INDEX `title_UNIQUE` ON `pentesting`.`roles` (`title` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`person2role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`person2role`;
CREATE TABLE IF NOT EXISTS `pentesting`.`person2role` (
  `id_person` BIGINT NOT NULL,
  `id_role` BIGINT NOT NULL,
  PRIMARY KEY (`id_person`, `id_role`),
  CONSTRAINT `fk_person2role_persons1` FOREIGN KEY (`id_person`) REFERENCES `pentesting`.`persons` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person2role_roles1` FOREIGN KEY (`id_role`) REFERENCES `pentesting`.`roles` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_person2role_persons1_idx` ON `pentesting`.`person2role` (`id_person` ASC);
CREATE INDEX `fk_person2role_roles1_idx` ON `pentesting`.`person2role` (`id_role` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`permissions`;
CREATE TABLE IF NOT EXISTS `pentesting`.`permissions` (
  `id_permission` BIGINT NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_permission`)
);
-- -----------------------------------------------------
-- Table `pentesting`.`role2permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`role2permission`;
CREATE TABLE IF NOT EXISTS `pentesting`.`role2permission` (
  `id_role` BIGINT NOT NULL,
  `id_permission` BIGINT NOT NULL,
  PRIMARY KEY (`id_permission`, `id_role`),
  CONSTRAINT `fk_role2permissions_roles1` FOREIGN KEY (`id_role`) REFERENCES `pentesting`.`roles` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_role2permissions_permissions1` FOREIGN KEY (`id_permission`) REFERENCES `pentesting`.`permissions` (`id_permission`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_role2permissions_roles1_idx` ON `pentesting`.`role2permission` (`id_role` ASC);
CREATE INDEX `fk_role2permissions_permissions1_idx` ON `pentesting`.`role2permission` (`id_permission` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`projects`;
CREATE TABLE IF NOT EXISTS `pentesting`.`projects` (
  `id_project` BIGINT NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_project`)
);
CREATE UNIQUE INDEX `name_UNIQUE` ON `pentesting`.`projects` (`slug` ASC);
CREATE UNIQUE INDEX `title_UNIQUE` ON `pentesting`.`projects` (`title` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`tasks`;
CREATE TABLE IF NOT EXISTS `pentesting`.`tasks` (
  `id_task` BIGINT NOT NULL AUTO_INCREMENT,
  `id_project` BIGINT NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_task`),
  CONSTRAINT `fk_tasks_projects` FOREIGN KEY (`id_project`) REFERENCES `pentesting`.`projects` (`id_project`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_tasks_projects_idx` ON `pentesting`.`tasks` (`id_project` ASC);
CREATE UNIQUE INDEX `name_UNIQUE` ON `pentesting`.`tasks` (`slug` ASC);
CREATE UNIQUE INDEX `title_UNIQUE` ON `pentesting`.`tasks` (`title` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`documents`;
CREATE TABLE IF NOT EXISTS `pentesting`.`documents` (
  `id_document` BIGINT NOT NULL AUTO_INCREMENT,
  `id_person` BIGINT NOT NULL,
  `document_path` VARCHAR(255) NOT NULL,
  `document_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_document`, `id_person`),
  CONSTRAINT `fk_documents_persons1` FOREIGN KEY (`id_person`) REFERENCES `pentesting`.`persons` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_documents_persons1_idx` ON `pentesting`.`documents` (`id_person` ASC);
CREATE UNIQUE INDEX `document_UNIQUE` ON `pentesting`.`documents` (`document_path`, `document_name` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`document2project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`document2project`;
CREATE TABLE IF NOT EXISTS `pentesting`.`document2project` (
  `id_document` BIGINT NOT NULL,
  `id_project` BIGINT NOT NULL,
  PRIMARY KEY (`id_document`, `id_project`),
  CONSTRAINT `fk_document2project_documents1` FOREIGN KEY (`id_document`) REFERENCES `pentesting`.`documents` (`id_document`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_document2project_projects1` FOREIGN KEY (`id_project`) REFERENCES `pentesting`.`projects` (`id_project`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_document2project_documents1_idx` ON `pentesting`.`document2project` (`id_document` ASC);
CREATE INDEX `fk_document2project_projects1_idx` ON `pentesting`.`document2project` (`id_project` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`person2project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`person2project`;
CREATE TABLE IF NOT EXISTS `pentesting`.`person2project` (
  `id_person2project` BIGINT NOT NULL,
  `id_person` BIGINT NOT NULL,
  `id_project` BIGINT NOT NULL,
  `id_role` BIGINT NOT NULL,
  `invited_at` TIMESTAMP NULL,
  `joined_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_person2project`),
  CONSTRAINT `fk_person2project_persons1` FOREIGN KEY (`id_person`) REFERENCES `pentesting`.`persons` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person2project_projects1` FOREIGN KEY (`id_project`) REFERENCES `pentesting`.`projects` (`id_project`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person2project_roles1` FOREIGN KEY (`id_role`) REFERENCES `pentesting`.`roles` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_person2project_persons1_idx` ON `pentesting`.`person2project` (`id_person` ASC);
CREATE INDEX `fk_person2project_projects1_idx` ON `pentesting`.`person2project` (`id_project` ASC);
CREATE INDEX `fk_person2project_roles1_idx` ON `pentesting`.`person2project` (`id_role` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`categories`;
CREATE TABLE IF NOT EXISTS `pentesting`.`categories` (
  `id_category` BIGINT NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_category`)
);
CREATE UNIQUE INDEX `name_UNIQUE` ON `pentesting`.`categories` (`slug` ASC);
CREATE UNIQUE INDEX `title_UNIQUE` ON `pentesting`.`categories` (`title` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`checklists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`checklists`;
CREATE TABLE IF NOT EXISTS `pentesting`.`checklists` (
  `id_checklist` BIGINT NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_checklist`)
);
CREATE UNIQUE INDEX `name_UNIQUE` ON `pentesting`.`checklists` (`slug` ASC);
CREATE UNIQUE INDEX `title_UNIQUE` ON `pentesting`.`checklists` (`title` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`checklist2category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`checklist2category`;
CREATE TABLE IF NOT EXISTS `pentesting`.`checklist2category` (
  `id_checklist` BIGINT NOT NULL,
  `id_category` BIGINT NOT NULL,
  PRIMARY KEY (`id_checklist`, `id_category`),
  CONSTRAINT `fk_checklist2category_checklists1` FOREIGN KEY (`id_checklist`) REFERENCES `pentesting`.`checklists` (`id_checklist`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_checklist2category_categories1` FOREIGN KEY (`id_category`) REFERENCES `pentesting`.`categories` (`id_category`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_checklist2category_checklists1_idx` ON `pentesting`.`checklist2category` (`id_checklist` ASC);
CREATE INDEX `fk_checklist2category_categories1_idx` ON `pentesting`.`checklist2category` (`id_category` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`vulnerabilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`vulnerabilities`;
CREATE TABLE IF NOT EXISTS `pentesting`.`vulnerabilities` (
  `id_vulnerability` BIGINT NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `cve` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_vulnerability`)
);
CREATE UNIQUE INDEX `name_UNIQUE` ON `pentesting`.`vulnerabilities` (`slug` ASC);
CREATE UNIQUE INDEX `title_UNIQUE` ON `pentesting`.`vulnerabilities` (`title` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`targets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`targets`;
CREATE TABLE IF NOT EXISTS `pentesting`.`targets` (
  `id_target` BIGINT NOT NULL AUTO_INCREMENT,
  `id_category` BIGINT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `address` VARCHAR(512) NULL,
  `description` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_target`),
  CONSTRAINT `fk_targets_categories1` FOREIGN KEY (`id_category`) REFERENCES `pentesting`.`categories` (`id_category`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_targets_categories1_idx` ON `pentesting`.`targets` (`id_category` ASC);
CREATE UNIQUE INDEX `name_UNIQUE` ON `pentesting`.`targets` (`slug` ASC);
CREATE UNIQUE INDEX `title_UNIQUE` ON `pentesting`.`targets` (`title` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`vulnerability2target`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`vulnerability2target`;
CREATE TABLE IF NOT EXISTS `pentesting`.`vulnerability2target` (
  `id_vulnerability` BIGINT NOT NULL,
  `id_target` BIGINT NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id_vulnerability`, `id_target`),
  CONSTRAINT `fk_vulnerability2target_targets1` FOREIGN KEY (`id_target`) REFERENCES `pentesting`.`targets` (`id_target`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vulnerability2target_vulnerabilities1` FOREIGN KEY (`id_vulnerability`) REFERENCES `pentesting`.`vulnerabilities` (`id_vulnerability`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_vulnerability2target_targets1_idx` ON `pentesting`.`vulnerability2target` (`id_target` ASC);
CREATE INDEX `fk_vulnerability2target_vulnerabilities1_idx` ON `pentesting`.`vulnerability2target` (`id_vulnerability` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`person2task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`person2task`;
CREATE TABLE IF NOT EXISTS `pentesting`.`person2task` (
  `id_person2project` BIGINT NOT NULL,
  `id_task` BIGINT NOT NULL,
  PRIMARY KEY (`id_person2project`, `id_task`),
  CONSTRAINT `fk_person2task_person2project1` FOREIGN KEY (`id_person2project`) REFERENCES `pentesting`.`person2project` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person2task_tasks1` FOREIGN KEY (`id_task`) REFERENCES `pentesting`.`tasks` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_person2task_person2project1_idx` ON `pentesting`.`person2task` (`id_person2project` ASC);
CREATE INDEX `fk_person2task_tasks1_idx` ON `pentesting`.`person2task` (`id_task` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`target2task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`target2task`;
CREATE TABLE IF NOT EXISTS `pentesting`.`target2task` (
  `id_target` BIGINT NOT NULL,
  `id_task` BIGINT NOT NULL,
  PRIMARY KEY (`id_target`, `id_task`),
  CONSTRAINT `fk_target2task_targets1` FOREIGN KEY (`id_target`) REFERENCES `pentesting`.`targets` (`id_target`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_target2task_tasks1` FOREIGN KEY (`id_task`) REFERENCES `pentesting`.`tasks` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_target2task_targets1_idx` ON `pentesting`.`target2task` (`id_target` ASC);
CREATE INDEX `fk_target2task_tasks1_idx` ON `pentesting`.`target2task` (`id_task` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`document_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`document_metadata`;
CREATE TABLE IF NOT EXISTS `pentesting`.`document_metadata` (
  `id_document_metadata` BIGINT NOT NULL AUTO_INCREMENT,
  `id_document` BIGINT NOT NULL,
  `file_extension` VARCHAR(45) NOT NULL,
  `file_type` VARCHAR(45) NOT NULL,
  `file_size` BIGINT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_document_metadata`, `id_document`),
  CONSTRAINT `fk_meta_documents1` FOREIGN KEY (`id_document`) REFERENCES `pentesting`.`documents` (`id_document`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_meta_documents1_idx` ON `pentesting`.`document_metadata` (`id_document` ASC);
-- -----------------------------------------------------
-- Table `pentesting`.`logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pentesting`.`logs`;
CREATE TABLE IF NOT EXISTS `pentesting`.`logs` (
  `id_log` BIGINT NOT NULL AUTO_INCREMENT,
  `id_person` BIGINT NOT NULL,
  `log_event` VARCHAR(255) NOT NULL,
  `log_timestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_log`, `id_person`),
  CONSTRAINT `fk_logs_persons1` FOREIGN KEY (`id_person`) REFERENCES `pentesting`.`persons` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX `fk_logs_persons1_idx` ON `pentesting`.`logs` (`id_person` ASC);