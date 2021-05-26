-- MySQL dump 10.14  Distrib 5.5.64-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: gocdb
-- ------------------------------------------------------
-- Server version	5.5.64-MariaDB-1~trusty

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
-- Current Database: `gocdb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gocdb` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `gocdb`;

--
-- Table structure for table `APIAuthenticationEntities`
--

DROP TABLE IF EXISTS `APIAuthenticationEntities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `APIAuthenticationEntities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parentSite_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `siteIdentifier` (`parentSite_id`,`type`,`identifier`),
  KEY `IDX_F246713E8F200B9F` (`parentSite_id`),
  CONSTRAINT `FK_F246713E8F200B9F` FOREIGN KEY (`parentSite_id`) REFERENCES `Sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `APIAuthenticationEntities`
--

LOCK TABLES `APIAuthenticationEntities` WRITE;
/*!40000 ALTER TABLE `APIAuthenticationEntities` DISABLE KEYS */;
/*!40000 ALTER TABLE `APIAuthenticationEntities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ArchivedNGIs`
--

DROP TABLE IF EXISTS `ArchivedNGIs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArchivedNGIs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletedBy` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deletedDate` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `scopes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentProjects` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `originalCreationDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ArchivedNGIs`
--

LOCK TABLES `ArchivedNGIs` WRITE;
/*!40000 ALTER TABLE `ArchivedNGIs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ArchivedNGIs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ArchivedServiceGroups`
--

DROP TABLE IF EXISTS `ArchivedServiceGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArchivedServiceGroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletedBy` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deletedDate` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `scopes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `services` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `originalCreationDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ArchivedServiceGroups`
--

LOCK TABLES `ArchivedServiceGroups` WRITE;
/*!40000 ALTER TABLE `ArchivedServiceGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ArchivedServiceGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ArchivedServices`
--

DROP TABLE IF EXISTS `ArchivedServices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArchivedServices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletedBy` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deletedDate` datetime NOT NULL,
  `hostName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `serviceType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `scopes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentSite` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitored` tinyint(1) DEFAULT NULL,
  `beta` tinyint(1) DEFAULT NULL,
  `production` tinyint(1) DEFAULT NULL,
  `originalCreationDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ArchivedServices`
--

LOCK TABLES `ArchivedServices` WRITE;
/*!40000 ALTER TABLE `ArchivedServices` DISABLE KEYS */;
INSERT INTO `ArchivedServices` VALUES (1,'admin','2020-05-14 13:30:35','megamentix.mega.de','MENTIX','SM','WWU',1,0,1,'2020-05-14 13:25:17'),(2,'admin','2020-06-09 09:32:04','sciencemesh-test.uni-muenster.de','MENTIX','SM','WWU',1,0,1,'2020-05-13 14:59:27'),(3,'admin','2020-06-09 09:32:12','sciencemesh-test.uni-muenster.de','OCM','SM','WWU',1,0,1,'2020-05-18 12:11:42'),(4,'admin','2020-06-24 08:49:11','localtest.de.xy','REVAD','SM','WWU',1,0,1,'2020-06-24 08:47:40'),(5,'admin','2021-01-12 11:40:54','sciencemesh-test.uni-muenster.de','Gateway','SM','WWU',0,0,0,'2020-09-08 09:46:02'),(6,'admin','2021-01-12 11:41:03','sciencemesh.cernbox.cern.ch','Gateway','SM','CERN',0,0,0,'2020-09-08 09:44:59'),(7,'admin','2021-01-26 12:52:51','sciencemesh-test.uni-muenster.de','GATEWAY','SM','AILLERON',0,0,0,'2021-01-26 12:51:51');
/*!40000 ALTER TABLE `ArchivedServices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ArchivedSites`
--

DROP TABLE IF EXISTS `ArchivedSites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArchivedSites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletedBy` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deletedDate` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `scopes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CertStatus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `V4PrimaryKey` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentNgi` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Infrastructure` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `originalCreationDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ArchivedSites`
--

LOCK TABLES `ArchivedSites` WRITE;
/*!40000 ALTER TABLE `ArchivedSites` DISABLE KEYS */;
/*!40000 ALTER TABLE `ArchivedSites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CertificationStatusLogs`
--

DROP TABLE IF EXISTS `CertificationStatusLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CertificationStatusLogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oldStatus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `newStatus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `addedBy` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `addedDate` datetime DEFAULT NULL,
  `reason` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentSite_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AD3967FE8F200B9F` (`parentSite_id`),
  CONSTRAINT `FK_AD3967FE8F200B9F` FOREIGN KEY (`parentSite_id`) REFERENCES `Sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CertificationStatusLogs`
--

LOCK TABLES `CertificationStatusLogs` WRITE;
/*!40000 ALTER TABLE `CertificationStatusLogs` DISABLE KEYS */;
INSERT INTO `CertificationStatusLogs` VALUES (1,NULL,'Certified','admin','2020-05-13 14:58:44','Initial creation',3),(2,NULL,'Certified','admin','2020-06-16 14:45:19','Initial creation',4),(3,NULL,'Certified','admin','2020-06-26 09:49:59','Initial creation',7),(4,NULL,'Certified','admin','2020-06-29 07:59:00','Initial creation',9),(5,NULL,'Certified','admin','2020-07-01 08:45:14','Initial creation',11),(6,NULL,'Candidate','admin','2020-07-01 10:44:01','Initial creation',14),(7,'Candidate','Certified','admin','2020-07-03 13:19:05','They are cool enough now',14),(8,NULL,'Certified','admin','2020-09-01 11:35:35','Initial creation',16),(9,NULL,'Certified','admin','2021-01-12 11:39:48','Initial creation',18);
/*!40000 ALTER TABLE `CertificationStatusLogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CertificationStatuses`
--

DROP TABLE IF EXISTS `CertificationStatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CertificationStatuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_4E5B6D45E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CertificationStatuses`
--

LOCK TABLES `CertificationStatuses` WRITE;
/*!40000 ALTER TABLE `CertificationStatuses` DISABLE KEYS */;
INSERT INTO `CertificationStatuses` VALUES (1,'Candidate'),(2,'Certified'),(3,'Closed'),(4,'Suspended'),(5,'Uncertified');
/*!40000 ALTER TABLE `CertificationStatuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Countries`
--

DROP TABLE IF EXISTS `Countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_DF97690E5E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Countries`
--

LOCK TABLES `Countries` WRITE;
/*!40000 ALTER TABLE `Countries` DISABLE KEYS */;
INSERT INTO `Countries` VALUES (1,'Bosnia and Herzegovina','BA'),(2,'New Zealand','NZ'),(3,'Indonesia','ID'),(4,'Moldova','MD'),(5,'Armenia','AM'),(6,'Albania','AL'),(7,'Georgia','GE'),(8,'Montenegro','ME'),(9,'Iran','IR'),(10,'Ukraine','UA'),(11,'Malaysia','MY'),(12,'Senegal','SN'),(13,'South Africa','ZA'),(14,'Belarus','BY'),(15,'Azerbaijan','AZ'),(16,'Austria','AT'),(17,'Hungary','HU'),(18,'Ireland','IE'),(19,'Israel','IL'),(20,'Italy','IT'),(21,'Japan','JP'),(22,'Netherlands','NL'),(23,'Pakistan','PK'),(24,'Poland','PL'),(25,'Portugal','PT'),(26,'Puerto Rico','PR'),(27,'Bulgaria','BG'),(28,'Romania','RO'),(29,'Russia','RU'),(30,'Slovakia','SK'),(31,'Spain','ES'),(32,'Sweden','SE'),(33,'Switzerland','CH'),(34,'Taiwan','TW'),(35,'United Kingdom','GB'),(36,'France','FR'),(37,'Greece','GR'),(38,'Germany','DE'),(39,'Czech Republic','CZ'),(40,'United States of America','US'),(41,'India','IN'),(42,'Canada','CA'),(43,'Brazil','BR'),(44,'Singapore','SG'),(45,'South Korea','KR'),(46,'Belgium','BE'),(47,'Slovenia','SI'),(48,'Serbia','RS'),(49,'Croatia','HR'),(50,'Turkey','TR'),(51,'Norway','NO'),(52,'China','CN'),(53,'Estonia','EE'),(54,'Latvia','LV'),(55,'Lithuania','LT'),(56,'Australia','AU'),(57,'Denmark','DK'),(58,'Finland','FI'),(59,'Cyprus','CY'),(60,'Republic of Macedonia','MK'),(61,'Colombia','CO'),(62,'Vietnam','VN'),(63,'Philippines','PH'),(64,'Morocco','MA'),(65,'Mexico','MX'),(66,'Argentina','AR'),(67,'Belize','BZ'),(68,'Bolivia','BO'),(69,'Chile','CL'),(70,'Costa Rica','CR'),(71,'Cuba','CU'),(72,'Dominican Republic','DO'),(73,'Ecuador','EC'),(74,'El Salvador','SV'),(75,'Guatemala','GT'),(76,'Haiti','HT'),(77,'Honduras','HN'),(78,'Nicaragua','NI'),(79,'Panama','PA'),(80,'Paraguay','PY'),(81,'Peru','PE'),(82,'Uruguay','UY'),(83,'Venezuela','VE'),(84,'Thailand','TH'),(85,'Afghanistan','AF'),(86,'Algeria','DZ'),(87,'American Samoa','AS'),(88,'Andorra','AD'),(89,'Angola','AO'),(90,'Anguilla','AI'),(91,'Antarctica','AQ'),(92,'Antigua and Barbuda','AG'),(93,'Aruba','AW'),(94,'Bahamas','BS'),(95,'Bahrain','BH'),(96,'Bangladesh','BD'),(97,'Barbados','BB'),(98,'Benin','BJ'),(99,'Bermuda','BM'),(100,'Bhutan','BT'),(101,'Botswana','BW'),(102,'British Indian Ocean Territory','IO'),(103,'British Virgin Islands','VG'),(104,'Brunei','BN'),(105,'Burkina Faso','BF'),(106,'Burma (Myanmar)','MM'),(107,'Burundi','BI'),(108,'Cambodia','KH'),(109,'Cameroon','CM'),(110,'Cape Verde','CV'),(111,'Cayman Islands','KY'),(112,'Central African Republic','CF'),(113,'Chad','TD'),(114,'Christmas Island','CX'),(115,'Cocos (Keeling) Islands','CC'),(116,'Comoros','KM'),(117,'Cook Islands','CK'),(118,'Democratic Republic of the Congo','CD'),(119,'Djibouti','DJ'),(120,'Dominica','DM'),(121,'Egypt','EG'),(122,'Equatorial Guinea','GQ'),(123,'Eritrea','ER'),(124,'Ethiopia','ET'),(125,'Falkland Islands','FK'),(126,'Faroe Islands','FO'),(127,'Fiji','FJ'),(128,'French Polynesia','PF'),(129,'Gabon','GA'),(130,'Gambia','GM'),(131,'Gaza St','ip'),(132,'Ghana','GH'),(133,'Gibraltar','GI'),(134,'Greenland','GL'),(135,'Grenada','GD'),(136,'Guam','GU'),(137,'Guinea','GN'),(138,'Guinea-Bissau','GW'),(139,'Guyana','GY'),(140,'Holy See (Vatican City)','VA'),(141,'Hong Kong','HK'),(142,'Iceland','IS'),(143,'Iraq','IQ'),(144,'Isle of Man','IM'),(145,'Ivory Coast','CI'),(146,'Jamaica','JM'),(147,'Jersey','JE'),(148,'Jordan','JO'),(149,'Kazakhstan','KZ'),(150,'Kenya','KE'),(151,'Kiribati','KI'),(152,'Kos','vo'),(153,'Kuwait','KW'),(154,'Kyrgyzstan','KG'),(155,'Laos','LA'),(156,'Lebanon','LB'),(157,'Lesotho','LS'),(158,'Liberia','LR'),(159,'Libya','LY'),(160,'Liechtenstein','LI'),(161,'Luxembourg','LU'),(162,'Macau','MO'),(163,'Madagascar','MG'),(164,'Malawi','MW'),(165,'Maldives','MV'),(166,'Mali','ML'),(167,'Malta','MT'),(168,'Marshall Islands','MH'),(169,'Mauritania','MR'),(170,'Mauritius','MU'),(171,'Mayotte','YT'),(172,'Micronesia','FM'),(173,'Monaco','MC'),(174,'Mongolia','MN'),(175,'Montserrat','MS'),(176,'Mozambique','MZ'),(177,'Namibia','NA'),(178,'Nauru','NR'),(179,'Nepal','NP'),(180,'Netherlands Antilles','AN'),(181,'New Caledonia','NC'),(182,'Niger','NE'),(183,'Nigeria','NG'),(184,'Niue','NU'),(185,'North Korea','KP'),(186,'Northern Mariana Islands','MP'),(187,'Oman','OM'),(188,'Palau','PW'),(189,'Papua New Guinea','PG'),(190,'Pitcairn Islands','PN'),(191,'Qatar','QA'),(192,'Republic of the Congo','CG'),(193,'Rwanda','RW'),(194,'Saint Barthelemy','BL'),(195,'Saint Helena','SH'),(196,'Saint Kitts and Nevis','KN'),(197,'Saint Lucia','LC'),(198,'Saint Martin','MF'),(199,'Saint Pierre and Miquelon','PM'),(200,'Saint Vincent and the Grenadines','VC'),(201,'Samoa','WS'),(202,'San Marino','SM'),(203,'Sao Tome and Principe','ST'),(204,'Saudi Arabia','SA'),(205,'Seychelles','SC'),(206,'Sierra Leone','SL'),(207,'Solomon Islands','SB'),(208,'Somalia','SO'),(209,'Sri Lanka','LK'),(210,'Sudan','SD'),(211,'Suriname','SR'),(212,'Svalbard','SJ'),(213,'Swaziland','SZ'),(214,'Syria','SY'),(215,'Tajikistan','TJ'),(216,'Tanzania','TZ'),(217,'Timor-Leste','TL'),(218,'Togo','TG'),(219,'Tokelau','TK'),(220,'Tonga','TO'),(221,'Trinidad and Tobago','TT'),(222,'Tunisia','TN'),(223,'Turkmenistan','TM'),(224,'Turks and Caicos Islands','TC'),(225,'Tuvalu','TV'),(226,'Uganda','UG'),(227,'United Arab Emirates','AE'),(228,'US Virgin Islands','VI'),(229,'Uzbekistan','UZ'),(230,'Vanuatu','VU'),(231,'Wallis and Futuna','WF'),(232,'Western Sahara','EH'),(233,'Yemen','YE'),(234,'Zambia','ZM'),(235,'Zimbabwe','ZW');
/*!40000 ALTER TABLE `Countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Downtimes`
--

DROP TABLE IF EXISTS `Downtimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Downtimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(4000) COLLATE utf8_unicode_ci NOT NULL,
  `severity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `classification` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `insertDate` datetime DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `primaryKey` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_AC786DACF5422415` (`primaryKey`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Downtimes`
--

LOCK TABLES `Downtimes` WRITE;
/*!40000 ALTER TABLE `Downtimes` DISABLE KEYS */;
INSERT INTO `Downtimes` VALUES (1,'Test outage','OUTAGE','UNSCHEDULED','2021-04-13 10:26:05','2021-04-13 22:00:00','2021-04-15 00:00:00','9G0'),(2,'Another test','OUTAGE','UNSCHEDULED','2021-04-13 11:58:27','2021-04-13 08:00:00','2021-04-17 05:00:00','10G0'),(3,'Nochn Test','OUTAGE','UNSCHEDULED','2021-04-13 12:51:39','2021-04-13 12:00:00','2021-04-15 13:00:00','11G0'),(4,'Test outage','OUTAGE','UNSCHEDULED','2021-04-19 12:12:34','2021-04-19 12:00:00','2021-04-20 12:00:00','12G0'),(5,'Test outage','OUTAGE','UNSCHEDULED','2021-04-19 12:13:26','2021-04-19 12:00:00','2021-04-19 15:00:00','13G0'),(6,'Test outage','OUTAGE','UNSCHEDULED','2021-04-19 12:38:10','2021-04-19 12:00:00','2021-04-20 12:00:00','14G0');
/*!40000 ALTER TABLE `Downtimes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Downtimes_EndpointLocations`
--

DROP TABLE IF EXISTS `Downtimes_EndpointLocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Downtimes_EndpointLocations` (
  `downtime_id` int(11) NOT NULL,
  `endpointLocation_id` int(11) NOT NULL,
  PRIMARY KEY (`downtime_id`,`endpointLocation_id`),
  KEY `IDX_2467A3653943157B` (`downtime_id`),
  KEY `IDX_2467A365A251422F` (`endpointLocation_id`),
  CONSTRAINT `FK_2467A3653943157B` FOREIGN KEY (`downtime_id`) REFERENCES `Downtimes` (`id`),
  CONSTRAINT `FK_2467A365A251422F` FOREIGN KEY (`endpointLocation_id`) REFERENCES `EndpointLocations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Downtimes_EndpointLocations`
--

LOCK TABLES `Downtimes_EndpointLocations` WRITE;
/*!40000 ALTER TABLE `Downtimes_EndpointLocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `Downtimes_EndpointLocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Downtimes_Services`
--

DROP TABLE IF EXISTS `Downtimes_Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Downtimes_Services` (
  `downtime_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  PRIMARY KEY (`downtime_id`,`service_id`),
  KEY `IDX_5CA34D143943157B` (`downtime_id`),
  KEY `IDX_5CA34D14ED5CA9E6` (`service_id`),
  CONSTRAINT `FK_5CA34D143943157B` FOREIGN KEY (`downtime_id`) REFERENCES `Downtimes` (`id`),
  CONSTRAINT `FK_5CA34D14ED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `Services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Downtimes_Services`
--

LOCK TABLES `Downtimes_Services` WRITE;
/*!40000 ALTER TABLE `Downtimes_Services` DISABLE KEYS */;
INSERT INTO `Downtimes_Services` VALUES (1,4),(1,34),(2,4),(2,6),(2,19),(2,34),(3,4),(3,6),(3,19),(3,34),(4,9),(4,10),(4,17),(4,33),(5,4),(5,6),(5,19),(5,34),(6,13),(6,14),(6,20);
/*!40000 ALTER TABLE `Downtimes_Services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EndpointLocations`
--

DROP TABLE IF EXISTS `EndpointLocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EndpointLocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `interfaceName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitored` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_498F8DB5ED5CA9E6` (`service_id`),
  CONSTRAINT `FK_498F8DB5ED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `Services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EndpointLocations`
--

LOCK TABLES `EndpointLocations` WRITE;
/*!40000 ALTER TABLE `EndpointLocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `EndpointLocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Endpoint_Properties`
--

DROP TABLE IF EXISTS `Endpoint_Properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Endpoint_Properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keyValue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentEndpoint_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `endpointproperty_keypairs` (`parentEndpoint_id`,`keyName`),
  KEY `IDX_AFD1580D833B85C9` (`parentEndpoint_id`),
  CONSTRAINT `FK_AFD1580D833B85C9` FOREIGN KEY (`parentEndpoint_id`) REFERENCES `EndpointLocations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Endpoint_Properties`
--

LOCK TABLES `Endpoint_Properties` WRITE;
/*!40000 ALTER TABLE `Endpoint_Properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `Endpoint_Properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Infrastructures`
--

DROP TABLE IF EXISTS `Infrastructures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Infrastructures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_63154B605E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Infrastructures`
--

LOCK TABLES `Infrastructures` WRITE;
/*!40000 ALTER TABLE `Infrastructures` DISABLE KEYS */;
INSERT INTO `Infrastructures` VALUES (4,'PPS'),(1,'Production'),(3,'SC'),(2,'Test');
/*!40000 ALTER TABLE `Infrastructures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NGIs`
--

DROP TABLE IF EXISTS `NGIs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NGIs` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rodEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `helpdeskEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `securityEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ggus_Su` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creationDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C7EDBF9D5E237E06` (`name`),
  CONSTRAINT `FK_C7EDBF9DBF396750` FOREIGN KEY (`id`) REFERENCES `OwnedEntities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NGIs`
--

LOCK TABLES `NGIs` WRITE;
/*!40000 ALTER TABLE `NGIs` DISABLE KEYS */;
INSERT INTO `NGIs` VALUES (2,'NGI_WWU','daniel.mueller@uni-muenster.de','daniel.mueller@uni-muenster.de','daniel.mueller@uni-muenster.de','daniel.mueller@uni-muenster.de',NULL,NULL,'2020-05-13 14:56:55'),(5,'NGI_CESNET','du-support@cesnet.cz','du-support@cesnet.cz','du-support@cesnet.cz','du-support@cesnet.cz',NULL,'','2020-06-16 14:54:44'),(6,'NGI_CERN','cernbox-service-ops@cern.ch','cernbox-service-ops@cern.ch','cernbox-service-ops@cern.ch','cernbox-service-ops@cern.ch',NULL,NULL,'2020-06-26 09:47:10'),(8,'NGI_SARA','thirsa.deboer@surf.nl','thirsa.deboer@surf.nl','thirsa.deboer@surf.nl','thirsa.deboer@surf.nl',NULL,NULL,'2020-06-29 07:56:41'),(10,'NGI_CUBBIT','hello@cubbit.io','hello@cubbit.io','hello@cubbit.io','hello@cubbit.io',NULL,NULL,'2020-07-01 08:43:45'),(12,'NGI_EU','daniel.mueller@uni-muenster.de','daniel.mueller@uni-muenster.de','daniel.mueller@uni-muenster.de','daniel.mueller@uni-muenster.de',NULL,NULL,'2020-07-01 10:38:20'),(13,'NGI_AILL','dawid.golosz@softwaremind.com','dawid.golosz@softwaremind.com','dawid.golosz@softwaremind.com','dawid.golosz@softwaremind.com',NULL,NULL,'2020-07-01 10:41:57'),(15,'NGI_SWITCH','fergus.kerins@switch.ch','','','',NULL,NULL,'2020-09-01 11:30:34'),(17,'NGI_DTU','marpap@dtu.dk','marpap@dtu.dk','marpap@dtu.dk','marpap@dtu.dk',NULL,'','2021-01-12 11:37:08');
/*!40000 ALTER TABLE `NGIs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NGIs_Scopes`
--

DROP TABLE IF EXISTS `NGIs_Scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NGIs_Scopes` (
  `ngi_Id` int(11) NOT NULL,
  `scope_Id` int(11) NOT NULL,
  PRIMARY KEY (`ngi_Id`,`scope_Id`),
  KEY `IDX_A4166208E284E4DD` (`ngi_Id`),
  KEY `IDX_A4166208FDAF7D93` (`scope_Id`),
  CONSTRAINT `FK_A4166208E284E4DD` FOREIGN KEY (`ngi_Id`) REFERENCES `NGIs` (`id`),
  CONSTRAINT `FK_A4166208FDAF7D93` FOREIGN KEY (`scope_Id`) REFERENCES `Scopes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NGIs_Scopes`
--

LOCK TABLES `NGIs_Scopes` WRITE;
/*!40000 ALTER TABLE `NGIs_Scopes` DISABLE KEYS */;
INSERT INTO `NGIs_Scopes` VALUES (2,1),(5,1),(6,1),(8,1),(10,1),(12,1),(13,1),(15,1),(17,1);
/*!40000 ALTER TABLE `NGIs_Scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OwnedEntities`
--

DROP TABLE IF EXISTS `OwnedEntities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OwnedEntities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OwnedEntities`
--

LOCK TABLES `OwnedEntities` WRITE;
/*!40000 ALTER TABLE `OwnedEntities` DISABLE KEYS */;
INSERT INTO `OwnedEntities` VALUES (1,'project'),(2,'ngi'),(3,'site'),(4,'site'),(5,'ngi'),(6,'ngi'),(7,'site'),(8,'ngi'),(9,'site'),(10,'ngi'),(11,'site'),(12,'ngi'),(13,'ngi'),(14,'site'),(15,'ngi'),(16,'site'),(17,'ngi'),(18,'site');
/*!40000 ALTER TABLE `OwnedEntities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PrimaryKeys`
--

DROP TABLE IF EXISTS `PrimaryKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PrimaryKeys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PrimaryKeys`
--

LOCK TABLES `PrimaryKeys` WRITE;
/*!40000 ALTER TABLE `PrimaryKeys` DISABLE KEYS */;
INSERT INTO `PrimaryKeys` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14);
/*!40000 ALTER TABLE `PrimaryKeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Projects`
--

DROP TABLE IF EXISTS `Projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Projects` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creationDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A5E5D1F25E237E06` (`name`),
  CONSTRAINT `FK_A5E5D1F2BF396750` FOREIGN KEY (`id`) REFERENCES `OwnedEntities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Projects`
--

LOCK TABLES `Projects` WRITE;
/*!40000 ALTER TABLE `Projects` DISABLE KEYS */;
INSERT INTO `Projects` VALUES (1,'ScienceMesh','ScienceMesh European Project','2020-04-22 14:21:23');
/*!40000 ALTER TABLE `Projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Projects_NGIs`
--

DROP TABLE IF EXISTS `Projects_NGIs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Projects_NGIs` (
  `project_Id` int(11) NOT NULL,
  `ngi_Id` int(11) NOT NULL,
  PRIMARY KEY (`project_Id`,`ngi_Id`),
  KEY `IDX_4A8D48A083E93B3E` (`project_Id`),
  KEY `IDX_4A8D48A0E284E4DD` (`ngi_Id`),
  CONSTRAINT `FK_4A8D48A083E93B3E` FOREIGN KEY (`project_Id`) REFERENCES `Projects` (`id`),
  CONSTRAINT `FK_4A8D48A0E284E4DD` FOREIGN KEY (`ngi_Id`) REFERENCES `NGIs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Projects_NGIs`
--

LOCK TABLES `Projects_NGIs` WRITE;
/*!40000 ALTER TABLE `Projects_NGIs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Projects_NGIs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RetrieveAccountRequests`
--

DROP TABLE IF EXISTS `RetrieveAccountRequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RetrieveAccountRequests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `newDn` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `confirmCode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_FB0E8628A76ED395` (`user_id`),
  CONSTRAINT `FK_FB0E8628A76ED395` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RetrieveAccountRequests`
--

LOCK TABLES `RetrieveAccountRequests` WRITE;
/*!40000 ALTER TABLE `RetrieveAccountRequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `RetrieveAccountRequests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RoleActionRecords`
--

DROP TABLE IF EXISTS `RoleActionRecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RoleActionRecords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actionDate` datetime NOT NULL,
  `updatedByUserId` int(11) NOT NULL,
  `updatedByUserPrinciple` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roleId` int(11) NOT NULL,
  `rolePreStatus` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roleNewStatus` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roleTypeId` int(11) NOT NULL,
  `roleTypeName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roleTargetOwnedEntityId` int(11) NOT NULL,
  `roleTargetOwnedEntityType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roleUserId` int(11) NOT NULL,
  `roleUserPrinciple` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RoleActionRecords`
--

LOCK TABLES `RoleActionRecords` WRITE;
/*!40000 ALTER TABLE `RoleActionRecords` DISABLE KEYS */;
/*!40000 ALTER TABLE `RoleActionRecords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RoleTypes`
--

DROP TABLE IF EXISTS `RoleTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RoleTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F99A26185E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RoleTypes`
--

LOCK TABLES `RoleTypes` WRITE;
/*!40000 ALTER TABLE `RoleTypes` DISABLE KEYS */;
INSERT INTO `RoleTypes` VALUES (13,'Chief Operations Officer'),(15,'CIC Staff'),(11,'COD Administrator'),(10,'COD Staff'),(12,'EGI CSIRT Officer'),(8,'NGI Operations Deputy Manager'),(9,'NGI Operations Manager'),(7,'NGI Security Officer'),(5,'Regional First Line Support'),(16,'Regional Staff'),(6,'Regional Staff (ROD)'),(14,'Service Group Administrator'),(1,'Site Administrator'),(3,'Site Operations Deputy Manager'),(4,'Site Operations Manager'),(2,'Site Security Officer');
/*!40000 ALTER TABLE `RoleTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roleType_id` int(11) DEFAULT NULL,
  `ownedEntity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NoDuplicateRoles` (`user_id`,`roleType_id`,`ownedEntity_id`),
  KEY `IDX_77FF01C358E4B33D` (`roleType_id`),
  KEY `IDX_77FF01C3A76ED395` (`user_id`),
  KEY `IDX_77FF01C31144F2F2` (`ownedEntity_id`),
  CONSTRAINT `FK_77FF01C31144F2F2` FOREIGN KEY (`ownedEntity_id`) REFERENCES `OwnedEntities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_77FF01C358E4B33D` FOREIGN KEY (`roleType_id`) REFERENCES `RoleTypes` (`id`),
  CONSTRAINT `FK_77FF01C3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Scopes`
--

DROP TABLE IF EXISTS `Scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Scopes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_378E6065E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Scopes`
--

LOCK TABLES `Scopes` WRITE;
/*!40000 ALTER TABLE `Scopes` DISABLE KEYS */;
INSERT INTO `Scopes` VALUES (1,'SM','ScienceMesh');
/*!40000 ALTER TABLE `Scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceGroup_Properties`
--

DROP TABLE IF EXISTS `ServiceGroup_Properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceGroup_Properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keyValue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentServiceGroup_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sgroup_keypairs` (`parentServiceGroup_id`,`keyName`),
  KEY `IDX_5553B348F68F1FEA` (`parentServiceGroup_id`),
  CONSTRAINT `FK_5553B348F68F1FEA` FOREIGN KEY (`parentServiceGroup_id`) REFERENCES `ServiceGroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceGroup_Properties`
--

LOCK TABLES `ServiceGroup_Properties` WRITE;
/*!40000 ALTER TABLE `ServiceGroup_Properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceGroup_Properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceGroups`
--

DROP TABLE IF EXISTS `ServiceGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceGroups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitored` tinyint(1) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creationDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_67F576C8BF396750` FOREIGN KEY (`id`) REFERENCES `OwnedEntities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceGroups`
--

LOCK TABLES `ServiceGroups` WRITE;
/*!40000 ALTER TABLE `ServiceGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceGroups_Scopes`
--

DROP TABLE IF EXISTS `ServiceGroups_Scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceGroups_Scopes` (
  `serviceGroup_Id` int(11) NOT NULL,
  `scope_Id` int(11) NOT NULL,
  PRIMARY KEY (`serviceGroup_Id`,`scope_Id`),
  KEY `IDX_FEE72E22296A2C52` (`serviceGroup_Id`),
  KEY `IDX_FEE72E22FDAF7D93` (`scope_Id`),
  CONSTRAINT `FK_FEE72E22296A2C52` FOREIGN KEY (`serviceGroup_Id`) REFERENCES `ServiceGroups` (`id`),
  CONSTRAINT `FK_FEE72E22FDAF7D93` FOREIGN KEY (`scope_Id`) REFERENCES `Scopes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceGroups_Scopes`
--

LOCK TABLES `ServiceGroups_Scopes` WRITE;
/*!40000 ALTER TABLE `ServiceGroups_Scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceGroups_Scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceGroups_Services`
--

DROP TABLE IF EXISTS `ServiceGroups_Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceGroups_Services` (
  `serviceGroup_Id` int(11) NOT NULL,
  `service_Id` int(11) NOT NULL,
  PRIMARY KEY (`serviceGroup_Id`,`service_Id`),
  KEY `IDX_EE13D584296A2C52` (`serviceGroup_Id`),
  KEY `IDX_EE13D58478D88D44` (`service_Id`),
  CONSTRAINT `FK_EE13D584296A2C52` FOREIGN KEY (`serviceGroup_Id`) REFERENCES `ServiceGroups` (`id`),
  CONSTRAINT `FK_EE13D58478D88D44` FOREIGN KEY (`service_Id`) REFERENCES `Services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceGroups_Services`
--

LOCK TABLES `ServiceGroups_Services` WRITE;
/*!40000 ALTER TABLE `ServiceGroups_Services` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceGroups_Services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceTypes`
--

DROP TABLE IF EXISTS `ServiceTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_13A6B93B5E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceTypes`
--

LOCK TABLES `ServiceTypes` WRITE;
/*!40000 ALTER TABLE `ServiceTypes` DISABLE KEYS */;
INSERT INTO `ServiceTypes` VALUES (3,'REVAD','Reva Daemon Service'),(4,'OCM','OpenCloudMesh Service'),(5,'Webdav','Web Distributed Authoring and Versioning Service'),(7,'GATEWAY','CS3 Gateway Service');
/*!40000 ALTER TABLE `ServiceTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Service_Properties`
--

DROP TABLE IF EXISTS `Service_Properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Service_Properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keyValue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentService_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serv_keypairs` (`parentService_id`,`keyName`),
  KEY `IDX_389B3931ED624C5` (`parentService_id`),
  CONSTRAINT `FK_389B3931ED624C5` FOREIGN KEY (`parentService_id`) REFERENCES `Services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Service_Properties`
--

LOCK TABLES `Service_Properties` WRITE;
/*!40000 ALTER TABLE `Service_Properties` DISABLE KEYS */;
INSERT INTO `Service_Properties` VALUES (2,'METRICS_PATH','/iop/metrics',4),(3,'METRICS_PATH','/iop/metrics',7),(4,'METRICS_PATH','/iop/metrics',9),(5,'METRICS_PATH','/iop/metrics',11),(6,'METRICS_PATH','/iop/metrics',15),(7,'API_VERSION','0.1.0',4),(8,'METRICS_PATH','/iop/metrics',23),(9,'ENABLE_HEALTH_CHECKS','true',15),(10,'ENABLE_HEALTH_CHECKS','true',11),(11,'ENABLE_HEALTH_CHECKS','true',23),(12,'ENABLE_HEALTH_CHECKS','true',4),(13,'ENABLE_HEALTH_CHECKS','true',9),(14,'ENABLE_HEALTH_CHECKS','true',7),(15,'ENABLE_HEALTH_CHECKS','true',13),(16,'GRPC_PORT','443',11),(17,'GRPC_PORT','443',23),(18,'GRPC_PORT','443',4),(19,'GRPC_PORT','443',9),(20,'GRPC_PORT','443',7),(21,'GRPC_PORT','443',13),(22,'GRPC_PORT','443',15),(23,'ENABLE_HEALTH_CHECKS','true',28),(24,'GRPC_PORT','19000',28);
/*!40000 ALTER TABLE `Service_Properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Services`
--

DROP TABLE IF EXISTS `Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `production` tinyint(1) NOT NULL,
  `beta` tinyint(1) NOT NULL,
  `monitored` tinyint(1) NOT NULL,
  `dn` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ipAddress` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ipV6Address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `operatingSystem` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `architecture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creationDate` datetime NOT NULL,
  `parentSite_id` int(11) DEFAULT NULL,
  `serviceType_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8A44833F8F200B9F` (`parentSite_id`),
  KEY `IDX_8A44833FCD0557BA` (`serviceType_id`),
  CONSTRAINT `FK_8A44833F8F200B9F` FOREIGN KEY (`parentSite_id`) REFERENCES `Sites` (`id`),
  CONSTRAINT `FK_8A44833FCD0557BA` FOREIGN KEY (`serviceType_id`) REFERENCES `ServiceTypes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Services`
--

LOCK TABLES `Services` WRITE;
/*!40000 ALTER TABLE `Services` DISABLE KEYS */;
INSERT INTO `Services` VALUES (4,'iop.sciencemesh.uni-muenster.de','Reva Daemon @ WWU',1,0,1,'','','','','','daniel.mueller@uni-muenster.de',0,'https://iop.sciencemesh.uni-muenster.de/iop','2020-06-09 09:37:03',3,3),(5,'sciencemesh.cesnet.cz','CESNET ScienceMesh Test',0,0,0,'','','','','','du-support@cesnet.cz',0,'https://sciencemesh.cesnet.cz/iop/ocm','2020-06-16 14:48:20',4,4),(6,'iop.sciencemesh.uni-muenster.de','OCM API service',0,0,0,'','','','','','daniel.mueller@uni-muenster.de',0,'https://iop.sciencemesh.uni-muenster.de/iop/ocm','2020-06-22 09:02:45',3,4),(7,'sciencemesh.cesnet.cz','REVAD IOP service',1,0,1,'','','','','','du-support@cesnet.cz',0,'https://sciencemesh.cesnet.cz/iop','2020-06-22 16:01:10',4,3),(9,'sciencemesh.cernbox.cern.ch','CERN ScienceMesh IOP',1,0,1,'','','','','','cernbox-service-ops@cern.ch',0,'https://sciencemesh.cernbox.cern.ch/iop','2020-06-26 09:50:58',7,3),(10,'sciencemesh.cernbox.cern.ch','CERN ScienceMesh OCM',0,0,0,'','','','','','cernbox-service-ops@cern.ch',0,'https://sciencemesh.cernbox.cern.ch/iop/ocm','2020-06-26 09:52:34',7,4),(11,'app.cs3mesh-iop.k8s.surfsara.nl','Surfsara IOP',1,0,1,'','','','','','thirsa.deboer@surf.nl',0,'https://app.cs3mesh-iop.k8s.surfsara.nl/iop','2020-06-29 08:00:25',9,3),(12,'app.cs3mesh-iop.k8s.surfsara.nl','Surfsara OCM',0,0,0,'','','','','','thirsa.deboer@surf.nl',0,'https://app.cs3mesh-iop.k8s.surfsara.nl/iop/ocm','2020-06-29 08:01:49',9,4),(13,'sciencemesh.cubbit.io','Cubbit IOP',1,0,1,'','','','','','hello@cubbit.io',0,'https://sciencemesh.cubbit.io','2020-07-01 08:45:55',11,3),(14,'sciencemesh.cubbit.io','Cubbit OCM',0,0,0,'','','','','','hello@cubbit.io',0,'https://sciencemesh.cubbit.io/ocm','2020-07-01 08:47:14',11,4),(15,'sciencemesh.softwaremind.com','Ailleron IOP',1,0,1,'','','','','','dawid.golosz@softwaremind.com',1,'https://sciencemesh.softwaremind.com/iop/','2020-07-01 10:45:41',14,3),(16,'sciencemesh.softwaremind.com','Ailleron OCM',0,0,0,'','','','','','dawid.golosz@softwaremind.com',0,'https://sciencemesh.softwaremind.com/iop/ocm','2020-07-01 10:46:23',14,4),(17,'sciencemesh.cernbox.cern.ch','Reva WebDAV service',0,0,0,'','','','','','cernbox-service-ops@cern.ch',0,'https://sciencemesh.cernbox.cern.ch/iop/remote.php/webdav/','2020-07-28 07:34:34',7,5),(18,'sciencemesh.cesnet.cz','Reva WebDAV service',0,0,0,'','','','','','du-support@cesnet.cz',0,'https://sciencemesh.cesnet.cz/iop/remote.php/webdav/','2020-07-28 07:35:21',4,5),(19,'iop.sciencemesh.uni-muenster.de','Reva WebDAV service',0,0,0,'','','','','','daniel.mueller@uni-muenster.de',0,'https://iop.sciencemesh.uni-muenster.de/iop/remote.php/webdav/','2020-07-28 07:36:26',3,5),(20,'sciencemesh.cubbit.io','Reva WebDAV service',0,0,0,'','','','','','hello@cubbit.io',0,'https://sciencemesh.cubbit.io/remote.php/webdav/','2020-07-28 07:38:07',11,5),(21,'sciencemesh.softwaremind.com','Reva WebDAV service',0,0,0,'','','','','','dawid.golosz@softwaremind.com',0,'https://sciencemesh.softwaremind.com/iop/remote.php/webdav/','2020-07-28 07:38:46',14,5),(22,'app.cs3mesh-iop.k8s.surfsara.nl','Reva WebDAV service',0,0,0,'','','','','','thirsa.deboer@surf.nl',0,'https://app.cs3mesh-iop.k8s.surfsara.nl/iop/remote.php/webdav/','2020-07-28 07:39:31',9,5),(23,'sciencemesh-test.switch.ch','Reva service',1,0,1,'','','','','','fergus.kerins@switch.ch',0,'https://sciencemesh-test.switch.ch/iop/','2020-09-01 11:36:35',16,3),(24,'sciencemesh-test.switch.ch','Reva OCM service',0,0,0,'','','','','','fergus.kerins@switch.ch',0,'https://sciencemesh-test.switch.ch/iop/ocm/','2020-09-01 11:37:00',16,4),(25,'sciencemesh-test.switch.ch','Reva WebDAV service',0,0,0,'','','','','','fergus.kerins@switch.ch',0,'https://sciencemesh-test.switch.ch/iop/remote.php/webdav/','2020-09-01 11:37:29',16,5),(28,'cs3mesh.sciencedata.dk','DTU IOP',1,0,1,'','',NULL,'','','marpap@dtu.dk',0,'http://cs3mesh.sciencedata.dk:20001','2021-01-12 11:43:15',18,3),(29,'cs3mesh.sciencedata.dk','Reva WebDAV service',0,0,0,'','',NULL,'','','marpap@dtu.dk',0,'http://cs3mesh.sciencedata.dk:20001/remote.php/webdav/','2021-01-12 11:45:56',18,5),(30,'cs3mesh.sciencedata.dk','OCM API service',0,0,0,'','',NULL,'','','marpap@dtu.dk',0,'http://cs3mesh.sciencedata.dk:20001/ocm','2021-01-12 11:46:43',18,4),(31,'app.cs3mesh-iop.k8s.surfsara.nl','Gateway service',0,0,0,'','','','','','thirsa.deboer@surf.nl',0,'app.cs3mesh-iop.k8s.surfsara.nl','2021-01-26 12:51:11',9,7),(33,'sciencemesh.cernbox.cern.ch','Gateway service',0,0,0,'','','','','','cernbox-service-ops@cern.ch',0,'sciencemesh.cernbox.cern.ch','2021-01-26 12:52:25',7,7),(34,'iop.sciencemesh.uni-muenster.de','Gateway service',0,0,0,'','','','','','daniel.mueller@uni-muenster.de',0,'iop.sciencemesh.uni-muenster.de:443','2021-01-26 12:53:25',3,7);
/*!40000 ALTER TABLE `Services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Services_Scopes`
--

DROP TABLE IF EXISTS `Services_Scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Services_Scopes` (
  `service_Id` int(11) NOT NULL,
  `scope_Id` int(11) NOT NULL,
  PRIMARY KEY (`service_Id`,`scope_Id`),
  KEY `IDX_13D31A9E78D88D44` (`service_Id`),
  KEY `IDX_13D31A9EFDAF7D93` (`scope_Id`),
  CONSTRAINT `FK_13D31A9E78D88D44` FOREIGN KEY (`service_Id`) REFERENCES `Services` (`id`),
  CONSTRAINT `FK_13D31A9EFDAF7D93` FOREIGN KEY (`scope_Id`) REFERENCES `Scopes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Services_Scopes`
--

LOCK TABLES `Services_Scopes` WRITE;
/*!40000 ALTER TABLE `Services_Scopes` DISABLE KEYS */;
INSERT INTO `Services_Scopes` VALUES (4,1),(5,1),(6,1),(7,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(28,1),(29,1),(30,1),(31,1),(33,1),(34,1);
/*!40000 ALTER TABLE `Services_Scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Site_Properties`
--

DROP TABLE IF EXISTS `Site_Properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Site_Properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keyValue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentSite_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_keypairs` (`parentSite_id`,`keyName`),
  KEY `IDX_6052834C8F200B9F` (`parentSite_id`),
  CONSTRAINT `FK_6052834C8F200B9F` FOREIGN KEY (`parentSite_id`) REFERENCES `Sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Site_Properties`
--

LOCK TABLES `Site_Properties` WRITE;
/*!40000 ALTER TABLE `Site_Properties` DISABLE KEYS */;
INSERT INTO `Site_Properties` VALUES (1,'ORGANIZATION','WWU Muenster',3),(2,'SITE_ID','0001',3),(3,'SITE_ID','0002',18),(4,'SITE_ID','0003',4),(5,'SITE_ID','0004',7),(6,'SITE_ID','0005',9),(7,'SITE_ID','0006',11),(8,'SITE_ID','0007',14),(9,'SITE_ID','0008',16);
/*!40000 ALTER TABLE `Site_Properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sites`
--

DROP TABLE IF EXISTS `Sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sites` (
  `id` int(11) NOT NULL,
  `ngi_id` int(11) DEFAULT NULL,
  `infrastructure_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `timezone_id` int(11) DEFAULT NULL,
  `tier_id` int(11) DEFAULT NULL,
  `subgrid_id` int(11) DEFAULT NULL,
  `primaryKey` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shortName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `officialName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homeUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `giisUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `csirtEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alarmEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ipRange` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ipV6Range` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `csirtTel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emergencyTel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emergencyEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `helpdeskEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  `certificationStatusChangeDate` datetime DEFAULT NULL,
  `timezoneId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creationDate` datetime NOT NULL,
  `certificationStatus_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_7DC18567C43A885D` (`shortName`),
  UNIQUE KEY `UNIQ_7DC18567F5422415` (`primaryKey`),
  KEY `IDX_7DC185677700C07F` (`ngi_id`),
  KEY `IDX_7DC18567243E7A84` (`infrastructure_id`),
  KEY `IDX_7DC18567829B1E9` (`certificationStatus_id`),
  KEY `IDX_7DC18567F92F3E70` (`country_id`),
  KEY `IDX_7DC185673FE997DE` (`timezone_id`),
  KEY `IDX_7DC18567A354F9DC` (`tier_id`),
  KEY `IDX_7DC185676793C05A` (`subgrid_id`),
  CONSTRAINT `FK_7DC18567243E7A84` FOREIGN KEY (`infrastructure_id`) REFERENCES `Infrastructures` (`id`),
  CONSTRAINT `FK_7DC185673FE997DE` FOREIGN KEY (`timezone_id`) REFERENCES `Timezones` (`id`),
  CONSTRAINT `FK_7DC185676793C05A` FOREIGN KEY (`subgrid_id`) REFERENCES `SubGrids` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_7DC185677700C07F` FOREIGN KEY (`ngi_id`) REFERENCES `NGIs` (`id`),
  CONSTRAINT `FK_7DC18567829B1E9` FOREIGN KEY (`certificationStatus_id`) REFERENCES `CertificationStatuses` (`id`),
  CONSTRAINT `FK_7DC18567A354F9DC` FOREIGN KEY (`tier_id`) REFERENCES `Tiers` (`id`),
  CONSTRAINT `FK_7DC18567BF396750` FOREIGN KEY (`id`) REFERENCES `OwnedEntities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_7DC18567F92F3E70` FOREIGN KEY (`country_id`) REFERENCES `Countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sites`
--

LOCK TABLES `Sites` WRITE;
/*!40000 ALTER TABLE `Sites` DISABLE KEYS */;
INSERT INTO `Sites` VALUES (3,2,1,38,NULL,NULL,NULL,'1G0','WWU','University of Muenster','http://www.uni-muenster.de','University of Muenster ScienceMesh Test','daniel.mueller@uni-muenster.de','+49 0251 8800','',51.9607,7.6261,'','','','','uni-muenster.de','Muenster','','','','',0,'2020-05-13 14:58:44','Europe/Berlin','2020-05-13 14:58:44',2),(4,5,1,39,NULL,NULL,NULL,'2G0','CESNET','CESNET a.l.e.','https://www.cesnet.cz/','CESNET ScienceMesh Test','du-support@cesnet.cz','+420 234 680 222','',50.1017989,14.3907022,'certs@cesnet.cz','','','','cesnet.cz','Prague','+420 234 680 222','','','du-support@cesnet.cz',0,'2020-06-16 14:45:19','Europe/Prague','2020-06-16 14:45:19',2),(7,6,1,33,NULL,NULL,NULL,'3G0','CERN','CERN','https://home.cern/','CERN ScienceMesh','cernbox-service-ops@cern.ch','0123456','',46.2351762,6.0392889,'','','','','cern.ch','Geneva','','','','',1,'2020-06-26 09:49:59','Europe/Zurich','2020-06-26 09:49:59',2),(9,8,1,22,NULL,NULL,NULL,'4G0','SURFSARA','SURFSARA','https://www.surf.nl/en','Surfsara ScienceMesh','thirsa.deboer@surf.nl','0123456','',52.35673,4.95459,'thirsa.deboer@surf.nl','','','','surfsara.nl','Amsterdam','','','','thirsa.deboer@surf.nl',1,'2020-06-29 07:59:00','Europe/Amsterdam','2020-06-29 07:59:00',2),(11,10,1,20,NULL,NULL,NULL,'5G0','CUBBIT','CUBBIT','http://www.cubbit.io','Cubbit ScienceMesh','hello@cubbit.io','0123456','',44.495121,11.34021,'','','','','cubbit.io','Bologna','','','','',1,'2020-07-01 08:45:14','Europe/Madrid','2020-07-01 08:45:14',2),(14,13,1,24,NULL,NULL,NULL,'6G0','AILLERON','Ailleron/Softwaremind','https://softwaremind.com/','Ailleron ScienceMesh','dawid.golosz@softwaremind.com','0123456','',50.064651,19.944981,'','','','','softwaremind.com','Krakow','','','','',0,'2020-07-03 13:19:05','Europe/Warsaw','2020-07-01 10:44:01',2),(16,15,1,33,NULL,NULL,NULL,'7G0','SWITCH','SWITCH','https://switch.ch','SWITCHdrive provides cloud storage to its students, faculty and researchers.','fergus.kerins@switch.ch','+41 44 268 15 15','',47.366667,8.55,'',NULL,'','','switch.ch','Zurich','','','','',0,'2020-09-01 11:35:35','Europe/Zurich','2020-09-01 11:35:35',2),(18,17,1,57,NULL,NULL,NULL,'8G0','DTU','Danmarks Tekniske Universitet','https://www.dtu.dk','DTU ScienceMesh','marpap@dtu.dk','+45 50103819','',55.676098,12.568337,'',NULL,'','','dtu.dk','Copenhagen','','','','',0,'2021-01-12 11:39:48','Europe/Copenhagen','2021-01-12 11:39:48',2);
/*!40000 ALTER TABLE `Sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sites_Scopes`
--

DROP TABLE IF EXISTS `Sites_Scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sites_Scopes` (
  `site_Id` int(11) NOT NULL,
  `scope_Id` int(11) NOT NULL,
  PRIMARY KEY (`site_Id`,`scope_Id`),
  KEY `IDX_B7074FAF633932E4` (`site_Id`),
  KEY `IDX_B7074FAFFDAF7D93` (`scope_Id`),
  CONSTRAINT `FK_B7074FAF633932E4` FOREIGN KEY (`site_Id`) REFERENCES `Sites` (`id`),
  CONSTRAINT `FK_B7074FAFFDAF7D93` FOREIGN KEY (`scope_Id`) REFERENCES `Scopes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sites_Scopes`
--

LOCK TABLES `Sites_Scopes` WRITE;
/*!40000 ALTER TABLE `Sites_Scopes` DISABLE KEYS */;
INSERT INTO `Sites_Scopes` VALUES (3,1),(4,1),(7,1),(9,1),(11,1),(14,1),(16,1),(18,1);
/*!40000 ALTER TABLE `Sites_Scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubGrids`
--

DROP TABLE IF EXISTS `SubGrids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubGrids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NGI_Id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_E199E8555E237E06` (`name`),
  KEY `IDX_E199E85584DB61D1` (`NGI_Id`),
  CONSTRAINT `FK_E199E85584DB61D1` FOREIGN KEY (`NGI_Id`) REFERENCES `NGIs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SubGrids`
--

LOCK TABLES `SubGrids` WRITE;
/*!40000 ALTER TABLE `SubGrids` DISABLE KEYS */;
/*!40000 ALTER TABLE `SubGrids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tiers`
--

DROP TABLE IF EXISTS `Tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D78614A65E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tiers`
--

LOCK TABLES `Tiers` WRITE;
/*!40000 ALTER TABLE `Tiers` DISABLE KEYS */;
INSERT INTO `Tiers` VALUES (1,'0'),(2,'1'),(3,'2');
/*!40000 ALTER TABLE `Tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Timezones`
--

DROP TABLE IF EXISTS `Timezones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Timezones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F7A34AFD5E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Timezones`
--

LOCK TABLES `Timezones` WRITE;
/*!40000 ALTER TABLE `Timezones` DISABLE KEYS */;
/*!40000 ALTER TABLE `Timezones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forename` varchar(255) COLLATE utf8_bin NOT NULL,
  `surname` varchar(255) COLLATE utf8_bin NOT NULL,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `workingHoursStart` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `workingHoursEnd` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `certificateDn` varchar(255) COLLATE utf8_bin NOT NULL,
  `username1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL,
  `creationDate` datetime NOT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  `homeSite_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D5428AED13566978` (`certificateDn`),
  KEY `IDX_D5428AED3037A1E4` (`homeSite_id`),
  CONSTRAINT `FK_D5428AED3037A1E4` FOREIGN KEY (`homeSite_id`) REFERENCES `Sites` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Super','User','Prof','super.user@sciencemesh.eu','',NULL,NULL,'admin',NULL,1,'2020-04-22 14:10:43','2021-05-04 12:25:05',NULL);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-04 13:19:33
