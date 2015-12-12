CREATE TABLE IF NOT EXISTS `retro_grantdb_2004_new`.`patent` (
  `id` varchar(20) NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `abstract` text CHARACTER SET utf8mb4,
  `title` text CHARACTER SET utf8mb4,
  `kind` varchar(10) DEFAULT NULL,
  `num_claims` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pat_idx1` (`type`,`number`),
  KEY `pat_idx2` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `retro_grantdb_2004_new`.`patent_description` (
  `id` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `briefsummarydescription` text CHARACTER SET utf8mb4,
  `briefdescriptiondrawings` text CHARACTER SET utf8mb4,
  `detaileddescription` longtext CHARACTER SET utf8mb4,
  `otherpatentrelations` text CHARACTER SET utf8mb4,
  PRIMARY KEY (`id`),
  KEY `patent_id` (`patent_id`),
  CONSTRAINT `patent_description_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `retro_grantdb_2004_new`.`rawlocation` (
  `id` varchar(256) NOT NULL,
  `location_id` varchar(256) DEFAULT NULL,
  `city` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `ix_rawlocation_state` (`state`),
  KEY `loc_idx1` (`city`,`state`,`country`),
  KEY `ix_rawlocation_country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `retro_grantdb_2004_new`.`rawinventor` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `inventor_id` varchar(36) DEFAULT NULL,
  `rawlocation_id` varchar(256) DEFAULT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `inventor_id` (`inventor_id`),
  KEY `rawlocation_id` (`rawlocation_id`),
  KEY `ix_rawinventor_sequence` (`sequence`),
  CONSTRAINT `rawinventor_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `rawinventor_ibfk_3` FOREIGN KEY (`rawlocation_id`) REFERENCES `rawlocation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `retro_grantdb_2004_new`.`rawassignee` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `assignee_id` varchar(36) DEFAULT NULL,
  `rawlocation_id` varchar(256) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `organization` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `residence` varchar(10) DEFAULT NULL,
  `nationality` varchar(10) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `assignee_id` (`assignee_id`),
  KEY `rawlocation_id` (`rawlocation_id`),
  KEY `ix_rawassignee_sequence` (`sequence`),
  CONSTRAINT `rawassignee_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `rawassignee_ibfk_3` FOREIGN KEY (`rawlocation_id`) REFERENCES `rawlocation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `retro_grantdb_2004_new`.`rawlawyer` (
  `uuid` varchar(36) NOT NULL,
  `lawyer_id` varchar(36) DEFAULT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `organization` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `lawyer_id` (`lawyer_id`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_rawlawyer_sequence` (`sequence`),
  CONSTRAINT `rawlawyer_ibfk_2` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `retro_grantdb_2004_new`.`application` (
  `id` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patent_id` (`patent_id`),
  KEY `app_idx1` (`type`,`number`),
  KEY `app_idx2` (`date`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
