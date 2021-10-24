-- -----------------------------------------------------
-- Schema pentesting
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pentesting` DEFAULT CHARACTER SET utf8;

USE `pentesting`;

-- -----------------------------------------------------
-- Table `pentesting`.`persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`persons` (
  `id_person` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `avatar` VARCHAR(255) NULL,
  `phone` VARCHAR(45) NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_person`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
);

-- -----------------------------------------------------
-- Table `pentesting`.`role_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`role_types` (
  `id_role_type` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_role_type`)
);

-- -----------------------------------------------------
-- Table `pentesting`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`roles` (
  `id_role` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `id_role_type` INT NOT NULL,
  PRIMARY KEY (`id_role`, `id_role_type`),
  INDEX `fk_roles_role_types1_idx` (`id_role_type` ASC),
  CONSTRAINT `fk_roles_role_types1` FOREIGN KEY (`id_role_type`) REFERENCES `pentesting`.`role_types` (`id_role_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`person2role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`person2role` (
  `id_person` INT NOT NULL,
  `id_role` INT NOT NULL,
  PRIMARY KEY (`id_person`, `id_role`),
  INDEX `fk_person2role_persons1_idx` (`id_person` ASC),
  INDEX `fk_person2role_roles1_idx` (`id_role` ASC),
  CONSTRAINT `fk_person2role_persons1` FOREIGN KEY (`id_person`) REFERENCES `pentesting`.`persons` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person2role_roles1` FOREIGN KEY (`id_role`) REFERENCES `pentesting`.`roles` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`permissions` (
  `id_permission` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_permission`)
);

-- -----------------------------------------------------
-- Table `pentesting`.`role2permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`role2permission` (
  `id_role` INT NOT NULL,
  `id_permission` INT NOT NULL,
  PRIMARY KEY (`id_permission`, `id_role`),
  INDEX `fk_role2permissions_roles1_idx` (`id_role` ASC),
  INDEX `fk_role2permissions_permissions1_idx` (`id_permission` ASC),
  CONSTRAINT `fk_role2permissions_roles1` FOREIGN KEY (`id_role`) REFERENCES `pentesting`.`roles` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_role2permissions_permissions1` FOREIGN KEY (`id_permission`) REFERENCES `pentesting`.`permissions` (`id_permission`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`projects` (
  `id_project` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `start` DATETIME NOT NULL,
  `end` DATETIME NOT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_project`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC)
);

-- -----------------------------------------------------
-- Table `pentesting`.`tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`tasks` (
  `id_task` INT NOT NULL AUTO_INCREMENT,
  `id_project` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_task`, `id_project`),
  INDEX `fk_tasks_projects_idx` (`id_project` ASC),
  CONSTRAINT `fk_tasks_projects` FOREIGN KEY (`id_project`) REFERENCES `pentesting`.`projects` (`id_project`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`documents` (
  `id_document` INT NOT NULL AUTO_INCREMENT,
  `id_person` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_document`, `id_person`),
  INDEX `fk_documents_persons1_idx` (`id_person` ASC),
  CONSTRAINT `fk_documents_persons1` FOREIGN KEY (`id_person`) REFERENCES `pentesting`.`persons` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`document2project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`document2project` (
  `id_document` INT NOT NULL,
  `id_project` INT NOT NULL,
  PRIMARY KEY (`id_document`, `id_project`),
  INDEX `fk_document2project_documents1_idx` (`id_document` ASC),
  INDEX `fk_document2project_projects1_idx` (`id_project` ASC),
  CONSTRAINT `fk_document2project_documents1` FOREIGN KEY (`id_document`) REFERENCES `pentesting`.`documents` (`id_document`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_document2project_projects1` FOREIGN KEY (`id_project`) REFERENCES `pentesting`.`projects` (`id_project`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`person2project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`person2project` (
  `id_person2project` INT NOT NULL,
  `id_person` INT NOT NULL,
  `id_project` INT NOT NULL,
  `id_role` INT NOT NULL,
  `invited_at` VARCHAR(45) NULL,
  `joined_at` VARCHAR(45) NULL,
  PRIMARY KEY (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`
  ),
  INDEX `fk_person2project_persons1_idx` (`id_person` ASC),
  INDEX `fk_person2project_projects1_idx` (`id_project` ASC),
  INDEX `fk_person2project_roles1_idx` (`id_role` ASC),
  CONSTRAINT `fk_person2project_persons1` FOREIGN KEY (`id_person`) REFERENCES `pentesting`.`persons` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person2project_projects1` FOREIGN KEY (`id_project`) REFERENCES `pentesting`.`projects` (`id_project`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person2project_roles1` FOREIGN KEY (`id_role`) REFERENCES `pentesting`.`roles` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`categories` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_category`)
);

-- -----------------------------------------------------
-- Table `pentesting`.`checklists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`checklists` (
  `id_checklist` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_checklist`)
);

-- -----------------------------------------------------
-- Table `pentesting`.`checklist2category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`checklist2category` (
  `id_checklist` INT NOT NULL,
  `id_category` INT NOT NULL,
  PRIMARY KEY (`id_checklist`, `id_category`),
  INDEX `fk_checklist2category_checklists1_idx` (`id_checklist` ASC),
  INDEX `fk_checklist2category_categories1_idx` (`id_category` ASC),
  CONSTRAINT `fk_checklist2category_checklists1` FOREIGN KEY (`id_checklist`) REFERENCES `pentesting`.`checklists` (`id_checklist`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_checklist2category_categories1` FOREIGN KEY (`id_category`) REFERENCES `pentesting`.`categories` (`id_category`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`vulnerabilities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`vulnerabilities` (
  `id_vulnerability` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `cve` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_vulnerability`)
);

-- -----------------------------------------------------
-- Table `pentesting`.`targets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`targets` (
  `id_target` INT NOT NULL AUTO_INCREMENT,
  `id_category` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_target`),
  INDEX `fk_targets_categories1_idx` (`id_category` ASC),
  CONSTRAINT `fk_targets_categories1` FOREIGN KEY (`id_category`) REFERENCES `pentesting`.`categories` (`id_category`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`vulnerability2target`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`vulnerability2target` (
  `id_vulnerability` INT NOT NULL,
  `id_target` INT NOT NULL,
  PRIMARY KEY (`id_vulnerability`, `id_target`),
  INDEX `fk_vulnerability2target_targets1_idx` (`id_target` ASC),
  INDEX `fk_vulnerability2target_vulnerabilities1_idx` (`id_vulnerability` ASC),
  CONSTRAINT `fk_vulnerability2target_targets1` FOREIGN KEY (`id_target`) REFERENCES `pentesting`.`targets` (`id_target`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vulnerability2target_vulnerabilities1` FOREIGN KEY (`id_vulnerability`) REFERENCES `pentesting`.`vulnerabilities` (`id_vulnerability`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`person2project2task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`person2project2task` (
  `id_person2project` INT NOT NULL,
  `id_task` INT NOT NULL,
  PRIMARY KEY (`id_person2project`, `id_task`),
  INDEX `fk_person2project2task_person2project1_idx` (`id_person2project` ASC),
  INDEX `fk_person2project2task_tasks1_idx` (`id_task` ASC),
  CONSTRAINT `fk_person2project2task_person2project1` FOREIGN KEY (`id_person2project`) REFERENCES `pentesting`.`person2project` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person2project2task_tasks1` FOREIGN KEY (`id_task`) REFERENCES `pentesting`.`tasks` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`target2task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`target2task` (
  `id_target` INT NOT NULL,
  `id_task` INT NOT NULL,
  PRIMARY KEY (`id_target`, `id_task`),
  INDEX `fk_target2task_targets1_idx` (`id_target` ASC),
  INDEX `fk_target2task_tasks1_idx` (`id_task` ASC),
  CONSTRAINT `fk_target2task_targets1` FOREIGN KEY (`id_target`) REFERENCES `pentesting`.`targets` (`id_target`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_target2task_tasks1` FOREIGN KEY (`id_task`) REFERENCES `pentesting`.`tasks` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`meta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`meta` (
  `id_meta` INT NOT NULL AUTO_INCREMENT,
  `id_document` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `size` VARCHAR(45) NOT NULL,
  `created_at` VARCHAR(45) NULL,
  `updated_at` VARCHAR(45) NULL,
  PRIMARY KEY (`id_meta`, `id_document`),
  INDEX `fk_meta_documents1_idx` (`id_document` ASC),
  CONSTRAINT `fk_meta_documents1` FOREIGN KEY (`id_document`) REFERENCES `pentesting`.`documents` (`id_document`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `pentesting`.`logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pentesting`.`logs` (
  `id_log` INT NOT NULL AUTO_INCREMENT,
  `id_person` INT NOT NULL,
  `event` VARCHAR(45) NOT NULL,
  `timestamp` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_log`, `id_person`),
  INDEX `fk_logs_persons1_idx` (`id_person` ASC),
  CONSTRAINT `fk_logs_persons1` FOREIGN KEY (`id_person`) REFERENCES `pentesting`.`persons` (`id_person`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Data for table `pentesting`.`persons`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    'rimeson0@drupal.org',
    'Rowen',
    'Imeson',
    '83c42f38884494fe75f740387405dc62879e4799d66d54bbe7f2e25af63d5e2d',
    'https://robohash.org/officiafacerevel.png?size=50x50&set=set1',
    '1489000442',
    '1605498603000',
    '1604759731000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    'cpearl1@yandex.ru',
    'Cris',
    'Pearl',
    'c63f601f3619a73b825ab4c08c80146277b932545b928997bf308981d84eab9b',
    'https://robohash.org/totamveritatisiste.png?size=50x50&set=set1',
    '8682671840',
    '1629729033000',
    '1629396709000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    'aryam2@state.tx.us',
    'Augusto',
    'Ryam',
    'f7be5c6b0ecabeec2685145eb52bad0cae10e30d9f7248c99b51036c98cc1ce4',
    'https://robohash.org/rationeimpeditodio.png?size=50x50&set=set1',
    '9264100873',
    '1619466520000',
    '1618445849000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    'sblowfield3@unesco.org',
    'Serge',
    'Blowfield',
    '3d39b77c0f348231897e45049a75253ae6d468ef39fe0c05485446c97f8f6c0e',
    'https://robohash.org/cupiditatevelitvel.png?size=50x50&set=set1',
    '9415179003',
    '1631756115000',
    '1607726046000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    'mthurstance4@ed.gov',
    'Melody',
    'Thurstance',
    '1192fbe8eb4e375917a170b7b66dea059707f2d4091cba5cff35324e5c271ef0',
    'https://robohash.org/odiocupiditateomnis.png?size=50x50&set=set1',
    '1422414023',
    '1618250601000',
    '1633451400000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    6,
    'aewins5@cbslocal.com',
    'Abra',
    'Ewins',
    '175ba6cc01483876b4da06d86e62f5de15366a012fc3cb15831dc673bc401373',
    'https://robohash.org/veritatismaioresnon.png?size=50x50&set=set1',
    '4624321001',
    '1608639126000',
    '1608688376000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    7,
    'schatelet6@flavors.me',
    'Stephanie',
    'Chatelet',
    '7129c38ab7ece8357ed2375e8feb5440c7b5e6ca0b2912931e67509b8d378db0',
    'https://robohash.org/repellendusaccusantiumet.png?size=50x50&set=set1',
    '9645409402',
    '1606845352000',
    '1607660992000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    8,
    'onickolls7@cocolog-nifty.com',
    'Olympia',
    'Nickolls',
    '2142891e6a6458f5e2ebb5128cc1e33f3dabb68ae4ed883c981cb557c0c28699',
    'https://robohash.org/velmagnamut.png?size=50x50&set=set1',
    '3277826672',
    '1621898959000',
    '1631468744000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9,
    'wgrob8@mediafire.com',
    'Wilhelmina',
    'Grob',
    '08b8d486d27c02d6e04eb386c6a4b99b7221c000acb45981c517870c17c17256',
    'https://robohash.org/esteiusneque.png?size=50x50&set=set1',
    '9915688792',
    '1628723843000',
    '1618854440000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10,
    'acrockatt9@ycombinator.com',
    'Ailis',
    'Crockatt',
    '4d0ae2fb373131382febedaeb4337d5e69554e043a1289bbd3f154150ad19bd6',
    'https://robohash.org/sintrecusandaererum.png?size=50x50&set=set1',
    '4009253555',
    '1631021185000',
    '1612782361000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    11,
    'crippera@github.io',
    'Cheston',
    'Ripper',
    '0eb45cf87830f2b088264b94963a746322d26f7723309839f1b2a6936b672c1c',
    'https://robohash.org/sedcorruptilabore.png?size=50x50&set=set1',
    '3321001518',
    '1617202640000',
    '1608751811000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12,
    'dklimusb@google.com.hk',
    'Dotty',
    'Klimus',
    '33b5ebbf55e14096505055c06de84432d43ab78a192ce945839f72a454a00fd1',
    'https://robohash.org/faceredoloremfuga.png?size=50x50&set=set1',
    '8953791814',
    '1630263722000',
    '1612445112000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    13,
    'bsavinec@techcrunch.com',
    'Bonnee',
    'Savine',
    'b042a48ccc67c2aa93506b31294d3e2612962a76607c17f583aeaab3517acce2',
    'https://robohash.org/itaquequinobis.png?size=50x50&set=set1',
    '2215023078',
    '1612157714000',
    '1633669413000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    14,
    'igrocuttd@typepad.com',
    'Ileane',
    'Grocutt',
    'f17a3ba9dc73fb5b42116e1da33f85085b019ef404f4db727afef8727263ddf2',
    'https://robohash.org/nonullamneque.png?size=50x50&set=set1',
    '8015560172',
    '1604776208000',
    '1629486396000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15,
    'dolerenshawe@dedecms.com',
    'Delphinia',
    'Olerenshaw',
    '206f18bf5af0e351a7b0c1ca15457d57c8cd4913ef78942bd982f8d20cc97788',
    'https://robohash.org/itaquemaiorestempore.png?size=50x50&set=set1',
    '8128249926',
    '1633792378000',
    '1613104209000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    16,
    'gsigsworthf@umn.edu',
    'Gregoor',
    'Sigsworth',
    '18aa9b13b21766d994412ecbe8bb26eb097ab036ddf17c645662a2fedbb8aed0',
    'https://robohash.org/indoloreest.png?size=50x50&set=set1',
    '8925216453',
    '1605482815000',
    '1618239496000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    17,
    'ebertholing@cbslocal.com',
    'Ellette',
    'Bertholin',
    'de1f58f5246e85a87fc8c2e71f92308a13ddc16e6f785f2765b5a061098d7b8b',
    'https://robohash.org/quamvelitodit.png?size=50x50&set=set1',
    '3984780876',
    '1619993080000',
    '1624899642000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    18,
    'ffinlaterh@europa.eu',
    'Farica',
    'Finlater',
    '3bae90cebd4f023c9ce934d2fe9013526f2977a4984fb22831acce8f84b3df0b',
    'https://robohash.org/dictaanimivoluptate.png?size=50x50&set=set1',
    '5206424637',
    '1616468349000',
    '1607274865000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    19,
    'jfatheri@dion.ne.jp',
    'Jarrod',
    'Father',
    '824fc8a57006154762876ad4e0f4949184133e54c6ca6fabce9d1fbc7797fd01',
    'https://robohash.org/doloremdolorumet.png?size=50x50&set=set1',
    '3458299176',
    '1607400390000',
    '1617824978000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    20,
    'pmcmeekinj@bing.com',
    'Phillipe',
    'Mc Meekin',
    '22643ae7e0956913ce8f57b99171011af4518ccae65f40e8fcaa70cc8011a143',
    'https://robohash.org/quiquinobis.png?size=50x50&set=set1',
    '4818188822',
    '1627413249000',
    '1620860148000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    21,
    'kbernardosk@shop-pro.jp',
    'Kristoffer',
    'Bernardos',
    'dad4faeab6e8d555784d6df8ea8e0bc2cd69b884a0bf5370f300952fc7726e1c',
    'https://robohash.org/rerumfacereeos.png?size=50x50&set=set1',
    '4182393098',
    '1629720409000',
    '1613378193000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    22,
    'dponderl@shutterfly.com',
    'Dill',
    'Ponder',
    '09973755bfc563079e594027894fc95d02df0c61a95d6f9f2c61f4826b129ade',
    'https://robohash.org/suscipiteain.png?size=50x50&set=set1',
    '7445181640',
    '1612934893000',
    '1612489465000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23,
    'ctiptaftm@webmd.com',
    'Connor',
    'Tiptaft',
    '897aaa3594746b48e400342d6dc74bb1da2d99a433740dde2afbbb7491185092',
    'https://robohash.org/facerequibusdameveniet.png?size=50x50&set=set1',
    '8889383239',
    '1622839243000',
    '1623123436000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    24,
    'nwhitseyn@theglobeandmail.com',
    'Nap',
    'Whitsey',
    '9949ae6a8ca22e0b7a408adec9eeae0f07721745479b775b2b51a9a9263e76b2',
    'https://robohash.org/etetassumenda.png?size=50x50&set=set1',
    '3704555217',
    '1618077852000',
    '1616871725000'
  );

INSERT INTO
  `pentesting`.`persons` (
    `id_person`,
    `email`,
    `first_name`,
    `last_name`,
    `password`,
    `avatar`,
    `phone`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    25,
    'sclausnero@globo.com',
    'Shamus',
    'Clausner',
    '546baf9a64e7ab510682f296183d25764b5543d68420bc450add159fde97b458',
    'https://robohash.org/veniamquiafugit.png?size=50x50&set=set1',
    '4884802456',
    '1629098619000',
    '1616345497000'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`role_types`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`role_types` (
    `id_role_type`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (1, 'global', 'Global role', NULL, NULL);

INSERT INTO
  `pentesting`.`role_types` (
    `id_role_type`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (2, 'project', 'Project role', NULL, NULL);

INSERT INTO
  `pentesting`.`role_types` (
    `id_role_type`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (3, 'development', 'Development role', NULL, NULL);

INSERT INTO
  `pentesting`.`role_types` (
    `id_role_type`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (4, 'demo', 'Demo role', NULL, NULL);

INSERT INTO
  `pentesting`.`role_types` (
    `id_role_type`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (5, 'testing', 'Testing role', NULL, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`roles`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`roles` (`id_role`, `name`, `title`, `id_role_type`)
VALUES
  (1, 'GlobalAdmin', 'Admin', 1);

INSERT INTO
  `pentesting`.`roles` (`id_role`, `name`, `title`, `id_role_type`)
VALUES
  (2, 'GlobalUser', 'User', 1);

INSERT INTO
  `pentesting`.`roles` (`id_role`, `name`, `title`, `id_role_type`)
VALUES
  (3, 'ProjectAdmin', 'Admin', 2);

INSERT INTO
  `pentesting`.`roles` (`id_role`, `name`, `title`, `id_role_type`)
VALUES
  (4, 'ProjectTester', 'Tester', 2);

INSERT INTO
  `pentesting`.`roles` (`id_role`, `name`, `title`, `id_role_type`)
VALUES
  (5, 'ProjectManager', 'Manager', 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`person2role`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (1, 1);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (2, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (3, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (4, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (5, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (6, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (7, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (8, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (9, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (10, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (11, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (12, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (13, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (14, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (15, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (16, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (17, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (18, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (19, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (20, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (21, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (22, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (23, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (24, 2);

INSERT INTO
  `pentesting`.`person2role` (`id_person`, `id_role`)
VALUES
  (25, 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`permissions`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`permissions` (
    `id_permission`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    'read',
    'Can read',
    '1605498603000',
    '1605498603000'
  );

INSERT INTO
  `pentesting`.`permissions` (
    `id_permission`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    'write',
    'Can write',
    '1605498603000',
    '1605498603000'
  );

INSERT INTO
  `pentesting`.`permissions` (
    `id_permission`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    'invite',
    'Can send invite',
    '1605498603000',
    '1605498603000'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`role2permission`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (1, 1);

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (2, 1);

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (3, 1);

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (4, 1);

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (5, 1);

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (1, 2);

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (3, 2);

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (4, 2);

INSERT INTO
  `pentesting`.`role2permission` (`id_role`, `id_permission`)
VALUES
  (2, 3);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`projects`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`projects` (
    `id_project`,
    `name`,
    `title`,
    `description`,
    `start`,
    `end`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    'but',
    'Brno University of Technology',
    'Pentesting main website',
    '2021-10-20',
    '2022-01-30',
    '1628520822700',
    '1628520822700'
  );

INSERT INTO
  `pentesting`.`projects` (
    `id_project`,
    `name`,
    `title`,
    `description`,
    `start`,
    `end`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    'muni',
    'Masaryk University',
    'Pentesting IS',
    '2021-09-10',
    '2022-01-11',
    '1628520142000',
    '1628520142000'
  );

INSERT INTO
  `pentesting`.`projects` (
    `id_project`,
    `name`,
    `title`,
    `description`,
    `start`,
    `end`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    'ctu',
    'Czech Technical University in Prague',
    'Staff Information System',
    '2021-08-23',
    '2021-12-12',
    '1628520222200',
    '1628520222200'
  );

INSERT INTO
  `pentesting`.`projects` (
    `id_project`,
    `name`,
    `title`,
    `description`,
    `start`,
    `end`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    'trello',
    'Trello',
    'App security audit',
    '2021-10-10',
    '2022-01-20',
    '1628520300000',
    '1628520300000'
  );

INSERT INTO
  `pentesting`.`projects` (
    `id_project`,
    `name`,
    `title`,
    `description`,
    `start`,
    `end`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    'mattermost',
    'Mattermost',
    'App pentesting',
    '2021-09-19',
    '2021-12-02',
    '1628520211000',
    '1628520211000'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`tasks`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    2,
    'user-permissions',
    'Scan system',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1626767285000',
    '1613674084000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    1,
    'scan-pages',
    'Scan all pages',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1624180026000',
    '1629640073000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    2,
    'test-file-uploads',
    'Test file uploads',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1604822179000',
    '1631771486000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    2,
    'test-user-permissions',
    'Test user permissions',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1633273382000',
    '1611778563000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    1,
    'test-login-registration-system',
    'Test login / registration system',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1634371224000',
    '1630942278000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    6,
    2,
    'test-brute-force',
    'Test brute force protection',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1611371147000',
    '1609297775000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    7,
    1,
    'map-libs',
    'Map libraries',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1627863703000',
    '1607872334000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    8,
    1,
    'misconfigs',
    'Check misconfiguration',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1608781746000',
    '1619946576000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9,
    2,
    'modules',
    'Test all modules',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1621733520000',
    '1618519016000'
  );

INSERT INTO
  `pentesting`.`tasks` (
    `id_task`,
    `id_project`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10,
    1,
    'sessions',
    'Session testing',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1611202919000',
    '1620333783000'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`documents`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (1, 1, 'JustoInBlandit.mp3');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (2, 1, 'In.mp3');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (3, 4, 'EstQuam.xls');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (4, 7, 'ElitProinRisus.gif');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (5, 12, 'AcConsequat.ppt');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (6, 25, 'Nam.xls');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (7, 13, 'In.tiff');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (8, 7, 'PraesentBlanditLacinia.avi');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (9, 19, 'Libero.avi');

INSERT INTO
  `pentesting`.`documents` (`id_document`, `id_person`, `name`)
VALUES
  (10, 20, 'NonVelit.ppt');

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`document2project`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`document2project` (`id_document`, `id_project`)
VALUES
  (1, 1);

INSERT INTO
  `pentesting`.`document2project` (`id_document`, `id_project`)
VALUES
  (2, 1);

INSERT INTO
  `pentesting`.`document2project` (`id_document`, `id_project`)
VALUES
  (3, 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`person2project`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (1, 1, 1, 1, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (2, 2, 1, 2, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (3, 3, 1, 2, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (4, 4, 2, 1, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (5, 5, 2, 2, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (6, 6, 2, 3, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (7, 7, 3, 1, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (8, 8, 1, 3, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (9, 9, 2, 3, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (10, 10, 3, 3, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (11, 11, 3, 4, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (12, 12, 4, 1, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (13, 13, 5, 1, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (14, 14, 5, 2, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (15, 15, 4, 2, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (16, 16, 4, 2, '1622223452000', '1614925986000');

INSERT INTO
  `pentesting`.`person2project` (
    `id_person2project`,
    `id_person`,
    `id_project`,
    `id_role`,
    `invited_at`,
    `joined_at`
  )
VALUES
  (17, 17, 1, 3, '1622223452000', '1614925986000');

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`categories`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`categories` (
    `id_category`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    'WebApp',
    'Website Application',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`categories` (
    `id_category`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    'MobileApp',
    'Mobile Application',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`categories` (
    `id_category`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    'Apache',
    'Apache HTTP Server',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`categories` (
    `id_category`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    'Nginx',
    'Nginx HTTP Server',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`categories` (
    `id_category`,
    `name`,
    `title`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    'WinServer2019',
    'Windows Server 2019',
    '1635078673',
    '1635078673'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`checklists`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    'ASVS 5.3.6f DOM based XSS',
    'Isn\'t it possible to inject and run HTML or JavaScript code while manipulating the DOM? ',
    'The purpose of this test is to verify that the application does not manipulate the tested input in such a way that it would move (copy) it to another place in the HTML document within the DOM and that it is not possible to inject your own HTML code or Javascript code into the HTML content.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    'ASVS 5.3.6d Javascript injection',
    'Isn\'t it possible to inject JavaScript code into dynamically executed content? ',
    'The purpose of this test is to verify that it is not possible to inject JavaScript code into the content which is then dynamically executed (for example, by using the eval function) on the client side (web browser). If the injection was successful, a Cross-Site Scripting (XSS) attack could be triggered.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    'ASVS 5.3.3 XSS protection',
    'Are unsafe output metacharacters treated to prevent XSS attacks? ',
    'The purpose of this test is to verify that the application applies metacharacter escaping to the output values, considering the specific output context (for example, whether it is a value of an HTML tag attribute, a content of a paired HTML tag, a value of an embedded JavaScript variable, etc.). The reason is to prevent attacks such as HTML injection and reflected, stored, or DOM-Based XSS.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    'ASVS 4.2.2a CSRF protection',
    'Are protection mechanisms against CRSF attacks implemented? ',
    'The purpose of this test is to verify that the application verifies the user\'s conscious intention for authorized requests on the server-side to prevent processing of such requests that users sent during a Cross-Site Request Forgery (CSRF) attack without their knowledge. The application must have such anti-CSRF protection implemented for authorized requests that can successfully prevent this type of attack. A suitable type of protection is, for example, adding a CSRF token between GET/POST parameters, or adding an HTTP authorization request header. Conversely, protection based on the value of the HTTP request header Referer, or the transfer of a CSRF token in the Cookie header, cannot be considered as suitable protection against CSRF attacks.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    'ASVS 5.3.4-5 SQLi protection',
    'Are SQL queries protected from SQL injection? ',
    'The purpose of this test is to verify that all database queries (including inserting new records, deleting records, or modifying existing values) use parameterized queries, ORM, Entity Framework, or are otherwise protected from SQL injection attacks.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    6,
    'MSTG-AUTH-1',
    'Testing Confirm Credentials',
    'The confirm credential flow is available since Android 6.0 and is used to ensure that users do not have to enter app-specific passwords together with the lock screen protection. Instead: if a user has logged in to the device recently, then confirm-credentials can be used to unlock cryptographic materials from the AndroidKeystore. That is, if the user unlocked the device within the set time limits (setUserAuthenticationValidityDurationSeconds), otherwise the device needs to be unlocked again.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    7,
    'Nginx Root',
    'Missing root location',
    'The root directive specifies the root folder for Nginx. In the above example, the root folder is /etc/nginx which means that we can reach files within that folder. The above configuration does not have a location for / (location / {...}), only for /hello.txt. Because of this, the root directive will be globally set, meaning that requests to / will take you to the local path /etc/nginx.   ',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    8,
    'Nginx Vars',
    'Unsafe variable use',
    'Some frameworks, scripts and Nginx configurations unsafely use the variables stored by Nginx. This can lead to issues such as XSS, bypassing HttpOnly-protection, information disclosure and in some cases even RCE.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9,
    'ASVS 2.1.2b Password truncat',
    'Isn\'t the entered password truncated to a specific size on the server side? ',
    'The purpose of this test is to verify that the truncation of the entered password is not performed on the server side and if so, what length is the entered password truncated to. Under no circumstances should the application truncate user\'s passwords. In case that the password truncation is performed on the server side, it is necessary to significantly notify the user about this fact.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`checklists` (
    `id_checklist`,
    `name`,
    `title`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10,
    'AD Brute Force',
    'Brute Force Active Directory',
    'To brute force attack on active directory, you can use Metasploit Framework auxiliaries. You can use below auxiliary:',
    '1635078673',
    '1635078673'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`checklist2category`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (1, 1);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (2, 1);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (3, 1);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (4, 1);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (5, 1);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (6, 2);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (7, 4);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (8, 4);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (9, 3);

INSERT INTO
  `pentesting`.`checklist2category` (`id_checklist`, `id_category`)
VALUES
  (10, 5);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`vulnerabilities`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`vulnerabilities` (
    `id_vulnerability`,
    `name`,
    `title`,
    `cve`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    'WP-CSSR-4-9',
    'WordPress 4.9.x Cross-Site Request Forgery (4.9 - 4.9.9)',
    'CVE-2019-9787',
    'WordPress is prone to a cross-site request forgery vulnerability. Exploiting this issue may allow a remote attacker to perform certain administrative actions and gain unauthorized access to the affected application; other attacks are also possible. WordPress versions 4.9.x ranging from 4.9 and up to (and including) 4.9.9 are vulnerable.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`vulnerabilities` (
    `id_vulnerability`,
    `name`,
    `title`,
    `cve`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    'WP-CSSR-5',
    'WordPress 5.x Cross-Site Request Forgery',
    'CVE-2019-9787',
    'WordPress is prone to a cross-site request forgery vulnerability. Exploiting this issue may allow a remote attacker to perform certain administrative actions and gain unauthorized access to the affected application; other attacks are also possible. WordPress versions 5.0.x ranging from 5.0 and up to (and including) 5.0.3 are vulnerable.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`vulnerabilities` (
    `id_vulnerability`,
    `name`,
    `title`,
    `cve`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    'http-parameter-pollution',
    'HTTP Parameter Pollution Vulnerabilities',
    'CVE-2019-4271',
    'IBM WebSphere Application Server 7.0, 8.0, 8.5, and 9.0 Admin console is vulnerable to a Client-side HTTP parameter pollution vulnerability. IBM X-Force ID: 160243.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`vulnerabilities` (
    `id_vulnerability`,
    `name`,
    `title`,
    `cve`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    'angularjs-remote-code-execution',
    'AngularJS Remote Code Execution',
    'CVE-2021-21277',
    'angular-expressions is \"angular\'s nicest part extracted as a standalone module for the browser and node\". In angular-expressions before version 1.1.2 there is a vulnerability which allows Remote Code Execution if you call \"expressions.compile(userControlledInput)\" where \"userControlledInput\" is text that comes from user input. The security of the package could be bypassed by using a more complex payload, using a \".constructor.constructor\" technique. In terms of impact: If running angular-expressions in the browser, an attacker could run any browser script when the application code calls expressions.compile(userControlledInput). If running angular-expressions on the server, an attacker could run any Javascript expression, thus gaining Remote Code Execution. This is fixed in version 1.1.2 of angular-expressions A temporary workaround might be either to disable user-controlled input that will be fed into angular-expressions in your application or allow only following characters in the userControlledInput.',
    '1635078673',
    '1635078673'
  );

INSERT INTO
  `pentesting`.`vulnerabilities` (
    `id_vulnerability`,
    `name`,
    `title`,
    `cve`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    'WPForms-Contact-Form',
    'WPForms Contact Form XSS',
    'CVE-2020-10385',
    'A stored cross-site scripting (XSS) vulnerability exists in the WPForms Contact Form (aka wpforms-lite) plugin before 1.5.9 for WordPress.',
    '1635078673',
    '1635078673'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`targets`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    5,
    'ronstring',
    'Daltfresh',
    'wordpress.com',
    'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo.',
    '1628520242000',
    '1633002978000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    5,
    'vagram',
    'Konklab',
    'latimes.com',
    'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.',
    '1630878978000',
    '1613970144000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    1,
    'sonair',
    'Fixflex',
    'wp.com',
    'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.',
    '1617388362000',
    '1625133347000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    3,
    'sonsing',
    'Sonair',
    'topsy.com',
    'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.',
    '1628883583000',
    '1614909470000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    5,
    'zaam-dox',
    'Asoka',
    'w3.org',
    'Integer ac leo. Pellentesque ultrices mattis odio.',
    '1617856747000',
    '1606152865000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    6,
    3,
    'transcof',
    'Zathin',
    'photobucket.com',
    'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.',
    '1607707436000',
    '1622043151000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    7,
    4,
    'it',
    'Namfix',
    'bravesites.com',
    'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',
    '1624595194000',
    '1604061459000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    8,
    5,
    'cookley',
    'Wrapsafe',
    'google.co.uk',
    'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.',
    '1616431210000',
    '1614098269000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9,
    4,
    'transcof',
    'Hatity',
    'usa.gov',
    'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.',
    '1624399758000',
    '1612788034000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10,
    4,
    'flexidy',
    'Bytecard',
    'purevolume.com',
    'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',
    '1609051445000',
    '1631585239000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    11,
    2,
    'holdlamis',
    'Zoolab',
    'home.pl',
    'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.',
    '1621398312000',
    '1624010138000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12,
    4,
    'kanlam',
    'Andalax',
    'discuz.net',
    'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',
    '1614779388000',
    '1604610714000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    13,
    4,
    'bytecard',
    'Stringtough',
    'hao123.com',
    'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.',
    '1621613819000',
    '1621681917000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    14,
    3,
    'flexidy',
    'Matsoft',
    'scientificamerican.com',
    'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.',
    '1619645340000',
    '1616240147000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15,
    4,
    'rank',
    'Span',
    'free.fr',
    'In hac habitasse platea dictumst.',
    '1617810101000',
    '1623002451000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    16,
    4,
    'quo lux',
    'Hatity',
    'toplist.cz',
    'Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.',
    '1628416659000',
    '1605410398000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    17,
    4,
    'tempsoft',
    'Fixflex',
    'samsung.com',
    'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.',
    '1608585014000',
    '1617476209000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    18,
    1,
    'namfix',
    'Flexidy',
    'census.gov',
    'Sed sagittis.',
    '1623460456000',
    '1633161173000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    19,
    3,
    'bytecard',
    'Regrant',
    'discuz.net',
    'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.',
    '1612249368000',
    '1606623544000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    20,
    4,
    'stronghold',
    'Zontrax',
    't-online.de',
    'Maecenas rhoncus aliquam lacus.',
    '1629425941000',
    '1630493638000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    21,
    4,
    'fixflex',
    'Keylex',
    'wix.com',
    'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.',
    '1612167656000',
    '1630414723000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    22,
    4,
    'daltfresh',
    'Tres-Zap',
    'rakuten.co.jp',
    'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.',
    '1615173450000',
    '1622000125000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23,
    5,
    'prodder',
    'Latlux',
    'wp.com',
    'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.',
    '1616859619000',
    '1616251501000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    24,
    4,
    'andalax',
    'Zathin',
    'indiegogo.com',
    'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.',
    '1613638410000',
    '1617815108000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    25,
    4,
    'bitchip',
    'Bytecard',
    'seattletimes.com',
    'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.',
    '1605918599000',
    '1609599757000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    26,
    4,
    'toughjoyfax',
    'Trippledex',
    'diigo.com',
    'Nulla ut erat id mauris vulputate elementum.',
    '1618222736000',
    '1612931885000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27,
    2,
    'veribet',
    'Zoolab',
    'hibu.com',
    'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.',
    '1632721175000',
    '1630115118000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28,
    3,
    'gembucket',
    'Hatity',
    'so-net.ne.jp',
    'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.',
    '1615149849000',
    '1622789281000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    29,
    2,
    'domainer',
    'Pannier',
    'statcounter.com',
    'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.',
    '1626773717000',
    '1607414571000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    30,
    2,
    'lotlux',
    'Holdlamis',
    'youku.com',
    'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.',
    '1609964086000',
    '1611613143000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    31,
    3,
    'y-solowarm',
    'Veribet',
    'hexun.com',
    'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.',
    '1613547662000',
    '1623930688000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    32,
    4,
    'zontrax',
    'Tresom',
    'spotify.com',
    'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.',
    '1621769215000',
    '1621788153000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    33,
    3,
    'tin',
    'Gembucket',
    'ezinearticles.com',
    'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.',
    '1613667057000',
    '1623683443000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    34,
    4,
    'voltsillam',
    'Lotstring',
    'reddit.com',
    'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.',
    '1615903266000',
    '1609250874000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    35,
    1,
    'opela',
    'Veribet',
    'delicious.com',
    'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.',
    '1624068909000',
    '1611939057000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    36,
    1,
    'stringtough',
    'Redhold',
    'meetup.com',
    'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.',
    '1617523164000',
    '1627250091000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    37,
    1,
    'fix san',
    'Sonsing',
    'twitpic.com',
    'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.',
    '1603528183000',
    '1632238197000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    38,
    4,
    'wrapsafe',
    'Zamit',
    'cisco.com',
    'Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.',
    '1619706494000',
    '1611415299000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    39,
    3,
    'holdlamis',
    'Stronghold',
    'china.com.cn',
    'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.',
    '1617637790000',
    '1626077073000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    40,
    1,
    'sonsing',
    'Sub-Ex',
    'hc360.com',
    'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.',
    '1617910945000',
    '1632002942000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    41,
    5,
    'matsoft',
    'Opela',
    'gov.uk',
    'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.',
    '1608405067000',
    '1605487645000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    42,
    2,
    'cardguard',
    'Span',
    'msu.edu',
    'Morbi a ipsum.',
    '1624630462000',
    '1620562826000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    43,
    5,
    'tampflex',
    'Trippledex',
    'mac.com',
    'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.',
    '1618560091000',
    '1634723650000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    44,
    1,
    'cardify',
    'Aerified',
    'sohu.com',
    'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.',
    '1611641108000',
    '1618614951000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    45,
    3,
    'temp',
    'Alpha',
    'apache.org',
    'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
    '1626652757000',
    '1632882900000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    46,
    5,
    'tempsoft',
    'Tin',
    'ow.ly',
    'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.',
    '1605746595000',
    '1629897341000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    47,
    1,
    'fintone',
    'Voyatouch',
    'theglobeandmail.com',
    'Nulla suscipit ligula in lacus.',
    '1631543657000',
    '1604828584000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    48,
    3,
    'ventosanzap',
    'Viva',
    'comcast.net',
    'Ut tellus.',
    '1634339999000',
    '1613251379000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    49,
    5,
    'trippledex',
    'Zontrax',
    'google.pl',
    'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.',
    '1622033305000',
    '1609409865000'
  );

INSERT INTO
  `pentesting`.`targets` (
    `id_target`,
    `id_category`,
    `name`,
    `title`,
    `address`,
    `description`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    50,
    5,
    'wrapsafe',
    'Viva',
    'mozilla.com',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',
    '1614964178000',
    '1630101245000'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`vulnerability2target`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`vulnerability2target` (`id_vulnerability`, `id_target`)
VALUES
  (3, 2);

INSERT INTO
  `pentesting`.`vulnerability2target` (`id_vulnerability`, `id_target`)
VALUES
  (4, 1);

INSERT INTO
  `pentesting`.`vulnerability2target` (`id_vulnerability`, `id_target`)
VALUES
  (3, 3);

INSERT INTO
  `pentesting`.`vulnerability2target` (`id_vulnerability`, `id_target`)
VALUES
  (1, 2);

INSERT INTO
  `pentesting`.`vulnerability2target` (`id_vulnerability`, `id_target`)
VALUES
  (1, 3);

INSERT INTO
  `pentesting`.`vulnerability2target` (`id_vulnerability`, `id_target`)
VALUES
  (2, 4);

INSERT INTO
  `pentesting`.`vulnerability2target` (`id_vulnerability`, `id_target`)
VALUES
  (4, 5);

INSERT INTO
  `pentesting`.`vulnerability2target` (`id_vulnerability`, `id_target`)
VALUES
  (1, 5);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`person2project2task`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (1, 2);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (2, 2);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (1, 5);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (1, 7);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (1, 8);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (1, 10);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (2, 5);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (2, 7);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (2, 8);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (2, 10);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (4, 4);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (4, 6);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (4, 9);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (5, 4);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (5, 6);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (5, 9);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (6, 4);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (6, 6);

INSERT INTO
  `pentesting`.`person2project2task` (`id_person2project`, `id_task`)
VALUES
  (6, 9);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`target2task`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (1, 1);

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (2, 1);

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (3, 2);

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (4, 1);

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (5, 2);

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (6, 2);

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (7, 1);

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (8, 1);

INSERT INTO
  `pentesting`.`target2task` (`id_target`, `id_task`)
VALUES
  (9, 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`meta`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    1,
    'application/pdf',
    '9207',
    '1622223452000',
    '1614925986000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    2,
    'application/mspowerpoint',
    '4709',
    '1615969284000',
    '1611612823000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    3,
    'image/x-tiff',
    '9980',
    '1609849625000',
    '1629797809000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    4,
    'image/pjpeg',
    '4532',
    '1615276279000',
    '1627648114000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    5,
    'image/tiff',
    '4021',
    '1612124172000',
    '1603746844000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    6,
    6,
    'image/pjpeg',
    '7468',
    '1604089719000',
    '1619642514000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    7,
    7,
    'application/pdf',
    '7001',
    '1625575175000',
    '1632124625000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    8,
    8,
    'audio/mpeg3',
    '4622',
    '1610708162000',
    '1627734900000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9,
    9,
    'application/x-excel',
    '6312',
    '1627622033000',
    '1618597045000'
  );

INSERT INTO
  `pentesting`.`meta` (
    `id_meta`,
    `id_document`,
    `type`,
    `size`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10,
    10,
    'application/x-msexcel',
    '8750',
    '1624529150000',
    '1605031443000'
  );

COMMIT;

-- -----------------------------------------------------
-- Data for table `pentesting`.`logs`
-- -----------------------------------------------------
START TRANSACTION;

USE `pentesting`;

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (1, 12, 'Sed accumsan felis.', '1634377017000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    2,
    16,
    'Suspendisse accumsan tortor quis turpis.',
    '1628896713000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (3, 20, 'Integer non velit.', '1625475215000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    4,
    17,
    'Nulla ut erat id mauris vulputate elementum.',
    '1615622862000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (5, 24, 'Vivamus tortor.', '1630855731000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    6,
    15,
    'Nam tristique tortor eu pede.',
    '1620805236000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    7,
    18,
    'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.',
    '1622259605000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    8,
    4,
    'Praesent blandit lacinia erat.',
    '1634600623000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    9,
    8,
    'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.',
    '1606162591000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (10, 6, 'Mauris sit amet eros.', '1613326057000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    11,
    1,
    'Quisque porta volutpat erat.',
    '1627565263000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (12, 20, 'Nam dui.', '1613115843000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    13,
    25,
    'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.',
    '1631231085000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    14,
    21,
    'In hac habitasse platea dictumst.',
    '1628636040000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    15,
    18,
    'Nullam sit amet turpis elementum ligula vehicula consequat.',
    '1612863247000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    16,
    8,
    'Phasellus id sapien in sapien iaculis congue.',
    '1619693423000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    17,
    15,
    'Curabitur at ipsum ac tellus semper interdum.',
    '1608673431000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (18, 21, 'Ut tellus.', '1623932173000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (19, 4, 'Praesent blandit.', '1609313455000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    20,
    3,
    'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',
    '1632706455000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (21, 16, 'Fusce consequat.', '1619906061000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (22, 12, 'Etiam vel augue.', '1613354690000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (23, 16, 'Nulla facilisi.', '1609845909000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    24,
    21,
    'Nullam molestie nibh in lectus.',
    '1632382510000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    25,
    14,
    'Donec quis orci eget orci vehicula condimentum.',
    '1612363227000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (26, 23, 'Donec dapibus.', '1626196076000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    27,
    14,
    'Proin interdum mauris non ligula pellentesque ultrices.',
    '1608028898000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    28,
    22,
    'Donec semper sapien a libero.',
    '1613827083000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (29, 8, 'Integer ac leo.', '1620517310000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (30, 1, 'Nulla facilisi.', '1617179618000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    31,
    6,
    'Fusce posuere felis sed lacus.',
    '1613487470000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    32,
    24,
    'Cras pellentesque volutpat dui.',
    '1616316414000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    33,
    6,
    'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
    '1607079853000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    34,
    1,
    'Nunc rhoncus dui vel sem.',
    '1604063229000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (35, 10, 'Mauris sit amet eros.', '1633814277000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (36, 14, 'Nullam varius.', '1605734971000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    37,
    25,
    'Suspendisse ornare consequat lectus.',
    '1634258015000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    38,
    3,
    'Aliquam quis turpis eget elit sodales scelerisque.',
    '1629058493000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    39,
    18,
    'Nam tristique tortor eu pede.',
    '1632099419000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    40,
    22,
    'Maecenas pulvinar lobortis est.',
    '1610380038000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (41, 16, 'Curabitur convallis.', '1606064683000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    42,
    12,
    'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',
    '1625726704000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    43,
    21,
    'Duis mattis egestas metus.',
    '1615831460000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    44,
    15,
    'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.',
    '1608900883000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (45, 19, 'Duis bibendum.', '1607285709000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    46,
    21,
    'Integer tincidunt ante vel ipsum.',
    '1613403156000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (47, 9, 'Praesent lectus.', '1612992158000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    48,
    6,
    'Aliquam sit amet diam in magna bibendum imperdiet.',
    '1613512183000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    49,
    9,
    'Vestibulum sed magna at nunc commodo placerat.',
    '1613711375000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    50,
    25,
    'Cras non velit nec nisi vulputate nonummy.',
    '1633441902000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    51,
    15,
    'Maecenas tincidunt lacus at velit.',
    '1632189570000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    52,
    2,
    'Nulla ut erat id mauris vulputate elementum.',
    '1617225600000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    53,
    19,
    'Maecenas pulvinar lobortis est.',
    '1607439456000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    54,
    25,
    'Pellentesque at nulla.',
    '1622163928000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    55,
    25,
    'Nullam sit amet turpis elementum ligula vehicula consequat.',
    '1611881243000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    56,
    20,
    'Ut at dolor quis odio consequat varius.',
    '1606594513000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    57,
    22,
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1627888892000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    58,
    22,
    'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',
    '1629608073000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    59,
    22,
    'Duis mattis egestas metus.',
    '1625200532000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    60,
    16,
    'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',
    '1609436337000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    61,
    8,
    'Aliquam quis turpis eget elit sodales scelerisque.',
    '1619426874000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (62, 19, 'Nulla tempus.', '1625706885000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    63,
    17,
    'Donec posuere metus vitae ipsum.',
    '1624739868000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (64, 24, 'Nulla justo.', '1630617728000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    65,
    18,
    'Pellentesque eget nunc.',
    '1627446775000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    66,
    22,
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    '1622422986000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    67,
    21,
    'Nunc rhoncus dui vel sem.',
    '1624698216000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (68, 6, 'Integer non velit.', '1625886370000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    69,
    19,
    'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.',
    '1626394332000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    70,
    25,
    'Duis mattis egestas metus.',
    '1617889028000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (71, 7, 'Praesent lectus.', '1635020162000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (72, 15, 'Integer ac neque.', '1621305854000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    73,
    25,
    'Maecenas tincidunt lacus at velit.',
    '1609883710000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (74, 5, 'Sed sagittis.', '1607332877000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    75,
    16,
    'Aliquam sit amet diam in magna bibendum imperdiet.',
    '1628254037000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    76,
    10,
    'Cras pellentesque volutpat dui.',
    '1629556261000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    77,
    12,
    'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',
    '1632028817000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    78,
    10,
    'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.',
    '1603554086000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    79,
    24,
    'Vestibulum ac est lacinia nisi venenatis tristique.',
    '1609155777000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    80,
    25,
    'Maecenas tincidunt lacus at velit.',
    '1631900107000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    81,
    7,
    'Suspendisse ornare consequat lectus.',
    '1612502296000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    82,
    17,
    'Suspendisse ornare consequat lectus.',
    '1631481990000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    83,
    15,
    'Curabitur in libero ut massa volutpat convallis.',
    '1624263178000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    84,
    7,
    'Cras in purus eu magna vulputate luctus.',
    '1612127257000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (85, 17, 'Ut tellus.', '1609458370000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    86,
    9,
    'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
    '1628157258000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    87,
    24,
    'Nulla suscipit ligula in lacus.',
    '1603936115000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (88, 3, 'Phasellus in felis.', '1623172985000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    89,
    6,
    'Suspendisse ornare consequat lectus.',
    '1620164978000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (90, 4, 'Duis bibendum.', '1609243272000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (91, 14, 'Duis ac nibh.', '1612940801000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    92,
    16,
    'Vivamus in felis eu sapien cursus vestibulum.',
    '1630277842000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (93, 16, 'Suspendisse potenti.', '1630603398000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    94,
    10,
    'Aenean sit amet justo.',
    '1605747745000'
  );

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (95, 1, 'Ut tellus.', '1609556023000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (96, 25, 'Phasellus in felis.', '1623117468000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (97, 4, 'Duis ac nibh.', '1608989379000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (98, 13, 'Donec vitae nisi.', '1625716059000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (99, 15, 'Suspendisse potenti.', '1630056544000');

INSERT INTO
  `pentesting`.`logs` (`id_log`, `id_person`, `event`, `timestamp`)
VALUES
  (
    100,
    22,
    'Vivamus vestibulum sagittis sapien.',
    '1628507552000'
  );

COMMIT;