-- CREATE DATABASE  IF NOT EXISTS `grantdb_1975_2004_updated` -- /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `grantdb_1975_2004_updated`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: grantdb_2014
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.12.04.1

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
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application` (
  `uuid` varchar(36) NOT NULL,
  `application_id` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`uuid`), 
  KEY `patent_id` (`patent_id`),
  KEY `app_idx1` (`type`,`number`),
  KEY `app_idx2` (`date`)/*,
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)*/
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assignee`
--

DROP TABLE IF EXISTS `assignee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignee` (
  `id` varchar(36) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `organization` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `residence` varchar(10) DEFAULT NULL,
  `nationality` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `claim`
--

DROP TABLE IF EXISTS `claim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `claim` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `text` text CHARACTER SET utf8mb4,
  `dependent` int(11) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_claim_sequence` (`sequence`) /*,
  CONSTRAINT `claim_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)*/
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `foreigncitation`
--

DROP TABLE IF EXISTS `foreigncitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foreigncitation` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `kind` varchar(10) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  `FREF_OCL` VARCHAR(255) DEFAULT NULL,
  `FREF_ICL` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `foreigncitation_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`)*/
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventor`
--

DROP TABLE IF EXISTS `inventor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventor` (
  `id` varchar(36) NOT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ipcr`
--

DROP TABLE IF EXISTS `ipcr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipcr` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `classification_level` varchar(20) DEFAULT NULL,
  `section` varchar(20) DEFAULT NULL,
  `subclass` varchar(20) DEFAULT NULL,
  `main_group` varchar(20) DEFAULT NULL,
  `subgroup` varchar(20) DEFAULT NULL,
  `symbol_position` varchar(20) DEFAULT NULL,
  `classification_value` varchar(20) DEFAULT NULL,
  `classification_status` varchar(20) DEFAULT NULL,
  `classification_data_source` varchar(20) DEFAULT NULL,
  `action_date` date DEFAULT NULL,
  `ipc_version_indicator` date DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_ipcr_sequence` (`sequence`),
  KEY `ix_ipcr_action_date` (`action_date`),
  KEY `ix_ipcr_ipc_version_indicator` (`ipc_version_indicator`) /*,
  CONSTRAINT `ipcr_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lawyer`
--

DROP TABLE IF EXISTS `lawyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lawyer` (
  `id` varchar(36) NOT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `organization` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` varchar(256) NOT NULL,
  `city` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dloc_idx2` (`city`,`state`,`country`),
  KEY `ix_location_country` (`country`),
  KEY `ix_location_state` (`state`),
  KEY `dloc_idx1` (`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_assignee`
--

DROP TABLE IF EXISTS `location_assignee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_assignee` (
  `location_id` varchar(256) DEFAULT NULL,
  `assignee_id` varchar(36) DEFAULT NULL,
  KEY `location_id` (`location_id`),
  KEY `assignee_id` (`assignee_id`) /*,
  CONSTRAINT `location_assignee_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `location_assignee_ibfk_2` FOREIGN KEY (`assignee_id`) REFERENCES `assignee` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_inventor`
--

DROP TABLE IF EXISTS `location_inventor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_inventor` (
  `location_id` varchar(256) DEFAULT NULL,
  `inventor_id` varchar(36) DEFAULT NULL,
  KEY `location_id` (`location_id`),
  KEY `inventor_id` (`inventor_id`) /*,
  CONSTRAINT `location_inventor_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `location_inventor_ibfk_2` FOREIGN KEY (`inventor_id`) REFERENCES `inventor` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mainclass`
--

DROP TABLE IF EXISTS `mainclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mainclass` (
  `id` varchar(20) NOT NULL,
  `title` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `text` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otherreference`
--

DROP TABLE IF EXISTS `otherreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otherreference` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `text` text CHARACTER SET utf8mb4,
  `sequence` int(11) DEFAULT NULL,
  `OREF_TEXT` text CHARACTER SET utf8mb4, 
  `GOVT_TEXT` text CHARACTER SET utf8mb4, 
  `PARN_TEXT` text CHARACTER SET utf8mb4, 
  `DRWD_TEXT` text CHARACTER SET utf8mb4, 
  `DETD_TEXT` text CHARACTER SET utf8mb4, 
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `otherreference_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patent`
--

DROP TABLE IF EXISTS `patent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patent` (
  `id` varchar(20) NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `abstract` text CHARACTER SET utf8mb4,
  `title` text CHARACTER SET utf8mb4,
  `kind` varchar(10) DEFAULT NULL,
  `num_claims` int(11) DEFAULT NULL,
  `PATN_SRC` int(11) DEFAULT NULL,
  `PATN_ART` varchar(3) DEFAULT NULL,
  `PATN_ECL` varchar(14) DEFAULT NULL,
  `PATN_EXP` VARCHAR(500) DEFAULT NULL,
  `PATN_PBL` varchar(1) DEFAULT NULL,
  `PATN_EXA` VARCHAR(500) DEFAULT NULL,
  `PATN_NDR` int(11) DEFAULT NULL,
  `PATN_NFG` int(11) DEFAULT NULL,
  `PATN_DCD` date DEFAULT NULL,
  `PATN_NPS` int(11) DEFAULT NULL,
  `PATN_TRM` text CHARACTER SET utf8mb4,
  `PATN_CLMS_STM` text CHARACTER SET utf8mb4,
  `PATN_ISSUE_YEAR` int(11) DEFAULT NULL,
  `NUM_INVTS` int(11) DEFAULT NULL,
  `NUM_ASSGS` int(11) DEFAULT NULL,
  `NUM_CITETO` int(11) DEFAULT NULL,
  `NUM_CITEBY_19762000` int(11) DEFAULT NULL,
  `NUM_OTHERREF` int(11) DEFAULT NULL,
  `NUM_FWD1` int(11) DEFAULT NULL,
  `NUM_FWD3` int(11) DEFAULT NULL,
  `NUM_FWD5` int(11) DEFAULT NULL,
  `NUM_BACK1` int(11) DEFAULT NULL,
  `NUM_BACK3` int(11) DEFAULT NULL,
  `NUM_BACK5` int(11) DEFAULT NULL,
  `FORMAT_OCL` VARCHAR(255) DEFAULT NULL,
  `FORMAT_XCL` VARCHAR(255) DEFAULT NULL,
  `FORMAT_ICL` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pat_idx1` (`type`,`number`),
  KEY `pat_idx2` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patent_assignee`
--

DROP TABLE IF EXISTS `patent_assignee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patent_assignee` (
  `patent_id` varchar(20) DEFAULT NULL,
  `assignee_id` varchar(36) DEFAULT NULL,
  KEY `patent_id` (`patent_id`),
  KEY `assignee_id` (`assignee_id`) /*,
  CONSTRAINT `patent_assignee_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `patent_assignee_ibfk_2` FOREIGN KEY (`assignee_id`) REFERENCES `assignee` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patent_description`
--

DROP TABLE IF EXISTS `patent_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patent_description` (
  `id` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `briefsummarydescription` text CHARACTER SET utf8mb4,
  `briefdescriptiondrawings` text CHARACTER SET utf8mb4,
  `detaileddescription` longtext CHARACTER SET utf8mb4,
  `otherpatentrelations` text CHARACTER SET utf8mb4,
  PRIMARY KEY (`id`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `patent_description_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patent_inventor`
--

DROP TABLE IF EXISTS `patent_inventor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patent_inventor` (
  `patent_id` varchar(20) DEFAULT NULL,
  `inventor_id` varchar(36) DEFAULT NULL,
  KEY `patent_id` (`patent_id`),
  KEY `inventor_id` (`inventor_id`) /*,
  CONSTRAINT `patent_inventor_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `patent_inventor_ibfk_2` FOREIGN KEY (`inventor_id`) REFERENCES `inventor` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patent_lawyer`
--

DROP TABLE IF EXISTS `patent_lawyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patent_lawyer` (
  `patent_id` varchar(20) DEFAULT NULL,
  `lawyer_id` varchar(36) DEFAULT NULL,
  KEY `patent_id` (`patent_id`),
  KEY `lawyer_id` (`lawyer_id`) /*,
  CONSTRAINT `patent_lawyer_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `patent_lawyer_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyer` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawassignee`
--

DROP TABLE IF EXISTS `rawassignee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rawassignee` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `assignee_id` varchar(36) DEFAULT NULL,
  `rawlocation_id` varchar(256) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `organization` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `residence` varchar(10) DEFAULT NULL,
  `nationality` varchar(10) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `assignee_id` (`assignee_id`),
  KEY `rawlocation_id` (`rawlocation_id`),
  KEY `ix_rawassignee_sequence` (`sequence`) /*,
  CONSTRAINT `rawassignee_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `rawassignee_ibfk_2` FOREIGN KEY (`assignee_id`) REFERENCES `assignee` (`id`),
  CONSTRAINT `rawassignee_ibfk_3` FOREIGN KEY (`rawlocation_id`) REFERENCES `rawlocation` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawinventor`
--

DROP TABLE IF EXISTS `rawinventor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rawinventor` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `inventor_id` varchar(36) DEFAULT NULL,
  `rawlocation_id` varchar(256) DEFAULT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `inventor_id` (`inventor_id`),
  KEY `rawlocation_id` (`rawlocation_id`),
  KEY `ix_rawinventor_sequence` (`sequence`) /*,
  CONSTRAINT `rawinventor_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`),
  CONSTRAINT `rawinventor_ibfk_2` FOREIGN KEY (`inventor_id`) REFERENCES `inventor` (`id`),
  CONSTRAINT `rawinventor_ibfk_3` FOREIGN KEY (`rawlocation_id`) REFERENCES `rawlocation` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawlawyer`
--

DROP TABLE IF EXISTS `rawlawyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rawlawyer` (
  `uuid` varchar(36) NOT NULL,
  `lawyer_id` varchar(36) DEFAULT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `name_first` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name_last` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `organization` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  `LREP_FRM` varchar(255),
  `LREP_FR2` varchar(255),
  `LREP_AAT` varchar(255),
  `LREP_AGT` varchar(255),
  `LREP_ATT` varchar(255),
  `LREP_REG` varchar(6),
  `LREP_NAM` varchar(255),
  `LREP_STR` varchar(255),
  `LREP_CTY` varchar(255),
  `LREP_STA` varchar(2),
  `LREP_CNT` varchar(3),
  `LREP_ZIP` varchar(5),
  PRIMARY KEY (`uuid`),
  KEY `lawyer_id` (`lawyer_id`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_rawlawyer_sequence` (`sequence`) /*,
  CONSTRAINT `rawlawyer_ibfk_1` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyer` (`id`),
  CONSTRAINT `rawlawyer_ibfk_2` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawlocation`
--

DROP TABLE IF EXISTS `rawlocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rawlocation` (
  `id` varchar(256) NOT NULL,
  `location_id` varchar(256) DEFAULT NULL,
  `city` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `ix_rawlocation_state` (`state`),
  KEY `loc_idx1` (`city`,`state`,`country`),
  KEY `ix_rawlocation_country` (`country`) /*,
  CONSTRAINT `rawlocation_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subclass`
--

DROP TABLE IF EXISTS `subclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subclass` (
  `id` varchar(300) NOT NULL,
  `title` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `text` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temporary_update`
--

DROP TABLE IF EXISTS `temporary_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temporary_update` (
  `pk` varchar(36) NOT NULL,
  `update` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `ix_temporary_update_update` (`update`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usapplicationcitation`
--

DROP TABLE IF EXISTS `usapplicationcitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usapplicationcitation` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `application_id` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `kind` varchar(10) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  `RLAP_COD` CHAR(2),
  `RLAP_APN` CHAR(6),
  `RLAP_PSC` CHAR(2),
  `RLAP_APD` DATE,
  `RLAP_PNO` CHAR(9),
  `RLAP_ISD` DATE,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_usapplicationcitation_application_id` (`application_id`) /*,
  CONSTRAINT `usapplicationcitation_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uspatentcitation`
--

DROP TABLE IF EXISTS `uspatentcitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uspatentcitation` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `citation_id` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `kind` varchar(10) DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  `UREF_OCL` VARCHAR(255) DEFAULT NULL,
  `UREF_XCL` VARCHAR(255) DEFAULT NULL,
  `UREF_UCL` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_uspatentcitation_citation_id` (`citation_id`) /*,
  CONSTRAINT `uspatentcitation_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uspc`
--

DROP TABLE IF EXISTS `uspc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uspc` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `mainclass_id` varchar(10) DEFAULT NULL,
  `subclass_id` varchar(10) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `mainclass_id` (`mainclass_id`),
  KEY `subclass_id` (`subclass_id`),
  KEY `ix_uspc_sequence` (`sequence`) /*,
  CONSTRAINT `uspc_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usreldoc`
--

DROP TABLE IF EXISTS `usreldoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usreldoc` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `rel_id` varchar(20) DEFAULT NULL,
  `doctype` varchar(64) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `number` varchar(64) DEFAULT NULL,
  `kind` varchar(10) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `relationship` varchar(64) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`),
  KEY `ix_usreldoc_doctype` (`doctype`),
  KEY `ix_usreldoc_sequence` (`sequence`),
  KEY `ix_usreldoc_country` (`country`),
  KEY `ix_usreldoc_number` (`number`),
  KEY `ix_usreldoc_date` (`date`),
  KEY `ix_usreldoc_rel_id` (`rel_id`) /*,
  CONSTRAINT `usreldoc_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Additional Table structure for table `pctinfo`
--

DROP TABLE IF EXISTS `pctinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pctinfo` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `PCTA_PCN` varchar(14) DEFAULT NULL,
  `PCTA_PD1` date DEFAULT NULL,
  `PCTA_PD2` date DEFAULT NULL,
  `PCTA_PD3` date DEFAULT NULL,
  `PCTA_PCP` varchar(15) DEFAULT NULL,
  `PCTA_PCD` date DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `pctinfo_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Additional Table structure for table `reissuedetails`
--

DROP TABLE IF EXISTS `reissuedetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reissuedetails` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `REIS_COD` varchar(2) DEFAULT NULL,
  `REIS_APN` varchar(6) DEFAULT NULL,
  `REIS_APD` date DEFAULT NULL,
  `REIS_PNO` varchar(20) DEFAULT NULL,
  `REIS_ISD` date DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `relationship` varchar(64) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `reissuedetails_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Additional Table structure for table `foreignprioritydetails`
--

DROP TABLE IF EXISTS `foreignprioritydetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foreignprioritydetails` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `PRIR_CNT` varchar(3) DEFAULT NULL,
  `PRIR_APD` date DEFAULT NULL,
  `PRIR_APN` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `foreignprioritydetails_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Additional Table structure for table `designclaims`
--

DROP TABLE IF EXISTS `designclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `designclaims` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `DCLM_TEXT` text DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `designclaims_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Additional Table structure for table `mainuspatentclassification`
--

DROP TABLE IF EXISTS `mainuspatentclassification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mainuspatentclassification` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `CLAS_OCL` VARCHAR(255) DEFAULT NULL,
  `CLAS_EDF` VARCHAR(1) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `mainuspatentclassification_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Additional Table structure for table `otheruspatentclassification`
--

DROP TABLE IF EXISTS `otheruspatentclassification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otheruspatentclassification` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `CLAS_XCL` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `otheruspatentclassification_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Additional Table structure for table `unofficialreferences`
--

DROP TABLE IF EXISTS `unofficialreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unofficialreferences` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `CLAS_UCL` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `unofficialreferences_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Additional Table structure for table `digestreferenes`
--

DROP TABLE IF EXISTS `digestreferenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `digestreferenes` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `CLAS_DCL` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `digestreferenes_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Additional Table structure for table `internationalpatentclassification`
--

DROP TABLE IF EXISTS `internationalpatentclassification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `internationalpatentclassification` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `CLAS_ICL` VARCHAR(255) DEFAULT NULL,
  `CLAS_EDF` VARCHAR(2) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `internationalpatentclassification_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Additional Table structure for table `fieldofsearchclassification`
--

DROP TABLE IF EXISTS `fieldofsearchclassification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldofsearchclassification` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `CLAS_FSC` VARCHAR(3) DEFAULT NULL,
  `CLAS_FSS` text CHARACTER SET utf8mb4,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `fieldofsearchclassification_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Additional Table structure for table `currentusclassification`
--

DROP TABLE IF EXISTS `currentusclassification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currentusclassification` (
  `uuid` varchar(36) NOT NULL,
  `patent_id` varchar(20) DEFAULT NULL,
  `CLAS_CCL` VARCHAR(4096) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patent_id` (`patent_id`) /*,
  CONSTRAINT `currentusclassification_ibfk_1` FOREIGN KEY (`patent_id`) REFERENCES `patent` (`id`) */
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;






--
-- Dumping routines for database 'grantdb_2014'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-15 19:31:27
