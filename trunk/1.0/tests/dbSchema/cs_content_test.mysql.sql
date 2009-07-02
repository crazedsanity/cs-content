-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.75-0ubuntu10.2


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema mysql
--

CREATE DATABASE IF NOT EXISTS mysql;
USE mysql;

--
-- Definition of table `mysql`.`columns_priv`
--

DROP TABLE IF EXISTS `mysql`.`columns_priv`;
CREATE TABLE  `mysql`.`columns_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Table_name` char(64) collate utf8_bin NOT NULL default '',
  `Column_name` char(64) collate utf8_bin NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Column_priv` set('Select','Insert','Update','References') character set utf8 NOT NULL default '',
  PRIMARY KEY  (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column privileges';

--
-- Dumping data for table `mysql`.`columns_priv`
--

/*!40000 ALTER TABLE `columns_priv` DISABLE KEYS */;
LOCK TABLES `columns_priv` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `columns_priv` ENABLE KEYS */;


--
-- Definition of table `mysql`.`db`
--

DROP TABLE IF EXISTS `mysql`.`db`;
CREATE TABLE  `mysql`.`db` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_view_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Show_view_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_routine_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_routine_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Execute_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  PRIMARY KEY  (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database privileges';

--
-- Dumping data for table `mysql`.`db`
--

/*!40000 ALTER TABLE `db` DISABLE KEYS */;
LOCK TABLES `db` WRITE;
INSERT INTO `mysql`.`db` VALUES  (0x25,0x74657374,'','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','N','N'),
 (0x25,0x746573745C5F25,'','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','N','N'),
 (0x25,0x7265736F7572636572657175657374,0x63686174746572,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),
 (0x25,0x6D7973716C,0x63686174746572,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),
 (0x25,0x696E666F726D6174696F6E5F736368656D61,0x63686174746572,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),
 (0x25,0x63686174,0x63686174746572,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),
 (0x31302E25,0x7265736F7572636572657175657374,0x726F6F74,'Y','Y','Y','Y','N','N','N','N','N','N','N','Y','N','N','N','N','N'),
 (0x3132372E302E302E31,0x7265736F7572636572657175657374,0x726F6F74,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),
 (0x6C6F63616C686F7374,0x7265736F7572636572657175657374,0x726F6F74,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),
 (0x736B6974746C6573,0x7265736F7572636572657175657374,0x726F6F74,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y');
INSERT INTO `mysql`.`db` VALUES  (0x25,0x7265736F7572636572657175657374,0x7265736F7572636572657175657374,'Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','N','N','N','N','N'),
 (0x3132372E25,0x7265736F7572636572657175657374,0x7265736F7572636572657175657374,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y');
UNLOCK TABLES;
/*!40000 ALTER TABLE `db` ENABLE KEYS */;


--
-- Definition of table `mysql`.`func`
--

DROP TABLE IF EXISTS `mysql`.`func`;
CREATE TABLE  `mysql`.`func` (
  `name` char(64) collate utf8_bin NOT NULL default '',
  `ret` tinyint(1) NOT NULL default '0',
  `dl` char(128) collate utf8_bin NOT NULL default '',
  `type` enum('function','aggregate') character set utf8 NOT NULL,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User defined functions';

--
-- Dumping data for table `mysql`.`func`
--

/*!40000 ALTER TABLE `func` DISABLE KEYS */;
LOCK TABLES `func` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `func` ENABLE KEYS */;


--
-- Definition of table `mysql`.`help_category`
--

DROP TABLE IF EXISTS `mysql`.`help_category`;
CREATE TABLE  `mysql`.`help_category` (
  `help_category_id` smallint(5) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint(5) unsigned default NULL,
  `url` char(128) NOT NULL,
  PRIMARY KEY  (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help categories';

--
-- Dumping data for table `mysql`.`help_category`
--

/*!40000 ALTER TABLE `help_category` DISABLE KEYS */;
LOCK TABLES `help_category` WRITE;
INSERT INTO `mysql`.`help_category` VALUES  (1,'Geographic',0,''),
 (2,'Polygon properties',31,''),
 (3,'WKT',31,''),
 (4,'Numeric Functions',35,''),
 (5,'MBR',31,''),
 (6,'Control flow functions',35,''),
 (7,'Transactions',32,''),
 (8,'Account Management',32,''),
 (9,'Point properties',31,''),
 (10,'Encryption Functions',35,''),
 (11,'LineString properties',31,''),
 (12,'Logical operators',35,''),
 (13,'Miscellaneous Functions',35,''),
 (14,'Information Functions',35,''),
 (15,'Functions and Modifiers for Use with GROUP BY',32,''),
 (16,'Comparison operators',35,''),
 (17,'Bit Functions',35,''),
 (18,'Table Maintenance',32,''),
 (19,'Data Types',32,''),
 (20,'User-Defined Functions',32,''),
 (21,'Compound Statements',32,''),
 (22,'Geometry constructors',31,''),
 (23,'GeometryCollection properties',1,''),
 (24,'Administration',32,''),
 (25,'Data Manipulation',32,''),
 (26,'Utility',32,''),
 (27,'Language Structure',32,''),
 (28,'Geometry relations',31,''),
 (29,'Date and Time Functions',35,''),
 (30,'WKB',31,'');
INSERT INTO `mysql`.`help_category` VALUES  (31,'Geographic Features',32,''),
 (32,'Contents',0,''),
 (33,'Geometry properties',31,''),
 (34,'String Functions',35,''),
 (35,'Functions',32,''),
 (36,'Data Definition',32,'');
UNLOCK TABLES;
/*!40000 ALTER TABLE `help_category` ENABLE KEYS */;


--
-- Definition of table `mysql`.`help_keyword`
--

DROP TABLE IF EXISTS `mysql`.`help_keyword`;
CREATE TABLE  `mysql`.`help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY  (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help keywords';

--
-- Dumping data for table `mysql`.`help_keyword`
--

/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
LOCK TABLES `help_keyword` WRITE;
INSERT INTO `mysql`.`help_keyword` VALUES  (0,'JOIN'),
 (1,'REPEAT'),
 (2,'SERIALIZABLE'),
 (3,'REPLACE'),
 (4,'RETURNS'),
 (5,'MASTER_SSL_CA'),
 (6,'NCHAR'),
 (7,'COLUMNS'),
 (8,'WORK'),
 (9,'DATETIME'),
 (10,'MODE'),
 (11,'OPEN'),
 (12,'INTEGER'),
 (13,'ESCAPE'),
 (14,'VALUE'),
 (15,'SQL_BIG_RESULT'),
 (16,'DROP'),
 (17,'GEOMETRYCOLLECTIONFROMWKB'),
 (18,'EVENTS'),
 (19,'MONTH'),
 (20,'INFO'),
 (21,'PROFILES'),
 (22,'DUPLICATE'),
 (23,'REPLICATION'),
 (24,'UNLOCK'),
 (25,'INNODB'),
 (26,'YEAR_MONTH'),
 (27,'SUBJECT'),
 (28,'PREPARE'),
 (29,'LOCK'),
 (30,'NDB'),
 (31,'CHECK'),
 (32,'FULL'),
 (33,'INT4'),
 (34,'BY'),
 (35,'NO'),
 (36,'MINUTE'),
 (37,'DATA'),
 (38,'DAY'),
 (39,'SHARE'),
 (40,'REAL'),
 (41,'SEPARATOR'),
 (42,'DELETE'),
 (43,'ON'),
 (44,'CONNECTION'),
 (45,'CLOSE'),
 (46,'X509'),
 (47,'USE'),
 (48,'WHERE'),
 (49,'PRIVILEGES'),
 (50,'SPATIAL'),
 (51,'SUPER'),
 (52,'SQL_BUFFER_RESULT'),
 (53,'IGNORE'),
 (54,'QUICK'),
 (55,'SIGNED'),
 (56,'SECURITY'),
 (57,'NDBCLUSTER'),
 (58,'POLYGONFROMWKB'),
 (59,'FALSE');
INSERT INTO `mysql`.`help_keyword` VALUES  (60,'LEVEL'),
 (61,'FORCE'),
 (62,'BINARY'),
 (63,'TO'),
 (64,'CHANGE'),
 (65,'HOUR_MINUTE'),
 (66,'UPDATE'),
 (67,'INTO'),
 (68,'FEDERATED'),
 (69,'VARYING'),
 (70,'HOUR_SECOND'),
 (71,'VARIABLE'),
 (72,'ROLLBACK'),
 (73,'RTREE'),
 (74,'PROCEDURE'),
 (75,'TIMESTAMP'),
 (76,'IMPORT'),
 (77,'AGAINST'),
 (78,'CHECKSUM'),
 (79,'COUNT'),
 (80,'LONGBINARY'),
 (81,'THEN'),
 (82,'INSERT'),
 (83,'ENGINES'),
 (84,'HANDLER'),
 (85,'DAY_SECOND'),
 (86,'EXISTS'),
 (87,'MUTEX'),
 (88,'RELEASE'),
 (89,'BOOLEAN'),
 (90,'MOD'),
 (91,'DEFAULT'),
 (92,'TYPE'),
 (93,'NO_WRITE_TO_BINLOG'),
 (94,'OPTIMIZE'),
 (95,'RESET'),
 (96,'ITERATE'),
 (97,'DO'),
 (98,'BIGINT'),
 (99,'SET'),
 (100,'ISSUER'),
 (101,'DATE'),
 (102,'STATUS'),
 (103,'FULLTEXT'),
 (104,'COMMENT'),
 (105,'MASTER_CONNECT_RETRY'),
 (106,'INNER'),
 (107,'STOP'),
 (108,'MASTER_LOG_FILE'),
 (109,'MRG_MYISAM'),
 (110,'PRECISION'),
 (111,'REQUIRE'),
 (112,'TRAILING'),
 (113,'LONG'),
 (114,'OPTION'),
 (115,'ELSE'),
 (116,'DEALLOCATE');
INSERT INTO `mysql`.`help_keyword` VALUES  (117,'IO_THREAD'),
 (118,'CASE'),
 (119,'CIPHER'),
 (120,'CONTINUE'),
 (121,'FROM'),
 (122,'READ'),
 (123,'LEFT'),
 (124,'ELSEIF'),
 (125,'MINUTE_SECOND'),
 (126,'COMPACT'),
 (127,'RESTORE'),
 (128,'DEC'),
 (129,'FOR'),
 (130,'WARNINGS'),
 (131,'MIN_ROWS'),
 (132,'CONDITION'),
 (133,'STRING'),
 (134,'ENCLOSED'),
 (135,'FUNCTION'),
 (136,'AGGREGATE'),
 (137,'FIELDS'),
 (138,'INT3'),
 (139,'ARCHIVE'),
 (140,'AVG_ROW_LENGTH'),
 (141,'ADD'),
 (142,'KILL'),
 (143,'FLOAT4'),
 (144,'VIEW'),
 (145,'REPEATABLE'),
 (146,'INFILE'),
 (147,'ORDER'),
 (148,'USING'),
 (149,'MIDDLEINT'),
 (150,'GRANT'),
 (151,'UNSIGNED'),
 (152,'DECIMAL'),
 (153,'GEOMETRYFROMTEXT'),
 (154,'INDEXES'),
 (155,'FOREIGN'),
 (156,'CACHE'),
 (157,'HOSTS'),
 (158,'COMMIT'),
 (159,'SCHEMAS'),
 (160,'LEADING'),
 (161,'SNAPSHOT'),
 (162,'DECLARE'),
 (163,'LOAD'),
 (164,'SQL_CACHE'),
 (165,'CONVERT'),
 (166,'DYNAMIC'),
 (167,'COLLATE'),
 (168,'POLYGONFROMTEXT'),
 (169,'BYTE'),
 (170,'GLOBAL'),
 (171,'LINESTRINGFROMWKB');
INSERT INTO `mysql`.`help_keyword` VALUES  (172,'BERKELEYDB'),
 (173,'WHEN'),
 (174,'HAVING'),
 (175,'AS'),
 (176,'STARTING'),
 (177,'RELOAD'),
 (178,'AUTOCOMMIT'),
 (179,'REVOKE'),
 (180,'GRANTS'),
 (181,'OUTER'),
 (182,'FLOOR'),
 (183,'EXPLAIN'),
 (184,'WITH'),
 (185,'AFTER'),
 (186,'STD'),
 (187,'CSV'),
 (188,'DISABLE'),
 (189,'OUTFILE'),
 (190,'LOW_PRIORITY'),
 (191,'FILE'),
 (192,'BDB'),
 (193,'SCHEMA'),
 (194,'SONAME'),
 (195,'POW'),
 (196,'MULTIPOINTFROMWKB'),
 (197,'INDEX'),
 (198,'DUAL'),
 (199,'BACKUP'),
 (200,'MULTIPOINTFROMTEXT'),
 (201,'EXTENDED'),
 (202,'MULTILINESTRINGFROMWKB'),
 (203,'CROSS'),
 (204,'NATIONAL'),
 (205,'GROUP'),
 (206,'SHA'),
 (207,'UNDO'),
 (208,'ZEROFILL'),
 (209,'CLIENT'),
 (210,'MASTER_PASSWORD'),
 (211,'RELAY_LOG_FILE'),
 (212,'TRUE'),
 (213,'CHARACTER'),
 (214,'MASTER_USER'),
 (215,'TABLE'),
 (216,'ENGINE'),
 (217,'INSERT_METHOD'),
 (218,'CASCADE'),
 (219,'RELAY_LOG_POS'),
 (220,'SQL_CALC_FOUND_ROWS'),
 (221,'UNION'),
 (222,'MYISAM'),
 (223,'LEAVE'),
 (224,'MODIFY');
INSERT INTO `mysql`.`help_keyword` VALUES  (225,'MATCH'),
 (226,'MASTER_LOG_POS'),
 (227,'DESC'),
 (228,'DISTINCTROW'),
 (229,'TIME'),
 (230,'NUMERIC'),
 (231,'EXPANSION'),
 (232,'CURSOR'),
 (233,'CODE'),
 (234,'GEOMETRYCOLLECTIONFROMTEXT'),
 (235,'CHAIN'),
 (236,'FLUSH'),
 (237,'CREATE'),
 (238,'DESCRIBE'),
 (239,'MAX_UPDATES_PER_HOUR'),
 (240,'INT2'),
 (241,'PROCESSLIST'),
 (242,'LOGS'),
 (243,'HEAP'),
 (244,'SOUNDS'),
 (245,'BETWEEN'),
 (246,'REPAIR'),
 (247,'MULTILINESTRINGFROMTEXT'),
 (248,'PACK_KEYS'),
 (249,'FAST'),
 (250,'CALL'),
 (251,'VALUES'),
 (252,'LOOP'),
 (253,'VARCHARACTER'),
 (254,'BEFORE'),
 (255,'TRUNCATE'),
 (256,'SHOW'),
 (257,'REDUNDANT'),
 (258,'ALL'),
 (259,'USER_RESOURCES'),
 (260,'PARTIAL'),
 (261,'BINLOG'),
 (262,'END'),
 (263,'SECOND'),
 (264,'AND'),
 (265,'FLOAT8'),
 (266,'PREV'),
 (267,'HOUR'),
 (268,'SELECT'),
 (269,'DATABASES'),
 (270,'OR'),
 (271,'IDENTIFIED'),
 (272,'MASTER_SSL_CIPHER'),
 (273,'SQL_SLAVE_SKIP_COUNTER'),
 (274,'BOTH'),
 (275,'BOOL'),
 (276,'YEAR'),
 (277,'MASTER_PORT');
INSERT INTO `mysql`.`help_keyword` VALUES  (278,'CONCURRENT'),
 (279,'HELP'),
 (280,'UNIQUE'),
 (281,'TRIGGERS'),
 (282,'PROCESS'),
 (283,'CONSISTENT'),
 (284,'MASTER_SSL'),
 (285,'DATE_ADD'),
 (286,'MAX_CONNECTIONS_PER_HOUR'),
 (287,'LIKE'),
 (288,'FETCH'),
 (289,'IN'),
 (290,'COLUMN'),
 (291,'DUMPFILE'),
 (292,'USAGE'),
 (293,'EXECUTE'),
 (294,'MEMORY'),
 (295,'CEIL'),
 (296,'QUERY'),
 (297,'MASTER_HOST'),
 (298,'LINES'),
 (299,'SQL_THREAD'),
 (300,'MAX_QUERIES_PER_HOUR'),
 (301,'MASTER_SSL_CERT'),
 (302,'MULTIPOLYGONFROMWKB'),
 (303,'TRANSACTION'),
 (304,'DAY_MINUTE'),
 (305,'STDDEV'),
 (306,'DATE_SUB'),
 (307,'GEOMETRYFROMWKB'),
 (308,'INT1'),
 (309,'RENAME'),
 (310,'RIGHT'),
 (311,'ALTER'),
 (312,'MAX_ROWS'),
 (313,'STRAIGHT_JOIN'),
 (314,'NATURAL'),
 (315,'VARIABLES'),
 (316,'ESCAPED'),
 (317,'SHA1'),
 (318,'PASSWORD'),
 (319,'CHAR'),
 (320,'OFFSET'),
 (321,'NEXT'),
 (322,'SQL_LOG_BIN'),
 (323,'ERRORS'),
 (324,'TEMPORARY'),
 (325,'COMMITTED'),
 (326,'SQL_SMALL_RESULT'),
 (327,'UPGRADE'),
 (328,'BEGIN');
INSERT INTO `mysql`.`help_keyword` VALUES  (329,'DELAY_KEY_WRITE'),
 (330,'PROFILE'),
 (331,'MEDIUM'),
 (332,'INTERVAL'),
 (333,'SSL'),
 (334,'DAY_HOUR'),
 (335,'REFERENCES'),
 (336,'AES_ENCRYPT'),
 (337,'STORAGE'),
 (338,'ISOLATION'),
 (339,'CEILING'),
 (340,'INT8'),
 (341,'RESTRICT'),
 (342,'UNCOMMITTED'),
 (343,'LINESTRINGFROMTEXT'),
 (344,'IS'),
 (345,'NOT'),
 (346,'ANALYSE'),
 (347,'DES_KEY_FILE'),
 (348,'COMPRESSED'),
 (349,'START'),
 (350,'SAVEPOINT'),
 (351,'IF'),
 (352,'PRIMARY'),
 (353,'PURGE'),
 (354,'USER'),
 (355,'INNOBASE'),
 (356,'LAST'),
 (357,'EXIT'),
 (358,'KEYS'),
 (359,'LIMIT'),
 (360,'KEY'),
 (361,'MERGE'),
 (362,'UNTIL'),
 (363,'SQL_NO_CACHE'),
 (364,'DELAYED'),
 (365,'ANALYZE'),
 (366,'CONSTRAINT'),
 (367,'SERIAL'),
 (368,'ACTION'),
 (369,'WRITE'),
 (370,'SESSION'),
 (371,'DATABASE'),
 (372,'NULL'),
 (373,'POWER'),
 (374,'USE_FRM'),
 (375,'SLAVE'),
 (376,'TERMINATED'),
 (377,'NVARCHAR'),
 (378,'ASC'),
 (379,'RETURN'),
 (380,'ENABLE'),
 (381,'OPTIONALLY'),
 (382,'DIRECTORY'),
 (383,'WHILE');
INSERT INTO `mysql`.`help_keyword` VALUES  (384,'MAX_USER_CONNECTIONS'),
 (385,'DISTINCT'),
 (386,'AES_DECRYPT'),
 (387,'LOCAL'),
 (388,'MASTER_SSL_KEY'),
 (389,'NONE'),
 (390,'TABLES'),
 (391,'<>'),
 (392,'RLIKE'),
 (393,'TRIGGER'),
 (394,'COLLATION'),
 (395,'SHUTDOWN'),
 (396,'HIGH_PRIORITY'),
 (397,'BTREE'),
 (398,'FIRST'),
 (399,'TYPES'),
 (400,'MASTER'),
 (401,'FIXED'),
 (402,'MULTIPOLYGONFROMTEXT'),
 (403,'ROW_FORMAT');
UNLOCK TABLES;
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;


--
-- Definition of table `mysql`.`help_relation`
--

DROP TABLE IF EXISTS `mysql`.`help_relation`;
CREATE TABLE  `mysql`.`help_relation` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `help_keyword_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`help_keyword_id`,`help_topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='keyword-topic relation';

--
-- Dumping data for table `mysql`.`help_relation`
--

/*!40000 ALTER TABLE `help_relation` DISABLE KEYS */;
LOCK TABLES `help_relation` WRITE;
INSERT INTO `mysql`.`help_relation` VALUES  (1,0),
 (341,0),
 (218,1),
 (427,2),
 (3,3),
 (402,3),
 (88,4),
 (176,5),
 (410,6),
 (17,7),
 (333,7),
 (402,7),
 (135,8),
 (216,9),
 (80,10),
 (341,10),
 (13,11),
 (97,11),
 (123,11),
 (333,11),
 (88,12),
 (476,12),
 (364,13),
 (3,14),
 (95,14),
 (229,14),
 (341,15),
 (26,16),
 (29,16),
 (79,16),
 (177,16),
 (223,16),
 (250,16),
 (263,16),
 (317,16),
 (390,16),
 (398,16),
 (441,16),
 (99,17),
 (113,18),
 (360,19),
 (246,20),
 (74,21),
 (95,22),
 (188,23),
 (31,24),
 (333,25),
 (385,25),
 (446,25),
 (360,26),
 (188,27),
 (30,28),
 (223,28),
 (31,29),
 (341,29),
 (446,30),
 (399,31),
 (446,31),
 (17,32),
 (281,32),
 (333,32),
 (431,32),
 (446,32),
 (476,33),
 (42,34),
 (69,34),
 (75,34),
 (188,34),
 (341,34),
 (347,34),
 (402,34),
 (441,34),
 (446,34),
 (446,35),
 (450,35),
 (360,36),
 (108,37),
 (402,37),
 (446,37),
 (360,38),
 (341,39),
 (88,40),
 (300,40),
 (347,41),
 (42,42),
 (446,42),
 (450,42),
 (1,43),
 (450,43),
 (165,44),
 (446,44),
 (45,45);
INSERT INTO `mysql`.`help_relation` VALUES  (97,45),
 (188,46),
 (1,47),
 (49,47),
 (42,48),
 (75,48),
 (97,48),
 (182,49),
 (188,49),
 (235,49),
 (198,50),
 (441,50),
 (188,51),
 (341,52),
 (1,53),
 (75,53),
 (95,53),
 (341,53),
 (402,53),
 (441,53),
 (42,54),
 (399,54),
 (444,54),
 (216,55),
 (188,56),
 (446,57),
 (82,58),
 (458,58),
 (369,59),
 (427,60),
 (1,61),
 (33,62),
 (216,62),
 (256,62),
 (176,63),
 (256,63),
 (439,63),
 (176,64),
 (441,64),
 (360,65),
 (75,66),
 (95,66),
 (341,66),
 (450,66),
 (3,67),
 (95,67),
 (290,67),
 (341,67),
 (446,68),
 (243,69),
 (360,70),
 (120,71),
 (135,72),
 (439,72),
 (198,73),
 (14,74),
 (175,74),
 (288,74),
 (314,74),
 (333,74),
 (341,74),
 (398,74),
 (419,74),
 (464,74),
 (90,75),
 (179,75),
 (402,76),
 (80,77),
 (386,78),
 (446,78),
 (61,79),
 (315,79),
 (413,79),
 (273,80),
 (24,81),
 (51,81),
 (77,81),
 (95,82),
 (183,82),
 (287,82),
 (462,82),
 (269,83),
 (333,83),
 (97,84),
 (299,84),
 (360,85),
 (26,86),
 (144,86),
 (177,86),
 (263,86),
 (270,87);
INSERT INTO `mysql`.`help_relation` VALUES  (333,87),
 (135,88),
 (439,88),
 (20,89),
 (80,89),
 (103,90),
 (164,90),
 (3,91),
 (95,91),
 (144,91),
 (187,91),
 (200,91),
 (229,91),
 (441,91),
 (446,91),
 (441,92),
 (446,92),
 (105,93),
 (313,93),
 (444,93),
 (448,93),
 (105,94),
 (32,95),
 (109,95),
 (140,95),
 (251,95),
 (115,96),
 (116,97),
 (472,97),
 (209,98),
 (3,99),
 (75,99),
 (95,99),
 (120,99),
 (128,99),
 (135,99),
 (144,99),
 (172,99),
 (200,99),
 (319,99),
 (402,99),
 (441,99),
 (446,99),
 (450,99),
 (454,99),
 (470,99),
 (188,100),
 (122,101),
 (216,101),
 (249,101),
 (360,101),
 (52,102),
 (126,102),
 (203,102),
 (211,102),
 (270,102),
 (314,102),
 (322,102),
 (333,102),
 (351,102),
 (385,102),
 (198,103),
 (441,103),
 (446,103),
 (446,104),
 (176,105),
 (1,106),
 (46,107),
 (176,108),
 (446,109),
 (300,110),
 (188,111),
 (435,112),
 (273,113),
 (188,114),
 (235,114),
 (51,115),
 (77,115),
 (223,116),
 (46,117),
 (310,117),
 (51,118),
 (77,118),
 (188,119),
 (299,120),
 (42,121),
 (108,121);
INSERT INTO `mysql`.`help_relation` VALUES  (113,121),
 (333,121),
 (341,121),
 (345,121),
 (435,121),
 (31,122),
 (97,122),
 (427,122),
 (1,123),
 (24,124),
 (360,125),
 (446,126),
 (169,127),
 (197,128),
 (170,129),
 (299,129),
 (333,129),
 (341,129),
 (401,129),
 (315,130),
 (333,130),
 (446,131),
 (170,132),
 (88,133),
 (402,134),
 (29,135),
 (60,135),
 (88,135),
 (199,135),
 (219,135),
 (288,135),
 (322,135),
 (333,135),
 (377,135),
 (390,135),
 (398,135),
 (88,136),
 (333,137),
 (402,137),
 (238,138),
 (446,139),
 (441,140),
 (446,140),
 (54,141),
 (441,141),
 (165,142),
 (158,143),
 (26,144),
 (148,144),
 (434,144),
 (427,145),
 (402,146),
 (42,147),
 (75,147),
 (341,147),
 (347,147),
 (441,147),
 (1,148),
 (42,148),
 (78,148),
 (238,149),
 (188,150),
 (235,150),
 (20,151),
 (119,151),
 (158,151),
 (197,151),
 (216,151),
 (300,151),
 (476,151),
 (88,152),
 (145,152),
 (216,152),
 (395,153),
 (333,154),
 (441,155),
 (446,155),
 (450,155),
 (92,156),
 (140,156),
 (290,156),
 (134,157),
 (333,157);
INSERT INTO `mysql`.`help_relation` VALUES  (135,158),
 (149,159),
 (333,159),
 (435,160),
 (135,161),
 (170,162),
 (187,162),
 (299,162),
 (401,162),
 (108,163),
 (290,163),
 (345,163),
 (402,163),
 (341,164),
 (216,165),
 (361,165),
 (446,166),
 (144,167),
 (200,167),
 (446,167),
 (379,168),
 (443,169),
 (120,170),
 (126,170),
 (172,170),
 (335,170),
 (427,170),
 (432,171),
 (446,172),
 (51,173),
 (77,173),
 (341,174),
 (1,175),
 (31,175),
 (341,175),
 (402,176),
 (188,177),
 (135,178),
 (235,179),
 (181,180),
 (333,180),
 (1,181),
 (209,182),
 (241,183),
 (80,184),
 (188,184),
 (441,185),
 (247,186),
 (402,187),
 (446,187),
 (441,188),
 (341,189),
 (3,190),
 (31,190),
 (42,190),
 (75,190),
 (95,190),
 (402,190),
 (188,191),
 (155,192),
 (446,192),
 (144,193),
 (177,193),
 (200,193),
 (295,193),
 (333,193),
 (88,194),
 (264,195),
 (442,196),
 (1,197),
 (54,197),
 (79,197),
 (92,197),
 (198,197),
 (290,197),
 (294,197),
 (333,197),
 (441,197),
 (446,197),
 (266,198),
 (343,199),
 (405,200),
 (241,201);
INSERT INTO `mysql`.`help_relation` VALUES  (444,201),
 (259,202),
 (1,203),
 (243,204),
 (410,204),
 (341,205),
 (407,206),
 (299,207),
 (20,208),
 (119,208),
 (158,208),
 (197,208),
 (300,208),
 (476,208),
 (188,209),
 (176,210),
 (176,211),
 (369,212),
 (144,213),
 (200,213),
 (243,213),
 (319,213),
 (402,213),
 (410,213),
 (446,213),
 (176,214),
 (54,215),
 (100,215),
 (105,215),
 (169,215),
 (203,215),
 (263,215),
 (265,215),
 (307,215),
 (333,215),
 (343,215),
 (345,215),
 (386,215),
 (399,215),
 (441,215),
 (444,215),
 (446,215),
 (448,215),
 (333,216),
 (351,216),
 (441,216),
 (446,216),
 (446,217),
 (26,218),
 (263,218),
 (446,218),
 (450,218),
 (176,219),
 (341,220),
 (291,221),
 (446,222),
 (296,223),
 (441,224),
 (80,225),
 (176,226),
 (316,227),
 (341,227),
 (347,227),
 (341,228),
 (216,229),
 (301,229),
 (359,229),
 (197,230),
 (80,231),
 (401,232),
 (60,233),
 (464,233),
 (232,234),
 (135,235),
 (140,236),
 (313,236),
 (14,237),
 (18,237),
 (54,237),
 (69,237),
 (88,237),
 (144,237);
INSERT INTO `mysql`.`help_relation` VALUES  (198,237),
 (199,237),
 (265,237),
 (288,237),
 (295,237),
 (333,237),
 (377,237),
 (434,237),
 (446,237),
 (316,238),
 (188,239),
 (220,240),
 (333,241),
 (431,241),
 (33,242),
 (155,242),
 (256,242),
 (333,242),
 (351,242),
 (446,243),
 (362,244),
 (136,245),
 (444,246),
 (98,247),
 (446,248),
 (399,249),
 (325,250),
 (3,251),
 (95,251),
 (330,252),
 (243,253),
 (256,254),
 (307,255),
 (14,256),
 (17,256),
 (21,256),
 (33,256),
 (52,256),
 (60,256),
 (61,256),
 (74,256),
 (113,256),
 (123,256),
 (126,256),
 (134,256),
 (149,256),
 (155,256),
 (181,256),
 (182,256),
 (203,256),
 (211,256),
 (265,256),
 (269,256),
 (270,256),
 (281,256),
 (294,256),
 (295,256),
 (314,256),
 (315,256),
 (319,256),
 (322,256),
 (333,256),
 (335,256),
 (351,256),
 (377,256),
 (385,256),
 (431,256),
 (463,256),
 (464,256),
 (468,256),
 (446,257),
 (188,258),
 (235,258),
 (291,258),
 (341,258),
 (313,259),
 (446,260),
 (113,261),
 (24,262),
 (51,262),
 (77,262),
 (218,262),
 (312,262);
INSERT INTO `mysql`.`help_relation` VALUES  (330,262),
 (472,262),
 (360,263),
 (136,264),
 (302,264),
 (300,265),
 (97,266),
 (360,267),
 (3,268),
 (95,268),
 (241,268),
 (246,268),
 (287,268),
 (341,268),
 (149,269),
 (333,269),
 (130,270),
 (69,271),
 (188,271),
 (176,272),
 (172,273),
 (435,274),
 (20,275),
 (101,275),
 (360,276),
 (176,277),
 (402,278),
 (110,279),
 (374,279),
 (441,280),
 (21,281),
 (188,282),
 (135,283),
 (176,284),
 (360,285),
 (188,286),
 (333,287),
 (362,287),
 (367,288),
 (80,289),
 (113,289),
 (341,289),
 (441,290),
 (341,291),
 (188,292),
 (78,293),
 (188,293),
 (341,294),
 (381,295),
 (80,296),
 (140,296),
 (165,296),
 (176,297),
 (402,298),
 (46,299),
 (310,299),
 (188,300),
 (176,301),
 (114,302),
 (135,303),
 (427,303),
 (360,304),
 (391,305),
 (360,306),
 (133,307),
 (20,308),
 (100,309),
 (210,309),
 (441,309),
 (1,310),
 (54,311),
 (148,311),
 (188,311),
 (200,311),
 (219,311),
 (419,311),
 (441,311),
 (446,312),
 (1,313),
 (341,313),
 (1,314),
 (333,315),
 (335,315);
INSERT INTO `mysql`.`help_relation` VALUES  (402,316),
 (407,317),
 (69,318),
 (188,318),
 (454,318),
 (216,319),
 (443,319),
 (341,320),
 (97,321),
 (470,322),
 (61,323),
 (333,323),
 (263,324),
 (427,325),
 (341,326),
 (399,327),
 (135,328),
 (312,328),
 (446,329),
 (463,330),
 (399,331),
 (360,332),
 (188,333),
 (360,334),
 (188,335),
 (446,335),
 (450,335),
 (423,336),
 (269,337),
 (427,338),
 (428,339),
 (119,340),
 (26,341),
 (263,341),
 (450,341),
 (427,342),
 (50,343),
 (76,344),
 (194,344),
 (354,344),
 (436,344),
 (76,345),
 (144,345),
 (194,345),
 (298,345),
 (175,346),
 (313,347),
 (446,348),
 (135,349),
 (310,349),
 (439,350),
 (24,351),
 (26,351),
 (144,351),
 (177,351),
 (263,351),
 (456,351),
 (441,352),
 (256,353),
 (69,354),
 (210,354),
 (317,354),
 (446,355),
 (97,356),
 (299,357),
 (294,358),
 (333,358),
 (441,358),
 (42,359),
 (75,359),
 (97,359),
 (113,359),
 (341,359),
 (54,360),
 (95,360),
 (441,360),
 (446,360),
 (450,360),
 (446,361),
 (218,362),
 (341,363),
 (3,364),
 (95,364);
INSERT INTO `mysql`.`help_relation` VALUES  (462,364),
 (448,365),
 (441,366),
 (446,366),
 (229,367),
 (446,367),
 (446,368),
 (450,368),
 (31,369),
 (120,370),
 (126,370),
 (335,370),
 (427,370),
 (144,371),
 (177,371),
 (200,371),
 (295,371),
 (333,371),
 (76,372),
 (354,372),
 (450,372),
 (459,373),
 (444,374),
 (32,375),
 (46,375),
 (134,375),
 (211,375),
 (310,375),
 (402,376),
 (243,377),
 (341,378),
 (347,378),
 (467,379),
 (441,380),
 (402,381),
 (446,382),
 (472,383),
 (188,384),
 (0,385),
 (87,385),
 (276,385),
 (291,385),
 (341,385),
 (347,385),
 (368,385),
 (413,385),
 (473,386),
 (31,387),
 (105,387),
 (313,387),
 (402,387),
 (444,387),
 (448,387),
 (176,388),
 (188,389),
 (31,390),
 (123,390),
 (281,390),
 (333,390),
 (471,391),
 (23,392),
 (18,393),
 (250,393),
 (468,394),
 (188,395),
 (95,396),
 (341,396),
 (198,397),
 (97,398),
 (441,398),
 (446,398),
 (333,399),
 (33,400),
 (52,400),
 (108,400),
 (176,400),
 (251,400),
 (256,400),
 (345,400),
 (197,401),
 (446,401),
 (189,402);
INSERT INTO `mysql`.`help_relation` VALUES  (446,403);
UNLOCK TABLES;
/*!40000 ALTER TABLE `help_relation` ENABLE KEYS */;


--
-- Definition of table `mysql`.`help_topic`
--

DROP TABLE IF EXISTS `mysql`.`help_topic`;
CREATE TABLE  `mysql`.`help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint(5) unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` char(128) NOT NULL,
  PRIMARY KEY  (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help topics';

--
-- Dumping data for table `mysql`.`help_topic`
--

/*!40000 ALTER TABLE `help_topic` DISABLE KEYS */;
LOCK TABLES `help_topic` WRITE;
INSERT INTO `mysql`.`help_topic` VALUES  (0,'MIN',15,'Syntax:\nMIN([DISTINCT] expr)\n\nReturns the minimum value of expr. MIN() may take a string argument; in\nsuch cases, it returns the minimum string value. See\nhttp://dev.mysql.com/doc/refman/5.0/en/mysql-indexes.html. The DISTINCT\nkeyword can be used to find the minimum of the distinct values of expr,\nhowever, this produces the same result as omitting DISTINCT.\n\nMIN() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','mysql> SELECT student_name, MIN(test_score), MAX(test_score)\n    ->        FROM student\n    ->        GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (1,'JOIN',25,'MySQL supports the following JOIN syntaxes for the table_references\npart of SELECT statements and multiple-table DELETE and UPDATE\nstatements:\n\ntable_references:\n    table_reference [, table_reference] ...\n\ntable_reference:\n    table_factor\n  | join_table\n\ntable_factor:\n    tbl_name [[AS] alias] [index_hint)]\n  | table_subquery [AS] alias\n  | ( table_references )\n  | { OJ table_reference LEFT OUTER JOIN table_reference\n        ON conditional_expr }\n\njoin_table:\n    table_reference [INNER | CROSS] JOIN table_factor [join_condition]\n  | table_reference STRAIGHT_JOIN table_factor\n  | table_reference STRAIGHT_JOIN table_factor ON conditional_expr\n  | table_reference {LEFT|RIGHT} [OUTER] JOIN table_reference join_condition\n  | table_reference NATURAL [{LEFT|RIGHT} [OUTER]] JOIN table_factor\n\njoin_condition:\n    ON conditional_expr\n  | USING (column_list)\n\nindex_hint:\n    USE {INDEX|KEY} [FOR JOIN] (index_list)\n  | IGNORE {INDEX|KEY} [FOR JOIN] (index_list)\n  | FORCE {INDEX|KEY} [FOR JOIN] (index_list)\n\nindex_list:\n    index_name [, index_name] ...\n\nA table reference is also known as a join expression.\n\nThe syntax of table_factor is extended in comparison with the SQL\nStandard. The latter accepts only table_reference, not a list of them\ninside a pair of parentheses.\n\nThis is a conservative extension if we consider each comma in a list of\ntable_reference items as equivalent to an inner join. For example:\n\nSELECT * FROM t1 LEFT JOIN (t2, t3, t4)\n                 ON (t2.a=t1.a AND t3.b=t1.b AND t4.c=t1.c)\n\nis equivalent to:\n\nSELECT * FROM t1 LEFT JOIN (t2 CROSS JOIN t3 CROSS JOIN t4)\n                 ON (t2.a=t1.a AND t3.b=t1.b AND t4.c=t1.c)\n\nIn MySQL, CROSS JOIN is a syntactic equivalent to INNER JOIN (they can\nreplace each other). In standard SQL, they are not equivalent. INNER\nJOIN is used with an ON clause, CROSS JOIN is used otherwise.\n\nIn versions of MySQL prior to 5.0.1, parentheses in table_references\nwere just omitted and all join operations were grouped to the left. In\ngeneral, parentheses can be ignored in join expressions containing only\ninner join operations. As of 5.0.1, nested joins are allowed (see\nhttp://dev.mysql.com/doc/refman/5.0/en/nested-joins.html).\n\nFurther changes in join processing were made in 5.0.12 to make MySQL\nmore compliant with standard SQL. These charges are described later in\nthis section.\n\nIndex hints can be specified to affect how the MySQL optimizer makes\nuse of indexes. For more information, see\nhttp://dev.mysql.com/doc/refman/5.0/en/index-hints.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/join.html\n\n','SELECT left_tbl.*\n  FROM left_tbl LEFT JOIN right_tbl ON left_tbl.id = right_tbl.id\n  WHERE right_tbl.id IS NULL;\n','http://dev.mysql.com/doc/refman/5.0/en/join.html'),
 (2,'HEX',34,'Syntax:\nHEX(N_or_S)\n\nIf N_or_S is a number, returns a string representation of the\nhexadecimal value of N, where N is a longlong (BIGINT) number. This is\nequivalent to CONV(N,10,16).\n\nIf N_or_S is a string, returns a hexadecimal string representation of\nN_or_S where each character in N_or_S is converted to two hexadecimal\ndigits. The inverse of this operation is performed by the UNHEX()\nfunction.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT HEX(255);\n        -> \'FF\'\nmysql> SELECT 0x616263;\n        -> \'abc\'\nmysql> SELECT HEX(\'abc\');\n        -> 616263\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (3,'REPLACE',25,'Syntax:\nREPLACE [LOW_PRIORITY | DELAYED]\n    [INTO] tbl_name [(col_name,...)]\n    {VALUES | VALUE} ({expr | DEFAULT},...),(...),...\n\nOr:\n\nREPLACE [LOW_PRIORITY | DELAYED]\n    [INTO] tbl_name\n    SET col_name={expr | DEFAULT}, ...\n\nOr:\n\nREPLACE [LOW_PRIORITY | DELAYED]\n    [INTO] tbl_name [(col_name,...)]\n    SELECT ...\n\nREPLACE works exactly like INSERT, except that if an old row in the\ntable has the same value as a new row for a PRIMARY KEY or a UNIQUE\nindex, the old row is deleted before the new row is inserted. See [HELP\nINSERT].\n\nREPLACE is a MySQL extension to the SQL standard. It either inserts, or\ndeletes and inserts. For another MySQL extension to standard SQL ---\nthat either inserts or updates --- see\nhttp://dev.mysql.com/doc/refman/5.0/en/insert-on-duplicate.html.\n\nNote that unless the table has a PRIMARY KEY or UNIQUE index, using a\nREPLACE statement makes no sense. It becomes equivalent to INSERT,\nbecause there is no index to be used to determine whether a new row\nduplicates another.\n\nValues for all columns are taken from the values specified in the\nREPLACE statement. Any missing columns are set to their default values,\njust as happens for INSERT. You cannot refer to values from the current\nrow and use them in the new row. If you use an assignment such as SET\ncol_name = col_name + 1, the reference to the column name on the right\nhand side is treated as DEFAULT(col_name), so the assignment is\nequivalent to SET col_name = DEFAULT(col_name) + 1.\n\nTo use REPLACE, you must have both the INSERT and DELETE privileges for\nthe table.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/replace.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/replace.html'),
 (4,'CONTAINS',28,'Contains(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 completely contains g2. This\ntests the opposite relationship as Within().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html');
INSERT INTO `mysql`.`help_topic` VALUES  (5,'SRID',33,'SRID(g)\n\nReturns an integer indicating the Spatial Reference System ID for the\ngeometry value g.\n\nIn MySQL, the SRID value is just an integer associated with the\ngeometry value. All calculations are done assuming Euclidean (planar)\ngeometry.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions\n\n','mysql> SELECT SRID(GeomFromText(\'LineString(1 1,2 2)\',101));\n+-----------------------------------------------+\n| SRID(GeomFromText(\'LineString(1 1,2 2)\',101)) |\n+-----------------------------------------------+\n|                                           101 |\n+-----------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions'),
 (6,'CURRENT_TIMESTAMP',29,'Syntax:\nCURRENT_TIMESTAMP, CURRENT_TIMESTAMP()\n\nCURRENT_TIMESTAMP and CURRENT_TIMESTAMP() are synonyms for NOW().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (7,'VARIANCE',15,'Syntax:\nVARIANCE(expr)\n\nReturns the population standard variance of expr. This is an extension\nto standard SQL. As of MySQL 5.0.3, the standard SQL function VAR_POP()\ncan be used instead.\n\nVARIANCE() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (8,'VAR_SAMP',15,'Syntax:\nVAR_SAMP(expr)\n\nReturns the sample variance of expr. That is, the denominator is the\nnumber of rows minus one. This function was added in MySQL 5.0.3.\n\nVAR_SAMP() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (9,'CONCAT',34,'Syntax:\nCONCAT(str1,str2,...)\n\nReturns the string that results from concatenating the arguments. May\nhave one or more arguments. If all arguments are non-binary strings,\nthe result is a non-binary string. If the arguments include any binary\nstrings, the result is a binary string. A numeric argument is converted\nto its equivalent binary string form; if you want to avoid that, you\ncan use an explicit type cast, as in this example:\n\nSELECT CONCAT(CAST(int_col AS CHAR), char_col);\n\nCONCAT() returns NULL if any argument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT CONCAT(\'My\', \'S\', \'QL\');\n        -> \'MySQL\'\nmysql> SELECT CONCAT(\'My\', NULL, \'QL\');\n        -> NULL\nmysql> SELECT CONCAT(14.3);\n        -> \'14.3\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (10,'GEOMETRY HIERARCHY',31,'Geometry is the base class. It is an abstract class. The instantiable\nsubclasses of Geometry are restricted to zero-, one-, and\ntwo-dimensional geometric objects that exist in two-dimensional\ncoordinate space. All instantiable geometry classes are defined so that\nvalid instances of a geometry class are topologically closed (that is,\nall defined geometries include their boundary).\n\nThe base Geometry class has subclasses for Point, Curve, Surface, and\nGeometryCollection:\n\no Point represents zero-dimensional objects.\n\no Curve represents one-dimensional objects, and has subclass\n  LineString, with sub-subclasses Line and LinearRing.\n\no Surface is designed for two-dimensional objects and has subclass\n  Polygon.\n\no GeometryCollection has specialized zero-, one-, and two-dimensional\n  collection classes named MultiPoint, MultiLineString, and\n  MultiPolygon for modeling geometries corresponding to collections of\n  Points, LineStrings, and Polygons, respectively. MultiCurve and\n  MultiSurface are introduced as abstract superclasses that generalize\n  the collection interfaces to handle Curves and Surfaces.\n\nGeometry, Curve, Surface, MultiCurve, and MultiSurface are defined as\nnon-instantiable classes. They define a common set of methods for their\nsubclasses and are included for extensibility.\n\nPoint, LineString, Polygon, GeometryCollection, MultiPoint,\nMultiLineString, and MultiPolygon are instantiable classes.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/gis-geometry-class-hierarchy.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/gis-geometry-class-hierarchy.html');
INSERT INTO `mysql`.`help_topic` VALUES  (11,'CHAR FUNCTION',34,'Syntax:\nCHAR(N,... [USING charset_name])\n\nCHAR() interprets each argument N as an integer and returns a string\nconsisting of the characters given by the code values of those\nintegers. NULL values are skipped.\nAs of MySQL 5.0.15, CHAR() arguments larger than 255 are converted into\nmultiple result bytes. For example, CHAR(256) is equivalent to\nCHAR(1,0), and CHAR(256*256) is equivalent to CHAR(1,0,0):\n\nmysql> SELECT HEX(CHAR(1,0)), HEX(CHAR(256));\n+----------------+----------------+\n| HEX(CHAR(1,0)) | HEX(CHAR(256)) |\n+----------------+----------------+\n| 0100           | 0100           |\n+----------------+----------------+\nmysql> SELECT HEX(CHAR(1,0,0)), HEX(CHAR(256*256));\n+------------------+--------------------+\n| HEX(CHAR(1,0,0)) | HEX(CHAR(256*256)) |\n+------------------+--------------------+\n| 010000           | 010000             |\n+------------------+--------------------+\n\nBy default, CHAR() returns a binary string. To produce a string in a\ngiven character set, use the optional USING clause:\n\nmysql> SELECT CHARSET(CHAR(0x65)), CHARSET(CHAR(0x65 USING utf8));\n+---------------------+--------------------------------+\n| CHARSET(CHAR(0x65)) | CHARSET(CHAR(0x65 USING utf8)) |\n+---------------------+--------------------------------+\n| binary              | utf8                           |\n+---------------------+--------------------------------+\n\nIf USING is given and the result string is illegal for the given\ncharacter set, a warning is issued. Also, if strict SQL mode is\nenabled, the result from CHAR() becomes NULL.\n\nBefore MySQL 5.0.15, CHAR() returns a string in the connection\ncharacter set and the USING clause is unavailable. In addition, each\nargument is interpreted modulo 256, so CHAR(256) and CHAR(256*256) both\nare equivalent to CHAR(0).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT CHAR(77,121,83,81,\'76\');\n        -> \'MySQL\'\nmysql> SELECT CHAR(77,77.3,\'77.3\');\n        -> \'MMM\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (12,'DATETIME',19,'DATETIME\n\nA date and time combination. The supported range is \'1000-01-01\n00:00:00\' to \'9999-12-31 23:59:59\'. MySQL displays DATETIME values in\n\'YYYY-MM-DD HH:MM:SS\' format, but allows assignment of values to\nDATETIME columns using either strings or numbers.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (13,'OPEN',21,'Syntax:\nOPEN cursor_name\n\nThis statement opens a previously declared cursor.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/open.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/open.html'),
 (14,'SHOW CREATE PROCEDURE',25,'Syntax:\nSHOW CREATE PROCEDURE proc_name\n\nThis statement is a MySQL extension. It returns the exact string that\ncan be used to re-create the named stored procedure. A similar\nstatement, SHOW CREATE FUNCTION, displays information about stored\nfunctions (see [HELP SHOW CREATE FUNCTION]).\n\nBoth statements require that you be the owner of the routine or have\nSELECT access to the mysql.proc table. If you do not have privileges\nfor the routine itself, the value displayed for the Create Procedure or\nCreate Function field will be NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-create-procedure.html\n\n','mysql> SHOW CREATE PROCEDURE test.simpleproc\\G\n*************************** 1. row ***************************\n       Procedure: simpleproc\n        sql_mode: \nCreate Procedure: CREATE PROCEDURE `simpleproc`(OUT param1 INT)\n                  BEGIN\n                  SELECT COUNT(*) INTO param1 FROM t;\n                  END\n\nmysql> SHOW CREATE FUNCTION test.hello\\G\n*************************** 1. row ***************************\n       Function: hello\n       sql_mode:\nCreate Function: CREATE FUNCTION `hello`(s CHAR(20))\n                 RETURNS CHAR(50)\n                 RETURN CONCAT(\'Hello, \',s,\'!\')\n','http://dev.mysql.com/doc/refman/5.0/en/show-create-procedure.html'),
 (15,'INTEGER',19,'INTEGER[(M)] [UNSIGNED] [ZEROFILL]\n\nThis type is a synonym for INT.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (16,'LOWER',34,'Syntax:\nLOWER(str)\n\nReturns the string str with all characters changed to lowercase\naccording to the current character set mapping. The default is latin1\n(cp1252 West European).\n\nmysql> SELECT LOWER(\'QUADRATICALLY\');\n        -> \'quadratically\'\n\nLOWER() (and UPPER()) are ineffective when applied to binary strings\n(BINARY, VARBINARY, BLOB). To perform lettercase conversion, convert\nthe string to a non-binary string:\n\nmysql> SET @str = BINARY \'New York\';\nmysql> SELECT LOWER(@str), LOWER(CONVERT(@str USING latin1));\n+-------------+-----------------------------------+\n| LOWER(@str) | LOWER(CONVERT(@str USING latin1)) |\n+-------------+-----------------------------------+\n| New York    | new york                          | \n+-------------+-----------------------------------+\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (17,'SHOW COLUMNS',25,'Syntax:\nSHOW [FULL] COLUMNS FROM tbl_name [FROM db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW COLUMNS displays information about the columns in a given table.\nIt also works for views as of MySQL 5.0.1. The LIKE clause, if present,\nindicates which column names to match. The WHERE clause can be given to\nselect rows using more general conditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nmysql> SHOW COLUMNS FROM City;\n+------------+----------+------+-----+---------+----------------+\n| Field      | Type     | Null | Key | Default | Extra          |\n+------------+----------+------+-----+---------+----------------+\n| Id         | int(11)  | NO   | PRI | NULL    | auto_increment |\n| Name       | char(35) | NO   |     |         |                |\n| Country    | char(3)  | NO   | UNI |         |                |\n| District   | char(20) | YES  | MUL |         |                |\n| Population | int(11)  | NO   |     | 0       |                |\n+------------+----------+------+-----+---------+----------------+\n5 rows in set (0.00 sec)\n\nIf the data types differ from what you expect them to be based on a\nCREATE TABLE statement, note that MySQL sometimes changes data types\nwhen you create or alter a table. The conditions under which this\noccurs are described in\nhttp://dev.mysql.com/doc/refman/5.0/en/silent-column-changes.html.\n\nThe FULL keyword causes the output to include the column collation and\ncomments, as well as the privileges you have for each column.\n\nYou can use db_name.tbl_name as an alternative to the tbl_name FROM\ndb_name syntax. In other words, these two statements are equivalent:\n\nmysql> SHOW COLUMNS FROM mytable FROM mydb;\nmysql> SHOW COLUMNS FROM mydb.mytable;\n\nSHOW COLUMNS displays the following values for each table column:\n\nField indicates the column name.\n\nType indicates the column data type.\n\nCollation indicates the collation for non-binary string columns, or\nNULL for other columns. This value is displayed only if you use the\nFULL keyword.\n\nThe Null field contains YES if NULL values can be stored in the column.\nIf not, the column contains NO as of MySQL 5.0.3, and \'\' before that.\n\nThe Key field indicates whether the column is indexed:\n\no If Key is empty, the column either is not indexed or is indexed only\n  as a secondary column in a multiple-column, non-unique index.\n\no If Key is PRI, the column is a PRIMARY KEY or is one of the columns\n  in a multiple-column PRIMARY KEY.\n\no If Key is UNI, the column is the first column of a unique-valued\n  index that cannot contain NULL values.\n\no If Key is MUL, multiple occurrences of a given value are allowed\n  within the column. The column is the first column of a non-unique\n  index or a unique-valued index that can contain NULL values.\n\nIf more than one of the Key values applies to a given column of a\ntable, Key displays the one with the highest priority, in the order\nPRI, UNI, MUL.\n\nA UNIQUE index may be displayed as PRI if it cannot contain NULL values\nand there is no PRIMARY KEY in the table. A UNIQUE index may display as\nMUL if several columns form a composite UNIQUE index; although the\ncombination of the columns is unique, each column can still hold\nmultiple occurrences of a given value.\n\nBefore MySQL 5.0.11, if the column allows NULL values, the Key value\ncan be MUL even when a single-column UNIQUE index is used. The\nrationale was that multiple rows in a UNIQUE index can hold a NULL\nvalue if the column is not declared NOT NULL. As of MySQL 5.0.11, the\ndisplay is UNI rather than MUL regardless of whether the column allows\nNULL; you can see from the Null field whether or not the column can\ncontain NULL.\n\nThe Default field indicates the default value that is assigned to the\ncolumn.\n\nThe Extra field contains any additional information that is available\nabout a given column. The value is auto_increment if the column was\ncreated with the AUTO_INCREMENT keyword and empty otherwise.\n\nPrivileges indicates the privileges you have for the column. This value\nis displayed only if you use the FULL keyword.\n\nComment indicates any comment the column has. This value is displayed\nonly if you use the FULL keyword.\n\nSHOW FIELDS is a synonym for SHOW COLUMNS. You can also list a table\'s\ncolumns with the mysqlshow db_name tbl_name command.\n\nThe DESCRIBE statement provides information similar to SHOW COLUMNS.\nSee [HELP DESCRIBE].\n\nThe SHOW CREATE TABLE, SHOW TABLE STATUS, and SHOW INDEX statements\nalso provide information about tables. See [HELP SHOW].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-columns.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-columns.html');
INSERT INTO `mysql`.`help_topic` VALUES  (18,'CREATE TRIGGER',36,'Syntax:\nCREATE\n    [DEFINER = { user | CURRENT_USER }]\n    TRIGGER trigger_name trigger_time trigger_event\n    ON tbl_name FOR EACH ROW trigger_stmt\n\nThis statement creates a new trigger. A trigger is a named database\nobject that is associated with a table, and that activates when a\nparticular event occurs for the table. The trigger becomes associated\nwith the table named tbl_name, which must refer to a permanent table.\nYou cannot associate a trigger with a TEMPORARY table or a view. CREATE\nTRIGGER was added in MySQL 5.0.2.\n\nIn MySQL 5.0 CREATE TRIGGER requires the SUPER privilege.\n\nThe DEFINER clause determines the security context to be used when\nchecking access privileges at trigger activation time.\n\ntrigger_time is the trigger action time. It can be BEFORE or AFTER to\nindicate that the trigger activates before or after each row to be\nmodified.\n\ntrigger_event indicates the kind of statement that activates the\ntrigger. The trigger_event can be one of the following:\n\no INSERT: The trigger is activated whenever a new row is inserted into\n  the table; for example, through INSERT, LOAD DATA, and REPLACE\n  statements.\n\no UPDATE: The trigger is activated whenever a row is modified; for\n  example, through UPDATE statements.\n\no DELETE: The trigger is activated whenever a row is deleted from the\n  table; for example, through DELETE and REPLACE statements. However,\n  DROP TABLE and TRUNCATE statements on the table do not activate this\n  trigger, because they do not use DELETE. See [HELP TRUNCATE TABLE].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-trigger.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/create-trigger.html'),
 (19,'MONTH',29,'Syntax:\nMONTH(date)\n\nReturns the month for date, in the range 1 to 12 for January to\nDecember, or 0 for dates such as \'0000-00-00\' or \'2008-00-00\' that have\na zero month part.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT MONTH(\'2008-02-03\');\n        -> 2\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (20,'TINYINT',19,'TINYINT[(M)] [UNSIGNED] [ZEROFILL]\n\nA very small integer. The signed range is -128 to 127. The unsigned\nrange is 0 to 255.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (21,'SHOW TRIGGERS',25,'Syntax:\nSHOW TRIGGERS [FROM db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW TRIGGERS lists the triggers currently defined for tables in a\ndatabase (the default database unless a FROM clause is given). This\nstatement requires the SUPER privilege. It was implemented in MySQL\n5.0.10. The LIKE clause, if present, indicates which table names to\nmatch and causes the statement to display triggers for those tables.\nThe WHERE clause can be given to select rows using more general\nconditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nFor the trigger ins_sum as defined in\nhttp://dev.mysql.com/doc/refman/5.0/en/triggers.html, the output of\nthis statement is as shown here:\n\nmysql> SHOW TRIGGERS LIKE \'acc%\'\\G\n*************************** 1. row ***************************\n  Trigger: ins_sum\n    Event: INSERT\n    Table: account\nStatement: SET @sum = @sum + NEW.amount\n   Timing: BEFORE\n  Created: NULL\n sql_mode:\n  Definer: myname@localhost\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-triggers.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-triggers.html'),
 (22,'MASTER_POS_WAIT',13,'Syntax:\nMASTER_POS_WAIT(log_name,log_pos[,timeout])\n\nThis function is useful for control of master/slave synchronization. It\nblocks until the slave has read and applied all updates up to the\nspecified position in the master log. The return value is the number of\nlog events the slave had to wait for to advance to the specified\nposition. The function returns NULL if the slave SQL thread is not\nstarted, the slave\'s master information is not initialized, the\narguments are incorrect, or an error occurs. It returns -1 if the\ntimeout has been exceeded. If the slave SQL thread stops while\nMASTER_POS_WAIT() is waiting, the function returns NULL. If the slave\nis past the specified position, the function returns immediately.\n\nIf a timeout value is specified, MASTER_POS_WAIT() stops waiting when\ntimeout seconds have elapsed. timeout must be greater than 0; a zero or\nnegative timeout means no timeout.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (23,'REGEXP',34,'Syntax:\nexpr REGEXP pat, expr RLIKE pat\n\nPerforms a pattern match of a string expression expr against a pattern\npat. The pattern can be an extended regular expression. The syntax for\nregular expressions is discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/regexp.html. Returns 1 if expr\nmatches pat; otherwise it returns 0. If either expr or pat is NULL, the\nresult is NULL. RLIKE is a synonym for REGEXP, provided for mSQL\ncompatibility.\n\nThe pattern need not be a literal string. For example, it can be\nspecified as a string expression or table column.\n\n*Note*: Because MySQL uses the C escape syntax in strings (for example,\n\"\\n\" to represent the newline character), you must double any \"\\\" that\nyou use in your REGEXP strings.\n\nREGEXP is not case sensitive, except when used with binary strings.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/regexp.html\n\n','mysql> SELECT \'Monty!\' REGEXP \'m%y%%\';\n        -> 0\nmysql> SELECT \'Monty!\' REGEXP \'.*\';\n        -> 1\nmysql> SELECT \'new*\\n*line\' REGEXP \'new\\\\*.\\\\*line\';\n        -> 1\nmysql> SELECT \'a\' REGEXP \'A\', \'a\' REGEXP BINARY \'A\';\n        -> 1  0\nmysql> SELECT \'a\' REGEXP \'^[a-d]\';\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/regexp.html'),
 (24,'IF STATEMENT',21,'Syntax:\nIF search_condition THEN statement_list\n    [ELSEIF search_condition THEN statement_list] ...\n    [ELSE statement_list]\nEND IF\n\nIF implements a basic conditional construct. If the search_condition\nevaluates to true, the corresponding SQL statement list is executed. If\nno search_condition matches, the statement list in the ELSE clause is\nexecuted. Each statement_list consists of one or more statements.\n\n*Note*: There is also an IF() function, which differs from the IF\nstatement described here. See\nhttp://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/if-statement.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/if-statement.html');
INSERT INTO `mysql`.`help_topic` VALUES  (25,'^',17,'Syntax:\n^\n\nBitwise XOR:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html\n\n','mysql> SELECT 1 ^ 1;\n        -> 0\nmysql> SELECT 1 ^ 0;\n        -> 1\nmysql> SELECT 11 ^ 3;\n        -> 8\n','http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html'),
 (26,'DROP VIEW',36,'Syntax:\nDROP VIEW [IF EXISTS]\n    view_name [, view_name] ...\n    [RESTRICT | CASCADE]\n\nDROP VIEW removes one or more views. You must have the DROP privilege\nfor each view. If any of the views named in the argument list do not\nexist, MySQL returns an error indicating by name which non-existing\nviews it was unable to drop, but it also drops all of the views in the\nlist that do exist.\n\nThe IF EXISTS clause prevents an error from occurring for views that\ndon\'t exist. When this clause is given, a NOTE is generated for each\nnon-existent view. See [HELP SHOW WARNINGS].\n\nRESTRICT and CASCADE, if given, are parsed and ignored.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-view.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-view.html'),
 (27,'WITHIN',28,'Within(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 is spatially within g2. This\ntests the opposite relationship as Contains().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html');
INSERT INTO `mysql`.`help_topic` VALUES  (28,'WEEK',29,'Syntax:\nWEEK(date[,mode])\n\nThis function returns the week number for date. The two-argument form\nof WEEK() allows you to specify whether the week starts on Sunday or\nMonday and whether the return value should be in the range from 0 to 53\nor from 1 to 53. If the mode argument is omitted, the value of the\ndefault_week_format system variable is used. See\nhttp://dev.mysql.com/doc/refman/5.0/en/server-system-variables.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT WEEK(\'2008-02-20\');\n        -> 7\nmysql> SELECT WEEK(\'2008-02-20\',0);\n        -> 7\nmysql> SELECT WEEK(\'2008-02-20\',1);\n        -> 8\nmysql> SELECT WEEK(\'2008-12-31\',1);\n        -> 53\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (29,'DROP FUNCTION UDF',20,'Syntax:\nDROP FUNCTION function_name\n\nThis statement drops the user-defined function (UDF) named\nfunction_name.\n\nTo drop a function, you must have the DELETE privilege for the mysql\ndatabase. This is because DROP FUNCTION removes a row from the\nmysql.func system table that records the function\'s name, type, and\nshared library name.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-function-udf.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-function-udf.html'),
 (30,'PREPARE',25,'Syntax:\nPREPARE stmt_name FROM preparable_stmt\n\nThe PREPARE statement prepares a statement and assigns it a name,\nstmt_name, by which to refer to the statement later. Statement names\nare not case sensitive. preparable_stmt is either a string literal or a\nuser variable that contains the text of the statement. The text must\nrepresent a single SQL statement, not multiple statements. Within the\nstatement, \"?\" characters can be used as parameter markers to indicate\nwhere data values are to be bound to the query later when you execute\nit. The \"?\" characters should not be enclosed within quotes, even if\nyou intend to bind them to string values. Parameter markers can be used\nonly where data values should appear, not for SQL keywords,\nidentifiers, and so forth.\n\nIf a prepared statement with the given name already exists, it is\ndeallocated implicitly before the new statement is prepared. This means\nthat if the new statement contains an error and cannot be prepared, an\nerror is returned and no statement with the given name exists.\n\nThe scope of a prepared statement is the client session within which it\nis created. Other clients cannot see it.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/sql-syntax-prepared-statements.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/sql-syntax-prepared-statements.html');
INSERT INTO `mysql`.`help_topic` VALUES  (31,'LOCK',7,'Syntax:\nLOCK TABLES\n    tbl_name [[AS] alias] lock_type\n    [, tbl_name [[AS] alias] lock_type] ...\n\nlock_type:\n    READ [LOCAL]\n  | [LOW_PRIORITY] WRITE\n\nUNLOCK TABLES\n\nMySQL enables client sessions to acquire table locks explicitly for the\npurpose of cooperating with other sessions for access to tables, or to\nprevent other sessions from modifying tables during periods when a\nsession requires exclusive access to them. A session can acquire or\nrelease locks only for itself. One session cannot acquire locks for\nanother session or release locks held by another session.\n\nLOCK TABLES acquires table locks for the current thread. It locks base\ntables or (as of MySQL 5.0.6) views. (For view locking, LOCK TABLES\nadds all base tables used in the view to the set of tables to be locked\nand locks them automatically.) To use LOCK TABLES, you must have the\nLOCK TABLES privilege, and the SELECT privilege for each object to be\nlocked.\n\nMySQL enables client sessions to acquire table locks explicitly Locks\nmay be used to emulate transactions or to get more speed when updating\ntables. This is explained in more detail later in this section.\n\nUNLOCK TABLES explicitly releases any table locks held by the current\nthread. Another use for UNLOCK TABLES is to release the global read\nlock acquired with FLUSH TABLES WITH READ LOCK. (You can lock all\ntables in all databases with a read lock with the FLUSH TABLES WITH\nREAD LOCK statement. See [HELP FLUSH]. This is a very convenient way to\nget backups if you have a filesystem such as Veritas that can take\nsnapshots in time.)\n\nThe following discussion applies only to non-TEMPORARY tables. LOCK\nTABLES is allowed (but ignored) for a TEMPORARY table. The table can be\naccessed freely by the session within which it was created, regardless\nof what other locking may be in effect. No lock is necessary because no\nother session can see the table.\n\nThe following general rules apply to acquisition and release of locks\nby a given thread:\n\no Table locks are acquired with LOCK TABLES.\n\no If the LOCK TABLES statement must wait due to locks held by other\n  threads on any of the tables, it blocks until all locks can be\n  acquired.\n\no Table locks are released explicitly with UNLOCK TABLES.\n\no Table locks are released implicitly under these conditions:\n\n  o LOCK TABLES releases any table locks currently held by the thread\n    before acquiring new locks.\n\n  o Beginning a transaction (for example, with START TRANSACTION)\n    implicitly performs an UNLOCK TABLES. (Additional information about\n    the interaction between table locking and transactions is given\n    later in this section.)\n\n  o If a client connection drops, the server releases table locks held\n    by the client. If the client reconnects, the locks will no longer\n    be in effect. In addition, if the client had an active transaction,\n    the server rolls back the transaction upon disconnect, and if\n    reconnect occurs, the new session begins with autocommit enabled.\n    For this reason, clients may wish to disable auto-reconnect. With\n    auto-reconnect in effect, the client is not notified if reconnect\n    occurs but any table locks or current transaction will have been\n    lost. With auto-reconnect disabled, if the connection drops, an\n    error occurs for the next statement issued. The client can detect\n    the error and take appropriate action such as reacquiring the locks\n    or redoing the transaction. See\n    http://dev.mysql.com/doc/refman/5.0/en/auto-reconnect.html.\n\n*Note*: If you use ALTER TABLE on a locked table, it may become\nunlocked. See\nhttp://dev.mysql.com/doc/refman/5.0/en/alter-table-problems.html.\n\nA table lock protects only against inappropriate reads or writes by\nother clients. The client holding the lock, even a read lock, can\nperform table-level operations such as DROP TABLE. Truncate operations\nare not transaction-safe, so an error occurs if the client attempts one\nduring an active transaction or while holding a table lock.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/lock-tables.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/lock-tables.html'),
 (32,'RESET SLAVE',25,'Syntax:\nRESET SLAVE\n\nRESET SLAVE makes the slave forget its replication position in the\nmaster\'s binary logs. This statement is meant to be used for a clean\nstart: It deletes the master.info and relay-log.info files, all the\nrelay logs, and starts a new relay log.\n\n*Note*: All relay logs are deleted, even if they have not been\ncompletely executed by the slave SQL thread. (This is a condition\nlikely to exist on a replication slave if you have issued a STOP SLAVE\nstatement or if the slave is highly loaded.)\n\nConnection information stored in the master.info file is immediately\nreset using any values specified in the corresponding startup options.\nThis information includes values such as master host, master port,\nmaster user, and master password. If the slave SQL thread was in the\nmiddle of replicating temporary tables when it was stopped, and RESET\nSLAVE is issued, these replicated temporary tables are deleted on the\nslave.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/reset-slave.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/reset-slave.html');
INSERT INTO `mysql`.`help_topic` VALUES  (33,'SHOW BINARY LOGS',25,'Syntax:\nSHOW BINARY LOGS\nSHOW MASTER LOGS\n\nLists the binary log files on the server. This statement is used as\npart of the procedure described in [HELP PURGE BINARY LOGS], that shows\nhow to determine which logs can be purged.\n\nmysql> SHOW BINARY LOGS;\n+---------------+-----------+\n| Log_name      | File_size |\n+---------------+-----------+\n| binlog.000015 |    724935 |\n| binlog.000016 |    733481 |\n+---------------+-----------+\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-binary-logs.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-binary-logs.html'),
 (34,'POLYGON',22,'Polygon(ls1,ls2,...)\n\nConstructs a WKB Polygon value from a number of WKB LineString\narguments. If any argument does not represent the WKB of a LinearRing\n(that is, not a closed and simple LineString) the return value is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions'),
 (35,'MINUTE',29,'Syntax:\nMINUTE(time)\n\nReturns the minute for time, in the range 0 to 59.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT MINUTE(\'2008-02-03 10:05:03\');\n        -> 5\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (36,'DAY',29,'Syntax:\nDAY(date)\n\nDAY() is a synonym for DAYOFMONTH().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (37,'MID',34,'Syntax:\nMID(str,pos,len)\n\nMID(str,pos,len) is a synonym for SUBSTRING(str,pos,len).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (38,'UUID',13,'Syntax:\nUUID()\n\nReturns a Universal Unique Identifier (UUID) generated according to\n\"DCE 1.1: Remote Procedure Call\" (Appendix A) CAE (Common Applications\nEnvironment) Specifications published by The Open Group in October 1997\n(Document Number C706,\nhttp://www.opengroup.org/public/pubs/catalog/c706.htm).\n\nA UUID is designed as a number that is globally unique in space and\ntime. Two calls to UUID() are expected to generate two different\nvalues, even if these calls are performed on two separate computers\nthat are not connected to each other.\n\nA UUID is a 128-bit number represented by a utf8 string of five\nhexadecimal numbers in aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee format:\n\no The first three numbers are generated from a timestamp.\n\no The fourth number preserves temporal uniqueness in case the timestamp\n  value loses monotonicity (for example, due to daylight saving time).\n\no The fifth number is an IEEE 802 node number that provides spatial\n  uniqueness. A random number is substituted if the latter is not\n  available (for example, because the host computer has no Ethernet\n  card, or we do not know how to find the hardware address of an\n  interface on your operating system). In this case, spatial uniqueness\n  cannot be guaranteed. Nevertheless, a collision should have very low\n  probability.\n\n  Currently, the MAC address of an interface is taken into account only\n  on FreeBSD and Linux. On other operating systems, MySQL uses a\n  randomly generated 48-bit number.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','mysql> SELECT UUID();\n        -> \'6ccd780c-baba-1026-9564-0040f4311e29\'\n','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (39,'LINESTRING',22,'LineString(pt1,pt2,...)\n\nConstructs a WKB LineString value from a number of WKB Point arguments.\nIf any argument is not a WKB Point, the return value is NULL. If the\nnumber of Point arguments is less than two, the return value is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (40,'SLEEP',13,'Syntax:\nSLEEP(duration)\n\nSleeps (pauses) for the number of seconds given by the duration\nargument, then returns 0. If SLEEP() is interrupted, it returns 1. The\nduration may have a fractional part given in microseconds. This\nfunction was added in MySQL 5.0.12.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (41,'CONNECTION_ID',14,'Syntax:\nCONNECTION_ID()\n\nReturns the connection ID (thread ID) for the connection. Every\nconnection has an ID that is unique among the set of currently\nconnected clients.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT CONNECTION_ID();\n        -> 23786\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (42,'DELETE',25,'Syntax:\nSingle-table syntax:\n\nDELETE [LOW_PRIORITY] [QUICK] [IGNORE] FROM tbl_name\n    [WHERE where_condition]\n    [ORDER BY ...]\n    [LIMIT row_count]\n\nMultiple-table syntax:\n\nDELETE [LOW_PRIORITY] [QUICK] [IGNORE]\n    tbl_name[.*] [, tbl_name[.*]] ...\n    FROM table_references\n    [WHERE where_condition]\n\nOr:\n\nDELETE [LOW_PRIORITY] [QUICK] [IGNORE]\n    FROM tbl_name[.*] [, tbl_name[.*]] ...\n    USING table_references\n    [WHERE where_condition]\n\nFor the single-table syntax, the DELETE statement deletes rows from\ntbl_name and returns a count of the number of deleted rows. This count\ncan be obtained by calling the ROW_COUNT() function (see\nhttp://dev.mysql.com/doc/refman/5.0/en/information-functions.html). The\nWHERE clause, if given, specifies the conditions that identify which\nrows to delete. With no WHERE clause, all rows are deleted. If the\nORDER BY clause is specified, the rows are deleted in the order that is\nspecified. The LIMIT clause places a limit on the number of rows that\ncan be deleted.\n\nFor the multiple-table syntax, DELETE deletes from each tbl_name the\nrows that satisfy the conditions. In this case, ORDER BY and LIMIT\ncannot be used.\n\nwhere_condition is an expression that evaluates to true for each row to\nbe deleted. It is specified as described in\nhttp://dev.mysql.com/doc/refman/5.0/en/select.html.\n\nCurrently, you cannot delete from a table and select from the same\ntable in a subquery.\n\nAs stated, a DELETE statement with no WHERE clause deletes all rows. A\nfaster way to do this, when you do not need to know the number of\ndeleted rows, is to use TRUNCATE TABLE. However, within a transaction\nor if you have a lock on the table, TRUNCATE TABLE cannot be used\nwhereas DELETE can. See [HELP TRUNCATE TABLE], and [HELP LOCK].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/delete.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/delete.html'),
 (43,'ROUND',4,'Syntax:\nROUND(X), ROUND(X,D)\n\nRounds the argument X to D decimal places. The rounding algorithm\ndepends on the data type of X. D defaults to 0 if not specified. D can\nbe negative to cause D digits left of the decimal point of the value X\nto become zero.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT ROUND(-1.23);\n        -> -1\nmysql> SELECT ROUND(-1.58);\n        -> -2\nmysql> SELECT ROUND(1.58);\n        -> 2\nmysql> SELECT ROUND(1.298, 1);\n        -> 1.3\nmysql> SELECT ROUND(1.298, 0);\n        -> 1\nmysql> SELECT ROUND(23.298, -1);\n        -> 20\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (44,'NULLIF',6,'Syntax:\nNULLIF(expr1,expr2)\n\nReturns NULL if expr1 = expr2 is true, otherwise returns expr1. This is\nthe same as CASE WHEN expr1 = expr2 THEN NULL ELSE expr1 END.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html\n\n','mysql> SELECT NULLIF(1,1);\n        -> NULL\nmysql> SELECT NULLIF(1,2);\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html'),
 (45,'CLOSE',21,'Syntax:\nCLOSE cursor_name\n\nThis statement closes a previously opened cursor.\n\nIf not closed explicitly, a cursor is closed at the end of the compound\nstatement in which it was declared.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/close.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/close.html'),
 (46,'STOP SLAVE',25,'Syntax:\nSTOP SLAVE [thread_type [, thread_type] ... ]\n\nthread_type: IO_THREAD | SQL_THREAD\n\nStops the slave threads. STOP SLAVE requires the SUPER privilege.\n\nLike START SLAVE, this statement may be used with the IO_THREAD and\nSQL_THREAD options to name the thread or threads to be stopped.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/stop-slave.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/stop-slave.html'),
 (47,'TIMEDIFF',29,'Syntax:\nTIMEDIFF(expr1,expr2)\n\nTIMEDIFF() returns expr1 - expr2 expressed as a time value. expr1 and\nexpr2 are time or date-and-time expressions, but both must be of the\nsame type.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT TIMEDIFF(\'2000:01:01 00:00:00\',\n    ->                 \'2000:01:01 00:00:00.000001\');\n        -> \'-00:00:00.000001\'\nmysql> SELECT TIMEDIFF(\'2008-12-31 23:59:59.000001\',\n    ->                 \'2008-12-30 01:01:01.000002\');\n        -> \'46:58:57.999999\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (48,'REPLACE FUNCTION',34,'Syntax:\nREPLACE(str,from_str,to_str)\n\nReturns the string str with all occurrences of the string from_str\nreplaced by the string to_str. REPLACE() performs a case-sensitive\nmatch when searching for from_str.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT REPLACE(\'www.mysql.com\', \'w\', \'Ww\');\n        -> \'WwWwWw.mysql.com\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (49,'USE',26,'Syntax:\nUSE db_name\n\nThe USE db_name statement tells MySQL to use the db_name database as\nthe default (current) database for subsequent statements. The database\nremains the default until the end of the session or another USE\nstatement is issued:\n\nUSE db1;\nSELECT COUNT(*) FROM mytable;   # selects from db1.mytable\nUSE db2;\nSELECT COUNT(*) FROM mytable;   # selects from db2.mytable\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/use.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/use.html'),
 (50,'LINEFROMTEXT',3,'LineFromText(wkt[,srid]), LineStringFromText(wkt[,srid])\n\nConstructs a LINESTRING value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (51,'CASE OPERATOR',6,'Syntax:\nCASE value WHEN [compare_value] THEN result [WHEN [compare_value] THEN\nresult ...] [ELSE result] END\n\nCASE WHEN [condition] THEN result [WHEN [condition] THEN result ...]\n[ELSE result] END\n\nThe first version returns the result where value=compare_value. The\nsecond version returns the result for the first condition that is true.\nIf there was no matching result value, the result after ELSE is\nreturned, or NULL if there is no ELSE part.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html\n\n','mysql> SELECT CASE 1 WHEN 1 THEN \'one\'\n    ->     WHEN 2 THEN \'two\' ELSE \'more\' END;\n        -> \'one\'\nmysql> SELECT CASE WHEN 1>0 THEN \'true\' ELSE \'false\' END;\n        -> \'true\'\nmysql> SELECT CASE BINARY \'B\'\n    ->     WHEN \'a\' THEN 1 WHEN \'b\' THEN 2 END;\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html'),
 (52,'SHOW MASTER STATUS',25,'Syntax:\nSHOW MASTER STATUS\n\nProvides status information about the binary log files of the master.\nExample:\n\nmysql> SHOW MASTER STATUS;\n+---------------+----------+--------------+------------------+\n| File          | Position | Binlog_Do_DB | Binlog_Ignore_DB |\n+---------------+----------+--------------+------------------+\n| mysql-bin.003 | 73       | test         | manual,mysql     |\n+---------------+----------+--------------+------------------+\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-master-status.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-master-status.html'),
 (53,'ADDTIME',29,'Syntax:\nADDTIME(expr1,expr2)\n\nADDTIME() adds expr2 to expr1 and returns the result. expr1 is a time\nor datetime expression, and expr2 is a time expression.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT ADDTIME(\'2007-12-31 23:59:59.999999\', \'1 1:1:1.000002\');\n        -> \'2008-01-02 01:01:01.000001\'\nmysql> SELECT ADDTIME(\'01:00:00.999999\', \'02:00:00.999998\');\n        -> \'03:00:01.999997\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (54,'SPATIAL',31,'MySQL can create spatial indexes using syntax similar to that for\ncreating regular indexes, but extended with the SPATIAL keyword.\nCurrently, columns in spatial indexes must be declared NOT NULL. The\nfollowing examples demonstrate how to create spatial indexes:\n\no With CREATE TABLE:\n\nCREATE TABLE geom (g GEOMETRY NOT NULL, SPATIAL INDEX(g));\n\no With ALTER TABLE:\n\nALTER TABLE geom ADD SPATIAL INDEX(g);\n\no With CREATE INDEX:\n\nCREATE SPATIAL INDEX sp_index ON geom (g);\n\nFor MyISAM tables, SPATIAL INDEX creates an R-tree index. For storage\nengines that support non-spatial indexing of spatial columns, the\nengine creates a B-tree index. A B-tree index on spatial values will be\nuseful for exact-value lookups, but not for range scans.\n\nFor more information on indexing spatial columns, see [HELP CREATE\nINDEX].\n\nTo drop spatial indexes, use ALTER TABLE or DROP INDEX:\n\no With ALTER TABLE:\n\nALTER TABLE geom DROP INDEX g;\n\no With DROP INDEX:\n\nDROP INDEX sp_index ON geom;\n\nExample: Suppose that a table geom contains more than 32,000\ngeometries, which are stored in the column g of type GEOMETRY. The\ntable also has an AUTO_INCREMENT column fid for storing object ID\nvalues.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-indexes.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-indexes.html'),
 (55,'TIMESTAMPDIFF',29,'Syntax:\nTIMESTAMPDIFF(unit,datetime_expr1,datetime_expr2)\n\nReturns datetime_expr2 - datetime_expr1, where datetime_expr1 and\ndatetime_expr2 are date or datetime expressions. One expression may be\na date and the other a datetime; a date value is treated as a datetime\nhaving the time part \'00:00:00\' where necessary. The unit for the\nresult (an integer) is given by the unit argument. The legal values for\nunit are the same as those listed in the description of the\nTIMESTAMPADD() function.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT TIMESTAMPDIFF(MONTH,\'2003-02-01\',\'2003-05-01\');\n        -> 3\nmysql> SELECT TIMESTAMPDIFF(YEAR,\'2002-05-01\',\'2001-01-01\');\n        -> -1\nmysql> SELECT TIMESTAMPDIFF(MINUTE,\'2003-02-01\',\'2003-05-01 12:05:55\');\n        -> 128885\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (56,'UPPER',34,'Syntax:\nUPPER(str)\n\nReturns the string str with all characters changed to uppercase\naccording to the current character set mapping. The default is latin1\n(cp1252 West European).\n\nmysql> SELECT UPPER(\'Hej\');\n        -> \'HEJ\'\n\nUPPER() is ineffective when applied to binary strings (BINARY,\nVARBINARY, BLOB). The description of LOWER() shows how to perform\nlettercase conversion of binary strings.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (57,'FROM_UNIXTIME',29,'Syntax:\nFROM_UNIXTIME(unix_timestamp), FROM_UNIXTIME(unix_timestamp,format)\n\nReturns a representation of the unix_timestamp argument as a value in\n\'YYYY-MM-DD HH:MM:SS\' or YYYYMMDDHHMMSS.uuuuuu format, depending on\nwhether the function is used in a string or numeric context. The value\nis expressed in the current time zone. unix_timestamp is an internal\ntimestamp value such as is produced by the UNIX_TIMESTAMP() function.\n\nIf format is given, the result is formatted according to the format\nstring, which is used the same way as listed in the entry for the\nDATE_FORMAT() function.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT FROM_UNIXTIME(1196440219);\n        -> \'2007-11-30 10:30:19\'\nmysql> SELECT FROM_UNIXTIME(1196440219) + 0;\n        -> 20071130103019.000000\nmysql> SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(),\n    ->                      \'%Y %D %M %h:%i:%s %x\');\n        -> \'2007 30th November 10:30:59 2007\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (58,'MEDIUMBLOB',19,'MEDIUMBLOB\n\nA BLOB column with a maximum length of 16,777,215 (224 - 1) bytes. Each\nMEDIUMBLOB value is stored using a three-byte length prefix that\nindicates the number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (59,'IFNULL',6,'Syntax:\nIFNULL(expr1,expr2)\n\nIf expr1 is not NULL, IFNULL() returns expr1; otherwise it returns\nexpr2. IFNULL() returns a numeric or string value, depending on the\ncontext in which it is used.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html\n\n','mysql> SELECT IFNULL(1,0);\n        -> 1\nmysql> SELECT IFNULL(NULL,10);\n        -> 10\nmysql> SELECT IFNULL(1/0,10);\n        -> 10\nmysql> SELECT IFNULL(1/0,\'yes\');\n        -> \'yes\'\n','http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html'),
 (60,'SHOW FUNCTION CODE',25,'Syntax:\nSHOW FUNCTION CODE func_name\n\nThis statement is similar to SHOW PROCEDURE CODE but for stored\nfunctions. See [HELP SHOW PROCEDURE CODE]. SHOW FUNCTION CODE was added\nin MySQL 5.0.17.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-function-code.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-function-code.html'),
 (61,'SHOW ERRORS',25,'Syntax:\nSHOW ERRORS [LIMIT [offset,] row_count]\nSHOW COUNT(*) ERRORS\n\nThis statement is similar to SHOW WARNINGS, except that instead of\ndisplaying errors, warnings, and notes, it displays only errors.\n\nThe LIMIT clause has the same syntax as for the SELECT statement. See\nhttp://dev.mysql.com/doc/refman/5.0/en/select.html.\n\nThe SHOW COUNT(*) ERRORS statement displays the number of errors. You\ncan also retrieve this number from the error_count variable:\n\nSHOW COUNT(*) ERRORS;\nSELECT @@error_count;\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-errors.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-errors.html'),
 (62,'LEAST',16,'Syntax:\nLEAST(value1,value2,...)\n\nWith two or more arguments, returns the smallest (minimum-valued)\nargument. The arguments are compared using the following rules:\n\no If the return value is used in an INTEGER context or all arguments\n  are integer-valued, they are compared as integers.\n\no If the return value is used in a REAL context or all arguments are\n  real-valued, they are compared as reals.\n\no If any argument is a case-sensitive string, the arguments are\n  compared as case-sensitive strings.\n\no In all other cases, the arguments are compared as case-insensitive\n  strings.\n\nBefore MySQL 5.0.13, LEAST() returns NULL only if all arguments are\nNULL. As of 5.0.13, it returns NULL if any argument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT LEAST(2,0);\n        -> 0\nmysql> SELECT LEAST(34.0,3.0,5.0,767.0);\n        -> 3.0\nmysql> SELECT LEAST(\'B\',\'A\',\'C\');\n        -> \'A\'\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html');
INSERT INTO `mysql`.`help_topic` VALUES  (63,'=',16,'=\n\nEqual:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 1 = 0;\n        -> 0\nmysql> SELECT \'0\' = 0;\n        -> 1\nmysql> SELECT \'0.0\' = 0;\n        -> 1\nmysql> SELECT \'0.01\' = 0;\n        -> 0\nmysql> SELECT \'.01\' = 0.01;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (64,'REVERSE',34,'Syntax:\nREVERSE(str)\n\nReturns the string str with the order of the characters reversed.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT REVERSE(\'abc\');\n        -> \'cba\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (65,'ISNULL',16,'Syntax:\nISNULL(expr)\n\nIf expr is NULL, ISNULL() returns 1, otherwise it returns 0.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT ISNULL(1+1);\n        -> 0\nmysql> SELECT ISNULL(1/0);\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (66,'BINARY',19,'BINARY(M)\n\nThe BINARY type is similar to the CHAR type, but stores binary byte\nstrings rather than non-binary character strings. M represents the\ncolumn length in bytes.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (67,'BLOB DATA TYPE',19,'A BLOB is a binary large object that can hold a variable amount of\ndata. The four BLOB types are TINYBLOB, BLOB, MEDIUMBLOB, and LONGBLOB.\nThese differ only in the maximum length of the values they can hold.\nThe four TEXT types are TINYTEXT, TEXT, MEDIUMTEXT, and LONGTEXT. These\ncorrespond to the four BLOB types and have the same maximum lengths and\nstorage requirements. See\nhttp://dev.mysql.com/doc/refman/5.0/en/storage-requirements.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/blob.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/blob.html'),
 (68,'BOUNDARY',33,'Boundary(g)\n\nReturns a geometry that is the closure of the combinatorial boundary of\nthe geometry value g.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions'),
 (69,'CREATE USER',8,'Syntax:\nCREATE USER user [IDENTIFIED BY [PASSWORD] \'password\']\n    [, user [IDENTIFIED BY [PASSWORD] \'password\']] ...\n\nThe CREATE USER statement was added in MySQL 5.0.2. This statement\ncreates new MySQL accounts. To use it, you must have the global CREATE\nUSER privilege or the INSERT privilege for the mysql database. For each\naccount, CREATE USER creates a new record in the mysql.user table that\nhas no privileges. An error occurs if the account already exists. Each\naccount is named using the same format as for the GRANT statement; for\nexample, \'jeffrey\'@\'localhost\'. If you specify only the username part\nof the account name, a hostname part of \'%\' is used. For additional\ninformation about specifying account names, see [HELP GRANT].\n\nThe account can be given a password with the optional IDENTIFIED BY\nclause. The user value and the password are given the same way as for\nthe GRANT statement. In particular, to specify the password in plain\ntext, omit the PASSWORD keyword. To specify the password as the hashed\nvalue as returned by the PASSWORD() function, include the PASSWORD\nkeyword. See [HELP GRANT].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-user.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/create-user.html');
INSERT INTO `mysql`.`help_topic` VALUES  (70,'POINT',22,'Point(x,y)\n\nConstructs a WKB Point using its coordinates.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions'),
 (71,'CURRENT_USER',14,'Syntax:\nCURRENT_USER, CURRENT_USER()\n\nReturns the username and hostname combination for the MySQL account\nthat the server used to authenticate the current client. This account\ndetermines your access privileges. The return value is a string in the\nutf8 character set.\n\nThe value of CURRENT_USER() can differ from the value of USER().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT USER();\n        -> \'davida@localhost\'\nmysql> SELECT * FROM mysql.user;\nERROR 1044: Access denied for user \'\'@\'localhost\' to\ndatabase \'mysql\'\nmysql> SELECT CURRENT_USER();\n        -> \'@localhost\'\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (72,'LCASE',34,'Syntax:\nLCASE(str)\n\nLCASE() is a synonym for LOWER().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (73,'<=',16,'Syntax:\n<=\n\nLess than or equal:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 0.1 <= 2;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (74,'SHOW PROFILES',25,'Syntax:\nSHOW PROFILE [type [, type] ... ]\n    [FOR QUERY n]\n    [LIMIT row_count [OFFSET offset]]\n\ntype:\n    ALL\n  | BLOCK IO\n  | CONTEXT SWITCHES\n  | CPU\n  | IPC\n  | MEMORY\n  | PAGE FAULTS\n  | SOURCE\n  | SWAPS\n\nThe SHOW PROFILES and SHOW PROFILE statements display profiling\ninformation that indicates resource usage for statements executed\nduring the course of the current session.\n\nProfiling is controlled by the profiling session variable, which has a\ndefault value of 0 (OFF). Profiling is enabled by setting profiling to\n1 or ON:\n\nmysql> SET profiling = 1;\n\nSHOW PROFILES displays a list of the most recent statements sent to the\nmaster. The size of the list is controlled by the\nprofiling_history_size session variable, which has a default value of\n15. The maximum value is 100. Setting the value to 0 has the practical\neffect of disabling profiling.\n\nAll statements are profiled except SHOW PROFILES and SHOW PROFILE, so\nyou will find neither of those statements in the profile list.\nMalformed statements are profiled. For example, SHOW PROFILING is an\nillegal statement, and a syntax error occurs if you try to execute it,\nbut it will show up in the profiling list.\n\nSHOW PROFILE displays detailed information about a single statement.\nWithout the FOR QUERY n clause, the output pertains to the most\nrecently executed statement. If FOR QUERY n is included, SHOW PROFILE\ndisplays information for statement n. The values of n correspond to the\nQuery_ID values displayed by SHOW PROFILES.\n\nThe LIMIT row_count clause may be given to limit the output to\nrow_count rows. If LIMIT is given, OFFSET offset may be added to begin\nthe output offset rows into the full set of rows.\n\nBy default, SHOW PROFILE displays Status and Duration columns. The\nStatus values are like the State values displayed by SHOW PROCESSLIST,\nalthought there might be some minor differences in interpretion for the\ntwo statements for some status values (see\nhttp://dev.mysql.com/doc/refman/5.0/en/thread-information.html).\n\nOptional type values may be specified to display specific additional\ntypes of information:\n\no ALL displays all information\n\no BLOCK IO displays counts for block input and output operations\n\no CONTEXT SWITCHES displays counts for voluntary and involuntary\n  context switches\n\no CPU displays user and system CPU usage times\n\no IPC displays counts for messages sent and received\n\no MEMORY is not currently implemented\n\no PAGE FAULTS displays counts for major and minor page faults\n\no SOURCE displays the names of functions from the source code, together\n  with the name and line number of the file in which the function\n  occurs\n\no SWAPS displays swap counts\n\nProfiling is enabled per session. When a session ends, its profiling\ninformation is lost.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-profiles.html\n\n','mysql> SELECT @@profiling;\n+-------------+\n| @@profiling |\n+-------------+\n|           0 |\n+-------------+\n1 row in set (0.00 sec)\n\nmysql> SET profiling = 1;\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> DROP TABLE IF EXISTS t1;\nQuery OK, 0 rows affected, 1 warning (0.00 sec)\n\nmysql> CREATE TABLE T1 (id INT);\nQuery OK, 0 rows affected (0.01 sec)\n\nmysql> SHOW PROFILES;\n+----------+----------+--------------------------+\n| Query_ID | Duration | Query                    |\n+----------+----------+--------------------------+\n|        0 | 0.000088 | SET PROFILING = 1        |\n|        1 | 0.000136 | DROP TABLE IF EXISTS t1  |\n|        2 | 0.011947 | CREATE TABLE t1 (id INT) |\n+----------+----------+--------------------------+\n3 rows in set (0.00 sec)\n\nmysql> SHOW PROFILE;\n+----------------------+----------+\n| Status               | Duration |\n+----------------------+----------+\n| checking permissions | 0.000040 |\n| creating table       | 0.000056 |\n| After create         | 0.011363 |\n| query end            | 0.000375 |\n| freeing items        | 0.000089 |\n| logging slow query   | 0.000019 |\n| cleaning up          | 0.000005 |\n+----------------------+----------+\n7 rows in set (0.00 sec)\n\nmysql> SHOW PROFILE FOR QUERY 1;\n+--------------------+----------+\n| Status             | Duration |\n+--------------------+----------+\n| query end          | 0.000107 |\n| freeing items      | 0.000008 |\n| logging slow query | 0.000015 |\n| cleaning up        | 0.000006 |\n+--------------------+----------+\n4 rows in set (0.00 sec)\n\nmysql> SHOW PROFILE CPU FOR QUERY 2;\n+----------------------+----------+----------+------------+\n| Status               | Duration | CPU_user | CPU_system |\n+----------------------+----------+----------+------------+\n| checking permissions | 0.000040 | 0.000038 |   0.000002 |\n| creating table       | 0.000056 | 0.000028 |   0.000028 |\n| After create         | 0.011363 | 0.000217 |   0.001571 |\n| query end            | 0.000375 | 0.000013 |   0.000028 |\n| freeing items        | 0.000089 | 0.000010 |   0.000014 |\n| logging slow query   | 0.000019 | 0.000009 |   0.000010 |\n| cleaning up          | 0.000005 | 0.000003 |   0.000002 |\n+----------------------+----------+----------+------------+\n7 rows in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/show-profiles.html'),
 (75,'UPDATE',25,'Syntax:\nSingle-table syntax:\n\nUPDATE [LOW_PRIORITY] [IGNORE] tbl_name\n    SET col_name1={expr1|DEFAULT} [, col_name2={expr2|DEFAULT}] ...\n    [WHERE where_condition]\n    [ORDER BY ...]\n    [LIMIT row_count]\n\nMultiple-table syntax:\n\nUPDATE [LOW_PRIORITY] [IGNORE] table_references\n    SET col_name1={expr1|DEFAULT} [, col_name2={expr2|DEFAULT}] ...\n    [WHERE where_condition]\n\nFor the single-table syntax, the UPDATE statement updates columns of\nexisting rows in tbl_name with new values. The SET clause indicates\nwhich columns to modify and the values they should be given. Each value\ncan be given as an expression, or the keyword DEFAULT to set a column\nexplicitly to its default value. The WHERE clause, if given, specifies\nthe conditions that identify which rows to update. With no WHERE\nclause, all rows are updated. If the ORDER BY clause is specified, the\nrows are updated in the order that is specified. The LIMIT clause\nplaces a limit on the number of rows that can be updated.\n\nFor the multiple-table syntax, UPDATE updates rows in each table named\nin table_references that satisfy the conditions. In this case, ORDER BY\nand LIMIT cannot be used.\n\nwhere_condition is an expression that evaluates to true for each row to\nbe updated. It is specified as described in\nhttp://dev.mysql.com/doc/refman/5.0/en/select.html.\n\nThe UPDATE statement supports the following modifiers:\n\no If you use the LOW_PRIORITY keyword, execution of the UPDATE is\n  delayed until no other clients are reading from the table. This\n  affects only storage engines that use only table-level locking\n  (MyISAM, MEMORY, MERGE).\n\no If you use the IGNORE keyword, the update statement does not abort\n  even if errors occur during the update. Rows for which duplicate-key\n  conflicts occur are not updated. Rows for which columns are updated\n  to values that would cause data conversion errors are updated to the\n  closest valid values instead.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/update.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/update.html');
INSERT INTO `mysql`.`help_topic` VALUES  (76,'IS NOT NULL',16,'Syntax:\nIS NOT NULL\n\nTests whether a value is not NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 1 IS NOT NULL, 0 IS NOT NULL, NULL IS NOT NULL;\n        -> 1, 1, 0\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (77,'CASE STATEMENT',21,'Syntax:\nCASE case_value\n    WHEN when_value THEN statement_list\n    [WHEN when_value THEN statement_list] ...\n    [ELSE statement_list]\nEND CASE\n\nOr:\n\nCASE\n    WHEN search_condition THEN statement_list\n    [WHEN search_condition THEN statement_list] ...\n    [ELSE statement_list]\nEND CASE\n\nThe CASE statement for stored programs implements a complex conditional\nconstruct. If a search_condition evaluates to true, the corresponding\nSQL statement list is executed. If no search condition matches, the\nstatement list in the ELSE clause is executed. Each statement_list\nconsists of one or more statements.\n\nIf no when_value or search_condition matches the value tested and the\nCASE statement contains no ELSE clause, a Case not found for CASE\nstatement error results.\n\nEach statement_list consists of one or more statements; an empty\nstatement_list is not allowed. To handle situations where no value is\nmatched by any WHEN clause, use an ELSE containing an empty BEGIN ...\nEND block, as shown in this example: DELIMITER | CREATE PROCEDURE p()\nBEGIN DECLARE v INT DEFAULT 1; CASE v WHEN 2 THEN SELECT v; WHEN 3 THEN\nSELECT 0; ELSE BEGIN END; END CASE; END; | (The indentation used here\nin the ELSE clause is for purposes of clarity only, and is not\notherwise significant.)\n\n*Note*: The syntax of the CASE statement used inside stored programs\ndiffers slightly from that of the SQL CASE expression described in\nhttp://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html. The\nCASE statement cannot have an ELSE NULL clause, and it is terminated\nwith END CASE instead of END.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/case-statement.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/case-statement.html'),
 (78,'EXECUTE STATEMENT',25,'Syntax:\nEXECUTE stmt_name [USING @var_name [, @var_name] ...]\n\nAfter preparing a statement, you execute it with an EXECUTE statement\nthat refers to the prepared statement name. If the prepared statement\ncontains any parameter markers, you must supply a USING clause that\nlists user variables containing the values to be bound to the\nparameters. Parameter values can be supplied only by user variables,\nand the USING clause must name exactly as many variables as the number\nof parameter markers in the statement.\n\nYou can execute a given prepared statement multiple times, passing\ndifferent variables to it or setting the variables to different values\nbefore each execution.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/sql-syntax-prepared-statements.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/sql-syntax-prepared-statements.html');
INSERT INTO `mysql`.`help_topic` VALUES  (79,'DROP INDEX',36,'Syntax:\nDROP INDEX index_name ON tbl_name\n\nDROP INDEX drops the index named index_name from the table tbl_name.\nThis statement is mapped to an ALTER TABLE statement to drop the index.\nSee [HELP ALTER TABLE].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-index.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-index.html'),
 (80,'MATCH AGAINST',34,'Syntax:\nMATCH (col1,col2,...) AGAINST (expr [search_modifier])\n\nMySQL has support for full-text indexing and searching:\n\no A full-text index in MySQL is an index of type FULLTEXT.\n\no Full-text indexes can be used only with MyISAM tables, and can be\n  created only for CHAR, VARCHAR, or TEXT columns.\n\no A FULLTEXT index definition can be given in the CREATE TABLE\n  statement when a table is created, or added later using ALTER TABLE\n  or CREATE INDEX.\n\no For large data sets, it is much faster to load your data into a table\n  that has no FULLTEXT index and then create the index after that, than\n  to load data into a table that has an existing FULLTEXT index.\n\nFull-text searching is performed using MATCH() ... AGAINST syntax.\nMATCH() takes a comma-separated list that names the columns to be\nsearched. AGAINST takes a string to search for, and an optional\nmodifier that indicates what type of search to perform. The search\nstring must be a literal string, not a variable or a column name. There\nare three types of full-text searches:\n\no A boolean search interprets the search string using the rules of a\n  special query language. The string contains the words to search for.\n  It can also contain operators that specify requirements such that a\n  word must be present or absent in matching rows, or that it should be\n  weighted higher or lower than usual. Common words such as \"some\" or\n  \"then\" are stopwords and do not match if present in the search\n  string. The IN BOOLEAN MODE modifier specifies a boolean search. For\n  more information, see\n  http://dev.mysql.com/doc/refman/5.0/en/fulltext-boolean.html.\n\no A natural language search interprets the search string as a phrase in\n  natural human language (a phrase in free text). There are no special\n  operators. The stopword list applies. In addition, words that are\n  present in 50% or more of the rows are considered common and do not\n  match. Full-text searches are natural language searches if no\n  modifier is given.\n\no A query expansion search is a modification of a natural language\n  search. The search string is used to perform a natural language\n  search. Then words from the most relevant rows returned by the search\n  are added to the search string and the search is done again. The\n  query returns the rows from the second search. The WITH QUERY\n  EXPANSION modifier specifies a query expansion search. For more\n  information, see\n  http://dev.mysql.com/doc/refman/5.0/en/fulltext-query-expansion.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/fulltext-search.html\n\n','mysql> SELECT id, body, MATCH (title,body) AGAINST\n    -> (\'Security implications of running MySQL as root\') AS score\n    -> FROM articles WHERE MATCH (title,body) AGAINST\n    -> (\'Security implications of running MySQL as root\');\n+----+-------------------------------------+-----------------+\n| id | body                                | score           |\n+----+-------------------------------------+-----------------+\n|  4 | 1. Never run mysqld as root. 2. ... | 1.5219271183014 |\n|  6 | When configured properly, MySQL ... | 1.3114095926285 |\n+----+-------------------------------------+-----------------+\n2 rows in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/fulltext-search.html'),
 (81,'ABS',4,'Syntax:\nABS(X)\n\nReturns the absolute value of X.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT ABS(2);\n        -> 2\nmysql> SELECT ABS(-32);\n        -> 32\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (82,'POLYFROMWKB',30,'PolyFromWKB(wkb[,srid]), PolygonFromWKB(wkb[,srid])\n\nConstructs a POLYGON value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions'),
 (83,'NOT LIKE',34,'Syntax:\nexpr NOT LIKE pat [ESCAPE \'escape_char\']\n\nThis is the same as NOT (expr LIKE pat [ESCAPE \'escape_char\']).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-comparison-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-comparison-functions.html'),
 (84,'SPACE',34,'Syntax:\nSPACE(N)\n\nReturns a string consisting of N space characters.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT SPACE(6);\n        -> \'      \'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (85,'MBR DEFINITION',5,'Its MBR (Minimum Bounding Rectangle), or Envelope. This is the bounding\ngeometry, formed by the minimum and maximum (X,Y) coordinates:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/gis-class-geometry.html\n\n','((MINX MINY, MAXX MINY, MAXX MAXY, MINX MAXY, MINX MINY))\n','http://dev.mysql.com/doc/refman/5.0/en/gis-class-geometry.html'),
 (86,'GEOMETRYCOLLECTION',22,'GeometryCollection(g1,g2,...)\n\nConstructs a WKB GeometryCollection. If any argument is not a\nwell-formed WKB representation of a geometry, the return value is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (87,'MAX',15,'Syntax:\nMAX([DISTINCT] expr)\n\nReturns the maximum value of expr. MAX() may take a string argument; in\nsuch cases, it returns the maximum string value. See\nhttp://dev.mysql.com/doc/refman/5.0/en/mysql-indexes.html. The DISTINCT\nkeyword can be used to find the maximum of the distinct values of expr,\nhowever, this produces the same result as omitting DISTINCT.\n\nMAX() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','mysql> SELECT student_name, MIN(test_score), MAX(test_score)\n    ->        FROM student\n    ->        GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (88,'CREATE FUNCTION UDF',20,'Syntax:\nCREATE [AGGREGATE] FUNCTION function_name RETURNS {STRING|INTEGER|REAL|DECIMAL}\n    SONAME shared_library_name\n\nA user-defined function (UDF) is a way to extend MySQL with a new\nfunction that works like a native (built-in) MySQL function such as\nABS() or CONCAT().\n\nfunction_name is the name that should be used in SQL statements to\ninvoke the function. The RETURNS clause indicates the type of the\nfunction\'s return value. As of MySQL 5.0.3, DECIMAL is a legal value\nafter RETURNS, but currently DECIMAL functions return string values and\nshould be written like STRING functions.\n\nshared_library_name is the basename of the shared object file that\ncontains the code that implements the function. As of MySQL 5.0.67, the\nfile must be located in the plugin directory. This directory is given\nby the value of the plugin_dir system variable. If the value of\nplugin_dir is empty, the behavior that is used before 5.0.67 applies:\nThe file must be located in a directory that is searched by your\nsystem\'s dynamic linker.\n\nTo create a function, you must have the INSERT privilege for the mysql\ndatabase. This is necessary because CREATE FUNCTION adds a row to the\nmysql.func system table that records the function\'s name, type, and\nshared library name. If you do not have this table, you should run the\nmysql_upgrade command to create it. See\nhttp://dev.mysql.com/doc/refman/5.0/en/mysql-upgrade.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-function-udf.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/create-function-udf.html'),
 (89,'*',4,'Syntax:\n*\n\nMultiplication:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html\n\n','mysql> SELECT 3*5;\n        -> 15\nmysql> SELECT 18014398509481984*18014398509481984.0;\n        -> 324518553658426726783156020576256.0\nmysql> SELECT 18014398509481984*18014398509481984;\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (90,'TIMESTAMP',19,'TIMESTAMP\n\nA timestamp. The range is \'1970-01-01 00:00:01\' UTC to \'2038-01-09\n03:14:07\' UTC. TIMESTAMP values are stored as the number of seconds\nsince the epoch (\'1970-01-01 00:00:00\' UTC). A TIMESTAMP cannot\nrepresent the value \'1970-01-01 00:00:00\' because that is equivalent to\n0 seconds from the epoch and the value 0 is reserved for representing\n\'0000-00-00 00:00:00\', the \"zero\" TIMESTAMP value.\n\nA TIMESTAMP column is useful for recording the date and time of an\nINSERT or UPDATE operation. By default, the first TIMESTAMP column in a\ntable is automatically set to the date and time of the most recent\noperation if you do not assign it a value yourself. You can also set\nany TIMESTAMP column to the current date and time by assigning it a\nNULL value. Variations on automatic initialization and update\nproperties are described in\nhttp://dev.mysql.com/doc/refman/5.0/en/timestamp.html.\n\nA TIMESTAMP value is returned as a string in the format \'YYYY-MM-DD\nHH:MM:SS\' with a display width fixed at 19 characters. To obtain the\nvalue as a number, you should add +0 to the timestamp column.\n\n*Note*: The TIMESTAMP format that was used prior to MySQL 4.1 is not\nsupported in MySQL 5.0; see MySQL 3.23, 4.0, 4.1 Reference Manual for\ninformation regarding the old format.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html'),
 (91,'DES_DECRYPT',10,'Syntax:\nDES_DECRYPT(crypt_str[,key_str])\n\nDecrypts a string encrypted with DES_ENCRYPT(). If an error occurs,\nthis function returns NULL.\n\nThis function works only if MySQL has been configured with SSL support.\nSee http://dev.mysql.com/doc/refman/5.0/en/secure-connections.html.\n\nIf no key_str argument is given, DES_DECRYPT() examines the first byte\nof the encrypted string to determine the DES key number that was used\nto encrypt the original string, and then reads the key from the DES key\nfile to decrypt the message. For this to work, the user must have the\nSUPER privilege. The key file can be specified with the --des-key-file\nserver option.\n\nIf you pass this function a key_str argument, that string is used as\nthe key for decrypting the message.\n\nIf the crypt_str argument does not appear to be an encrypted string,\nMySQL returns the given crypt_str.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (92,'CACHE INDEX',25,'Syntax:\nCACHE INDEX\n  tbl_index_list [, tbl_index_list] ...\n  IN key_cache_name\n\ntbl_index_list:\n  tbl_name [[INDEX|KEY] (index_name[, index_name] ...)]\n\nThe CACHE INDEX statement assigns table indexes to a specific key\ncache. It is used only for MyISAM tables.\n\nThe following statement assigns indexes from the tables t1, t2, and t3\nto the key cache named hot_cache:\n\nmysql> CACHE INDEX t1, t2, t3 IN hot_cache;\n+---------+--------------------+----------+----------+\n| Table   | Op                 | Msg_type | Msg_text |\n+---------+--------------------+----------+----------+\n| test.t1 | assign_to_keycache | status   | OK       |\n| test.t2 | assign_to_keycache | status   | OK       |\n| test.t3 | assign_to_keycache | status   | OK       |\n+---------+--------------------+----------+----------+\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/cache-index.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/cache-index.html'),
 (93,'ENDPOINT',11,'EndPoint(ls)\n\nReturns the Point that is the endpoint of the LineString value ls.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT AsText(EndPoint(GeomFromText(@ls)));\n+-------------------------------------+\n| AsText(EndPoint(GeomFromText(@ls))) |\n+-------------------------------------+\n| POINT(3 3)                          |\n+-------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (94,'COMPRESS',10,'Syntax:\nCOMPRESS(string_to_compress)\n\nCompresses a string and returns the result as a binary string. This\nfunction requires MySQL to have been compiled with a compression\nlibrary such as zlib. Otherwise, the return value is always NULL. The\ncompressed string can be uncompressed with UNCOMPRESS().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','mysql> SELECT LENGTH(COMPRESS(REPEAT(\'a\',1000)));\n        -> 21\nmysql> SELECT LENGTH(COMPRESS(\'\'));\n        -> 0\nmysql> SELECT LENGTH(COMPRESS(\'a\'));\n        -> 13\nmysql> SELECT LENGTH(COMPRESS(REPEAT(\'a\',16)));\n        -> 15\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (95,'INSERT',25,'Syntax:\nINSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]\n    [INTO] tbl_name [(col_name,...)]\n    {VALUES | VALUE} ({expr | DEFAULT},...),(...),...\n    [ ON DUPLICATE KEY UPDATE\n      col_name=expr\n        [, col_name=expr] ... ]\n\nOr:\n\nINSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]\n    [INTO] tbl_name\n    SET col_name={expr | DEFAULT}, ...\n    [ ON DUPLICATE KEY UPDATE\n      col_name=expr\n        [, col_name=expr] ... ]\n\nOr:\n\nINSERT [LOW_PRIORITY | HIGH_PRIORITY] [IGNORE]\n    [INTO] tbl_name [(col_name,...)]\n    SELECT ...\n    [ ON DUPLICATE KEY UPDATE\n      col_name=expr\n        [, col_name=expr] ... ]\n\nINSERT inserts new rows into an existing table. The INSERT ... VALUES\nand INSERT ... SET forms of the statement insert rows based on\nexplicitly specified values. The INSERT ... SELECT form inserts rows\nselected from another table or tables. INSERT ... SELECT is discussed\nfurther in [HELP INSERT SELECT].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/insert.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/insert.html'),
 (96,'COUNT',15,'Syntax:\nCOUNT(expr)\n\nReturns a count of the number of non-NULL values of expr in the rows\nretrieved by a SELECT statement. The result is a BIGINT value.\n\nCOUNT() returns 0 if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','mysql> SELECT student.student_name,COUNT(*)\n    ->        FROM student,course\n    ->        WHERE student.student_id=course.student_id\n    ->        GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (97,'HANDLER',25,'Syntax:\nHANDLER tbl_name OPEN [ [AS] alias]\nHANDLER tbl_name READ index_name { = | >= | <= | < } (value1,value2,...)\n    [ WHERE where_condition ] [LIMIT ... ]\nHANDLER tbl_name READ index_name { FIRST | NEXT | PREV | LAST }\n    [ WHERE where_condition ] [LIMIT ... ]\nHANDLER tbl_name READ { FIRST | NEXT }\n    [ WHERE where_condition ] [LIMIT ... ]\nHANDLER tbl_name CLOSE\n\nThe HANDLER statement provides direct access to table storage engine\ninterfaces. It is available for MyISAM and InnoDB tables.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/handler.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/handler.html'),
 (98,'MLINEFROMTEXT',3,'MLineFromText(wkt[,srid]), MultiLineStringFromText(wkt[,srid])\n\nConstructs a MULTILINESTRING value using its WKT representation and\nSRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions'),
 (99,'GEOMCOLLFROMWKB',30,'GeomCollFromWKB(wkb[,srid]), GeometryCollectionFromWKB(wkb[,srid])\n\nConstructs a GEOMETRYCOLLECTION value using its WKB representation and\nSRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (100,'RENAME TABLE',36,'Syntax:\nRENAME TABLE tbl_name TO new_tbl_name\n    [, tbl_name2 TO new_tbl_name2] ...\n\nThis statement renames one or more tables.\n\nThe rename operation is done atomically, which means that no other\nsession can access any of the tables while the rename is running. For\nexample, if you have an existing table old_table, you can create\nanother table new_table that has the same structure but is empty, and\nthen replace the existing table with the empty one as follows (assuming\nthat backup_table does not already exist):\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/rename-table.html\n\n','CREATE TABLE new_table (...);\nRENAME TABLE old_table TO backup_table, new_table TO old_table;\n','http://dev.mysql.com/doc/refman/5.0/en/rename-table.html'),
 (101,'BOOLEAN',19,'BOOL, BOOLEAN\n\nThese types are synonyms for TINYINT(1). A value of zero is considered\nfalse. Non-zero values are considered true:\n\nmysql> SELECT IF(0, \'true\', \'false\');\n+------------------------+\n| IF(0, \'true\', \'false\') |\n+------------------------+\n| false                  |\n+------------------------+\n\nmysql> SELECT IF(1, \'true\', \'false\');\n+------------------------+\n| IF(1, \'true\', \'false\') |\n+------------------------+\n| true                   |\n+------------------------+\n\nmysql> SELECT IF(2, \'true\', \'false\');\n+------------------------+\n| IF(2, \'true\', \'false\') |\n+------------------------+\n| true                   |\n+------------------------+\n\nHowever, the values TRUE and FALSE are merely aliases for 1 and 0,\nrespectively, as shown here:\n\nmysql> SELECT IF(0 = FALSE, \'true\', \'false\');\n+--------------------------------+\n| IF(0 = FALSE, \'true\', \'false\') |\n+--------------------------------+\n| true                           |\n+--------------------------------+\n\nmysql> SELECT IF(1 = TRUE, \'true\', \'false\');\n+-------------------------------+\n| IF(1 = TRUE, \'true\', \'false\') |\n+-------------------------------+\n| true                          |\n+-------------------------------+\n\nmysql> SELECT IF(2 = TRUE, \'true\', \'false\');\n+-------------------------------+\n| IF(2 = TRUE, \'true\', \'false\') |\n+-------------------------------+\n| false                         |\n+-------------------------------+\n\nmysql> SELECT IF(2 = FALSE, \'true\', \'false\');\n+--------------------------------+\n| IF(2 = FALSE, \'true\', \'false\') |\n+--------------------------------+\n| false                          |\n+--------------------------------+\n\nThe last two statements display the results shown because 2 is equal to\nneither 1 nor 0.\n\nWe intend to implement full boolean type handling, in accordance with\nstandard SQL, in a future MySQL release.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (102,'DEFAULT',13,'Syntax:\nDEFAULT(col_name)\n\nReturns the default value for a table column. Starting with MySQL\n5.0.2, an error results if the column has no default value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','mysql> UPDATE t SET i = DEFAULT(i)+1 WHERE id < 100;\n','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (103,'MOD',4,'Syntax:\nMOD(N,M), N % M, N MOD M\n\nModulo operation. Returns the remainder of N divided by M.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT MOD(234, 10);\n        -> 4\nmysql> SELECT 253 % 7;\n        -> 1\nmysql> SELECT MOD(29,9);\n        -> 2\nmysql> SELECT 29 MOD 9;\n        -> 2\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (104,'TINYTEXT',19,'TINYTEXT [CHARACTER SET charset_name] [COLLATE collation_name]\n\nA TEXT column with a maximum length of 255 (28 - 1) characters. The\neffective maximum length is less if the value contains multi-byte\ncharacters. Each TINYTEXT value is stored using a one-byte length\nprefix that indicates the number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (105,'OPTIMIZE TABLE',18,'Syntax:\nOPTIMIZE [NO_WRITE_TO_BINLOG | LOCAL] TABLE\n    tbl_name [, tbl_name] ...\n\nOPTIMIZE TABLE should be used if you have deleted a large part of a\ntable or if you have made many changes to a table with variable-length\nrows (tables that have VARCHAR, VARBINARY, BLOB, or TEXT columns).\nDeleted rows are maintained in a linked list and subsequent INSERT\noperations reuse old row positions. You can use OPTIMIZE TABLE to\nreclaim the unused space and to defragment the data file.\n\nThis statement requires SELECT and INSERT privileges for the table.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/optimize-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/optimize-table.html'),
 (106,'DECODE',10,'Syntax:\nDECODE(crypt_str,pass_str)\n\nDecrypts the encrypted string crypt_str using pass_str as the password.\ncrypt_str should be a string returned from ENCODE().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (107,'<=>',16,'Syntax:\n<=>\n\nNULL-safe equal. This operator performs an equality comparison like the\n= operator, but returns 1 rather than NULL if both operands are NULL,\nand 0 rather than NULL if one operand is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 1 <=> 1, NULL <=> NULL, 1 <=> NULL;\n        -> 1, 1, 0\nmysql> SELECT 1 = 1, NULL = NULL, 1 = NULL;\n        -> 1, NULL, NULL\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (108,'LOAD DATA FROM MASTER',25,'Syntax:\nLOAD DATA FROM MASTER\n\nThis feature is deprecated. We recommend not using it anymore. It is\nsubject to removal in a future version of MySQL.\n\nSince the current implementation of LOAD DATA FROM MASTER and LOAD\nTABLE FROM MASTER is very limited, these statements are deprecated in\nversions 4.1 of MySQL and above. We will introduce a more advanced\ntechnique (called \"online backup\") in a future version. That technique\nwill have the additional advantage of working with more storage\nengines.\n\nFor MySQL 5.1 and earlier, the recommended alternative solution to\nusing LOAD DATA FROM MASTER or LOAD TABLE FROM MASTER is using\nmysqldump or mysqlhotcopy. The latter requires Perl and two Perl\nmodules (DBI and DBD:mysql) and works for MyISAM and ARCHIVE tables\nonly. With mysqldump, you can create SQL dumps on the master and pipe\n(or copy) these to a mysql client on the slave. This has the advantage\nof working for all storage engines, but can be quite slow, since it\nworks using SELECT.\n\nThis statement takes a snapshot of the master and copies it to the\nslave. It updates the values of MASTER_LOG_FILE and MASTER_LOG_POS so\nthat the slave starts replicating from the correct position. Any table\nand database exclusion rules specified with the --replicate-*-do-* and\n--replicate-*-ignore-* options are honored. --replicate-rewrite-db is\nnot taken into account because a user could use this option to set up a\nnon-unique mapping such as --replicate-rewrite-db=\"db1->db3\" and\n--replicate-rewrite-db=\"db2->db3\", which would confuse the slave when\nloading tables from the master.\n\nUse of this statement is subject to the following conditions:\n\no It works only for MyISAM tables. Attempting to load a non-MyISAM\n  table results in the following error:\n\nERROR 1189 (08S01): Net error reading from master\n\no It acquires a global read lock on the master while taking the\n  snapshot, which prevents updates on the master during the load\n  operation.\n\nIf you are loading large tables, you might have to increase the values\nof net_read_timeout and net_write_timeout on both the master and slave\nservers. See\nhttp://dev.mysql.com/doc/refman/5.0/en/server-system-variables.html.\n\nNote that LOAD DATA FROM MASTER does not copy any tables from the mysql\ndatabase. This makes it easy to have different users and privileges on\nthe master and the slave.\n\nTo use LOAD DATA FROM MASTER, the replication account that is used to\nconnect to the master must have the RELOAD and SUPER privileges on the\nmaster and the SELECT privilege for all master tables you want to load.\nAll master tables for which the user does not have the SELECT privilege\nare ignored by LOAD DATA FROM MASTER. This is because the master hides\nthem from the user: LOAD DATA FROM MASTER calls SHOW DATABASES to know\nthe master databases to load, but SHOW DATABASES returns only databases\nfor which the user has some privilege. See [HELP SHOW DATABASES]. On\nthe slave side, the user that issues LOAD DATA FROM MASTER must have\nprivileges for dropping and creating the databases and tables that are\ncopied.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/load-data-from-master.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/load-data-from-master.html'),
 (109,'RESET',25,'Syntax:\nRESET reset_option [, reset_option] ...\n\nThe RESET statement is used to clear the state of various server\noperations. You must have the RELOAD privilege to execute RESET.\n\nRESET acts as a stronger version of the FLUSH statement. See [HELP\nFLUSH].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/reset.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/reset.html');
INSERT INTO `mysql`.`help_topic` VALUES  (110,'HELP STATEMENT',26,'Syntax:\nHELP \'search_string\'\n\nThe HELP statement returns online information from the MySQL Reference\nmanual. Its proper operation requires that the help tables in the mysql\ndatabase be initialized with help topic information (see\nhttp://dev.mysql.com/doc/refman/5.0/en/server-side-help-support.html).\n\nThe HELP statement searches the help tables for the given search string\nand displays the result of the search. The search string is not case\nsensitive.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/help.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/help.html'),
 (111,'GET_LOCK',13,'Syntax:\nGET_LOCK(str,timeout)\n\nTries to obtain a lock with a name given by the string str, using a\ntimeout of timeout seconds. Returns 1 if the lock was obtained\nsuccessfully, 0 if the attempt timed out (for example, because another\nclient has previously locked the name), or NULL if an error occurred\n(such as running out of memory or the thread was killed with mysqladmin\nkill). If you have a lock obtained with GET_LOCK(), it is released when\nyou execute RELEASE_LOCK(), execute a new GET_LOCK(), or your\nconnection terminates (either normally or abnormally). Locks obtained\nwith GET_LOCK() do not interact with transactions. That is, committing\na transaction does not release any such locks obtained during the\ntransaction.\n\nThis function can be used to implement application locks or to simulate\nrecord locks. Names are locked on a server-wide basis. If a name has\nbeen locked by one client, GET_LOCK() blocks any request by another\nclient for a lock with the same name. This allows clients that agree on\na given lock name to use the name to perform cooperative advisory\nlocking. But be aware that it also allows a client that is not among\nthe set of cooperating clients to lock a name, either inadvertently or\ndeliberately, and thus prevent any of the cooperating clients from\nlocking that name. One way to reduce the likelihood of this is to use\nlock names that are database-specific or application-specific. For\nexample, use lock names of the form db_name.str or app_name.str.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','mysql> SELECT GET_LOCK(\'lock1\',10);\n        -> 1\nmysql> SELECT IS_FREE_LOCK(\'lock2\');\n        -> 1\nmysql> SELECT GET_LOCK(\'lock2\',10);\n        -> 1\nmysql> SELECT RELEASE_LOCK(\'lock2\');\n        -> 1\nmysql> SELECT RELEASE_LOCK(\'lock1\');\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (112,'UCASE',34,'Syntax:\nUCASE(str)\n\nUCASE() is a synonym for UPPER().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (113,'SHOW BINLOG EVENTS',25,'Syntax:\nSHOW BINLOG EVENTS\n   [IN \'log_name\'] [FROM pos] [LIMIT [offset,] row_count]\n\nShows the events in the binary log. If you do not specify \'log_name\',\nthe first binary log is displayed.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-binlog-events.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-binlog-events.html'),
 (114,'MPOLYFROMWKB',30,'MPolyFromWKB(wkb[,srid]), MultiPolygonFromWKB(wkb[,srid])\n\nConstructs a MULTIPOLYGON value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions'),
 (115,'ITERATE',21,'Syntax:\nITERATE label\n\nITERATE can appear only within LOOP, REPEAT, and WHILE statements.\nITERATE means \"do the loop again.\"\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/iterate-statement.html\n\n','CREATE PROCEDURE doiterate(p1 INT)\nBEGIN\n  label1: LOOP\n    SET p1 = p1 + 1;\n    IF p1 < 10 THEN ITERATE label1; END IF;\n    LEAVE label1;\n  END LOOP label1;\n  SET @x = p1;\nEND\n','http://dev.mysql.com/doc/refman/5.0/en/iterate-statement.html'),
 (116,'DO',25,'Syntax:\nDO expr [, expr] ...\n\nDO executes the expressions but does not return any results. In most\nrespects, DO is shorthand for SELECT expr, ..., but has the advantage\nthat it is slightly faster when you do not care about the result.\n\nDO is useful primarily with functions that have side effects, such as\nRELEASE_LOCK().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/do.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/do.html');
INSERT INTO `mysql`.`help_topic` VALUES  (117,'CURTIME',29,'Syntax:\nCURTIME()\n\nReturns the current time as a value in \'HH:MM:SS\' or HHMMSS.uuuuuu\nformat, depending on whether the function is used in a string or\nnumeric context. The value is expressed in the current time zone.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT CURTIME();\n        -> \'23:50:26\'\nmysql> SELECT CURTIME() + 0;\n        -> 235026.000000\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (118,'CHAR_LENGTH',34,'Syntax:\nCHAR_LENGTH(str)\n\nReturns the length of the string str, measured in characters. A\nmulti-byte character counts as a single character. This means that for\na string containing five two-byte characters, LENGTH() returns 10,\nwhereas CHAR_LENGTH() returns 5.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (119,'BIGINT',19,'BIGINT[(M)] [UNSIGNED] [ZEROFILL]\n\nA large integer. The signed range is -9223372036854775808 to\n9223372036854775807. The unsigned range is 0 to 18446744073709551615.\n\nSERIAL is an alias for BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (120,'SET',25,'Syntax:\nSET variable_assignment [, variable_assignment] ...\n\nvariable_assignment:\n      user_var_name = expr\n    | [GLOBAL | SESSION] system_var_name = expr\n    | [@@global. | @@session. | @@]system_var_name = expr\n\nThe SET statement assigns values to different types of variables that\naffect the operation of the server or your client. Older versions of\nMySQL employed SET OPTION, but this syntax is deprecated in favor of\nSET without OPTION.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/set-option.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/set-option.html');
INSERT INTO `mysql`.`help_topic` VALUES  (121,'CONV',4,'Syntax:\nCONV(N,from_base,to_base)\n\nConverts numbers between different number bases. Returns a string\nrepresentation of the number N, converted from base from_base to base\nto_base. Returns NULL if any argument is NULL. The argument N is\ninterpreted as an integer, but may be specified as an integer or a\nstring. The minimum base is 2 and the maximum base is 36. If to_base is\na negative number, N is regarded as a signed number. Otherwise, N is\ntreated as unsigned. CONV() works with 64-bit precision.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT CONV(\'a\',16,2);\n        -> \'1010\'\nmysql> SELECT CONV(\'6E\',18,8);\n        -> \'172\'\nmysql> SELECT CONV(-17,10,-18);\n        -> \'-H\'\nmysql> SELECT CONV(10+\'10\'+\'10\'+0xa,10,10);\n        -> \'40\'\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (122,'DATE',19,'DATE\n\nA date. The supported range is \'1000-01-01\' to \'9999-12-31\'. MySQL\ndisplays DATE values in \'YYYY-MM-DD\' format, but allows assignment of\nvalues to DATE columns using either strings or numbers.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html'),
 (123,'SHOW OPEN TABLES',25,'Syntax:\nSHOW OPEN TABLES [FROM db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW OPEN TABLES lists the non-TEMPORARY tables that are currently open\nin the table cache. See\nhttp://dev.mysql.com/doc/refman/5.0/en/table-cache.html. The WHERE\nclause can be given to select rows using more general conditions, as\ndiscussed in http://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nThe FROM and LIKE clauses may be used as of MySQL 5.0.12. The LIKE\nclause, if present, indicates which table names to match. The FROM\nclause, if present, restricts the tables shown to those present in the\ndb_name database.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-open-tables.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-open-tables.html');
INSERT INTO `mysql`.`help_topic` VALUES  (124,'EXTRACT',29,'Syntax:\nEXTRACT(unit FROM date)\n\nThe EXTRACT() function uses the same kinds of unit specifiers as\nDATE_ADD() or DATE_SUB(), but extracts parts from the date rather than\nperforming date arithmetic.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT EXTRACT(YEAR FROM \'2009-07-02\');\n       -> 2009\nmysql> SELECT EXTRACT(YEAR_MONTH FROM \'2009-07-02 01:02:03\');\n       -> 200907\nmysql> SELECT EXTRACT(DAY_MINUTE FROM \'2009-07-02 01:02:03\');\n       -> 20102\nmysql> SELECT EXTRACT(MICROSECOND\n    ->                FROM \'2003-01-02 10:30:00.000123\');\n        -> 123\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (125,'ENCRYPT',10,'Syntax:\nENCRYPT(str[,salt])\n\nEncrypts str using the Unix crypt() system call and returns a binary\nstring. The salt argument should be a string with at least two\ncharacters. If no salt argument is given, a random value is used.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','mysql> SELECT ENCRYPT(\'hello\');\n        -> \'VxuFAJXVARROc\'\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (126,'SHOW STATUS',25,'Syntax:\nSHOW [GLOBAL | SESSION] STATUS\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW STATUS provides server status information. This information also\ncan be obtained using the mysqladmin extended-status command. The LIKE\nclause, if present, indicates which variable names to match. The WHERE\nclause can be given to select rows using more general conditions, as\ndiscussed in http://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\nWith a LIKE clause, the statement displays only rows for those\nvariables with names that match the pattern:\n\nmysql> SHOW STATUS LIKE \'Key%\';\n+--------------------+----------+\n| Variable_name      | Value    |\n+--------------------+----------+\n| Key_blocks_used    | 14955    |\n| Key_read_requests  | 96854827 |\n| Key_reads          | 162040   |\n| Key_write_requests | 7589728  |\n| Key_writes         | 3813196  |\n+--------------------+----------+\n\nThe GLOBAL and SESSION options are new in MySQL 5.0.2. With the GLOBAL\nmodifier, SHOW STATUS displays the status values for all connections to\nMySQL. With SESSION, it displays the status values for the current\nconnection. If no modifier is present, the default is SESSION. LOCAL is\na synonym for SESSION.\n\nSome status variables have only a global value. For these, you get the\nsame value for both GLOBAL and SESSION. The scope for each status\nvariable is listed at\nhttp://dev.mysql.com/doc/refman/5.0/en/server-status-variables.html.\n\n*Note*: Before MySQL 5.0.2, SHOW STATUS returned global status values.\nBecause the default as of 5.0.2 is to return session values, this is\nincompatible with previous versions. To issue a SHOW STATUS statement\nthat will retrieve global status values for all versions of MySQL,\nwrite it like this:\n\nSHOW /*!50002 GLOBAL */ STATUS;\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-status.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-status.html');
INSERT INTO `mysql`.`help_topic` VALUES  (127,'OLD_PASSWORD',10,'Syntax:\nOLD_PASSWORD(str)\n\nOLD_PASSWORD() was added to MySQL when the implementation of PASSWORD()\nwas changed to improve security. OLD_PASSWORD() returns the value of\nthe old (pre-4.1) implementation of PASSWORD() as a binary string, and\nis intended to permit you to reset passwords for any pre-4.1 clients\nthat need to connect to your version 5.0 MySQL server without locking\nthem out. See\nhttp://dev.mysql.com/doc/refman/5.0/en/password-hashing.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (128,'SET VARIABLE',21,'Syntax:\nSET var_name = expr [, var_name = expr] ...\n\nThe SET statement in stored programs is an extended version of the\ngeneral SET statement (see [HELP SET]). Referenced variables may be\nones declared inside a stored program, global system variables, or\nuser-defined variables.\n\nThe SET statement in stored programs is implemented as part of the\npre-existing SET syntax. This allows an extended syntax of SET a=x,\nb=y, ... where different variable types (locally declared variables,\nglobal and session server variables, user-defined variables) can be\nmixed. This also allows combinations of local variables and some\noptions that make sense only for system variables; in that case, the\noptions are recognized but ignored.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/set-statement.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/set-statement.html'),
 (129,'FORMAT',34,'Syntax:\nFORMAT(X,D)\n\nFormats the number X to a format like \'#,###,###.##\', rounded to D\ndecimal places, and returns the result as a string. If D is 0, the\nresult has no decimal point or fractional part.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT FORMAT(12332.123456, 4);\n        -> \'12,332.1235\'\nmysql> SELECT FORMAT(12332.1,4);\n        -> \'12,332.1000\'\nmysql> SELECT FORMAT(12332.2,0);\n        -> \'12,332\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (130,'||',12,'Syntax:\nOR, ||\n\nLogical OR. When both operands are non-NULL, the result is 1 if any\noperand is non-zero, and 0 otherwise. With a NULL operand, the result\nis 1 if the other operand is non-zero, and NULL otherwise. If both\noperands are NULL, the result is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/logical-operators.html\n\n','mysql> SELECT 1 || 1;\n        -> 1\nmysql> SELECT 1 || 0;\n        -> 1\nmysql> SELECT 0 || 0;\n        -> 0\nmysql> SELECT 0 || NULL;\n        -> NULL\nmysql> SELECT 1 || NULL;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/logical-operators.html'),
 (131,'BIT_LENGTH',34,'Syntax:\nBIT_LENGTH(str)\n\nReturns the length of the string str in bits.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT BIT_LENGTH(\'text\');\n        -> 32\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (132,'EXTERIORRING',2,'ExteriorRing(poly)\n\nReturns the exterior ring of the Polygon value poly as a LineString.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#polygon-property-functions\n\n','mysql> SET @poly =\n    -> \'Polygon((0 0,0 3,3 3,3 0,0 0),(1 1,1 2,2 2,2 1,1 1))\';\nmysql> SELECT AsText(ExteriorRing(GeomFromText(@poly)));\n+-------------------------------------------+\n| AsText(ExteriorRing(GeomFromText(@poly))) |\n+-------------------------------------------+\n| LINESTRING(0 0,0 3,3 3,3 0,0 0)           |\n+-------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#polygon-property-functions'),
 (133,'GEOMFROMWKB',30,'GeomFromWKB(wkb[,srid]), GeometryFromWKB(wkb[,srid])\n\nConstructs a geometry value of any type using its WKB representation\nand SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (134,'SHOW SLAVE HOSTS',25,'Syntax:\nSHOW SLAVE HOSTS\n\nDisplays a list of replication slaves currently registered with the\nmaster. Only slaves started with the --report-host=host_name option are\nvisible in this list.\n\nThe list is displayed on any server (not just the master server). The\noutput looks like this:\n\nmysql> SHOW SLAVE HOSTS;\n+------------+-----------+------+-----------+\n| Server_id  | Host      | Port | Master_id |\n+------------+-----------+------+-----------+\n|  192168010 | iconnect2 | 3306 | 192168011 |\n| 1921680101 | athena    | 3306 | 192168011 |\n+------------+-----------+------+-----------+\n\no Server_id: The unique server ID of the slave server, as configured in\n  the server\'s option file, or on the command line with\n  --server-id=value.\n\no Host: The host name of the slave server, as configured in the\n  server\'s option file, or on the command line with\n  --report-host=host_name. Note that this can differ from the machine\n  name as configured in the operating system.\n\no Port: The port the slave server is listening on.\n\no Master_id: The unique server ID of the master server that the slave\n  server is replicating from.\n\nSome MySQL versions report another variable, Rpl_recovery_rank. This\nvariable was never used, and was eventually removed.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-slave-hosts.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-slave-hosts.html'),
 (135,'START TRANSACTION',7,'Syntax:\nSTART TRANSACTION [WITH CONSISTENT SNAPSHOT] | BEGIN [WORK]\nCOMMIT [WORK] [AND [NO] CHAIN] [[NO] RELEASE]\nROLLBACK [WORK] [AND [NO] CHAIN] [[NO] RELEASE]\nSET autocommit = {0 | 1}\n\nThe START TRANSACTION or BEGIN statement begins a new transaction.\nCOMMIT commits the current transaction, making its changes permanent.\nROLLBACK rolls back the current transaction, canceling its changes. The\nSET autocommit statement disables or enables the default autocommit\nmode for the current session.\n\nBeginning with MySQL 5.0.3, the optional WORK keyword is supported for\nCOMMIT and ROLLBACK, as are the CHAIN and RELEASE clauses. CHAIN and\nRELEASE can be used for additional control over transaction completion.\nThe value of the completion_type system variable determines the default\ncompletion behavior. See\nhttp://dev.mysql.com/doc/refman/5.0/en/server-system-variables.html.\n\nThe AND CHAIN clause causes a new transaction to begin as soon as the\ncurrent one ends, and the new transaction has the same isolation level\nas the just-terminated transaction. The RELEASE clause causes the\nserver to disconnect the current client session after terminating the\ncurrent transaction. Including the NO keyword suppresses CHAIN or\nRELEASE completion, which can be useful if the completion_type system\nvariable is set to cause chaining or release completion by default.\n\nBy default, MySQL runs with autocommit mode enabled. This means that as\nsoon as you execute a statement that updates (modifies) a table, MySQL\nstores the update on disk to make it permanent. To disable autocommit\nmode, use the following statement:\n\nSET autocommit=0;\n\nAfter disabling autocommit mode by setting the autocommit variable to\nzero, changes to transaction-safe tables (such as those for InnoDB,\nBDB, or NDBCLUSTER) are not made permanent immediately. You must use\nCOMMIT to store your changes to disk or ROLLBACK to ignore the changes.\n\nTo disable autocommit mode for a single series of statements, use the\nSTART TRANSACTION statement:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/commit.html\n\n','START TRANSACTION;\nSELECT @A:=SUM(salary) FROM table1 WHERE type=1;\nUPDATE table2 SET summary=@A WHERE type=1;\nCOMMIT;\n','http://dev.mysql.com/doc/refman/5.0/en/commit.html');
INSERT INTO `mysql`.`help_topic` VALUES  (136,'BETWEEN AND',16,'Syntax:\nexpr BETWEEN min AND max\n\nIf expr is greater than or equal to min and expr is less than or equal\nto max, BETWEEN returns 1, otherwise it returns 0. This is equivalent\nto the expression (min <= expr AND expr <= max) if all the arguments\nare of the same type. Otherwise type conversion takes place according\nto the rules described in\nhttp://dev.mysql.com/doc/refman/5.0/en/type-conversion.html, but\napplied to all the three arguments.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 1 BETWEEN 2 AND 3;\n        -> 0\nmysql> SELECT \'b\' BETWEEN \'a\' AND \'c\';\n        -> 1\nmysql> SELECT 2 BETWEEN 2 AND \'3\';\n        -> 1\nmysql> SELECT 2 BETWEEN 2 AND \'x-3\';\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (137,'MULTIPOLYGON',22,'MultiPolygon(poly1,poly2,...)\n\nConstructs a WKB MultiPolygon value from a set of WKB Polygon\narguments. If any argument is not a WKB Polygon, the return value is\nNULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions'),
 (138,'TIME_FORMAT',29,'Syntax:\nTIME_FORMAT(time,format)\n\nThis is used like the DATE_FORMAT() function, but the format string may\ncontain format specifiers only for hours, minutes, and seconds. Other\nspecifiers produce a NULL value or 0.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT TIME_FORMAT(\'100:00:00\', \'%H %k %h %I %l\');\n        -> \'100 100 04 04 4\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (139,'LEFT',34,'Syntax:\nLEFT(str,len)\n\nReturns the leftmost len characters from the string str, or NULL if any\nargument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT LEFT(\'foobarbar\', 5);\n        -> \'fooba\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (140,'FLUSH QUERY CACHE',24,'You can defragment the query cache to better utilize its memory with\nthe FLUSH QUERY CACHE statement. The statement does not remove any\nqueries from the cache.\n\nThe RESET QUERY CACHE statement removes all query results from the\nquery cache. The FLUSH TABLES statement also does this.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/query-cache-status-and-maintenance.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/query-cache-status-and-maintenance.html'),
 (141,'SET DATA TYPE',19,'SET(\'value1\',\'value2\',...) [CHARACTER SET charset_name] [COLLATE\ncollation_name]\n\nA set. A string object that can have zero or more values, each of which\nmust be chosen from the list of values \'value1\', \'value2\', ... A SET\ncolumn can have a maximum of 64 members. SET values are represented\ninternally as integers.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (142,'RAND',4,'Syntax:\nRAND(), RAND(N)\n\nReturns a random floating-point value v in the range 0 <= v < 1.0. If a\nconstant integer argument N is specified, it is used as the seed value,\nwhich produces a repeatable sequence of column values. In the following\nexample, note that the sequences of values produced by RAND(3) is the\nsame both places where it occurs.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> CREATE TABLE t (i INT);\nQuery OK, 0 rows affected (0.42 sec)\n\nmysql> INSERT INTO t VALUES(1),(2),(3);\nQuery OK, 3 rows affected (0.00 sec)\nRecords: 3  Duplicates: 0  Warnings: 0\n\nmysql> SELECT i, RAND() FROM t;\n+------+------------------+\n| i    | RAND()           |\n+------+------------------+\n|    1 | 0.61914388706828 | \n|    2 | 0.93845168309142 | \n|    3 | 0.83482678498591 | \n+------+------------------+\n3 rows in set (0.00 sec)\n\nmysql> SELECT i, RAND(3) FROM t;\n+------+------------------+\n| i    | RAND(3)          |\n+------+------------------+\n|    1 | 0.90576975597606 | \n|    2 | 0.37307905813035 | \n|    3 | 0.14808605345719 | \n+------+------------------+\n3 rows in set (0.00 sec)\n\nmysql> SELECT i, RAND() FROM t;\n+------+------------------+\n| i    | RAND()           |\n+------+------------------+\n|    1 | 0.35877890638893 | \n|    2 | 0.28941420772058 | \n|    3 | 0.37073435016976 | \n+------+------------------+\n3 rows in set (0.00 sec)\n\nmysql> SELECT i, RAND(3) FROM t;\n+------+------------------+\n| i    | RAND(3)          |\n+------+------------------+\n|    1 | 0.90576975597606 | \n|    2 | 0.37307905813035 | \n|    3 | 0.14808605345719 | \n+------+------------------+\n3 rows in set (0.01 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (143,'RPAD',34,'Syntax:\nRPAD(str,len,padstr)\n\nReturns the string str, right-padded with the string padstr to a length\nof len characters. If str is longer than len, the return value is\nshortened to len characters.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT RPAD(\'hi\',5,\'?\');\n        -> \'hi???\'\nmysql> SELECT RPAD(\'hi\',1,\'?\');\n        -> \'h\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (144,'CREATE DATABASE',36,'Syntax:\nCREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name\n    [create_specification] ...\n\ncreate_specification:\n    [DEFAULT] CHARACTER SET [=] charset_name\n  | [DEFAULT] COLLATE [=] collation_name\n\nCREATE DATABASE creates a database with the given name. To use this\nstatement, you need the CREATE privilege for the database. CREATE\nSCHEMA is a synonym for CREATE DATABASE as of MySQL 5.0.2.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-database.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/create-database.html'),
 (145,'DEC',19,'DEC[(M[,D])] [UNSIGNED] [ZEROFILL], NUMERIC[(M[,D])] [UNSIGNED]\n[ZEROFILL], FIXED[(M[,D])] [UNSIGNED] [ZEROFILL]\n\nThese types are synonyms for DECIMAL. The FIXED synonym is available\nfor compatibility with other database systems.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (146,'VAR_POP',15,'Syntax:\nVAR_POP(expr)\n\nReturns the population standard variance of expr. It considers rows as\nthe whole population, not as a sample, so it has the number of rows as\nthe denominator. This function was added in MySQL 5.0.3. Before 5.0.3,\nyou can use VARIANCE(), which is equivalent but is not standard SQL.\n\nVAR_POP() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (147,'ELT',34,'Syntax:\nELT(N,str1,str2,str3,...)\n\nReturns str1 if N = 1, str2 if N = 2, and so on. Returns NULL if N is\nless than 1 or greater than the number of arguments. ELT() is the\ncomplement of FIELD().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT ELT(1, \'ej\', \'Heja\', \'hej\', \'foo\');\n        -> \'ej\'\nmysql> SELECT ELT(4, \'ej\', \'Heja\', \'hej\', \'foo\');\n        -> \'foo\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (148,'ALTER VIEW',36,'Syntax:\nALTER\n    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]\n    [DEFINER = { user | CURRENT_USER }]\n    [SQL SECURITY { DEFINER | INVOKER }]\n    VIEW view_name [(column_list)]\n    AS select_statement\n    [WITH [CASCADED | LOCAL] CHECK OPTION]\n\nThis statement changes the definition of a view, which must exist. The\nsyntax is similar to that for CREATE VIEW and the effect is the same as\nfor CREATE OR REPLACE VIEW. See [HELP CREATE VIEW]. This statement\nrequires the CREATE VIEW and DROP privileges for the view, and some\nprivilege for each column referred to in the SELECT statement. As of\nMySQL 5.0.52, ALTER VIEW is allowed only to the original definer or\nusers with the SUPER privilege.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/alter-view.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/alter-view.html');
INSERT INTO `mysql`.`help_topic` VALUES  (149,'SHOW DATABASES',25,'Syntax:\nSHOW {DATABASES | SCHEMAS}\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW DATABASES lists the databases on the MySQL server host. SHOW\nSCHEMAS is a synonym for SHOW DATABASES as of MySQL 5.0.2. The LIKE\nclause, if present, indicates which database names to match. The WHERE\nclause can be given to select rows using more general conditions, as\ndiscussed in http://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nYou see only those databases for which you have some kind of privilege,\nunless you have the global SHOW DATABASES privilege. You can also get\nthis list using the mysqlshow command.\n\nIf the server was started with the --skip-show-database option, you\ncannot use this statement at all unless you have the SHOW DATABASES\nprivilege.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-databases.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-databases.html'),
 (150,'~',17,'Syntax:\n~\n\nInvert all bits.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html\n\n','mysql> SELECT 5 & ~1;\n        -> 4\n','http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html'),
 (151,'TEXT',19,'TEXT[(M)] [CHARACTER SET charset_name] [COLLATE collation_name]\n\nA TEXT column with a maximum length of 65,535 (216 - 1) characters. The\neffective maximum length is less if the value contains multi-byte\ncharacters. Each TEXT value is stored using a two-byte length prefix\nthat indicates the number of bytes in the value.\n\nAn optional length M can be given for this type. If this is done, MySQL\ncreates the column as the smallest TEXT type large enough to hold\nvalues M characters long.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (152,'CONCAT_WS',34,'Syntax:\nCONCAT_WS(separator,str1,str2,...)\n\nCONCAT_WS() stands for Concatenate With Separator and is a special form\nof CONCAT(). The first argument is the separator for the rest of the\narguments. The separator is added between the strings to be\nconcatenated. The separator can be a string, as can the rest of the\narguments. If the separator is NULL, the result is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT CONCAT_WS(\',\',\'First name\',\'Second name\',\'Last Name\');\n        -> \'First name,Second name,Last Name\'\nmysql> SELECT CONCAT_WS(\',\',\'First name\',NULL,\'Last Name\');\n        -> \'First name,Last Name\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (153,'ROW_COUNT',14,'Syntax:\nROW_COUNT()\n\nROW_COUNT() returns the number of rows updated, inserted, or deleted by\nthe preceding statement. This is the same as the row count that the\nmysql client displays and the value from the mysql_affected_rows() C\nAPI function.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> INSERT INTO t VALUES(1),(2),(3);\nQuery OK, 3 rows affected (0.00 sec)\nRecords: 3  Duplicates: 0  Warnings: 0\n\nmysql> SELECT ROW_COUNT();\n+-------------+\n| ROW_COUNT() |\n+-------------+\n|           3 |\n+-------------+\n1 row in set (0.00 sec)\n\nmysql> DELETE FROM t WHERE i IN(1,2);\nQuery OK, 2 rows affected (0.00 sec)\n\nmysql> SELECT ROW_COUNT();\n+-------------+\n| ROW_COUNT() |\n+-------------+\n|           2 |\n+-------------+\n1 row in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (154,'ASIN',4,'Syntax:\nASIN(X)\n\nReturns the arc sine of X, that is, the value whose sine is X. Returns\nNULL if X is not in the range -1 to 1.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT ASIN(0.2);\n        -> 0.20135792079033\nmysql> SELECT ASIN(\'foo\');\n\n+-------------+\n| ASIN(\'foo\') |\n+-------------+\n|           0 |\n+-------------+\n1 row in set, 1 warning (0.00 sec)\n\nmysql> SHOW WARNINGS;\n+---------+------+-----------------------------------------+\n| Level   | Code | Message                                 |\n+---------+------+-----------------------------------------+\n| Warning | 1292 | Truncated incorrect DOUBLE value: \'foo\' |\n+---------+------+-----------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (155,'SHOW LOGS',25,'Syntax:\nSHOW [BDB] LOGS\n\nIn MySQL 5.0, this is a deprecated synonym for SHOW ENGINE BDB LOGS.\nSee [HELP SHOW ENGINE].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-logs.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-logs.html'),
 (156,'SIGN',4,'Syntax:\nSIGN(X)\n\nReturns the sign of the argument as -1, 0, or 1, depending on whether X\nis negative, zero, or positive.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT SIGN(-32);\n        -> -1\nmysql> SELECT SIGN(0);\n        -> 0\nmysql> SELECT SIGN(234);\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (157,'SEC_TO_TIME',29,'Syntax:\nSEC_TO_TIME(seconds)\n\nReturns the seconds argument, converted to hours, minutes, and seconds,\nas a TIME value. The range of the result is constrained to that of the\nTIME data type. A warning occurs if the argument corresponds to a value\noutside that range.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT SEC_TO_TIME(2378);\n        -> \'00:39:38\'\nmysql> SELECT SEC_TO_TIME(2378) + 0;\n        -> 3938\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (158,'FLOAT',19,'FLOAT[(M,D)] [UNSIGNED] [ZEROFILL]\n\nA small (single-precision) floating-point number. Allowable values are\n-3.402823466E+38 to -1.175494351E-38, 0, and 1.175494351E-38 to\n3.402823466E+38. These are the theoretical limits, based on the IEEE\nstandard. The actual range might be slightly smaller depending on your\nhardware or operating system.\n\nM is the total number of digits and D is the number of digits following\nthe decimal point. If M and D are omitted, values are stored to the\nlimits allowed by the hardware. A single-precision floating-point\nnumber is accurate to approximately 7 decimal places.\n\nUNSIGNED, if specified, disallows negative values.\n\nUsing FLOAT might give you some unexpected problems because all\ncalculations in MySQL are done with double precision. See\nhttp://dev.mysql.com/doc/refman/5.0/en/no-matching-rows.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (159,'LOCATE',34,'Syntax:\nLOCATE(substr,str), LOCATE(substr,str,pos)\n\nThe first syntax returns the position of the first occurrence of\nsubstring substr in string str. The second syntax returns the position\nof the first occurrence of substring substr in string str, starting at\nposition pos. Returns 0 if substr is not in str.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT LOCATE(\'bar\', \'foobarbar\');\n        -> 4\nmysql> SELECT LOCATE(\'xbar\', \'foobar\');\n        -> 0\nmysql> SELECT LOCATE(\'bar\', \'foobarbar\', 5);\n        -> 7\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (160,'CHARSET',14,'Syntax:\nCHARSET(str)\n\nReturns the character set of the string argument.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT CHARSET(\'abc\');\n        -> \'latin1\'\nmysql> SELECT CHARSET(CONVERT(\'abc\' USING utf8));\n        -> \'utf8\'\nmysql> SELECT CHARSET(USER());\n        -> \'utf8\'\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (161,'SUBDATE',29,'Syntax:\nSUBDATE(date,INTERVAL expr unit), SUBDATE(expr,days)\n\nWhen invoked with the INTERVAL form of the second argument, SUBDATE()\nis a synonym for DATE_SUB(). For information on the INTERVAL unit\nargument, see the discussion for DATE_ADD().\n\nmysql> SELECT DATE_SUB(\'2008-01-02\', INTERVAL 31 DAY);\n        -> \'2007-12-02\'\nmysql> SELECT SUBDATE(\'2008-01-02\', INTERVAL 31 DAY);\n        -> \'2007-12-02\'\n\nThe second form allows the use of an integer value for days. In such\ncases, it is interpreted as the number of days to be subtracted from\nthe date or datetime expression expr.\n\nmysql> SELECT SUBDATE(\'2008-01-02 12:00:00\', 31);\n        -> \'2007-12-02 12:00:00\'\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (162,'DAYOFYEAR',29,'Syntax:\nDAYOFYEAR(date)\n\nReturns the day of the year for date, in the range 1 to 366.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT DAYOFYEAR(\'2007-02-03\');\n        -> 34\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (163,'LONGTEXT',19,'LONGTEXT [CHARACTER SET charset_name] [COLLATE collation_name]\n\nA TEXT column with a maximum length of 4,294,967,295 or 4GB (232 - 1)\ncharacters. The effective maximum length is less if the value contains\nmulti-byte characters. The effective maximum length of LONGTEXT columns\nalso depends on the configured maximum packet size in the client/server\nprotocol and available memory. Each LONGTEXT value is stored using a\nfour-byte length prefix that indicates the number of bytes in the\nvalue.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (164,'%',4,'Syntax:\nN % M\n\nModulo operation. Returns the remainder of N divided by M. For more\ninformation, see the description for the MOD() function in\nhttp://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (165,'KILL',25,'Syntax:\nKILL [CONNECTION | QUERY] thread_id\n\nEach connection to mysqld runs in a separate thread. You can see which\nthreads are running with the SHOW PROCESSLIST statement and kill a\nthread with the KILL thread_id statement.\n\nIn MySQL 5.0.0, KILL allows the optional CONNECTION or QUERY modifier:\n\no KILL CONNECTION is the same as KILL with no modifier: It terminates\n  the connection associated with the given thread_id.\n\no KILL QUERY terminates the statement that the connection is currently\n  executing, but leaves the connection itself intact.\n\nIf you have the PROCESS privilege, you can see all threads. If you have\nthe SUPER privilege, you can kill all threads and statements.\nOtherwise, you can see and kill only your own threads and statements.\n\nYou can also use the mysqladmin processlist and mysqladmin kill\ncommands to examine and kill threads.\n\n*Note*: You cannot use KILL with the Embedded MySQL Server library,\nbecause the embedded server merely runs inside the threads of the host\napplication. It does not create any connection threads of its own.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/kill.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/kill.html'),
 (166,'DISJOINT',28,'Disjoint(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 is spatially disjoint from (does\nnot intersect) g2.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html');
INSERT INTO `mysql`.`help_topic` VALUES  (167,'ASTEXT',3,'AsText(g), AsWKT(g)\n\nConverts a value in internal geometry format to its WKT representation\nand returns the string result.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-to-convert-geometries-between-formats.html\n\n','mysql> SET @g = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT AsText(GeomFromText(@g));\n+--------------------------+\n| AsText(GeomFromText(@g)) |\n+--------------------------+\n| LINESTRING(1 1,2 2,3 3)  |\n+--------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/functions-to-convert-geometries-between-formats.html'),
 (168,'LPAD',34,'Syntax:\nLPAD(str,len,padstr)\n\nReturns the string str, left-padded with the string padstr to a length\nof len characters. If str is longer than len, the return value is\nshortened to len characters.\n\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT LPAD(\'hi\',4,\'??\');\n        -> \'??hi\'\nmysql> SELECT LPAD(\'hi\',1,\'??\');\n        -> \'h\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (169,'RESTORE TABLE',18,'Syntax:\nRESTORE TABLE tbl_name [, tbl_name] ... FROM \'/path/to/backup/directory\'\n\nRESTORE TABLE restores the table or tables from a backup that was made\nwith BACKUP TABLE. The directory should be specified as a full\npathname.\n\nExisting tables are not overwritten; if you try to restore over an\nexisting table, an error occurs. Just as for BACKUP TABLE, RESTORE\nTABLE currently works only for MyISAM tables. Restored tables are not\nreplicated from master to slave.\n\nThe backup for each table consists of its .frm format file and .MYD\ndata file. The restore operation restores those files, and then uses\nthem to rebuild the .MYI index file. Restoring takes longer than\nbacking up due to the need to rebuild the indexes. The more indexes the\ntable has, the longer it takes.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/restore-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/restore-table.html');
INSERT INTO `mysql`.`help_topic` VALUES  (170,'DECLARE CONDITION',21,'Syntax:\nDECLARE condition_name CONDITION FOR condition_value\n\ncondition_value:\n    SQLSTATE [VALUE] sqlstate_value\n  | mysql_error_code\n\nThe DECLARE ... CONDITION statement defines a named error condition. It\nspecifies a condition that needs specific handling and associates a\nname with that condition. The name can be referred to in a subsequence\nDECLARE ... HANDLER statement. See [HELP DECLARE HANDLER].\n\nA condition_value for DECLARE ... CONDITION can be an SQLSTATE value (a\n5-character string literal) or a MySQL error code (a number). You\nshould not use SQLSTATE value \'00000\' or MySQL error code 0, because\nthose indicate sucess rather than an error condition. For a list of\nSQLSTATE values and MySQL error codes, see\nhttp://dev.mysql.com/doc/refman/5.0/en/error-messages-server.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/declare-condition.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/declare-condition.html'),
 (171,'OVERLAPS',28,'Overlaps(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 spatially overlaps g2. The term\nspatially overlaps is used if two geometries intersect and their\nintersection results in a geometry of the same dimension but not equal\nto either of the given geometries.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html');
INSERT INTO `mysql`.`help_topic` VALUES  (172,'SET GLOBAL SQL_SLAVE_SKIP_COUNTER',25,'Syntax:\nSET GLOBAL SQL_SLAVE_SKIP_COUNTER = N\n\nThis statement skips the next N events from the master. This is useful\nfor recovering from replication stops caused by a statement.\n\nThis statement is valid only when the slave thread is not running.\nOtherwise, it produces an error.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/set-global-sql-slave-skip-counter.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/set-global-sql-slave-skip-counter.html'),
 (173,'NUMGEOMETRIES',23,'NumGeometries(gc)\n\nReturns the number of geometries in the GeometryCollection value gc.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#geometrycollection-property-functions\n\n','mysql> SET @gc = \'GeometryCollection(Point(1 1),LineString(2 2, 3 3))\';\nmysql> SELECT NumGeometries(GeomFromText(@gc));\n+----------------------------------+\n| NumGeometries(GeomFromText(@gc)) |\n+----------------------------------+\n|                                2 |\n+----------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#geometrycollection-property-functions'),
 (174,'MONTHNAME',29,'Syntax:\nMONTHNAME(date)\n\nReturns the full name of the month for date. As of MySQL 5.0.25, the\nlanguage used for the name is controlled by the value of the\nlc_time_names system variable\n(http://dev.mysql.com/doc/refman/5.0/en/locale-support.html).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT MONTHNAME(\'2008-02-03\');\n        -> \'February\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (175,'PROCEDURE ANALYSE',35,'Syntax:\nanalyse([max_elements[,max_memory]])\n\nThis procedure is defined in the sql/sql_analyse.cc file. It examines\nthe result from a query and returns an analysis of the results that\nsuggests optimal data types for each column. To obtain this analysis,\nappend PROCEDURE ANALYSE to the end of a SELECT statement:\n\nSELECT ... FROM ... WHERE ... PROCEDURE ANALYSE([max_elements,[max_memory]])\n\nFor example:\n\nSELECT col1, col2 FROM table1 PROCEDURE ANALYSE(10, 2000);\n\nThe results show some statistics for the values returned by the query,\nand propose an optimal data type for the columns. This can be helpful\nfor checking your existing tables, or after importing new data. You may\nneed to try different settings for the arguments so that PROCEDURE\nANALYSE() does not suggest the ENUM data type when it is not\nappropriate.\n\nThe arguments are optional and are used as follows:\n\no max_elements (default 256) is the maximum number of distinct values\n  that analyse notices per column. This is used by analyse to check\n  whether the optimal data type should be of type ENUM; if there are\n  more than max_elements distinct values, then ENUM is not a suggested\n  type.\n\no max_memory (default 8192) is the maximum amount of memory that\n  analyse should allocate per column while trying to find all distinct\n  values.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/procedure-analyse.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/procedure-analyse.html'),
 (176,'CHANGE MASTER TO',25,'Syntax:\nCHANGE MASTER TO master_def [, master_def] ...\n\nmaster_def:\n    MASTER_HOST = \'host_name\'\n  | MASTER_USER = \'user_name\'\n  | MASTER_PASSWORD = \'password\'\n  | MASTER_PORT = port_num\n  | MASTER_CONNECT_RETRY = interval\n  | MASTER_LOG_FILE = \'master_log_name\'\n  | MASTER_LOG_POS = master_log_pos\n  | RELAY_LOG_FILE = \'relay_log_name\'\n  | RELAY_LOG_POS = relay_log_pos\n  | MASTER_SSL = {0|1}\n  | MASTER_SSL_CA = \'ca_file_name\'\n  | MASTER_SSL_CAPATH = \'ca_directory_name\'\n  | MASTER_SSL_CERT = \'cert_file_name\'\n  | MASTER_SSL_KEY = \'key_file_name\'\n  | MASTER_SSL_CIPHER = \'cipher_list\'\n\nCHANGE MASTER TO changes the parameters that the slave server uses for\nconnecting to and communicating with the master server. It also updates\nthe contents of the master.info and relay-log.info files.\n\nMASTER_USER, MASTER_PASSWORD, MASTER_SSL, MASTER_SSL_CA,\nMASTER_SSL_CAPATH, MASTER_SSL_CERT, MASTER_SSL_KEY, and\nMASTER_SSL_CIPHER provide information to the slave about how to connect\nto its master.\n\nMASTER_CONNECT_RETRY specifies how many seconds to wait between connect\nretries. The default is 60. The number of reconnection attempts is\nlimited by the --master-retry-count server option; for more\ninformation, see\nhttp://dev.mysql.com/doc/refman/5.0/en/replication-options.html.\n\nThe SSL options (MASTER_SSL, MASTER_SSL_CA, MASTER_SSL_CAPATH,\nMASTER_SSL_CERT, MASTER_SSL_KEY, and MASTER_SSL_CIPHER) can be changed\neven on slaves that are compiled without SSL support. They are saved to\nthe master.info file, but are ignored unless you use a server that has\nSSL support enabled.\n\nIf you don\'t specify a given parameter, it keeps its old value, except\nas indicated in the following discussion. For example, if the password\nto connect to your MySQL master has changed, you just need to issue\nthese statements to tell the slave about the new password:\n\nSTOP SLAVE; -- if replication was running\nCHANGE MASTER TO MASTER_PASSWORD=\'new3cret\';\nSTART SLAVE; -- if you want to restart replication\n\nThere is no need to specify the parameters that do not change (host,\nport, user, and so forth).\n\nMASTER_HOST and MASTER_PORT are the hostname (or IP address) of the\nmaster host and its TCP/IP port. Note that if MASTER_HOST is equal to\nlocalhost, then, like in other parts of MySQL, the port number might be\nignored.\n\n*Note*: Replication cannot use Unix socket files. You must be able to\nconnect to the master MySQL server using TCP/IP.\n\nIf you specify MASTER_HOST or MASTER_PORT, the slave assumes that the\nmaster server is different from before (even if you specify a host or\nport value that is the same as the current value.) In this case, the\nold values for the master binary log name and position are considered\nno longer applicable, so if you do not specify MASTER_LOG_FILE and\nMASTER_LOG_POS in the statement, MASTER_LOG_FILE=\'\' and\nMASTER_LOG_POS=4 are silently appended to it.\n\nMASTER_LOG_FILE and MASTER_LOG_POS are the coordinates at which the\nslave I/O thread should begin reading from the master the next time the\nthread starts. If you specify either of them, you cannot specify\nRELAY_LOG_FILE or RELAY_LOG_POS. If neither of MASTER_LOG_FILE or\nMASTER_LOG_POS are specified, the slave uses the last coordinates of\nthe slave SQL thread before CHANGE MASTER TO was issued. This ensures\nthat there is no discontinuity in replication, even if the slave SQL\nthread was late compared to the slave I/O thread, when you merely want\nto change, say, the password to use.\n\nCHANGE MASTER TO deletes all relay log files and starts a new one,\nunless you specify RELAY_LOG_FILE or RELAY_LOG_POS. In that case, relay\nlogs are kept; the relay_log_purge global variable is set silently to\n0.\n\nCHANGE MASTER TO is useful for setting up a slave when you have the\nsnapshot of the master and have recorded the log and the offset\ncorresponding to it. After loading the snapshot into the slave, you can\nrun CHANGE MASTER TO MASTER_LOG_FILE=\'log_name_on_master\',\nMASTER_LOG_POS=log_offset_on_master on the slave.\n\nThe following example changes the master and master\'s binary log\ncoordinates. This is used when you want to set up the slave to\nreplicate the master:\n\nCHANGE MASTER TO\n  MASTER_HOST=\'master2.mycompany.com\',\n  MASTER_USER=\'replication\',\n  MASTER_PASSWORD=\'bigs3cret\',\n  MASTER_PORT=3306,\n  MASTER_LOG_FILE=\'master2-bin.001\',\n  MASTER_LOG_POS=4,\n  MASTER_CONNECT_RETRY=10;\n\nThe next example shows an operation that is less frequently employed.\nIt is used when the slave has relay logs that you want it to execute\nagain for some reason. To do this, the master need not be reachable.\nYou need only use CHANGE MASTER TO and start the SQL thread (START\nSLAVE SQL_THREAD):\n\nCHANGE MASTER TO\n  RELAY_LOG_FILE=\'slave-relay-bin.006\',\n  RELAY_LOG_POS=4025;\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/change-master-to.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/change-master-to.html');
INSERT INTO `mysql`.`help_topic` VALUES  (177,'DROP DATABASE',36,'Syntax:\nDROP {DATABASE | SCHEMA} [IF EXISTS] db_name\n\nDROP DATABASE drops all tables in the database and deletes the\ndatabase. Be very careful with this statement! To use DROP DATABASE,\nyou need the DROP privilege on the database. DROP SCHEMA is a synonym\nfor DROP DATABASE as of MySQL 5.0.2.\n\n*Important*: When a database is dropped, user privileges on the\ndatabase are not automatically dropped. See [HELP GRANT].\n\nIF EXISTS is used to prevent an error from occurring if the database\ndoes not exist.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-database.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-database.html'),
 (178,'MBREQUAL',5,'MBREqual(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 are the same.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html'),
 (179,'TIMESTAMP FUNCTION',29,'Syntax:\nTIMESTAMP(expr), TIMESTAMP(expr1,expr2)\n\nWith a single argument, this function returns the date or datetime\nexpression expr as a datetime value. With two arguments, it adds the\ntime expression expr2 to the date or datetime expression expr1 and\nreturns the result as a datetime value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT TIMESTAMP(\'2003-12-31\');\n        -> \'2003-12-31 00:00:00\'\nmysql> SELECT TIMESTAMP(\'2003-12-31 12:00:00\',\'12:00:00\');\n        -> \'2004-01-01 00:00:00\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (180,'CHARACTER_LENGTH',34,'Syntax:\nCHARACTER_LENGTH(str)\n\nCHARACTER_LENGTH() is a synonym for CHAR_LENGTH().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (181,'SHOW GRANTS',25,'Syntax:\nSHOW GRANTS [FOR user]\n\nThis statement lists the GRANT statement or statements that must be\nissued to duplicate the privileges that are granted to a MySQL user\naccount. The account is named using the same format as for the GRANT\nstatement; for example, \'jeffrey\'@\'localhost\'. If you specify only the\nusername part of the account name, a hostname part of \'%\' is used. For\nadditional information about specifying account names, see [HELP\nGRANT].\n\nmysql> SHOW GRANTS FOR \'root\'@\'localhost\';\n+---------------------------------------------------------------------+\n| Grants for root@localhost                                           |\n+---------------------------------------------------------------------+\n| GRANT ALL PRIVILEGES ON *.* TO \'root\'@\'localhost\' WITH GRANT OPTION |\n+---------------------------------------------------------------------+\n\nTo list the privileges granted to the account that you are using to\nconnect to the server, you can use any of the following statements:\n\nSHOW GRANTS;\nSHOW GRANTS FOR CURRENT_USER;\nSHOW GRANTS FOR CURRENT_USER();\n\nAs of MySQL 5.0.24, if SHOW GRANTS FOR CURRENT_USER (or any of the\nequivalent syntaxes) is used in DEFINER context, such as within a\nstored procedure that is defined with SQL SECURITY DEFINER), the grants\ndisplayed are those of the definer and not the invoker.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-grants.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-grants.html'),
 (182,'SHOW PRIVILEGES',25,'Syntax:\nSHOW PRIVILEGES\n\nSHOW PRIVILEGES shows the list of system privileges that the MySQL\nserver supports. The exact list of privileges depends on the version of\nyour server.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-privileges.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-privileges.html');
INSERT INTO `mysql`.`help_topic` VALUES  (183,'INSERT FUNCTION',34,'Syntax:\nINSERT(str,pos,len,newstr)\n\nReturns the string str, with the substring beginning at position pos\nand len characters long replaced by the string newstr. Returns the\noriginal string if pos is not within the length of the string. Replaces\nthe rest of the string from position pos if len is not within the\nlength of the rest of the string. Returns NULL if any argument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT INSERT(\'Quadratic\', 3, 4, \'What\');\n        -> \'QuWhattic\'\nmysql> SELECT INSERT(\'Quadratic\', -1, 4, \'What\');\n        -> \'Quadratic\'\nmysql> SELECT INSERT(\'Quadratic\', 3, 100, \'What\');\n        -> \'QuWhat\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (184,'CRC32',4,'Syntax:\nCRC32(expr)\n\nComputes a cyclic redundancy check value and returns a 32-bit unsigned\nvalue. The result is NULL if the argument is NULL. The argument is\nexpected to be a string and (if possible) is treated as one if it is\nnot.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT CRC32(\'MySQL\');\n        -> 3259397556\nmysql> SELECT CRC32(\'mysql\');\n        -> 2501908538\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (185,'XOR',12,'Syntax:\nXOR\n\nLogical XOR. Returns NULL if either operand is NULL. For non-NULL\noperands, evaluates to 1 if an odd number of operands is non-zero,\notherwise 0 is returned.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/logical-operators.html\n\n','mysql> SELECT 1 XOR 1;\n        -> 0\nmysql> SELECT 1 XOR 0;\n        -> 1\nmysql> SELECT 1 XOR NULL;\n        -> NULL\nmysql> SELECT 1 XOR 1 XOR 1;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/logical-operators.html');
INSERT INTO `mysql`.`help_topic` VALUES  (186,'STARTPOINT',11,'StartPoint(ls)\n\nReturns the Point that is the start point of the LineString value ls.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT AsText(StartPoint(GeomFromText(@ls)));\n+---------------------------------------+\n| AsText(StartPoint(GeomFromText(@ls))) |\n+---------------------------------------+\n| POINT(1 1)                            |\n+---------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions'),
 (187,'DECLARE VARIABLE',21,'Syntax:\nDECLARE var_name [, var_name] ... type [DEFAULT value]\n\nThis statement is used to declare local variables within stored\nprograms. To provide a default value for the variable, include a\nDEFAULT clause. The value can be specified as an expression; it need\nnot be a constant. If the DEFAULT clause is missing, the initial value\nis NULL.\n\nLocal variables are treated like stored routine parameters with respect\nto data type and overflow checking. See [HELP CREATE PROCEDURE].\n\nLocal variable names are not case sensitive.\n\nThe scope of a local variable is within the BEGIN ... END block where\nit is declared. The variable can be referred to in blocks nested within\nthe declaring block, except those blocks that declare a variable with\nthe same name.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/declare-local-variable.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/declare-local-variable.html'),
 (188,'GRANT',8,'Syntax:\nGRANT\n    priv_type [(column_list)]\n      [, priv_type [(column_list)]] ...\n    ON [object_type]\n        {\n            *\n          | *.*\n          | db_name.*\n          | db_name.tbl_name\n          | tbl_name\n          | db_name.routine_name\n\n        }\n    TO user [IDENTIFIED BY [PASSWORD] \'password\']\n        [, user [IDENTIFIED BY [PASSWORD] \'password\']] ...\n    [REQUIRE\n        NONE |\n        [{SSL| X509}]\n        [CIPHER \'cipher\' [AND]]\n        [ISSUER \'issuer\' [AND]]\n        [SUBJECT \'subject\']]\n    [WITH with_option [with_option] ...]\n\nobject_type =\n    TABLE\n  | FUNCTION\n  | PROCEDURE\n\nwith_option =\n    GRANT OPTION\n  | MAX_QUERIES_PER_HOUR count\n  | MAX_UPDATES_PER_HOUR count\n  | MAX_CONNECTIONS_PER_HOUR count\n  | MAX_USER_CONNECTIONS count\n\nThe GRANT statement enables system administrators to create MySQL user\naccounts and to grant rights to accounts. To use GRANT, you must have\nthe GRANT OPTION privilege, and you must have the privileges that you\nare granting. The REVOKE statement is related and enables\nadministrators to remove account privileges. See [HELP REVOKE].\n\nMySQL account information is stored in the tables of the mysql\ndatabase. This database and the access control system are discussed\nextensively in\nhttp://dev.mysql.com/doc/refman/5.0/en/server-administration.html,\nwhich you should consult for additional details.\n\n*Important*: Some releases of MySQL introduce changes to the structure\nof the grant tables to add new privileges or features. Whenever you\nupdate to a new version of MySQL, you should update your grant tables\nto make sure that they have the current structure so that you can take\nadvantage of any new capabilities. See\nhttp://dev.mysql.com/doc/refman/5.0/en/mysql-upgrade.html.\n\nIf the grant tables hold privilege rows that contain mixed-case\ndatabase or table names and the lower_case_table_names system variable\nis set to a non-zero value, REVOKE cannot be used to revoke these\nprivileges. It will be necessary to manipulate the grant tables\ndirectly. (GRANT will not create such rows when lower_case_table_names\nis set, but such rows might have been created prior to setting the\nvariable.)\n\nPrivileges can be granted at several levels. The examples shown here\ninclude no IDENTIFIED BY \'password\' clause for brevity, but you should\ninclude one if the account does not already exist to avoid creating an\naccount with no password.\n\no Global level\n\n  Global privileges apply to all databases on a given server. These\n  privileges are stored in the mysql.user table. GRANT ALL ON *.* and\n  REVOKE ALL ON *.* grant and revoke only global privileges.\n\nGRANT ALL ON *.* TO \'someuser\'@\'somehost\';\nGRANT SELECT, INSERT ON *.* TO \'someuser\'@\'somehost\';\n\no Database level\n\n  Database privileges apply to all objects in a given database. These\n  privileges are stored in the mysql.db and mysql.host tables. GRANT\n  ALL ON db_name.* and REVOKE ALL ON db_name.* grant and revoke only\n  database privileges.\n\nGRANT ALL ON mydb.* TO \'someuser\'@\'somehost\';\nGRANT SELECT, INSERT ON mydb.* TO \'someuser\'@\'somehost\';\n\no Table level\n\n  Table privileges apply to all columns in a given table. These\n  privileges are stored in the mysql.tables_priv table. GRANT ALL ON\n  db_name.tbl_name and REVOKE ALL ON db_name.tbl_name grant and revoke\n  only table privileges.\n\nGRANT ALL ON mydb.mytbl TO \'someuser\'@\'somehost\';\nGRANT SELECT, INSERT ON mydb.mytbl TO \'someuser\'@\'somehost\';\n\n  If you specify tbl_name rather than db_name.tbl_name, the statement\n  applies to tbl_name in the default database.\n\no Column level\n\n  Column privileges apply to single columns in a given table. These\n  privileges are stored in the mysql.columns_priv table. When using\n  REVOKE, you must specify the same columns that were granted. The\n  column or columns for which the privileges are to be granted must be\n  enclosed within parentheses.\n\nGRANT SELECT (col1), INSERT (col1,col2) ON mydb.mytbl TO \'someuser\'@\'somehost\';\n\no Routine level\n\n  The CREATE ROUTINE, ALTER ROUTINE, EXECUTE, and GRANT OPTION\n  privileges apply to stored routines (functions and procedures). They\n  can be granted at the global and database levels. Also, except for\n  CREATE ROUTINE, these privileges can be granted at the routine level\n  for individual routines and are stored in the mysql.procs_priv table.\n\nGRANT CREATE ROUTINE ON mydb.* TO \'someuser\'@\'somehost\';\nGRANT EXECUTE ON PROCEDURE mydb.myproc TO \'someuser\'@\'somehost\';\n\nThe object_type clause was added in MySQL 5.0.6. It should be specified\nas TABLE, FUNCTION, or PROCEDURE when the following object is a table,\na stored function, or a stored procedure.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/grant.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/grant.html');
INSERT INTO `mysql`.`help_topic` VALUES  (189,'MPOLYFROMTEXT',3,'MPolyFromText(wkt[,srid]), MultiPolygonFromText(wkt[,srid])\n\nConstructs a MULTIPOLYGON value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions'),
 (190,'MBRINTERSECTS',5,'MBRIntersects(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 intersect.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html'),
 (191,'BIT_OR',15,'Syntax:\nBIT_OR(expr)\n\nReturns the bitwise OR of all bits in expr. The calculation is\nperformed with 64-bit (BIGINT) precision.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (192,'YEARWEEK',29,'Syntax:\nYEARWEEK(date), YEARWEEK(date,mode)\n\nReturns year and week for a date. The mode argument works exactly like\nthe mode argument to WEEK(). The year in the result may be different\nfrom the year in the date argument for the first and the last week of\nthe year.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT YEARWEEK(\'1987-01-01\');\n        -> 198653\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (193,'NOT BETWEEN',16,'Syntax:\nexpr NOT BETWEEN min AND max\n\nThis is the same as NOT (expr BETWEEN min AND max).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (194,'IS NOT',16,'Syntax:\nIS NOT boolean_value\n\nTests a value against a boolean value, where boolean_value can be TRUE,\nFALSE, or UNKNOWN.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 1 IS NOT UNKNOWN, 0 IS NOT UNKNOWN, NULL IS NOT UNKNOWN;\n        -> 1, 1, 0\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (195,'LOG10',4,'Syntax:\nLOG10(X)\n\nReturns the base-10 logarithm of X.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT LOG10(2);\n        -> 0.30102999566398\nmysql> SELECT LOG10(100);\n        -> 2\nmysql> SELECT LOG10(-100);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (196,'SQRT',4,'Syntax:\nSQRT(X)\n\nReturns the square root of a non-negative number X.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT SQRT(4);\n        -> 2\nmysql> SELECT SQRT(20);\n        -> 4.4721359549996\nmysql> SELECT SQRT(-16);\n        -> NULL        \n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (197,'DECIMAL',19,'DECIMAL[(M[,D])] [UNSIGNED] [ZEROFILL]\n\nFor MySQL 5.0.3 and above:\n\nA packed \"exact\" fixed-point number. M is the total number of digits\n(the precision) and D is the number of digits after the decimal point\n(the scale). The decimal point and (for negative numbers) the \"-\" sign\nare not counted in M. If D is 0, values have no decimal point or\nfractional part. The maximum number of digits (M) for DECIMAL is 65 (64\nfrom 5.0.3 to 5.0.5). The maximum number of supported decimals (D) is\n30. If D is omitted, the default is 0. If M is omitted, the default is\n10.\n\nUNSIGNED, if specified, disallows negative values.\n\nAll basic calculations (+, -, *, /) with DECIMAL columns are done with\na precision of 65 digits.\n\nBefore MySQL 5.0.3:\n\nAn unpacked fixed-point number. Behaves like a CHAR column; \"unpacked\"\nmeans the number is stored as a string, using one character for each\ndigit of the value. M is the total number of digits and D is the number\nof digits after the decimal point. The decimal point and (for negative\nnumbers) the \"-\" sign are not counted in M, although space for them is\nreserved. If D is 0, values have no decimal point or fractional part.\nThe maximum range of DECIMAL values is the same as for DOUBLE, but the\nactual range for a given DECIMAL column may be constrained by the\nchoice of M and D. If D is omitted, the default is 0. If M is omitted,\nthe default is 10.\n\nUNSIGNED, if specified, disallows negative values.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (198,'CREATE INDEX',36,'Syntax:\nCREATE [UNIQUE|FULLTEXT|SPATIAL] INDEX index_name\n    [index_type]\n    ON tbl_name (index_col_name,...)\n    [index_type]\n\nindex_col_name:\n    col_name [(length)] [ASC | DESC]\n\nindex_type:\n    USING {BTREE | HASH | RTREE}\n\nCREATE INDEX is mapped to an ALTER TABLE statement to create indexes.\nSee [HELP ALTER TABLE]. CREATE INDEX cannot be used to create a PRIMARY\nKEY; use ALTER TABLE instead. For more information about indexes, see\nhttp://dev.mysql.com/doc/refman/5.0/en/mysql-indexes.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-index.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/create-index.html');
INSERT INTO `mysql`.`help_topic` VALUES  (199,'CREATE FUNCTION',36,'The CREATE FUNCTION statement is used to create stored functions and\nuser-defined functions (UDFs):\n\no For information about creating stored functions, see [HELP CREATE\n  PROCEDURE].\n\no For information about creating user-defined functions, see [HELP\n  CREATE FUNCTION UDF].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-function.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/create-function.html'),
 (200,'ALTER DATABASE',36,'Syntax:\nALTER {DATABASE | SCHEMA} [db_name]\n    alter_specification ...\n\nalter_specification:\n    [DEFAULT] CHARACTER SET [=] charset_name\n  | [DEFAULT] COLLATE [=] collation_name\n\nALTER DATABASE enables you to change the overall characteristics of a\ndatabase. These characteristics are stored in the db.opt file in the\ndatabase directory. To use ALTER DATABASE, you need the ALTER privilege\non the database. ALTER SCHEMA is a synonym for ALTER DATABASE as of\nMySQL 5.0.2.\n\nThe CHARACTER SET clause changes the default database character set.\nThe COLLATE clause changes the default database collation.\nhttp://dev.mysql.com/doc/refman/5.0/en/charset.html, discusses\ncharacter set and collation names.\n\nYou can see what character sets and collations are available using,\nrespectively, the SHOW CHARACTER SET and SHOW COLLATION statements. See\n[HELP SHOW CHARACTER SET], and [HELP SHOW COLLATION], for more\ninformation.\n\nThe database name can be omitted, in which case the statement applies\nto the default database.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/alter-database.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/alter-database.html'),
 (201,'GEOMETRYN',23,'GeometryN(gc,N)\n\nReturns the N-th geometry in the GeometryCollection value gc.\nGeometries are numbered beginning with 1.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#geometrycollection-property-functions\n\n','mysql> SET @gc = \'GeometryCollection(Point(1 1),LineString(2 2, 3 3))\';\nmysql> SELECT AsText(GeometryN(GeomFromText(@gc),1));\n+----------------------------------------+\n| AsText(GeometryN(GeomFromText(@gc),1)) |\n+----------------------------------------+\n| POINT(1 1)                             |\n+----------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#geometrycollection-property-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (202,'<<',17,'Syntax:\n<<\n\nShifts a longlong (BIGINT) number to the left.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html\n\n','mysql> SELECT 1 << 2;\n        -> 4\n','http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html'),
 (203,'SHOW TABLE STATUS',25,'Syntax:\nSHOW TABLE STATUS [FROM db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW TABLE STATUS works likes SHOW TABLES, but provides a lot of\ninformation about each non-TEMPORARY table. You can also get this list\nusing the mysqlshow --status db_name command. The LIKE clause, if\npresent, indicates which table names to match. The WHERE clause can be\ngiven to select rows using more general conditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-table-status.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-table-status.html'),
 (204,'MD5',10,'Syntax:\nMD5(str)\n\nCalculates an MD5 128-bit checksum for the string. The value is\nreturned as a binary string of 32 hex digits, or NULL if the argument\nwas NULL. The return value can, for example, be used as a hash key.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','mysql> SELECT MD5(\'testing\');\n        -> \'ae2b1fca515949e5d54fb22b8ed95575\'\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (205,'<',16,'Syntax:\n<\n\nLess than:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 2 < 2;\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html');
INSERT INTO `mysql`.`help_topic` VALUES  (206,'UNIX_TIMESTAMP',29,'Syntax:\nUNIX_TIMESTAMP(), UNIX_TIMESTAMP(date)\n\nIf called with no argument, returns a Unix timestamp (seconds since\n\'1970-01-01 00:00:00\' UTC) as an unsigned integer. If UNIX_TIMESTAMP()\nis called with a date argument, it returns the value of the argument as\nseconds since \'1970-01-01 00:00:00\' UTC. date may be a DATE string, a\nDATETIME string, a TIMESTAMP, or a number in the format YYMMDD or\nYYYYMMDD. The server interprets date as a value in the current time\nzone and converts it to an internal value in UTC. Clients can set their\ntime zone as described in\nhttp://dev.mysql.com/doc/refman/5.0/en/time-zone-support.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT UNIX_TIMESTAMP();\n        -> 1196440210\nmysql> SELECT UNIX_TIMESTAMP(\'2007-11-30 10:30:19\');\n        -> 1196440219\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (207,'DAYOFMONTH',29,'Syntax:\nDAYOFMONTH(date)\n\nReturns the day of the month for date, in the range 1 to 31, or 0 for\ndates such as \'0000-00-00\' or \'2008-00-00\' that have a zero day part.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT DAYOFMONTH(\'2007-02-03\');\n        -> 3\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (208,'ASCII',34,'Syntax:\nASCII(str)\n\nReturns the numeric value of the leftmost character of the string str.\nReturns 0 if str is the empty string. Returns NULL if str is NULL.\nASCII() works for 8-bit characters.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT ASCII(\'2\');\n        -> 50\nmysql> SELECT ASCII(2);\n        -> 50\nmysql> SELECT ASCII(\'dx\');\n        -> 100\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (209,'DIV',4,'Syntax:\nDIV\n\nInteger division. Similar to FLOOR(), but is safe with BIGINT values.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html\n\n','mysql> SELECT 5 DIV 2;\n        -> 2\n','http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html'),
 (210,'RENAME USER',8,'Syntax:\nRENAME USER old_user TO new_user\n    [, old_user TO new_user] ...\n\nThe RENAME USER statement renames existing MySQL accounts. To use it,\nyou must have the global CREATE USER privilege or the UPDATE privilege\nfor the mysql database. An error occurs if any old account does not\nexist or any new account exists. Each account is named using the same\nformat as for the GRANT statement; for example, \'jeffrey\'@\'localhost\'.\nIf you specify only the username part of the account name, a hostname\npart of \'%\' is used. For additional information about specifying\naccount names, see [HELP GRANT].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/rename-user.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/rename-user.html'),
 (211,'SHOW SLAVE STATUS',25,'Syntax:\nSHOW SLAVE STATUS\n\nThis statement provides status information on essential parameters of\nthe slave threads. If you issue this statement using the mysql client,\nyou can use a \\G statement terminator rather than a semicolon to obtain\na more readable vertical layout:\n\nmysql> SHOW SLAVE STATUS\\G\n*************************** 1. row ***************************\n       Slave_IO_State: Waiting for master to send event\n          Master_Host: localhost\n          Master_User: root\n          Master_Port: 3306\n        Connect_Retry: 3\n      Master_Log_File: gbichot-bin.005\n  Read_Master_Log_Pos: 79\n       Relay_Log_File: gbichot-relay-bin.005\n        Relay_Log_Pos: 548\nRelay_Master_Log_File: gbichot-bin.005\n     Slave_IO_Running: Yes\n    Slave_SQL_Running: Yes\n      Replicate_Do_DB:\n  Replicate_Ignore_DB:\n           Last_Errno: 0\n           Last_Error:\n         Skip_Counter: 0\n  Exec_Master_Log_Pos: 79\n      Relay_Log_Space: 552\n      Until_Condition: None\n       Until_Log_File:\n        Until_Log_Pos: 0\n   Master_SSL_Allowed: No\n   Master_SSL_CA_File:\n   Master_SSL_CA_Path:\n      Master_SSL_Cert:\n    Master_SSL_Cipher:\n       Master_SSL_Key:\nSeconds_Behind_Master: 8\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-slave-status.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-slave-status.html');
INSERT INTO `mysql`.`help_topic` VALUES  (212,'GEOMETRY',31,'MySQL provides a standard way of creating spatial columns for geometry\ntypes, for example, with CREATE TABLE or ALTER TABLE. Currently,\nspatial columns are supported for MyISAM, InnoDB, NDB, BDB, and ARCHIVE\ntables. (Support for storage engines other than MyISAM was added in\nMySQL 5.0.16.) See also the annotations about spatial indexes under\n[HELP SPATIAL].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-columns.html\n\n','CREATE TABLE geom (g GEOMETRY);\n','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-columns.html'),
 (213,'NUMPOINTS',11,'NumPoints(ls)\n\nReturns the number of Point objects in the LineString value ls.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT NumPoints(GeomFromText(@ls));\n+------------------------------+\n| NumPoints(GeomFromText(@ls)) |\n+------------------------------+\n|                            3 |\n+------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions'),
 (214,'&',17,'Syntax:\n&\n\nBitwise AND:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html\n\n','mysql> SELECT 29 & 15;\n        -> 13\n','http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (215,'LOCALTIMESTAMP',29,'Syntax:\nLOCALTIMESTAMP, LOCALTIMESTAMP()\n\nLOCALTIMESTAMP and LOCALTIMESTAMP() are synonyms for NOW().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (216,'CONVERT',34,'Syntax:\nCONVERT(expr,type), CONVERT(expr USING transcoding_name)\n\nThe CONVERT() and CAST() functions take a value of one type and produce\na value of another type.\n\nThe type can be one of the following values:\n\no BINARY[(N)]\n\no CHAR[(N)]\n\no DATE\n\no DATETIME\n\no DECIMAL[(M[,D])]\n\no SIGNED [INTEGER]\n\no TIME\n\no UNSIGNED [INTEGER]\n\nBINARY produces a string with the BINARY data type. See\nhttp://dev.mysql.com/doc/refman/5.0/en/binary-varbinary.html for a\ndescription of how this affects comparisons. If the optional length N\nis given, BINARY(N) causes the cast to use no more than N bytes of the\nargument. As of MySQL 5.0.17, values shorter than N bytes are padded\nwith 0x00 bytes to a length of N.\n\nCHAR(N) causes the cast to use no more than N characters of the\nargument.\n\nThe DECIMAL type is available as of MySQL 5.0.8.\n\nCAST() and CONVERT(... USING ...) are standard SQL syntax. The\nnon-USING form of CONVERT() is ODBC syntax.\n\nCONVERT() with USING is used to convert data between different\ncharacter sets. In MySQL, transcoding names are the same as the\ncorresponding character set names. For example, this statement converts\nthe string \'abc\' in the default character set to the corresponding\nstring in the utf8 character set:\n\nSELECT CONVERT(\'abc\' USING utf8);\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/cast-functions.html\n\n','SELECT enum_col FROM tbl_name ORDER BY CAST(enum_col AS CHAR);\n','http://dev.mysql.com/doc/refman/5.0/en/cast-functions.html'),
 (217,'ADDDATE',29,'Syntax:\nADDDATE(date,INTERVAL expr unit), ADDDATE(expr,days)\n\nWhen invoked with the INTERVAL form of the second argument, ADDDATE()\nis a synonym for DATE_ADD(). The related function SUBDATE() is a\nsynonym for DATE_SUB(). For information on the INTERVAL unit argument,\nsee the discussion for DATE_ADD().\n\nmysql> SELECT DATE_ADD(\'2008-01-02\', INTERVAL 31 DAY);\n        -> \'2008-02-02\'\nmysql> SELECT ADDDATE(\'2008-01-02\', INTERVAL 31 DAY);\n        -> \'2008-02-02\'\n\nWhen invoked with the days form of the second argument, MySQL treats it\nas an integer number of days to be added to expr.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT ADDDATE(\'2008-01-02\', 31);\n        -> \'2008-02-02\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (218,'REPEAT LOOP',21,'Syntax:\n[begin_label:] REPEAT\n    statement_list\nUNTIL search_condition\nEND REPEAT [end_label]\n\nThe statement list within a REPEAT statement is repeated until the\nsearch_condition is true. Thus, a REPEAT always enters the loop at\nleast once. statement_list consists of one or more statements, each\nterminated by a semicolon (;) statement delimiter.\n\nA REPEAT statement can be labeled. end_label cannot be given unless\nbegin_label also is present. If both are present, they must be the\nsame.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/repeat-statement.html\n\n','mysql> delimiter //\n\nmysql> CREATE PROCEDURE dorepeat(p1 INT)\n    -> BEGIN\n    ->   SET @x = 0;\n    ->   REPEAT SET @x = @x + 1; UNTIL @x > p1 END REPEAT;\n    -> END\n    -> //\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> CALL dorepeat(1000)//\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT @x//\n+------+\n| @x   |\n+------+\n| 1001 |\n+------+\n1 row in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/repeat-statement.html'),
 (219,'ALTER FUNCTION',36,'Syntax:\nALTER FUNCTION func_name [characteristic ...]\n\ncharacteristic:\n    { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }\n  | SQL SECURITY { DEFINER | INVOKER }\n  | COMMENT \'string\'\n\nThis statement can be used to change the characteristics of a stored\nfunction. More than one change may be specified in an ALTER FUNCTION\nstatement. However, you cannot change the parameters or body of a\nstored function using this statement; to make such changes, you must\ndrop and re-create the function using DROP FUNCTION and CREATE\nFUNCTION.\n\nAs of MySQL 5.0.3, you must have the ALTER ROUTINE privilege for the\nfunction. (That privilege is granted automatically to the function\ncreator.) If binary logging is enabled, the ALTER FUNCTION statement\nmight also require the SUPER privilege, as described in\nhttp://dev.mysql.com/doc/refman/5.0/en/stored-programs-logging.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/alter-function.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/alter-function.html');
INSERT INTO `mysql`.`help_topic` VALUES  (220,'SMALLINT',19,'SMALLINT[(M)] [UNSIGNED] [ZEROFILL]\n\nA small integer. The signed range is -32768 to 32767. The unsigned\nrange is 0 to 65535.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (221,'DOUBLE PRECISION',19,'DOUBLE PRECISION[(M,D)] [UNSIGNED] [ZEROFILL], REAL[(M,D)] [UNSIGNED]\n[ZEROFILL]\n\nThese types are synonyms for DOUBLE. Exception: If the REAL_AS_FLOAT\nSQL mode is enabled, REAL is a synonym for FLOAT rather than DOUBLE.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (222,'ORD',34,'Syntax:\nORD(str)\n\nIf the leftmost character of the string str is a multi-byte character,\nreturns the code for that character, calculated from the numeric values\nof its constituent bytes using this formula:\n\n  (1st byte code)\n+ (2nd byte code x 256)\n+ (3rd byte code x 2562) ...\n\nIf the leftmost character is not a multi-byte character, ORD() returns\nthe same value as the ASCII() function.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT ORD(\'2\');\n        -> 50\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (223,'DEALLOCATE PREPARE',25,'Syntax:\n{DEALLOCATE | DROP} PREPARE stmt_name\n\nTo deallocate a prepared statement, use the DEALLOCATE PREPARE\nstatement. Attempting to execute a prepared statement after\ndeallocating it results in an error.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/sql-syntax-prepared-statements.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/sql-syntax-prepared-statements.html');
INSERT INTO `mysql`.`help_topic` VALUES  (224,'ENVELOPE',33,'Envelope(g)\n\nReturns the Minimum Bounding Rectangle (MBR) for the geometry value g.\nThe result is returned as a Polygon value.\n\nThe polygon is defined by the corner points of the bounding box:\n\nPOLYGON((MINX MINY, MAXX MINY, MAXX MAXY, MINX MAXY, MINX MINY))\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions\n\n','mysql> SELECT AsText(Envelope(GeomFromText(\'LineString(1 1,2 2)\')));\n+-------------------------------------------------------+\n| AsText(Envelope(GeomFromText(\'LineString(1 1,2 2)\'))) |\n+-------------------------------------------------------+\n| POLYGON((1 1,2 1,2 2,1 2,1 1))                        |\n+-------------------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions'),
 (225,'IS_FREE_LOCK',13,'Syntax:\nIS_FREE_LOCK(str)\n\nChecks whether the lock named str is free to use (that is, not locked).\nReturns 1 if the lock is free (no one is using the lock), 0 if the lock\nis in use, and NULL if an error occurs (such as an incorrect argument).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (226,'TOUCHES',28,'Touches(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 spatially touches g2. Two\ngeometries spatially touch if the interiors of the geometries do not\nintersect, but the boundary of one of the geometries intersects either\nthe boundary or the interior of the other.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html');
INSERT INTO `mysql`.`help_topic` VALUES  (227,'INET_ATON',13,'Syntax:\nINET_ATON(expr)\n\nGiven the dotted-quad representation of a network address as a string,\nreturns an integer that represents the numeric value of the address.\nAddresses may be 4- or 8-byte addresses.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','mysql> SELECT INET_ATON(\'209.207.224.40\');\n        -> 3520061480\n','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (228,'UNCOMPRESS',10,'Syntax:\nUNCOMPRESS(string_to_uncompress)\n\nUncompresses a string compressed by the COMPRESS() function. If the\nargument is not a compressed value, the result is NULL. This function\nrequires MySQL to have been compiled with a compression library such as\nzlib. Otherwise, the return value is always NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','mysql> SELECT UNCOMPRESS(COMPRESS(\'any string\'));\n        -> \'any string\'\nmysql> SELECT UNCOMPRESS(\'any string\');\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (229,'AUTO_INCREMENT',19,'The AUTO_INCREMENT attribute can be used to generate a unique identity\nfor new rows:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/example-auto-increment.html\n\n','CREATE TABLE animals (\n     id MEDIUMINT NOT NULL AUTO_INCREMENT,\n     name CHAR(30) NOT NULL,\n     PRIMARY KEY (id)\n );\n\nINSERT INTO animals (name) VALUES \n    (\'dog\'),(\'cat\'),(\'penguin\'),\n    (\'lax\'),(\'whale\'),(\'ostrich\');\n\nSELECT * FROM animals;\n','http://dev.mysql.com/doc/refman/5.0/en/example-auto-increment.html');
INSERT INTO `mysql`.`help_topic` VALUES  (230,'ISSIMPLE',33,'IsSimple(g)\n\nCurrently, this function is a placeholder and should not be used. If\nimplemented, its behavior will be as described in the next paragraph.\n\nReturns 1 if the geometry value g has no anomalous geometric points,\nsuch as self-intersection or self-tangency. IsSimple() returns 0 if the\nargument is not simple, and -1 if it is NULL.\n\nThe description of each instantiable geometric class given earlier in\nthe chapter includes the specific conditions that cause an instance of\nthat class to be classified as not simple. (See [HELP Geometry\nhierarchy].)\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions'),
 (231,'- BINARY',4,'Syntax:\n-\n\nSubtraction:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html\n\n','mysql> SELECT 3-5;\n        -> -2\n','http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html'),
 (232,'GEOMCOLLFROMTEXT',3,'GeomCollFromText(wkt[,srid]), GeometryCollectionFromText(wkt[,srid])\n\nConstructs a GEOMETRYCOLLECTION value using its WKT representation and\nSRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (233,'WKT DEFINITION',3,'The Well-Known Text (WKT) representation of Geometry is designed to\nexchange geometry data in ASCII form.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/gis-wkt-format.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/gis-wkt-format.html'),
 (234,'CURRENT_TIME',29,'Syntax:\nCURRENT_TIME, CURRENT_TIME()\n\nCURRENT_TIME and CURRENT_TIME() are synonyms for CURTIME().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (235,'REVOKE',8,'Syntax:\nREVOKE\n    priv_type [(column_list)]\n      [, priv_type [(column_list)]] ...\n    ON [object_type]\n        {\n            *\n          | *.*\n          | db_name.*\n          | db_name.tbl_name\n          | tbl_name\n          | db_name.routine_name\n\n        }\n    FROM user [, user] ...\n\nREVOKE ALL PRIVILEGES, GRANT OPTION FROM user [, user] ...\n\nThe REVOKE statement enables system administrators to revoke privileges\nfrom MySQL accounts. Each account is named using the same format as for\nthe GRANT statement; for example, \'jeffrey\'@\'localhost\'. If you specify\nonly the username part of the account name, a hostname part of \'%\' is\nused. For additional information about specifying account names, see\n[HELP GRANT].\n\nTo use the first REVOKE syntax, you must have the GRANT OPTION\nprivilege, and you must have the privileges that you are revoking.\n\nFor details on the levels at which privileges exist, the allowable\npriv_type values, and the syntax for specifying users and passwords,\nsee [HELP GRANT]\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/revoke.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/revoke.html'),
 (236,'LAST_INSERT_ID',14,'Syntax:\nLAST_INSERT_ID(), LAST_INSERT_ID(expr)\n\nLAST_INSERT_ID() (with no argument) returns the first automatically\ngenerated value that was set for an AUTO_INCREMENT column by the most\nrecently executed INSERT statement to affect such a column. For\nexample, after inserting a row that generates an AUTO_INCREMENT value,\nyou can get the value like this:\n\nmysql> SELECT LAST_INSERT_ID();\n        -> 195\n\nif a table contains an AUTO_INCREMENT column and INSERT ... ON\nDUPLICATE KEY UPDATE updates (rather than inserts) a row, the value of\nLAST_INSERT_ID() is not meaningful. For a workaround, see\nhttp://dev.mysql.com/doc/refman/5.0/en/insert-on-duplicate.html.\n\nThe currently executing statement does not affect the value of\nLAST_INSERT_ID(). Suppose that you generate an AUTO_INCREMENT value\nwith one statement, and then refer to LAST_INSERT_ID() in a\nmultiple-row INSERT statement that inserts rows into a table with its\nown AUTO_INCREMENT column. The value of LAST_INSERT_ID() will remain\nstable in the second statement; its value for the second and later rows\nis not affected by the earlier row insertions. (However, if you mix\nreferences to LAST_INSERT_ID() and LAST_INSERT_ID(expr), the effect is\nundefined.)\n\nIf the previous statement returned an error, the value of\nLAST_INSERT_ID() is undefined. For transactional tables, if the\nstatement is rolled back due to an error, the value of LAST_INSERT_ID()\nis left undefined. For manual ROLLBACK, the value of LAST_INSERT_ID()\nis not restored to that before the transaction; it remains as it was at\nthe point of the ROLLBACK.\n\nWithin the body of a stored routine (procedure or function) or a\ntrigger, the value of LAST_INSERT_ID() changes the same way as for\nstatements executed outside the body of these kinds of objects. The\neffect of a stored routine or trigger upon the value of\nLAST_INSERT_ID() that is seen by following statements depends on the\nkind of routine:\n\no If a stored procedure executes statements that change the value of\n  LAST_INSERT_ID(), the changed value will be seen by statements that\n  follow the procedure call.\n\no For stored functions and triggers that change the value, the value is\n  restored when the function or trigger ends, so following statements\n  will not see a changed value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (237,'LAST_DAY',29,'Syntax:\nLAST_DAY(date)\n\nTakes a date or datetime value and returns the corresponding value for\nthe last day of the month. Returns NULL if the argument is invalid.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT LAST_DAY(\'2003-02-05\');\n        -> \'2003-02-28\'\nmysql> SELECT LAST_DAY(\'2004-02-05\');\n        -> \'2004-02-29\'\nmysql> SELECT LAST_DAY(\'2004-01-01 01:01:01\');\n        -> \'2004-01-31\'\nmysql> SELECT LAST_DAY(\'2003-03-32\');\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (238,'MEDIUMINT',19,'MEDIUMINT[(M)] [UNSIGNED] [ZEROFILL]\n\nA medium-sized integer. The signed range is -8388608 to 8388607. The\nunsigned range is 0 to 16777215.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (239,'FLOOR',4,'Syntax:\nFLOOR(X)\n\nReturns the largest integer value not greater than X.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT FLOOR(1.23);\n        -> 1\nmysql> SELECT FLOOR(-1.23);\n        -> -2\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (240,'RTRIM',34,'Syntax:\nRTRIM(str)\n\nReturns the string str with trailing space characters removed.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT RTRIM(\'barbar   \');\n        -> \'barbar\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (241,'EXPLAIN',26,'Syntax:\nEXPLAIN tbl_name\n\nOr:\n\nEXPLAIN [EXTENDED] SELECT select_options\n\nThe EXPLAIN statement can be used either as a synonym for DESCRIBE or\nas a way to obtain information about how MySQL executes a SELECT\nstatement:\n\no EXPLAIN tbl_name is synonymous with DESCRIBE tbl_name or SHOW COLUMNS\n  FROM tbl_name.\n\n  For a description of the DESCRIBE and SHOW COLUMNS statements, see\n  [HELP DESCRIBE], and [HELP SHOW COLUMNS].\n\no When you precede a SELECT statement with the keyword EXPLAIN, MySQL\n  displays information from the optimizer about the query execution\n  plan. That is, MySQL explains how it would process the SELECT,\n  including information about how tables are joined and in which order.\n\n  For information regarding the use of EXPLAIN for obtaining query\n  execution plan information, see\n  http://dev.mysql.com/doc/refman/5.0/en/using-explain.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/explain.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/explain.html'),
 (242,'DEGREES',4,'Syntax:\nDEGREES(X)\n\nReturns the argument X, converted from radians to degrees.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT DEGREES(PI());\n        -> 180\nmysql> SELECT DEGREES(PI() / 2);\n        -> 90\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (243,'VARCHAR',19,'[NATIONAL] VARCHAR(M) [CHARACTER SET charset_name] [COLLATE\ncollation_name]\n\nA variable-length string. M represents the maximum column length in\ncharacters. In MySQL 5.0, the range of M is 0 to 255 before MySQL\n5.0.3, and 0 to 65,535 in MySQL 5.0.3 and later. The effective maximum\nlength of a VARCHAR in MySQL 5.0.3 and later is subject to the maximum\nrow size (65,535 bytes, which is shared among all columns) and the\ncharacter set used. For example, utf8 characters can require up to\nthree bytes per character, so a VARCHAR column that uses the utf8\ncharacter set can be declared to be a maximum of 21,844 characters.\n\nMySQL stores VARCHAR values as a one-byte or two-byte length prefix\nplus data. The length prefix indicates the number of bytes in the\nvalue. A VARCHAR column uses one length byte if values require no more\nthan 255 bytes, two length bytes if values may require more than 255\nbytes.\n\n*Note*: Before 5.0.3, trailing spaces were removed when VARCHAR values\nwere stored, which differs from the standard SQL specification.\n\nPrior to MySQL 5.0.3, a VARCHAR column with a length specification\ngreater than 255 is converted to the smallest TEXT type that can hold\nvalues of the given length. For example, VARCHAR(500) is converted to\nTEXT, and VARCHAR(200000) is converted to MEDIUMTEXT. However, this\nconversion affects trailing-space removal.\n\nVARCHAR is shorthand for CHARACTER VARYING. NATIONAL VARCHAR is the\nstandard SQL way to define that a VARCHAR column should use some\npredefined character set. MySQL 4.1 and up uses utf8 as this predefined\ncharacter set.\nhttp://dev.mysql.com/doc/refman/5.0/en/charset-national.html. NVARCHAR\nis shorthand for NATIONAL VARCHAR.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (244,'UNHEX',34,'Syntax:\n\nUNHEX(str)\n\nPerforms the inverse operation of HEX(str). That is, it interprets each\npair of hexadecimal digits in the argument as a number and converts it\nto the character represented by the number. The resulting characters\nare returned as a binary string.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT UNHEX(\'4D7953514C\');\n        -> \'MySQL\'\nmysql> SELECT 0x4D7953514C;\n        -> \'MySQL\'\nmysql> SELECT UNHEX(HEX(\'string\'));\n        -> \'string\'\nmysql> SELECT HEX(UNHEX(\'1267\'));\n        -> \'1267\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (245,'- UNARY',4,'Syntax:\n-\n\nUnary minus. This operator changes the sign of the argument.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html\n\n','mysql> SELECT - 2;\n        -> -2\n','http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html'),
 (246,'SELECT INTO',21,'Syntax:\nSELECT col_name [, col_name] ...\n    INTO var_name [, var_name] ...\n    table_expr\n\nSELECT ... INTO syntax enables selected columns to be stored directly\ninto variables. The statement must retrieve only a single row. If it is\npossible that the statement may retrieve multiple rows, you can use\nLIMIT 1 to limit the result set to a single row.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/select-into-statement.html\n\n','SELECT id,data INTO x,y FROM test.t1 LIMIT 1;\n','http://dev.mysql.com/doc/refman/5.0/en/select-into-statement.html'),
 (247,'STD',15,'Syntax:\nSTD(expr)\n\nReturns the population standard deviation of expr. This is an extension\nto standard SQL. As of MySQL 5.0.3, the standard SQL function\nSTDDEV_POP() can be used instead.\n\nThis function returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (248,'COS',4,'Syntax:\nCOS(X)\n\nReturns the cosine of X, where X is given in radians.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT COS(PI());\n        -> -1\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (249,'DATE FUNCTION',29,'Syntax:\nDATE(expr)\n\nExtracts the date part of the date or datetime expression expr.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT DATE(\'2003-12-31 01:02:03\');\n        -> \'2003-12-31\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (250,'DROP TRIGGER',36,'Syntax:\nDROP TRIGGER [IF EXISTS] [schema_name.]trigger_name\n\nThis statement drops a trigger. The schema (database) name is optional.\nIf the schema is omitted, the trigger is dropped from the default\nschema. DROP TRIGGER was added in MySQL 5.0.2. Its use requires the\nSUPER privilege.\n\nUse IF EXISTS to prevent an error from occurring for a trigger that\ndoes not exist. A NOTE is generated for a non-existent trigger when\nusing IF EXISTS. See [HELP SHOW WARNINGS]. The IF EXISTS clause was\nadded in MySQL 5.0.32.\n\nTriggers for a table are also dropped if you drop the table.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-trigger.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-trigger.html'),
 (251,'RESET MASTER',25,'Syntax:\nRESET MASTER\n\nDeletes all binary logs listed in the index file, resets the binary log\nindex file to be empty, and creates a new binary log file. It is\nintended to be used only when the master is started for the first time.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/reset-master.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/reset-master.html');
INSERT INTO `mysql`.`help_topic` VALUES  (252,'TAN',4,'Syntax:\nTAN(X)\n\nReturns the tangent of X, where X is given in radians.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT TAN(PI());\n        -> -1.2246063538224e-16\nmysql> SELECT TAN(PI()+1);\n        -> 1.5574077246549\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (253,'PI',4,'Syntax:\nPI()\n\nReturns the value of π (pi). The default number of decimal places\ndisplayed is seven, but MySQL uses the full double-precision value\ninternally.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT PI();\n        -> 3.141593\nmysql> SELECT PI()+0.000000000000000000;\n        -> 3.141592653589793116\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (254,'WEEKOFYEAR',29,'Syntax:\nWEEKOFYEAR(date)\n\nReturns the calendar week of the date as a number in the range from 1\nto 53. WEEKOFYEAR() is a compatibility function that is equivalent to\nWEEK(date,3).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT WEEKOFYEAR(\'2008-02-20\');\n        -> 8\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (255,'/',4,'Syntax:\n/\n\nDivision:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html\n\n','mysql> SELECT 3/5;\n        -> 0.60\n','http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (256,'PURGE BINARY LOGS',25,'Syntax:\nPURGE { BINARY | MASTER } LOGS\n    { TO \'log_name\' | BEFORE datetime_expr }\n\nThe binary log is a set of files that contain information about data\nmodifications made by the MySQL server. The log consists of a set of\nbinary log files, plus an index file.\n\nThe PURGE BINARY LOGS statement deletes all the binary log files listed\nin the log index file prior to the specified log file name or date. The\nlog files also are removed from the list recorded in the index file, so\nthat the given log file becomes the first.\n\nThis statement has no effect if the --log-bin option has not been\nenabled.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/purge-binary-logs.html\n\n','PURGE BINARY LOGS TO \'mysql-bin.010\';\nPURGE BINARY LOGS BEFORE \'2008-04-02 22:46:26\';\n','http://dev.mysql.com/doc/refman/5.0/en/purge-binary-logs.html'),
 (257,'STDDEV_SAMP',15,'Syntax:\nSTDDEV_SAMP(expr)\n\nReturns the sample standard deviation of expr (the square root of\nVAR_SAMP(). This function was added in MySQL 5.0.3.\n\nSTDDEV_SAMP() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (258,'SCHEMA',14,'Syntax:\nSCHEMA()\n\nThis function is a synonym for DATABASE(). It was added in MySQL 5.0.2.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (259,'MLINEFROMWKB',30,'MLineFromWKB(wkb[,srid]), MultiLineStringFromWKB(wkb[,srid])\n\nConstructs a MULTILINESTRING value using its WKB representation and\nSRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions'),
 (260,'LOG2',4,'Syntax:\nLOG2(X)\n\nReturns the base-2 logarithm of X.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT LOG2(65536);\n        -> 16\nmysql> SELECT LOG2(-100);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (261,'SUBTIME',29,'Syntax:\nSUBTIME(expr1,expr2)\n\nSUBTIME() returns expr1 - expr2 expressed as a value in the same format\nas expr1. expr1 is a time or datetime expression, and expr2 is a time\nexpression.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT SUBTIME(\'2007-12-31 23:59:59.999999\',\'1 1:1:1.000002\');\n        -> \'2007-12-30 22:58:58.999997\'\nmysql> SELECT SUBTIME(\'01:00:00.999999\', \'02:00:00.999998\');\n        -> \'-00:59:59.999999\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (262,'UNCOMPRESSED_LENGTH',10,'Syntax:\nUNCOMPRESSED_LENGTH(compressed_string)\n\nReturns the length that the compressed string had before being\ncompressed.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','mysql> SELECT UNCOMPRESSED_LENGTH(COMPRESS(REPEAT(\'a\',30)));\n        -> 30\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (263,'DROP TABLE',36,'Syntax:\nDROP [TEMPORARY] TABLE [IF EXISTS]\n    tbl_name [, tbl_name] ...\n    [RESTRICT | CASCADE]\n\nDROP TABLE removes one or more tables. You must have the DROP privilege\nfor each table. All table data and the table definition are removed, so\nbe careful with this statement! If any of the tables named in the\nargument list do not exist, MySQL returns an error indicating by name\nwhich non-existing tables it was unable to drop, but it also drops all\nof the tables in the list that do exist.\n\n*Important*: When a table is dropped, user privileges on the table are\nnot automatically dropped. See [HELP GRANT].\n\nUse IF EXISTS to prevent an error from occurring for tables that do not\nexist. A NOTE is generated for each non-existent table when using IF\nEXISTS. See [HELP SHOW WARNINGS].\n\nRESTRICT and CASCADE are allowed to make porting easier. In MySQL 5.0,\nthey do nothing.\n\n*Note*: DROP TABLE automatically commits the current active\ntransaction, unless you use the TEMPORARY keyword.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-table.html'),
 (264,'POW',4,'Syntax:\nPOW(X,Y)\n\nReturns the value of X raised to the power of Y.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT POW(2,2);\n        -> 4\nmysql> SELECT POW(2,-2);\n        -> 0.25\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (265,'SHOW CREATE TABLE',25,'Syntax:\nSHOW CREATE TABLE tbl_name\n\nShows the CREATE TABLE statement that creates the given table. As of\nMySQL 5.0.1, this statement also works with views.\nSHOW CREATE TABLE quotes table and column names according to the value\nof the sql_quote_show_create option. See\nhttp://dev.mysql.com/doc/refman/5.0/en/server-session-variables.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-create-table.html\n\n','mysql> SHOW CREATE TABLE t\\G\n*************************** 1. row ***************************\n       Table: t\nCreate Table: CREATE TABLE t (\n  id INT(11) default NULL auto_increment,\n  s char(60) default NULL,\n  PRIMARY KEY (id)\n) ENGINE=MyISAM\n','http://dev.mysql.com/doc/refman/5.0/en/show-create-table.html'),
 (266,'DUAL',25,'You are allowed to specify DUAL as a dummy table name in situations\nwhere no tables are referenced:\n\nmysql> SELECT 1 + 1 FROM DUAL;\n        -> 2\n\nDUAL is purely for the convenience of people who require that all\nSELECT statements should have FROM and possibly other clauses. MySQL\nmay ignore the clauses. MySQL does not require FROM DUAL if no tables\nare referenced.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/select.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/select.html'),
 (267,'INSTR',34,'Syntax:\nINSTR(str,substr)\n\nReturns the position of the first occurrence of substring substr in\nstring str. This is the same as the two-argument form of LOCATE(),\nexcept that the order of the arguments is reversed.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT INSTR(\'foobarbar\', \'bar\');\n        -> 4\nmysql> SELECT INSTR(\'xbar\', \'foobar\');\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (268,'NOW',29,'Syntax:\nNOW()\n\nReturns the current date and time as a value in \'YYYY-MM-DD HH:MM:SS\'\nor YYYYMMDDHHMMSS.uuuuuu format, depending on whether the function is\nused in a string or numeric context. The value is expressed in the\ncurrent time zone.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT NOW();\n        -> \'2007-12-15 23:50:26\'\nmysql> SELECT NOW() + 0;\n        -> 20071215235026.000000\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (269,'SHOW ENGINES',25,'Syntax:\nSHOW [STORAGE] ENGINES\n\nSHOW ENGINES displays status information about the server\'s storage\nengines. This is particularly useful for checking whether a storage\nengine is supported, or to see what the default engine is. SHOW TABLE\nTYPES is a deprecated synonym.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-engines.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-engines.html'),
 (270,'SHOW MUTEX STATUS',25,'Syntax:\nSHOW MUTEX STATUS\n\nSHOW MUTEX STATUS displays InnoDB mutex statistics. From MySQL 5.0.3 to\n5.0.32, the statement displays the following output fields:\n\no Mutex\n\n  The mutex name. The name indicates the mutex purpose. For example,\n  the log_sys mutex is used by the InnoDB logging subsystem and\n  indicates how intensive logging activity is. The buf_pool mutex\n  protects the InnoDB buffer pool.\n\no Module\n\n  The source file where the mutex is implemented.\n\no Count indicates how many times the mutex was requested.\n\no Spin_waits indicates how many times the spinlock had to run.\n\no Spin_rounds indicates the number of spinlock rounds. (spin_rounds\n  divided by spin_waits provides the average round count.)\n\no OS_waits indicates the number of operating system waits. This occurs\n  when the spinlock did not work (the mutex was not locked during the\n  spinlock and it was necessary to yield to the operating system and\n  wait).\n\no OS_yields indicates the number of times that a thread trying to lock\n  a mutex gave up its timeslice and yielded to the operating system (on\n  the presumption that allowing other threads to run will free the\n  mutex so that it can be locked).\n\no OS_waits_time indicates the amount of time (in ms) spent in operating\n  system waits, if the timed_mutexes system variable is 1 (ON). If\n  timed_mutexes is 0 (OFF), timing is disabled, so OS_waits_time is 0.\n  timed_mutexes is off by default.\n\nFrom MySQL 5.0.33 on, the statement uses the same output format as that\njust described, but only if UNIV_DEBUG was defined at MySQL compilation\ntime (for example, in include/univ.h in the InnoDB part of the MySQL\nsource tree). If UNIV_DEBUG was not defined, the statement displays the\nfollowing fields. In the latter case (without UNIV_DEBUG), the\ninformation on which the statement output is based is insufficient to\ndistinguish regular mutexes and mutexes that protect rw-locks (which\nallow multiple readers or a single writer). Consequently, the output\nmay appear to contain multiple rows for the same mutex.\n\no File\n\n  The source file where the mutex is implemented.\n\no Line\n\n  The line number in the source file where the mutex is created. This\n  may change depending on your version of MySQL.\n\no OS_waits\n\n  Same as OS_waits_time.\n\nInformation from this statement can be used to diagnose system\nproblems. For example, large values of spin_waits and spin_rounds may\nindicate scalability problems.\n\nSHOW MUTEX STATUS was added in MySQL 5.0.3. In MySQL 5.1, SHOW MUTEX\nSTATUS is renamed to SHOW ENGINE INNODB MUTEX. The latter statement\ndisplays similar information but in a somewhat different output format.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-mutex-status.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-mutex-status.html');
INSERT INTO `mysql`.`help_topic` VALUES  (271,'>=',16,'Syntax:\n>=\n\nGreater than or equal:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 2 >= 2;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (272,'EXP',4,'Syntax:\nEXP(X)\n\nReturns the value of e (the base of natural logarithms) raised to the\npower of X. The inverse of this function is LOG() (using a single\nargumentonly) or LN().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT EXP(2);\n        -> 7.3890560989307\nmysql> SELECT EXP(-2);\n        -> 0.13533528323661\nmysql> SELECT EXP(0);\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (273,'LONGBLOB',19,'LONGBLOB\n\nA BLOB column with a maximum length of 4,294,967,295 or 4GB (232 - 1)\nbytes. The effective maximum length of LONGBLOB columns depends on the\nconfigured maximum packet size in the client/server protocol and\navailable memory. Each LONGBLOB value is stored using a four-byte\nlength prefix that indicates the number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (274,'POINTN',11,'PointN(ls,N)\n\nReturns the N-th Point in the Linestring value ls. Points are numbered\nbeginning with 1.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT AsText(PointN(GeomFromText(@ls),2));\n+-------------------------------------+\n| AsText(PointN(GeomFromText(@ls),2)) |\n+-------------------------------------+\n| POINT(2 2)                          |\n+-------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (275,'YEAR DATA TYPE',19,'YEAR[(2|4)]\n\nA year in two-digit or four-digit format. The default is four-digit\nformat. In four-digit format, the allowable values are 1901 to 2155,\nand 0000. In two-digit format, the allowable values are 70 to 69,\nrepresenting years from 1970 to 2069. MySQL displays YEAR values in\nYYYY format, but allows you to assign values to YEAR columns using\neither strings or numbers.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html'),
 (276,'SUM',15,'Syntax:\nSUM([DISTINCT] expr)\n\nReturns the sum of expr. If the return set has no rows, SUM() returns\nNULL. The DISTINCT keyword can be used in MySQL 5.0 to sum only the\ndistinct values of expr.\n\nSUM() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (277,'OCT',34,'Syntax:\nOCT(N)\n\nReturns a string representation of the octal value of N, where N is a\nlonglong (BIGINT) number. This is equivalent to CONV(N,10,8). Returns\nNULL if N is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT OCT(12);\n        -> \'14\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (278,'SYSDATE',29,'Syntax:\nSYSDATE()\n\nReturns the current date and time as a value in \'YYYY-MM-DD HH:MM:SS\'\nor YYYYMMDDHHMMSS.uuuuuu format, depending on whether the function is\nused in a string or numeric context.\n\nAs of MySQL 5.0.13, SYSDATE() returns the time at which it executes.\nThis differs from the behavior for NOW(), which returns a constant time\nthat indicates the time at which the statement began to execute.\n(Within a stored routine or trigger, NOW() returns the time at which\nthe routine or triggering statement began to execute.)\n\nmysql> SELECT NOW(), SLEEP(2), NOW();\n+---------------------+----------+---------------------+\n| NOW()               | SLEEP(2) | NOW()               |\n+---------------------+----------+---------------------+\n| 2006-04-12 13:47:36 |        0 | 2006-04-12 13:47:36 |\n+---------------------+----------+---------------------+\n\nmysql> SELECT SYSDATE(), SLEEP(2), SYSDATE();\n+---------------------+----------+---------------------+\n| SYSDATE()           | SLEEP(2) | SYSDATE()           |\n+---------------------+----------+---------------------+\n| 2006-04-12 13:47:44 |        0 | 2006-04-12 13:47:46 |\n+---------------------+----------+---------------------+\n\nIn addition, the SET TIMESTAMP statement affects the value returned by\nNOW() but not by SYSDATE(). This means that timestamp settings in the\nbinary log have no effect on invocations of SYSDATE().\n\nBecause SYSDATE() can return different values even within the same\nstatement, and is not affected by SET TIMESTAMP, it is\nnon-deterministic and therefore unsafe for replication. If that is a\nproblem, you can start the server with the --sysdate-is-now option to\ncause SYSDATE() to be an alias for NOW(). The non-deterministic nature\nof SYSDATE() also means that indexes cannot be used for evaluating\nexpressions that refer to it.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (279,'ASBINARY',30,'AsBinary(g), AsWKB(g)\n\nConverts a value in internal geometry format to its WKB representation\nand returns the binary result.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-to-convert-geometries-between-formats.html\n\n','SELECT AsBinary(g) FROM geom;\n','http://dev.mysql.com/doc/refman/5.0/en/functions-to-convert-geometries-between-formats.html');
INSERT INTO `mysql`.`help_topic` VALUES  (280,'REPEAT FUNCTION',34,'Syntax:\nREPEAT(str,count)\n\nReturns a string consisting of the string str repeated count times. If\ncount is less than 1, returns an empty string. Returns NULL if str or\ncount are NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT REPEAT(\'MySQL\', 3);\n        -> \'MySQLMySQLMySQL\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (281,'SHOW TABLES',25,'Syntax:\nSHOW [FULL] TABLES [FROM db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW TABLES lists the non-TEMPORARY tables in a given database. You can\nalso get this list using the mysqlshow db_name command. The LIKE\nclause, if present, indicates which table names to match. The WHERE\nclause can be given to select rows using more general conditions, as\ndiscussed in http://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nBefore MySQL 5.0.1, the output from SHOW TABLES contains a single\ncolumn of table names. Beginning with MySQL 5.0.1, this statement also\nlists any views in the database. As of MySQL 5.0.2, the FULL modifier\nis supported such that SHOW FULL TABLES displays a second output\ncolumn. Values for the second column are BASE TABLE for a table and\nVIEW for a view.\n\nIf you have no privileges for a base table or view, it does not show up\nin the output from SHOW TABLES or mysqlshow db_name.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-tables.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-tables.html'),
 (282,'MAKEDATE',29,'Syntax:\nMAKEDATE(year,dayofyear)\n\nReturns a date, given year and day-of-year values. dayofyear must be\ngreater than 0 or the result is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT MAKEDATE(2011,31), MAKEDATE(2011,32);\n        -> \'2011-01-31\', \'2011-02-01\'\nmysql> SELECT MAKEDATE(2011,365), MAKEDATE(2014,365);\n        -> \'2011-12-31\', \'2014-12-31\'\nmysql> SELECT MAKEDATE(2011,0);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (283,'BINARY OPERATOR',34,'Syntax:\nBINARY\n\nThe BINARY operator casts the string following it to a binary string.\nThis is an easy way to force a column comparison to be done byte by\nbyte rather than character by character. This causes the comparison to\nbe case sensitive even if the column isn\'t defined as BINARY or BLOB.\nBINARY also causes trailing spaces to be significant.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/cast-functions.html\n\n','mysql> SELECT \'a\' = \'A\';\n        -> 1\nmysql> SELECT BINARY \'a\' = \'A\';\n        -> 0\nmysql> SELECT \'a\' = \'a \';\n        -> 1\nmysql> SELECT BINARY \'a\' = \'a \';\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/cast-functions.html'),
 (284,'MBROVERLAPS',5,'MBROverlaps(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 overlap. The term spatially overlaps is\nused if two geometries intersect and their intersection results in a\ngeometry of the same dimension but not equal to either of the given\ngeometries.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html'),
 (285,'SOUNDEX',34,'Syntax:\nSOUNDEX(str)\n\nReturns a soundex string from str. Two strings that sound almost the\nsame should have identical soundex strings. A standard soundex string\nis four characters long, but the SOUNDEX() function returns an\narbitrarily long string. You can use SUBSTRING() on the result to get a\nstandard soundex string. All non-alphabetic characters in str are\nignored. All international alphabetic characters outside the A-Z range\nare treated as vowels.\n\n*Important*: When using SOUNDEX(), you should be aware of the following\nlimitations:\n\no This function, as currently implemented, is intended to work well\n  with strings that are in the English language only. Strings in other\n  languages may not produce reliable results.\n\no This function is not guaranteed to provide consistent results with\n  strings that use multi-byte character sets, including utf-8.\n\n  We hope to remove these limitations in a future release. See\n  Bug#22638 (http://bugs.mysql.com/22638) for more information.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT SOUNDEX(\'Hello\');\n        -> \'H400\'\nmysql> SELECT SOUNDEX(\'Quadratically\');\n        -> \'Q36324\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (286,'MBRTOUCHES',5,'MBRTouches(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 touch. Two geometries spatially touch if\nthe interiors of the geometries do not intersect, but the boundary of\none of the geometries intersects either the boundary or the interior of\nthe other.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html'),
 (287,'INSERT SELECT',25,'Syntax:\nINSERT [LOW_PRIORITY | HIGH_PRIORITY] [IGNORE]\n    [INTO] tbl_name [(col_name,...)]\n    SELECT ...\n    [ ON DUPLICATE KEY UPDATE col_name=expr, ... ]\n\nWith INSERT ... SELECT, you can quickly insert many rows into a table\nfrom one or many tables. For example:\n\nINSERT INTO tbl_temp2 (fld_id)\n  SELECT tbl_temp1.fld_order_id\n  FROM tbl_temp1 WHERE tbl_temp1.fld_order_id > 100;\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/insert-select.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/insert-select.html'),
 (288,'CREATE PROCEDURE',36,'Syntax:\nCREATE\n    [DEFINER = { user | CURRENT_USER }]\n    PROCEDURE sp_name ([proc_parameter[,...]])\n    [characteristic ...] routine_body\n\nCREATE\n    [DEFINER = { user | CURRENT_USER }]\n    FUNCTION sp_name ([func_parameter[,...]])\n    RETURNS type\n    [characteristic ...] routine_body\n    \nproc_parameter:\n    [ IN | OUT | INOUT ] param_name type\n    \nfunc_parameter:\n    param_name type\n\ntype:\n    Any valid MySQL data type\n\ncharacteristic:\n    LANGUAGE SQL\n  | [NOT] DETERMINISTIC\n  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }\n  | SQL SECURITY { DEFINER | INVOKER }\n  | COMMENT \'string\'\n\nroutine_body:\n    Valid SQL procedure statement\n\nThese statements create stored routines. By default, a routine is\nassociated with the default database. To associate the routine\nexplicitly with a given database, specify the name as db_name.sp_name\nwhen you create it.\n\nThe CREATE FUNCTION statement is also used in MySQL to support UDFs\n(user-defined functions). See\nhttp://dev.mysql.com/doc/refman/5.0/en/adding-functions.html. A UDF can\nbe regarded as an external stored function. However, do note that\nstored functions share their namespace with UDFs. See\nhttp://dev.mysql.com/doc/refman/5.0/en/function-resolution.html, for\nthe rules describing how the server interprets references to different\nkinds of functions.\n\nWhen the routine is invoked, an implicit USE db_name is performed (and\nundone when the routine terminates). The causes the routine to have the\ngiven default database while it executes. USE statements within stored\nroutines are disallowed.\n\nWhen a stored function has been created, you invoke it by referring to\nit in an expression. The function returns a value during expression\nevaluation. When a stored procedure has been created, you invoke it by\nusing the CALL statement (see [HELP CALL]).\n\nAs of MySQL 5.0.3, to execute the CREATE PROCEDURE or CREATE FUNCTION\nstatement, it is necessary to have the CREATE ROUTINE privilege. By\ndefault, MySQL automatically grants the ALTER ROUTINE and EXECUTE\nprivileges to the routine creator. See also\nhttp://dev.mysql.com/doc/refman/5.0/en/stored-routines-privileges.html.\nIf binary logging is enabled, the CREATE FUNCTION statement might also\nrequire the SUPER privilege, as described in\nhttp://dev.mysql.com/doc/refman/5.0/en/stored-programs-logging.html.\n\nThe DEFINER and SQL SECURITY clauses specify the security context to be\nused when checking access privileges at routine execution time, as\ndescribed later.\n\nIf the routine name is the same as the name of a built-in SQL function,\nyou must use a space between the name and the following parenthesis\nwhen defining the routine, or a syntax error occurs. This is also true\nwhen you invoke the routine later. For this reason, we suggest that it\nis better to avoid re-using the names of existing SQL functions for\nyour own stored routines.\n\nThe IGNORE_SPACE SQL mode applies to built-in functions, not to stored\nroutines. It is always allowable to have spaces after a routine name,\nregardless of whether IGNORE_SPACE is enabled.\n\nThe parameter list enclosed within parentheses must always be present.\nIf there are no parameters, an empty parameter list of () should be\nused. Parameter names are not case sensitive.\n\nEach parameter can be declared to use any valid data type, except that\nthe COLLATE attribute cannot be used.\n\nEach parameter is an IN parameter by default. To specify otherwise for\na parameter, use the keyword OUT or INOUT before the parameter name.\n\n*Note*: Specifying a parameter as IN, OUT, or INOUT is valid only for a\nPROCEDURE. (FUNCTION parameters are always regarded as IN parameters.)\n\nAn IN parameter passes a value into a procedure. The procedure might\nmodify the value, but the modification is not visible to the caller\nwhen the procedure returns. An OUT parameter passes a value from the\nprocedure back to the caller. Its initial value is NULL within the\nprocedure, and its value is visible to the caller when the procedure\nreturns. An INOUT parameter is initialized by the caller, can be\nmodified by the procedure, and any change made by the procedure is\nvisible to the caller when the procedure returns.\n\nFor each OUT or INOUT parameter, pass a user-defined variable so that\nyou can obtain its value when the procedure returns. (For an example,\nsee [HELP CALL].) If you are calling the procedure from within another\nstored procedure or function, you can also pass a routine parameter or\nlocal routine variable as an IN or INOUT parameter.\n\nThe RETURNS clause may be specified only for a FUNCTION, for which it\nis mandatory. It indicates the return type of the function, and the\nfunction body must contain a RETURN value statement. If the RETURN\nstatement returns a value of a different type, the value is coerced to\nthe proper type. For example, if a function specifies an ENUM or SET\nvalue in the RETURNS clause, but the RETURN statement returns an\ninteger, the value returned from the function is the string for the\ncorresponding ENUM member of set of SET members.\n\nThe routine_body consists of a valid SQL procedure statement. This can\nbe a simple statement such as SELECT or INSERT, or it can be a compound\nstatement written using BEGIN and END. Compound statements can contain\ndeclarations, loops, and other control structure statements. The syntax\nfor these statements is described in\nhttp://dev.mysql.com/doc/refman/5.0/en/sql-syntax-compound-statements.h\ntml.\n\nSome statements are not allowed in stored routines; see\nhttp://dev.mysql.com/doc/refman/5.0/en/stored-program-restrictions.html\n.\n\nMySQL stores the sql_mode system variable setting that is in effect at\nthe time a routine is created, and always executes the routine with\nthis setting in force, regardless of the current server SQL mode.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-procedure.html\n\n','mysql> delimiter //\n\nmysql> CREATE PROCEDURE simpleproc (OUT param1 INT)\n    -> BEGIN\n    ->   SELECT COUNT(*) INTO param1 FROM t;\n    -> END;\n    -> //\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> delimiter ;\n\nmysql> CALL simpleproc(@a);\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT @a;\n+------+\n| @a   |\n+------+\n| 3    |\n+------+\n1 row in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/create-procedure.html');
INSERT INTO `mysql`.`help_topic` VALUES  (289,'VARBINARY',19,'VARBINARY(M)\n\nThe VARBINARY type is similar to the VARCHAR type, but stores binary\nbyte strings rather than non-binary character strings. M represents the\nmaximum column length in bytes.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (290,'LOAD INDEX',25,'Syntax:\nLOAD INDEX INTO CACHE\n  tbl_index_list [, tbl_index_list] ...\n\ntbl_index_list:\n  tbl_name\n    [[INDEX|KEY] (index_name[, index_name] ...)]\n    [IGNORE LEAVES]\n\nThe LOAD INDEX INTO CACHE statement preloads a table index into the key\ncache to which it has been assigned by an explicit CACHE INDEX\nstatement, or into the default key cache otherwise. LOAD INDEX INTO\nCACHE is used only for MyISAM tables.\n\nThe IGNORE LEAVES modifier causes only blocks for the non-leaf nodes of\nthe index to be preloaded.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/load-index.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/load-index.html'),
 (291,'UNION',25,'Syntax:\nSELECT ...\nUNION [ALL | DISTINCT] SELECT ...\n[UNION [ALL | DISTINCT] SELECT ...]\n\nUNION is used to combine the result from multiple SELECT statements\ninto a single result set.\n\nThe column names from the first SELECT statement are used as the column\nnames for the results returned. Selected columns listed in\ncorresponding positions of each SELECT statement should have the same\ndata type. (For example, the first column selected by the first\nstatement should have the same type as the first column selected by the\nother statements.)\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/union.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/union.html');
INSERT INTO `mysql`.`help_topic` VALUES  (292,'TO_DAYS',29,'Syntax:\nTO_DAYS(date)\n\nGiven a date date, returns a day number (the number of days since year\n0).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT TO_DAYS(950501);\n        -> 728779\nmysql> SELECT TO_DAYS(\'2007-10-07\');\n        -> 733321\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (293,'NOT REGEXP',34,'Syntax:\nexpr NOT REGEXP pat, expr NOT RLIKE pat\n\nThis is the same as NOT (expr REGEXP pat).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/regexp.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/regexp.html'),
 (294,'SHOW INDEX',25,'Syntax:\nSHOW INDEX FROM tbl_name [FROM db_name]\n\nSHOW INDEX returns table index information. The format resembles that\nof the SQLStatistics call in ODBC.\nThe LIKE clause, if present, indicates which event names to match. The\nWHERE clause can be given to select rows using more general conditions,\nas discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nYou can use db_name.tbl_name as an alternative to the tbl_name FROM\ndb_name syntax. These two statements are equivalent:\n\nSHOW INDEX FROM mytable FROM mydb;\nSHOW INDEX FROM mydb.mytable;\n\nSHOW KEYS is a synonym for SHOW INDEX. You can also list a table\'s\nindexes with the mysqlshow -k db_name tbl_name command.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-index.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-index.html'),
 (295,'SHOW CREATE DATABASE',25,'Syntax:\nSHOW CREATE {DATABASE | SCHEMA} db_name\n\nShows the CREATE DATABASE statement that creates the given database.\nSHOW CREATE SCHEMA is a synonym for SHOW CREATE DATABASE as of MySQL\n5.0.2.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-create-database.html\n\n','mysql> SHOW CREATE DATABASE test\\G\n*************************** 1. row ***************************\n       Database: test\nCreate Database: CREATE DATABASE `test`\n                 /*!40100 DEFAULT CHARACTER SET latin1 */\n\nmysql> SHOW CREATE SCHEMA test\\G\n*************************** 1. row ***************************\n       Database: test\nCreate Database: CREATE DATABASE `test`\n                 /*!40100 DEFAULT CHARACTER SET latin1 */\n','http://dev.mysql.com/doc/refman/5.0/en/show-create-database.html');
INSERT INTO `mysql`.`help_topic` VALUES  (296,'LEAVE',21,'Syntax:\nLEAVE label\n\nThis statement is used to exit the flow control construct that has the\ngiven label. It can be used within BEGIN ... END or loop constructs\n(LOOP, REPEAT, WHILE).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/leave-statement.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/leave-statement.html'),
 (297,'NOT IN',16,'Syntax:\nexpr NOT IN (value,...)\n\nThis is the same as NOT (expr IN (value,...)).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (298,'!',12,'Syntax:\nNOT, !\n\nLogical NOT. Evaluates to 1 if the operand is 0, to 0 if the operand is\nnon-zero, and NOT NULL returns NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/logical-operators.html\n\n','mysql> SELECT NOT 10;\n        -> 0\nmysql> SELECT NOT 0;\n        -> 1\nmysql> SELECT NOT NULL;\n        -> NULL\nmysql> SELECT ! (1+1);\n        -> 0\nmysql> SELECT ! 1+1;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/logical-operators.html'),
 (299,'DECLARE HANDLER',21,'Syntax:\nDECLARE handler_type HANDLER\n    FOR condition_value [, condition_value] ...\n    statement\n\nhandler_type:\n    CONTINUE\n  | EXIT\n  | UNDO\n\ncondition_value:\n    SQLSTATE [VALUE] sqlstate_value\n  | condition_name\n  | SQLWARNING\n  | NOT FOUND\n  | SQLEXCEPTION\n  | mysql_error_code\n\nThe DECLARE ... HANDLER statement specifies handlers that each may deal\nwith one or more conditions. If one of these conditions occurs, the\nspecified statement is executed. statement can be a simple statement\n(for example, SET var_name = value), or it can be a compound statement\nwritten using BEGIN and END (see [HELP BEGIN END]).\n\nFor a CONTINUE handler, execution of the current program continues\nafter execution of the handler statement. For an EXIT handler,\nexecution terminates for the BEGIN ... END compound statement in which\nthe handler is declared. (This is true even if the condition occurs in\nan inner block.) The UNDO handler type statement is not supported.\n\nIf a condition occurs for which no handler has been declared, the\ndefault action is EXIT.\n\nA condition_value for DECLARE ... HANDLER can be any of the following\nvalues:\n\no An SQLSTATE value (a 5-character string literal) or a MySQL error\n  code (a number). You should not use SQLSTATE value \'00000\' or MySQL\n  error code 0, because those indicate sucess rather than an error\n  condition. For a list of SQLSTATE values and MySQL error codes, see\n  http://dev.mysql.com/doc/refman/5.0/en/error-messages-server.html.\n\no A condition name previously specified with DECLARE ... CONDITION. See\n  [HELP DECLARE CONDITION].\n\no SQLWARNING is shorthand for the class of SQLSTATE values that begin\n  with \'01\'.\n\no NOT FOUND is shorthand for the class of SQLSTATE values that begin\n  with \'02\'. This is relevant only within the context of cursors and is\n  used to control what happens when a cursor reaches the end of a data\n  set.\n\no SQLEXCEPTION is shorthand for the class of SQLSTATE values that do\n  not begin with \'00\', \'01\', or \'02\'.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/declare-handler.html\n\n','mysql> CREATE TABLE test.t (s1 INT, PRIMARY KEY (s1));\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> delimiter //\n\nmysql> CREATE PROCEDURE handlerdemo ()\n    -> BEGIN\n    ->   DECLARE CONTINUE HANDLER FOR SQLSTATE \'23000\' SET @x2 = 1;\n    ->   SET @x = 1;\n    ->   INSERT INTO test.t VALUES (1);\n    ->   SET @x = 2;\n    ->   INSERT INTO test.t VALUES (1);\n    ->   SET @x = 3;\n    -> END;\n    -> //\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> CALL handlerdemo()//\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT @x//\n    +------+\n    | @x   |\n    +------+\n    | 3    |\n    +------+\n    1 row in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/declare-handler.html');
INSERT INTO `mysql`.`help_topic` VALUES  (300,'DOUBLE',19,'DOUBLE[(M,D)] [UNSIGNED] [ZEROFILL]\n\nA normal-size (double-precision) floating-point number. Allowable\nvalues are -1.7976931348623157E+308 to -2.2250738585072014E-308, 0, and\n2.2250738585072014E-308 to 1.7976931348623157E+308. These are the\ntheoretical limits, based on the IEEE standard. The actual range might\nbe slightly smaller depending on your hardware or operating system.\n\nM is the total number of digits and D is the number of digits following\nthe decimal point. If M and D are omitted, values are stored to the\nlimits allowed by the hardware. A double-precision floating-point\nnumber is accurate to approximately 15 decimal places.\n\nUNSIGNED, if specified, disallows negative values.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (301,'TIME',19,'TIME\n\nA time. The range is \'-838:59:59\' to \'838:59:59\'. MySQL displays TIME\nvalues in \'HH:MM:SS\' format, but allows assignment of values to TIME\ncolumns using either strings or numbers.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-type-overview.html'),
 (302,'&&',12,'Syntax:\nAND, &&\n\nLogical AND. Evaluates to 1 if all operands are non-zero and not NULL,\nto 0 if one or more operands are 0, otherwise NULL is returned.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/logical-operators.html\n\n','mysql> SELECT 1 && 1;\n        -> 1\nmysql> SELECT 1 && 0;\n        -> 0\nmysql> SELECT 1 && NULL;\n        -> NULL\nmysql> SELECT 0 && NULL;\n        -> 0\nmysql> SELECT NULL && 0;\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/logical-operators.html');
INSERT INTO `mysql`.`help_topic` VALUES  (303,'X',9,'X(p)\n\nReturns the X-coordinate value for the point p as a double-precision\nnumber.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#point-property-functions\n\n','mysql> SET @pt = \'Point(56.7 53.34)\';\nmysql> SELECT X(GeomFromText(@pt));\n+----------------------+\n| X(GeomFromText(@pt)) |\n+----------------------+\n|                 56.7 |\n+----------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#point-property-functions'),
 (304,'FOUND_ROWS',14,'Syntax:\nFOUND_ROWS()\n\nA SELECT statement may include a LIMIT clause to restrict the number of\nrows the server returns to the client. In some cases, it is desirable\nto know how many rows the statement would have returned without the\nLIMIT, but without running the statement again. To obtain this row\ncount, include a SQL_CALC_FOUND_ROWS option in the SELECT statement,\nand then invoke FOUND_ROWS() afterward:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT SQL_CALC_FOUND_ROWS * FROM tbl_name\n    -> WHERE id > 100 LIMIT 10;\nmysql> SELECT FOUND_ROWS();\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (305,'SYSTEM_USER',14,'Syntax:\nSYSTEM_USER()\n\nSYSTEM_USER() is a synonym for USER().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (306,'CROSSES',28,'Crosses(g1,g2)\n\nReturns 1 if g1 spatially crosses g2. Returns NULL if g1 is a Polygon\nor a MultiPolygon, or if g2 is a Point or a MultiPoint. Otherwise,\nreturns 0.\n\nThe term spatially crosses denotes a spatial relation between two given\ngeometries that has the following properties:\n\no The two geometries intersect\n\no Their intersection results in a geometry that has a dimension that is\n  one less than the maximum dimension of the two given geometries\n\no Their intersection is not equal to either of the two given geometries\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html'),
 (307,'TRUNCATE TABLE',25,'Syntax:\nTRUNCATE [TABLE] tbl_name\n\nTRUNCATE TABLE empties a table completely. Logically, this is\nequivalent to a DELETE statement that deletes all rows, but there are\npractical differences under some circumstances.\n\nFor an InnoDB table before version 5.0.3, InnoDB processes TRUNCATE\nTABLE by deleting rows one by one. As of MySQL 5.0.3, row by row\ndeletion is used only if there are any FOREIGN KEY constraints that\nreference the table. If there are no FOREIGN KEY constraints, InnoDB\nperforms fast truncation by dropping the original table and creating an\nempty one with the same definition, which is much faster than deleting\nrows one by one. (When fast truncation is used, it resets any\nAUTO_INCREMENT counter. From MySQL 5.0.13 on, the AUTO_INCREMENT\ncounter is reset by TRUNCATE TABLE, regardless of whether there is a\nforeign key constraint.)\n\nIn the case that FOREIGN KEY constraints reference the table, InnoDB\ndeletes rows one by one and processes the constraints on each one. If\nthe FOREIGN KEY constraint specifies DELETE CASCADE, rows from the\nchild (referenced) table are deleted, and the truncated table becomes\nempty. If the FOREIGN KEY constraint does not specify CASCADE, the\nTRUNCATE statement deletes rows one by one and stops if it encounters a\nparent row that is referenced by the child, returning this error:\n\nERROR 1451 (23000): Cannot delete or update a parent row: a foreign\nkey constraint fails (`test`.`child`, CONSTRAINT `child_ibfk_1`\nFOREIGN KEY (`parent_id`) REFERENCES `parent` (`id`))\n\nThis is the same as a DELETE statement with no WHERE clause.\n\nThe count of rows affected by TRUNCATE TABLE is accurate only when it\nis mapped to a DELETE statement.\n\nFor other storage engines, TRUNCATE TABLE differs from DELETE in the\nfollowing ways in MySQL 5.0:\n\no Truncate operations drop and re-create the table, which is much\n  faster than deleting rows one by one, particularly for large tables.\n\no Truncate operations are not transaction-safe; an error occurs when\n  attempting one in the course of an active transaction or active table\n  lock.\n\no Truncation operations do not return the number of deleted rows.\n\no As long as the table format file tbl_name.frm is valid, the table can\n  be re-created as an empty table with TRUNCATE TABLE, even if the data\n  or index files have become corrupted.\n\no The table handler does not remember the last used AUTO_INCREMENT\n  value, but starts counting from the beginning. This is true even for\n  MyISAM and InnoDB, which normally do not reuse sequence values.\n\no Since truncation of a table does not make any use of DELETE, the\n  TRUNCATE statement does not invoke ON DELETE triggers.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/truncate.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/truncate.html'),
 (308,'BIT_XOR',15,'Syntax:\nBIT_XOR(expr)\n\nReturns the bitwise XOR of all bits in expr. The calculation is\nperformed with 64-bit (BIGINT) precision.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (309,'CURRENT_DATE',29,'Syntax:\nCURRENT_DATE, CURRENT_DATE()\n\nCURRENT_DATE and CURRENT_DATE() are synonyms for CURDATE().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (310,'START SLAVE',25,'Syntax:\nSTART SLAVE [thread_type [, thread_type] ... ]\nSTART SLAVE [SQL_THREAD] UNTIL\n    MASTER_LOG_FILE = \'log_name\', MASTER_LOG_POS = log_pos\nSTART SLAVE [SQL_THREAD] UNTIL\n    RELAY_LOG_FILE = \'log_name\', RELAY_LOG_POS = log_pos\n\nthread_type: IO_THREAD | SQL_THREAD\n\nSTART SLAVE with no thread_type options starts both of the slave\nthreads. The I/O thread reads queries from the master server and stores\nthem in the relay log. The SQL thread reads the relay log and executes\nthe queries. START SLAVE requires the SUPER privilege.\n\nIf START SLAVE succeeds in starting the slave threads, it returns\nwithout any error. However, even in that case, it might be that the\nslave threads start and then later stop (for example, because they do\nnot manage to connect to the master or read its binary logs, or some\nother problem). START SLAVE does not warn you about this. You must\ncheck the slave\'s error log for error messages generated by the slave\nthreads, or check that they are running satisfactorily with SHOW SLAVE\nSTATUS.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/start-slave.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/start-slave.html'),
 (311,'AREA',2,'Area(poly)\n\nReturns as a double-precision number the area of the Polygon value\npoly, as measured in its spatial reference system.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#polygon-property-functions\n\n','mysql> SET @poly = \'Polygon((0 0,0 3,3 0,0 0),(1 1,1 2,2 1,1 1))\';\nmysql> SELECT Area(GeomFromText(@poly));\n+---------------------------+\n| Area(GeomFromText(@poly)) |\n+---------------------------+\n|                         4 |\n+---------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#polygon-property-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (312,'BEGIN END',21,'Syntax:\n[begin_label:] BEGIN\n    [statement_list]\nEND [end_label]\n\nBEGIN ... END syntax is used for writing compound statements, which can\nappear within stored programs. A compound statement can contain\nmultiple statements, enclosed by the BEGIN and END keywords.\nstatement_list represents a list of one or more statements, each\nterminated by a semicolon (;) statement delimiter. statement_list is\noptional, which means that the empty compound statement (BEGIN END) is\nlegal.\n\nUse of multiple statements requires that a client is able to send\nstatement strings containing the ; statement delimiter. This is handled\nin the mysql command-line client with the delimiter command. Changing\nthe ; end-of-statement delimiter (for example, to //) allows ; to be\nused in a program body. For an example, see\nhttp://dev.mysql.com/doc/refman/5.0/en/stored-programs-defining.html.\n\nA compound statement can be labeled. end_label cannot be given unless\nbegin_label also is present. If both are present, they must be the\nsame.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/begin-end.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/begin-end.html'),
 (313,'FLUSH',25,'Syntax:\nFLUSH [NO_WRITE_TO_BINLOG | LOCAL]\n    flush_option [, flush_option] ...\n\nThe FLUSH statement clears or reloads various internal caches used by\nMySQL. To execute FLUSH, you must have the RELOAD privilege.\n\nThe RESET statement is similar to FLUSH. See [HELP RESET].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/flush.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/flush.html');
INSERT INTO `mysql`.`help_topic` VALUES  (314,'SHOW PROCEDURE STATUS',25,'Syntax:\nSHOW PROCEDURE STATUS\n    [LIKE \'pattern\' | WHERE expr]\n\nThis statement is a MySQL extension. It returns characteristics of a\nstored procedure, such as the database, name, type, creator, creation\nand modification dates, and character set information. A similar\nstatement, SHOW FUNCTION STATUS, displays information about stored\nfunctions (see [HELP SHOW FUNCTION STATUS]).\n\nThe LIKE clause, if present, indicates which procedure or function\nnames to match. The WHERE clause can be given to select rows using more\ngeneral conditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-procedure-status.html\n\n','mysql> SHOW PROCEDURE STATUS LIKE \'sp1\'\\G\n*************************** 1. row ***************************\n           Db: test\n         Name: sp1\n         Type: PROCEDURE\n      Definer: testuser@localhost\n     Modified: 2004-08-03 15:29:37\n      Created: 2004-08-03 15:29:37\nSecurity_type: DEFINER\n      Comment:\n','http://dev.mysql.com/doc/refman/5.0/en/show-procedure-status.html'),
 (315,'SHOW WARNINGS',25,'Syntax:\nSHOW WARNINGS [LIMIT [offset,] row_count]\nSHOW COUNT(*) WARNINGS\n\nSHOW WARNINGS shows the error, warning, and note messages that resulted\nfrom the last statement that generated messages. It shows nothing if\nthe last statement used a table and generated no messages. (That is, a\nstatement that uses a table but generates no messages clears the\nmessage list.) Statements that do not use tables and do not generate\nmessages have no effect on the message list.\n\nA related statement, SHOW ERRORS, shows only the errors. See [HELP SHOW\nERRORS].\n\nThe SHOW COUNT(*) WARNINGS statement displays the total number of\nerrors, warnings, and notes. You can also retrieve this number from the\nwarning_count variable:\n\nSHOW COUNT(*) WARNINGS;\nSELECT @@warning_count;\n\nThe value of warning_count might be greater than the number of messages\ndisplayed by SHOW WARNINGS if the max_error_count system variable is\nset so low that not all messages are stored. An example shown later in\nthis section demonstrates how this can happen.\n\nThe LIMIT clause has the same syntax as for the SELECT statement. See\nhttp://dev.mysql.com/doc/refman/5.0/en/select.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-warnings.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-warnings.html');
INSERT INTO `mysql`.`help_topic` VALUES  (316,'DESCRIBE',26,'Syntax:\n{DESCRIBE | DESC} tbl_name [col_name | wild]\n\nDESCRIBE provides information about the columns in a table. It is a\nshortcut for SHOW COLUMNS FROM. As of MySQL 5.0.1, these statements\nalso display information for views. (See [HELP SHOW COLUMNS].)\n\ncol_name can be a column name, or a string containing the SQL \"%\" and\n\"_\" wildcard characters to obtain output only for the columns with\nnames matching the string. There is no need to enclose the string\nwithin quotes unless it contains spaces or other special characters.\n\nmysql> DESCRIBE City;\n+------------+----------+------+-----+---------+----------------+\n| Field      | Type     | Null | Key | Default | Extra          |\n+------------+----------+------+-----+---------+----------------+\n| Id         | int(11)  | NO   | PRI | NULL    | auto_increment |\n| Name       | char(35) | NO   |     |         |                |\n| Country    | char(3)  | NO   | UNI |         |                |\n| District   | char(20) | YES  | MUL |         |                |\n| Population | int(11)  | NO   |     | 0       |                |\n+------------+----------+------+-----+---------+----------------+\n5 rows in set (0.00 sec)\n\nThe description for SHOW COLUMNS provides more information about the\noutput columns (see [HELP SHOW COLUMNS]).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/describe.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/describe.html'),
 (317,'DROP USER',8,'Syntax:\nDROP USER user [, user] ...\n\nThe DROP USER statement removes one or more MySQL accounts. To use it,\nyou must have the global CREATE USER privilege or the DELETE privilege\nfor the mysql database. Each account is named using the same format as\nfor the GRANT statement; for example, \'jeffrey\'@\'localhost\'. If you\nspecify only the username part of the account name, a hostname part of\n\'%\' is used. For additional information about specifying account names,\nsee [HELP GRANT].\n\nDROP USER as present in MySQL 5.0.0 removes only accounts that have no\nprivileges. In MySQL 5.0.2, it was modified to remove account\nprivileges as well. This means that the procedure for removing an\naccount depends on your version of MySQL.\n\nAs of MySQL 5.0.2, you can remove an account and its privileges as\nfollows:\n\nDROP USER user;\n\nThe statement removes privilege rows for the account from all grant\ntables.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-user.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-user.html');
INSERT INTO `mysql`.`help_topic` VALUES  (318,'STDDEV_POP',15,'Syntax:\nSTDDEV_POP(expr)\n\nReturns the population standard deviation of expr (the square root of\nVAR_POP()). This function was added in MySQL 5.0.3. Before 5.0.3, you\ncan use STD() or STDDEV(), which are equivalent but not standard SQL.\n\nSTDDEV_POP() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (319,'SHOW CHARACTER SET',25,'Syntax:\nSHOW CHARACTER SET\n    [LIKE \'pattern\' | WHERE expr]\n\nThe SHOW CHARACTER SET statement shows all available character sets.\nThe LIKE clause, if present, indicates which character set names to\nmatch. The WHERE clause can be given to select rows using more general\nconditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html. For example:\n\nmysql> SHOW CHARACTER SET LIKE \'latin%\';\n+---------+-----------------------------+-------------------+--------+\n| Charset | Description                 | Default collation | Maxlen |\n+---------+-----------------------------+-------------------+--------+\n| latin1  | cp1252 West European        | latin1_swedish_ci |      1 |\n| latin2  | ISO 8859-2 Central European | latin2_general_ci |      1 |\n| latin5  | ISO 8859-9 Turkish          | latin5_turkish_ci |      1 |\n| latin7  | ISO 8859-13 Baltic          | latin7_general_ci |      1 |\n+---------+-----------------------------+-------------------+--------+\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-character-set.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-character-set.html'),
 (320,'SUBSTRING',34,'Syntax:\nSUBSTRING(str,pos), SUBSTRING(str FROM pos), SUBSTRING(str,pos,len),\nSUBSTRING(str FROM pos FOR len)\n\nThe forms without a len argument return a substring from string str\nstarting at position pos. The forms with a len argument return a\nsubstring len characters long from string str, starting at position\npos. The forms that use FROM are standard SQL syntax. It is also\npossible to use a negative value for pos. In this case, the beginning\nof the substring is pos characters from the end of the string, rather\nthan the beginning. A negative value may be used for pos in any of the\nforms of this function.\n\nFor all forms of SUBSTRING(), the position of the first character in\nthe string from which the substring is to be extracted is reckoned as\n1.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT SUBSTRING(\'Quadratically\',5);\n        -> \'ratically\'\nmysql> SELECT SUBSTRING(\'foobarbar\' FROM 4);\n        -> \'barbar\'\nmysql> SELECT SUBSTRING(\'Quadratically\',5,6);\n        -> \'ratica\'        \nmysql> SELECT SUBSTRING(\'Sakila\', -3);\n        -> \'ila\'        \nmysql> SELECT SUBSTRING(\'Sakila\', -5, 3);\n        -> \'aki\'\nmysql> SELECT SUBSTRING(\'Sakila\' FROM -4 FOR 2);\n        -> \'ki\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (321,'ISEMPTY',33,'IsEmpty(g)\n\nReturns 1 if the geometry value g is the empty geometry, 0 if it is not\nempty, and -1 if the argument is NULL. If the geometry is empty, it\nrepresents the empty point set.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions'),
 (322,'SHOW FUNCTION STATUS',25,'Syntax:\nSHOW FUNCTION STATUS\n    [LIKE \'pattern\' | WHERE expr]\n\nThis statement is similar to SHOW PROCEDURE STATUS but for stored\nfunctions. See [HELP SHOW PROCEDURE STATUS].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-function-status.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-function-status.html'),
 (323,'LTRIM',34,'Syntax:\nLTRIM(str)\n\nReturns the string str with leading space characters removed.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT LTRIM(\'  barbar\');\n        -> \'barbar\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (324,'INTERSECTS',28,'Intersects(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 spatially intersects g2.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html');
INSERT INTO `mysql`.`help_topic` VALUES  (325,'CALL',25,'Syntax:\nCALL sp_name([parameter[,...]])\nCALL sp_name[()]\n\nThe CALL statement invokes a stored procedure that was defined\npreviously with CREATE PROCEDURE.\n\nCALL can pass back values to its caller using parameters that are\ndeclared as OUT or INOUT parameters. When the procedure returns, a\nclient program can also obtain the number of rows affected for the\nfinal statement executed within the routine: At the SQL level, call the\nROW_COUNT() function; from C, call the mysql_affected_rows() C API\nfunction.\n\nAs of MySQL 5.0.30, stored procedures that take no arguments can be\ninvoked without parentheses. That is, CALL p() and CALL p are\nequivalent.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/call.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/call.html'),
 (326,'MBRDISJOINT',5,'MBRDisjoint(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 are disjoint (do not intersect).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html'),
 (327,'VALUES',13,'Syntax:\nVALUES(col_name)\n\nIn an INSERT ... ON DUPLICATE KEY UPDATE statement, you can use the\nVALUES(col_name) function in the UPDATE clause to refer to column\nvalues from the INSERT portion of the statement. In other words,\nVALUES(col_name) in the UPDATE clause refers to the value of col_name\nthat would be inserted, had no duplicate-key conflict occurred. This\nfunction is especially useful in multiple-row inserts. The VALUES()\nfunction is meaningful only in INSERT ... ON DUPLICATE KEY UPDATE\nstatements and returns NULL otherwise.\nhttp://dev.mysql.com/doc/refman/5.0/en/insert-on-duplicate.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','mysql> INSERT INTO table (a,b,c) VALUES (1,2,3),(4,5,6)\n    -> ON DUPLICATE KEY UPDATE c=VALUES(a)+VALUES(b);\n','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (328,'SUBSTRING_INDEX',34,'Syntax:\nSUBSTRING_INDEX(str,delim,count)\n\nReturns the substring from string str before count occurrences of the\ndelimiter delim. If count is positive, everything to the left of the\nfinal delimiter (counting from the left) is returned. If count is\nnegative, everything to the right of the final delimiter (counting from\nthe right) is returned. SUBSTRING_INDEX() performs a case-sensitive\nmatch when searching for delim.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT SUBSTRING_INDEX(\'www.mysql.com\', \'.\', 2);\n        -> \'www.mysql\'\nmysql> SELECT SUBSTRING_INDEX(\'www.mysql.com\', \'.\', -2);\n        -> \'mysql.com\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (329,'ENCODE',10,'Syntax:\nENCODE(str,pass_str)\n\nEncrypt str using pass_str as the password. To decrypt the result, use\nDECODE().\n\nThe result is a binary string of the same length as str.\n\nThe strength of the encryption is based on how good the random\ngenerator is. It should suffice for short strings.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (330,'LOOP',21,'Syntax:\n[begin_label:] LOOP\n    statement_list\nEND LOOP [end_label]\n\nLOOP implements a simple loop construct, enabling repeated execution of\nthe statement list, which consists of one or more statements, each\nterminated by a semicolon (;) statement delimiter. The statements\nwithin the loop are repeated until the loop is exited; usually this is\naccomplished with a LEAVE statement.\n\nA LOOP statement can be labeled. end_label cannot be given unless\nbegin_label also is present. If both are present, they must be the\nsame.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/loop-statement.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/loop-statement.html');
INSERT INTO `mysql`.`help_topic` VALUES  (331,'TRUNCATE',4,'Syntax:\nTRUNCATE(X,D)\n\nReturns the number X, truncated to D decimal places. If D is 0, the\nresult has no decimal point or fractional part. D can be negative to\ncause D digits left of the decimal point of the value X to become zero.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT TRUNCATE(1.223,1);\n        -> 1.2\nmysql> SELECT TRUNCATE(1.999,1);\n        -> 1.9\nmysql> SELECT TRUNCATE(1.999,0);\n        -> 1\nmysql> SELECT TRUNCATE(-1.999,1);\n        -> -1.9\nmysql> SELECT TRUNCATE(122,-2);\n       -> 100\nmysql> SELECT TRUNCATE(10.28*100,0);\n       -> 1028\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (332,'TIMESTAMPADD',29,'Syntax:\nTIMESTAMPADD(unit,interval,datetime_expr)\n\nAdds the integer expression interval to the date or datetime expression\ndatetime_expr. The unit for interval is given by the unit argument,\nwhich should be one of the following values: FRAC_SECOND\n(microseconds), SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, or\nYEAR.\n\nBeginning with MySQL 5.0.60, it is possible to use MICROSECOND in place\nof FRAC_SECOND with this function, and FRAC_SECOND is deprecated.\n\nThe unit value may be specified using one of keywords as shown, or with\na prefix of SQL_TSI_. For example, DAY and SQL_TSI_DAY both are legal.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT TIMESTAMPADD(MINUTE,1,\'2003-01-02\');\n        -> \'2003-01-02 00:01:00\'\nmysql> SELECT TIMESTAMPADD(WEEK,1,\'2003-01-02\');\n        -> \'2003-01-09\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (333,'SHOW',25,'SHOW has many forms that provide information about databases, tables,\ncolumns, or status information about the server. This section describes\nthose following:\n\nSHOW CHARACTER SET [like_or_where]\nSHOW COLLATION [like_or_where]\nSHOW [FULL] COLUMNS FROM tbl_name [FROM db_name] [like_or_where]\nSHOW CREATE DATABASE db_name\nSHOW CREATE FUNCTION func_name\nSHOW CREATE PROCEDURE proc_name\nSHOW CREATE TABLE tbl_name\nSHOW DATABASES [like_or_where]\nSHOW ENGINE engine_name {LOGS | STATUS }\nSHOW [STORAGE] ENGINES\nSHOW ERRORS [LIMIT [offset,] row_count]\nSHOW FUNCTION CODE func_name\nSHOW FUNCTION STATUS [like_or_where]\nSHOW GRANTS FOR user\nSHOW INDEX FROM tbl_name [FROM db_name]\nSHOW INNODB STATUS\nSHOW PROCEDURE CODE proc_name\nSHOW PROCEDURE STATUS [like_or_where]\nSHOW [BDB] LOGS\nSHOW MUTEX STATUS\nSHOW OPEN TABLES [FROM db_name] [like_or_where]\nSHOW PRIVILEGES\nSHOW [FULL] PROCESSLIST\nSHOW PROFILE [types] [FOR QUERY n] [OFFSET n] [LIMIT n]\nSHOW PROFILES\nSHOW [GLOBAL | SESSION] STATUS [like_or_where]\nSHOW TABLE STATUS [FROM db_name] [like_or_where]\nSHOW TABLES [FROM db_name] [like_or_where]\nSHOW TRIGGERS [FROM db_name] [like_or_where]\nSHOW [GLOBAL | SESSION] VARIABLES [like_or_where]\nSHOW WARNINGS [LIMIT [offset,] row_count]\n\nlike_or_where:\n    LIKE \'pattern\'\n  | WHERE expr\n\nIf the syntax for a given SHOW statement includes a LIKE \'pattern\'\npart, \'pattern\' is a string that can contain the SQL \"%\" and \"_\"\nwildcard characters. The pattern is useful for restricting statement\noutput to matching values.\n\nSeveral SHOW statements also accept a WHERE clause that provides more\nflexibility in specifying which rows to display. See\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show.html');
INSERT INTO `mysql`.`help_topic` VALUES  (334,'GREATEST',16,'Syntax:\nGREATEST(value1,value2,...)\n\nWith two or more arguments, returns the largest (maximum-valued)\nargument. The arguments are compared using the same rules as for\nLEAST().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT GREATEST(2,0);\n        -> 2\nmysql> SELECT GREATEST(34.0,3.0,5.0,767.0);\n        -> 767.0\nmysql> SELECT GREATEST(\'B\',\'A\',\'C\');\n        -> \'C\'\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (335,'SHOW VARIABLES',25,'Syntax:\nSHOW [GLOBAL | SESSION] VARIABLES\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW VARIABLES shows the values of MySQL system variables. This\ninformation also can be obtained using the mysqladmin variables\ncommand. The LIKE clause, if present, indicates which variable names to\nmatch. The WHERE clause can be given to select rows using more general\nconditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html.\n\nWith the GLOBAL modifier, SHOW VARIABLES displays the values that are\nused for new connections to MySQL. With SESSION, it displays the values\nthat are in effect for the current connection. If no modifier is\npresent, the default is SESSION. LOCAL is a synonym for SESSION.\nWith a LIKE clause, the statement displays only rows for those\nvariables with names that match the pattern. To obtain the row for a\nspecific variable, use a LIKE clause as shown:\n\nSHOW VARIABLES LIKE \'max_join_size\';\nSHOW SESSION VARIABLES LIKE \'max_join_size\';\n\nTo get a list of variables whose name match a pattern, use the \"%\"\nwildcard character in a LIKE clause:\n\nSHOW VARIABLES LIKE \'%size%\';\nSHOW GLOBAL VARIABLES LIKE \'%size%\';\n\nWildcard characters can be used in any position within the pattern to\nbe matched. Strictly speaking, because \"_\" is a wildcard that matches\nany single character, you should escape it as \"\\_\" to match it\nliterally. In practice, this is rarely necessary.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-variables.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-variables.html'),
 (336,'BIT_AND',15,'Syntax:\nBIT_AND(expr)\n\nReturns the bitwise AND of all bits in expr. The calculation is\nperformed with 64-bit (BIGINT) precision.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (337,'SECOND',29,'Syntax:\nSECOND(time)\n\nReturns the second for time, in the range 0 to 59.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT SECOND(\'10:05:03\');\n        -> 3\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (338,'ATAN2',4,'Syntax:\nATAN(Y,X), ATAN2(Y,X)\n\nReturns the arc tangent of the two variables X and Y. It is similar to\ncalculating the arc tangent of Y / X, except that the signs of both\narguments are used to determine the quadrant of the result.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT ATAN(-2,2);\n        -> -0.78539816339745\nmysql> SELECT ATAN2(PI(),0);\n        -> 1.5707963267949\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (339,'MBRCONTAINS',5,'MBRContains(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangle of g1\ncontains the Minimum Bounding Rectangle of g2. This tests the opposite\nrelationship as MBRWithin().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html\n\n','mysql> SET @g1 = GeomFromText(\'Polygon((0 0,0 3,3 3,3 0,0 0))\');\nmysql> SET @g2 = GeomFromText(\'Point(1 1)\');\nmysql> SELECT MBRContains(@g1,@g2), MBRContains(@g2,@g1);\n----------------------+----------------------+\n| MBRContains(@g1,@g2) | MBRContains(@g2,@g1) |\n+----------------------+----------------------+\n|                    1 |                    0 |\n+----------------------+----------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html'),
 (340,'HOUR',29,'Syntax:\nHOUR(time)\n\nReturns the hour for time. The range of the return value is 0 to 23 for\ntime-of-day values. However, the range of TIME values actually is much\nlarger, so HOUR can return values greater than 23.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT HOUR(\'10:05:03\');\n        -> 10\nmysql> SELECT HOUR(\'272:59:59\');\n        -> 272\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (341,'SELECT',25,'Syntax:\nSELECT\n    [ALL | DISTINCT | DISTINCTROW ]\n      [HIGH_PRIORITY]\n      [STRAIGHT_JOIN]\n      [SQL_SMALL_RESULT] [SQL_BIG_RESULT] [SQL_BUFFER_RESULT]\n      [SQL_CACHE | SQL_NO_CACHE] [SQL_CALC_FOUND_ROWS]\n    select_expr, ...\n    [FROM table_references\n    [WHERE where_condition]\n    [GROUP BY {col_name | expr | position}\n      [ASC | DESC], ... [WITH ROLLUP]]\n    [HAVING where_condition]\n    [ORDER BY {col_name | expr | position}\n      [ASC | DESC], ...]\n    [LIMIT {[offset,] row_count | row_count OFFSET offset}]\n    [PROCEDURE procedure_name(argument_list)]\n    [INTO OUTFILE \'file_name\' export_options\n      | INTO DUMPFILE \'file_name\'\n      | INTO var_name [, var_name]]\n    [FOR UPDATE | LOCK IN SHARE MODE]]\n\nSELECT is used to retrieve rows selected from one or more tables, and\ncan include UNION statements and subqueries. See [HELP UNION], and\nhttp://dev.mysql.com/doc/refman/5.0/en/subqueries.html.\n\nThe most commonly used clauses of SELECT statements are these:\n\no Each select_expr indicates a column that you want to retrieve. There\n  must be at least one select_expr.\n\no table_references indicates the table or tables from which to retrieve\n  rows. Its syntax is described in [HELP JOIN].\n\no The WHERE clause, if given, indicates the condition or conditions\n  that rows must satisfy to be selected. where_condition is an\n  expression that evaluates to true for each row to be selected. The\n  statement selects all rows if there is no WHERE clause.\n\n  In the WHERE clause, you can use any of the functions and operators\n  that MySQL supports, except for aggregate (summary) functions. See\n  http://dev.mysql.com/doc/refman/5.0/en/functions.html.\n\nSELECT can also be used to retrieve rows computed without reference to\nany table.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/select.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/select.html'),
 (342,'COT',4,'Syntax:\nCOT(X)\n\nReturns the cotangent of X.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT COT(12);\n        -> -1.5726734063977\nmysql> SELECT COT(0);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (343,'BACKUP TABLE',18,'Syntax:\nBACKUP TABLE tbl_name [, tbl_name] ... TO \'/path/to/backup/directory\'\n\n*Note*: This statement is deprecated. We are working on a better\nreplacement for it that will provide online backup capabilities. In the\nmeantime, the mysqlhotcopy script can be used instead.\n\nBACKUP TABLE copies to the backup directory the minimum number of table\nfiles needed to restore the table, after flushing any buffered changes\nto disk. The statement works only for MyISAM tables. It copies the .frm\ndefinition and .MYD data files. The .MYI index file can be rebuilt from\nthose two files. The directory should be specified as a full pathname.\nTo restore the table, use RESTORE TABLE.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/backup-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/backup-table.html'),
 (344,'LOAD_FILE',34,'Syntax:\nLOAD_FILE(file_name)\n\nReads the file and returns the file contents as a string. To use this\nfunction, the file must be located on the server host, you must specify\nthe full pathname to the file, and you must have the FILE privilege.\nThe file must be readable by all and its size less than\nmax_allowed_packet bytes.\n\nIf the file does not exist or cannot be read because one of the\npreceding conditions is not satisfied, the function returns NULL.\n\nAs of MySQL 5.0.19, the character_set_filesystem system variable\ncontrols interpretation of filenames that are given as literal strings.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> UPDATE t\n            SET blob_col=LOAD_FILE(\'/tmp/picture\')\n            WHERE id=1;\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (345,'LOAD TABLE FROM MASTER',25,'Syntax:\nLOAD TABLE tbl_name FROM MASTER\n\nThis feature is deprecated. We recommend not using it anymore. It is\nsubject to removal in a future version of MySQL.\n\nSince the current implementation of LOAD DATA FROM MASTER and LOAD\nTABLE FROM MASTER is very limited, these statements are deprecated in\nversions 4.1 of MySQL and above. We will introduce a more advanced\ntechnique (called \"online backup\") in a future version. That technique\nwill have the additional advantage of working with more storage\nengines.\n\nFor MySQL 5.1 and earlier, the recommended alternative solution to\nusing LOAD DATA FROM MASTER or LOAD TABLE FROM MASTER is using\nmysqldump or mysqlhotcopy. The latter requires Perl and two Perl\nmodules (DBI and DBD:mysql) and works for MyISAM and ARCHIVE tables\nonly. With mysqldump, you can create SQL dumps on the master and pipe\n(or copy) these to a mysql client on the slave. This has the advantage\nof working for all storage engines, but can be quite slow, since it\nworks using SELECT.\n\nTransfers a copy of the table from the master to the slave. This\nstatement is implemented mainly debugging LOAD DATA FROM MASTER\noperations. To use LOAD TABLE, the account used for connecting to the\nmaster server must have the RELOAD and SUPER privileges on the master\nand the SELECT privilege for the master table to load. On the slave\nside, the user that issues LOAD TABLE FROM MASTER must have privileges\nfor dropping and creating the table.\n\nThe conditions for LOAD DATA FROM MASTER apply here as well. For\nexample, LOAD TABLE FROM MASTER works only for MyISAM tables. The\ntimeout notes for LOAD DATA FROM MASTER apply as well.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/load-table-from-master.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/load-table-from-master.html');
INSERT INTO `mysql`.`help_topic` VALUES  (346,'POINTFROMTEXT',3,'PointFromText(wkt[,srid])\n\nConstructs a POINT value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions'),
 (347,'GROUP_CONCAT',15,'Syntax:\nGROUP_CONCAT(expr)\n\nThis function returns a string result with the concatenated non-NULL\nvalues from a group. It returns NULL if there are no non-NULL values.\nThe full syntax is as follows:\n\nGROUP_CONCAT([DISTINCT] expr [,expr ...]\n             [ORDER BY {unsigned_integer | col_name | expr}\n                 [ASC | DESC] [,col_name ...]]\n             [SEPARATOR str_val])\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','mysql> SELECT student_name,\n    ->     GROUP_CONCAT(test_score)\n    ->     FROM student\n    ->     GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (348,'DATE_FORMAT',29,'Syntax:\nDATE_FORMAT(date,format)\n\nFormats the date value according to the format string.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT DATE_FORMAT(\'2009-10-04 22:23:00\', \'%W %M %Y\');\n        -> \'Sunday October 2009\'\nmysql> SELECT DATE_FORMAT(\'2007-10-04 22:23:00\', \'%H:%i:%s\');\n        -> \'22:23:00\'\nmysql> SELECT DATE_FORMAT(\'1900-10-04 22:23:00\',\n    ->                 \'%D %y %a %d %m %b %j\');\n        -> \'4th 00 Thu 04 10 Oct 277\'\nmysql> SELECT DATE_FORMAT(\'1997-10-04 22:23:00\',\n    ->                 \'%H %k %I %r %T %S %w\');\n        -> \'22 22 10 10:23:00 PM 22:23:00 00 6\'\nmysql> SELECT DATE_FORMAT(\'1999-01-01\', \'%X %V\');\n        -> \'1998 52\'\nmysql> SELECT DATE_FORMAT(\'2006-06-00\', \'%d\');\n        -> \'00\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (349,'BENCHMARK',14,'Syntax:\nBENCHMARK(count,expr)\n\nThe BENCHMARK() function executes the expression expr repeatedly count\ntimes. It may be used to time how quickly MySQL processes the\nexpression. The result value is always 0. The intended use is from\nwithin the mysql client, which reports query execution times:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT BENCHMARK(1000000,ENCODE(\'hello\',\'goodbye\'));\n+----------------------------------------------+\n| BENCHMARK(1000000,ENCODE(\'hello\',\'goodbye\')) |\n+----------------------------------------------+\n|                                            0 |\n+----------------------------------------------+\n1 row in set (4.74 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (350,'YEAR',29,'Syntax:\nYEAR(date)\n\nReturns the year for date, in the range 1000 to 9999, or 0 for the\n\"zero\" date.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT YEAR(\'1987-01-01\');\n        -> 1987\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (351,'SHOW ENGINE',25,'Syntax:\nSHOW ENGINE engine_name {LOGS | STATUS }\n\nSHOW ENGINE displays log or status information about a storage engine.\nThe following statements currently are supported:\n\nSHOW ENGINE BDB LOGS\nSHOW ENGINE INNODB STATUS\nSHOW ENGINE NDB STATUS\nSHOW ENGINE NDBCLUSTER STATUS\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-engine.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-engine.html');
INSERT INTO `mysql`.`help_topic` VALUES  (352,'NAME_CONST',13,'Syntax:\nNAME_CONST(name,value)\n\nReturns the given value. When used to produce a result set column,\nNAME_CONST() causes the column to have the given name. The arguments\nshould be constants.\n\nmysql> SELECT NAME_CONST(\'myname\', 14);\n+--------+\n| myname |\n+--------+\n|     14 |\n+--------+\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (353,'RELEASE_LOCK',13,'Syntax:\nRELEASE_LOCK(str)\n\nReleases the lock named by the string str that was obtained with\nGET_LOCK(). Returns 1 if the lock was released, 0 if the lock was not\nestablished by this thread (in which case the lock is not released),\nand NULL if the named lock did not exist. The lock does not exist if it\nwas never obtained by a call to GET_LOCK() or if it has previously been\nreleased.\n\nThe DO statement is convenient to use with RELEASE_LOCK(). See [HELP\nDO].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (354,'IS NULL',16,'Syntax:\nIS NULL\n\nTests whether a value is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 1 IS NULL, 0 IS NULL, NULL IS NULL;\n        -> 0, 0, 1\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html');
INSERT INTO `mysql`.`help_topic` VALUES  (355,'CONVERT_TZ',29,'Syntax:\nCONVERT_TZ(dt,from_tz,to_tz)\n\nCONVERT_TZ() converts a datetime value dt from the time zone given by\nfrom_tz to the time zone given by to_tz and returns the resulting\nvalue. Time zones are specified as described in\nhttp://dev.mysql.com/doc/refman/5.0/en/time-zone-support.html. This\nfunction returns NULL if the arguments are invalid.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT CONVERT_TZ(\'2004-01-01 12:00:00\',\'GMT\',\'MET\');\n        -> \'2004-01-01 13:00:00\'\nmysql> SELECT CONVERT_TZ(\'2004-01-01 12:00:00\',\'+00:00\',\'+10:00\');\n        -> \'2004-01-01 22:00:00\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (356,'TIME_TO_SEC',29,'Syntax:\nTIME_TO_SEC(time)\n\nReturns the time argument, converted to seconds.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT TIME_TO_SEC(\'22:23:00\');\n        -> 80580\nmysql> SELECT TIME_TO_SEC(\'00:39:38\');\n        -> 2378\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (357,'WEEKDAY',29,'Syntax:\nWEEKDAY(date)\n\nReturns the weekday index for date (0 = Monday, 1 = Tuesday, ... 6 =\nSunday).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT WEEKDAY(\'2008-02-03 22:23:00\');\n        -> 6\nmysql> SELECT WEEKDAY(\'2007-11-06\');\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (358,'EXPORT_SET',34,'Syntax:\nEXPORT_SET(bits,on,off[,separator[,number_of_bits]])\n\nReturns a string such that for every bit set in the value bits, you get\nan on string and for every bit not set in the value, you get an off\nstring. Bits in bits are examined from right to left (from low-order to\nhigh-order bits). Strings are added to the result from left to right,\nseparated by the separator string (the default being the comma\ncharacter \",\"). The number of bits examined is given by number_of_bits\n(defaults to 64).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT EXPORT_SET(5,\'Y\',\'N\',\',\',4);\n        -> \'Y,N,Y,N\'\nmysql> SELECT EXPORT_SET(6,\'1\',\'0\',\',\',10);\n        -> \'0,1,1,0,0,0,0,0,0,0\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (359,'TIME FUNCTION',29,'Syntax:\nTIME(expr)\n\nExtracts the time part of the time or datetime expression expr and\nreturns it as a string.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT TIME(\'2003-12-31 01:02:03\');\n        -> \'01:02:03\'\nmysql> SELECT TIME(\'2003-12-31 01:02:03.000123\');\n        -> \'01:02:03.000123\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (360,'DATE_ADD',29,'Syntax:\nDATE_ADD(date,INTERVAL expr unit), DATE_SUB(date,INTERVAL expr unit)\n\nThese functions perform date arithmetic. The date argument specifies\nthe starting date or datetime value. expr is an expression specifying\nthe interval value to be added or subtracted from the starting date.\nexpr is a string; it may start with a \"-\" for negative intervals. unit\nis a keyword indicating the units in which the expression should be\ninterpreted.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT \'2008-12-31 23:59:59\' + INTERVAL 1 SECOND;\n        -> \'2009-01-01 00:00:00\'\nmysql> SELECT INTERVAL 1 DAY + \'2008-12-31\';\n        -> \'2009-01-01\'\nmysql> SELECT \'2005-01-01\' - INTERVAL 1 SECOND;\n        -> \'2004-12-31 23:59:59\'\nmysql> SELECT DATE_ADD(\'2000-12-31 23:59:59\',\n    ->                 INTERVAL 1 SECOND);\n        -> \'2001-01-01 00:00:00\'\nmysql> SELECT DATE_ADD(\'2010-12-31 23:59:59\',\n    ->                 INTERVAL 1 DAY);\n        -> \'2011-01-01 23:59:59\'\nmysql> SELECT DATE_ADD(\'2100-12-31 23:59:59\',\n    ->                 INTERVAL \'1:1\' MINUTE_SECOND);\n        -> \'2101-01-01 00:01:00\'\nmysql> SELECT DATE_SUB(\'2005-01-01 00:00:00\',\n    ->                 INTERVAL \'1 1:1:1\' DAY_SECOND);\n        -> \'2004-12-30 22:58:59\'\nmysql> SELECT DATE_ADD(\'1900-01-01 00:00:00\',\n    ->                 INTERVAL \'-1 10\' DAY_HOUR);\n        -> \'1899-12-30 14:00:00\'\nmysql> SELECT DATE_SUB(\'1998-01-02\', INTERVAL 31 DAY);\n        -> \'1997-12-02\'\nmysql> SELECT DATE_ADD(\'1992-12-31 23:59:59.000002\',\n    ->            INTERVAL \'1.999999\' SECOND_MICROSECOND);\n        -> \'1993-01-01 00:00:01.000001\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (361,'CAST',34,'Syntax:\nCAST(expr AS type)\n\nThe CAST() function takes a value of one type and produce a value of\nanother type, similar to CONVERT(). See the description of CONVERT()\nfor more information.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/cast-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/cast-functions.html'),
 (362,'SOUNDS LIKE',34,'Syntax:\nexpr1 SOUNDS LIKE expr2\n\nThis is the same as SOUNDEX(expr1) = SOUNDEX(expr2).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (363,'PERIOD_DIFF',29,'Syntax:\nPERIOD_DIFF(P1,P2)\n\nReturns the number of months between periods P1 and P2. P1 and P2\nshould be in the format YYMM or YYYYMM. Note that the period arguments\nP1 and P2 are not date values.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT PERIOD_DIFF(200802,200703);\n        -> 11\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (364,'LIKE',34,'Syntax:\nexpr LIKE pat [ESCAPE \'escape_char\']\n\nPattern matching using SQL simple regular expression comparison.\nReturns 1 (TRUE) or 0 (FALSE). If either expr or pat is NULL, the\nresult is NULL.\n\nThe pattern need not be a literal string. For example, it can be\nspecified as a string expression or table column.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-comparison-functions.html\n\n','mysql> SELECT \'David!\' LIKE \'David_\';\n        -> 1\nmysql> SELECT \'David!\' LIKE \'%D%v%\';\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/string-comparison-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (365,'MULTIPOINT',22,'MultiPoint(pt1,pt2,...)\n\nConstructs a WKB MultiPoint value using WKB Point arguments. If any\nargument is not a WKB Point, the return value is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions'),
 (366,'>>',17,'Syntax:\n>>\n\nShifts a longlong (BIGINT) number to the right.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html\n\n','mysql> SELECT 4 >> 2;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html'),
 (367,'FETCH',21,'Syntax:\nFETCH cursor_name INTO var_name [, var_name] ...\n\nThis statement fetches the next row (if a row exists) using the\nspecified open cursor, and advances the cursor pointer.\n\nIf no more rows are available, a No Data condition occurs with SQLSTATE\nvalue 02000. To detect this condition, you can set up a handler for it\n(or for a NOT FOUND condition). An example is shown in\nhttp://dev.mysql.com/doc/refman/5.0/en/cursors.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/fetch.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/fetch.html'),
 (368,'AVG',15,'Syntax:\nAVG([DISTINCT] expr)\n\nReturns the average value of expr. The DISTINCT option can be used as\nof MySQL 5.0.3 to return the average of the distinct values of expr.\n\nAVG() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','mysql> SELECT student_name, AVG(test_score)\n    ->        FROM student\n    ->        GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (369,'TRUE FALSE',27,'The constants TRUE and FALSE evaluate to 1 and 0, respectively. The\nconstant names can be written in any lettercase.\n\nmysql> SELECT TRUE, true, FALSE, false;\n        -> 1, 1, 0, 0\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/boolean-values.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/boolean-values.html'),
 (370,'MBRWITHIN',5,'MBRWithin(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangle of g1\nis within the Minimum Bounding Rectangle of g2. This tests the opposite\nrelationship as MBRContains().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html\n\n','mysql> SET @g1 = GeomFromText(\'Polygon((0 0,0 3,3 3,3 0,0 0))\');\nmysql> SET @g2 = GeomFromText(\'Polygon((0 0,0 5,5 5,5 0,0 0))\');\nmysql> SELECT MBRWithin(@g1,@g2), MBRWithin(@g2,@g1);\n+--------------------+--------------------+\n| MBRWithin(@g1,@g2) | MBRWithin(@g2,@g1) |\n+--------------------+--------------------+\n|                  1 |                  0 |\n+--------------------+--------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/relations-on-geometry-mbr.html'),
 (371,'IN',16,'Syntax:\nexpr IN (value,...)\n\nReturns 1 if expr is equal to any of the values in the IN list, else\nreturns 0. If all values are constants, they are evaluated according to\nthe type of expr and sorted. The search for the item then is done using\na binary search. This means IN is very quick if the IN value list\nconsists entirely of constants. Otherwise, type conversion takes place\naccording to the rules described in\nhttp://dev.mysql.com/doc/refman/5.0/en/type-conversion.html, but\napplied to all the arguments.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 2 IN (0,3,5,7);\n        -> 0\nmysql> SELECT \'wefwf\' IN (\'wee\',\'wefwf\',\'weg\');\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html');
INSERT INTO `mysql`.`help_topic` VALUES  (372,'QUOTE',34,'Syntax:\nQUOTE(str)\n\nQuotes a string to produce a result that can be used as a properly\nescaped data value in an SQL statement. The string is returned enclosed\nby single quotes and with each instance of single quote (\"\'\"),\nbackslash (\"\\\"), ASCII NUL, and Control-Z preceded by a backslash. If\nthe argument is NULL, the return value is the word \"NULL\" without\nenclosing single quotes.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT QUOTE(\'Don\\\'t!\');\n        -> \'Don\\\'t!\'\nmysql> SELECT QUOTE(NULL);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (373,'SESSION_USER',14,'Syntax:\nSESSION_USER()\n\nSESSION_USER() is a synonym for USER().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (374,'HELP COMMAND',24,'Syntax:\nmysql> help search_string\n\nIf you provide an argument to the help command, mysql uses it as a\nsearch string to access server-side help from the contents of the MySQL\nReference Manual. The proper operation of this command requires that\nthe help tables in the mysql database be initialized with help topic\ninformation (see\nhttp://dev.mysql.com/doc/refman/5.0/en/server-side-help-support.html).\n\nIf there is no match for the search string, the search fails:\n\nmysql> help me\n\nNothing found\nPlease try to run \'help contents\' for a list of all accessible topics\n\nUse help contents to see a list of the help categories:\n\nmysql> help contents\nYou asked for help about help category: \"Contents\"\nFor more information, type \'help <item>\', where <item> is one of the\nfollowing categories:\n   Account Management\n   Administration\n   Data Definition\n   Data Manipulation\n   Data Types\n   Functions\n   Functions and Modifiers for Use with GROUP BY\n   Geographic Features\n   Language Structure\n   Storage Engines\n   Stored Routines\n   Table Maintenance\n   Transactions\n   Triggers\n\nIf the search string matches multiple items, mysql shows a list of\nmatching topics:\n\nmysql> help logs\nMany help items for your request exist.\nTo make a more specific request, please type \'help <item>\',\nwhere <item> is one of the following topics:\n   SHOW\n   SHOW BINARY LOGS\n   SHOW ENGINE\n   SHOW LOGS\n\nUse a topic as the search string to see the help entry for that topic:\n\nmysql> help show binary logs\nName: \'SHOW BINARY LOGS\'\nDescription:\nSyntax:\nSHOW BINARY LOGS\nSHOW MASTER LOGS\n\nLists the binary log files on the server. This statement is used as\npart of the procedure described in [purge-binary-logs], that shows how\nto determine which logs can be purged.\n\nmysql> SHOW BINARY LOGS;\n+---------------+-----------+\n| Log_name      | File_size |\n+---------------+-----------+\n| binlog.000015 |    724935 |\n| binlog.000016 |    733481 |\n+---------------+-----------+\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mysql-server-side-help.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/mysql-server-side-help.html'),
 (375,'QUARTER',29,'Syntax:\nQUARTER(date)\n\nReturns the quarter of the year for date, in the range 1 to 4.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT QUARTER(\'2008-04-01\');\n        -> 2\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (376,'POSITION',34,'Syntax:\nPOSITION(substr IN str)\n\nPOSITION(substr IN str) is a synonym for LOCATE(substr,str).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (377,'SHOW CREATE FUNCTION',25,'Syntax:\nSHOW CREATE FUNCTION func_name\n\nThis statement is similar to SHOW CREATE PROCEDURE but for stored\nfunctions. See [HELP SHOW CREATE PROCEDURE].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-create-function.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-create-function.html'),
 (378,'IS_USED_LOCK',13,'Syntax:\nIS_USED_LOCK(str)\n\nChecks whether the lock named str is in use (that is, locked). If so,\nit returns the connection identifier of the client that holds the lock.\nOtherwise, it returns NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (379,'POLYFROMTEXT',3,'PolyFromText(wkt[,srid]), PolygonFromText(wkt[,srid])\n\nConstructs a POLYGON value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (380,'DES_ENCRYPT',10,'Syntax:\nDES_ENCRYPT(str[,{key_num|key_str}])\n\nEncrypts the string with the given key using the Triple-DES algorithm.\n\nThis function works only if MySQL has been configured with SSL support.\nSee http://dev.mysql.com/doc/refman/5.0/en/secure-connections.html.\n\nThe encryption key to use is chosen based on the second argument to\nDES_ENCRYPT(), if one was given. With no argument, the first key from\nthe DES key file is used. With a key_num argument, the given key number\n(0-9) from the DES key file is used. With a key_str argument, the given\nkey string is used to encrypt str.\n\nThe key file can be specified with the --des-key-file server option.\n\nThe return string is a binary string where the first character is\nCHAR(128 | key_num). If an error occurs, DES_ENCRYPT() returns NULL.\n\nThe 128 is added to make it easier to recognize an encrypted key. If\nyou use a string key, key_num is 127.\n\nThe string length for the result is given by this formula:\n\nnew_len = orig_len + (8 - (orig_len % 8)) + 1\n\nEach line in the DES key file has the following format:\n\nkey_num des_key_str\n\nEach key_num value must be a number in the range from 0 to 9. Lines in\nthe file may be in any order. des_key_str is the string that is used to\nencrypt the message. There should be at least one space between the\nnumber and the key. The first key is the default key that is used if\nyou do not specify any key argument to DES_ENCRYPT().\n\nYou can tell MySQL to read new key values from the key file with the\nFLUSH DES_KEY_FILE statement. This requires the RELOAD privilege.\n\nOne benefit of having a set of default keys is that it gives\napplications a way to check for the existence of encrypted column\nvalues, without giving the end user the right to decrypt those values.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','mysql> SELECT customer_address FROM customer_table \n     > WHERE crypted_credit_card = DES_ENCRYPT(\'credit_card_number\');\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (381,'CEIL',4,'Syntax:\nCEIL(X)\n\nCEIL() is a synonym for CEILING().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (382,'LENGTH',34,'Syntax:\nLENGTH(str)\n\nReturns the length of the string str, measured in bytes. A multi-byte\ncharacter counts as multiple bytes. This means that for a string\ncontaining five two-byte characters, LENGTH() returns 10, whereas\nCHAR_LENGTH() returns 5.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT LENGTH(\'text\');\n        -> 4\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (383,'STR_TO_DATE',29,'Syntax:\nSTR_TO_DATE(str,format)\n\nThis is the inverse of the DATE_FORMAT() function. It takes a string\nstr and a format string format. STR_TO_DATE() returns a DATETIME value\nif the format string contains both date and time parts, or a DATE or\nTIME value if the string contains only date or time parts.\n\nThe date, time, or datetime values contained in str should be given in\nthe format indicated by format. For the specifiers that can be used in\nformat, see the DATE_FORMAT() function description. If str contains an\nillegal date, time, or datetime value, STR_TO_DATE() returns NULL.\nStarting from MySQL 5.0.3, an illegal value also produces a warning.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (384,'Y',9,'Y(p)\n\nReturns the Y-coordinate value for the point p as a double-precision\nnumber.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#point-property-functions\n\n','mysql> SET @pt = \'Point(56.7 53.34)\';\nmysql> SELECT Y(GeomFromText(@pt));\n+----------------------+\n| Y(GeomFromText(@pt)) |\n+----------------------+\n|                53.34 |\n+----------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#point-property-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (385,'SHOW INNODB STATUS',25,'Syntax:\nSHOW INNODB STATUS\n\nIn MySQL 5.0, this is a deprecated synonym for SHOW ENGINE INNODB\nSTATUS. See [HELP SHOW ENGINE].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-innodb-status.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-innodb-status.html'),
 (386,'CHECKSUM TABLE',18,'Syntax:\nCHECKSUM TABLE tbl_name [, tbl_name] ... [ QUICK | EXTENDED ]\n\nCHECKSUM TABLE reports a table checksum.\n\nWith QUICK, the live table checksum is reported if it is available, or\nNULL otherwise. This is very fast. A live checksum is enabled by\nspecifying the CHECKSUM=1 table option when you create the table;\ncurrently, this is supported only for MyISAM tables. See [HELP CREATE\nTABLE].\n\nWith EXTENDED, the entire table is read row by row and the checksum is\ncalculated. This can be very slow for large tables.\n\nIf neither QUICK nor EXTENDED is specified, MySQL returns a live\nchecksum if the table storage engine supports it and scans the table\notherwise.\n\nFor a non-existent table, CHECKSUM TABLE returns NULL and, as of MySQL\n5.0.3, generates a warning.\n\nThe checksum value depends on the table row format. If the row format\nchanges, the checksum also changes. For example, the storage format for\nVARCHAR changed between MySQL 4.1 and 5.0, so if a 4.1 table is\nupgraded to MySQL 5.0, the checksum value may change.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/checksum-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/checksum-table.html'),
 (387,'NUMINTERIORRINGS',2,'NumInteriorRings(poly)\n\nReturns the number of interior rings in the Polygon value poly.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#polygon-property-functions\n\n','mysql> SET @poly =\n    -> \'Polygon((0 0,0 3,3 3,3 0,0 0),(1 1,1 2,2 2,2 1,1 1))\';\nmysql> SELECT NumInteriorRings(GeomFromText(@poly));\n+---------------------------------------+\n| NumInteriorRings(GeomFromText(@poly)) |\n+---------------------------------------+\n|                                     1 |\n+---------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#polygon-property-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (388,'INTERIORRINGN',2,'InteriorRingN(poly,N)\n\nReturns the N-th interior ring for the Polygon value poly as a\nLineString. Rings are numbered beginning with 1.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#polygon-property-functions\n\n','mysql> SET @poly =\n    -> \'Polygon((0 0,0 3,3 3,3 0,0 0),(1 1,1 2,2 2,2 1,1 1))\';\nmysql> SELECT AsText(InteriorRingN(GeomFromText(@poly),1));\n+----------------------------------------------+\n| AsText(InteriorRingN(GeomFromText(@poly),1)) |\n+----------------------------------------------+\n| LINESTRING(1 1,1 2,2 2,2 1,1 1)              |\n+----------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#polygon-property-functions'),
 (389,'UTC_TIME',29,'Syntax:\nUTC_TIME, UTC_TIME()\n\nReturns the current UTC time as a value in \'HH:MM:SS\' or HHMMSS.uuuuuu\nformat, depending on whether the function is used in a string or\nnumeric context.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT UTC_TIME(), UTC_TIME() + 0;\n        -> \'18:07:53\', 180753.000000\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (390,'DROP FUNCTION',36,'The DROP FUNCTION statement is used to drop stored functions and\nuser-defined functions (UDFs):\n\no For information about dropping stored functions, see [HELP DROP\n  PROCEDURE].\n\no For information about dropping user-defined functions, see [HELP DROP\n  FUNCTION UDF].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-function.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-function.html');
INSERT INTO `mysql`.`help_topic` VALUES  (391,'STDDEV',15,'Syntax:\nSTDDEV(expr)\n\nReturns the population standard deviation of expr. This function is\nprovided for compatibility with Oracle. As of MySQL 5.0.3, the standard\nSQL function STDDEV_POP() can be used instead.\n\nThis function returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (392,'DATE_SUB',29,'Syntax:\nDATE_SUB(date,INTERVAL expr unit)\n\nSee the description for DATE_ADD().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (393,'PERIOD_ADD',29,'Syntax:\nPERIOD_ADD(P,N)\n\nAdds N months to period P (in the format YYMM or YYYYMM). Returns a\nvalue in the format YYYYMM. Note that the period argument P is not a\ndate value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT PERIOD_ADD(200801,2);\n        -> 200803\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (394,'|',17,'Syntax:\n|\n\nBitwise OR:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html\n\n','mysql> SELECT 29 | 15;\n        -> 31\n','http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (395,'GEOMFROMTEXT',3,'GeomFromText(wkt[,srid]), GeometryFromText(wkt[,srid])\n\nConstructs a geometry value of any type using its WKT representation\nand SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions'),
 (396,'RIGHT',34,'Syntax:\nRIGHT(str,len)\n\nReturns the rightmost len characters from the string str, or NULL if\nany argument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT RIGHT(\'foobarbar\', 4);\n        -> \'rbar\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (397,'DATEDIFF',29,'Syntax:\nDATEDIFF(expr1,expr2)\n\nDATEDIFF() returns expr1 - expr2 expressed as a value in days from one\ndate to the other. expr1 and expr2 are date or date-and-time\nexpressions. Only the date parts of the values are used in the\ncalculation.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT DATEDIFF(\'2007-12-31 23:59:59\',\'2007-12-30\');\n        -> 1\nmysql> SELECT DATEDIFF(\'2010-11-30 23:59:59\',\'2010-12-31\');\n        -> -31\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (398,'DROP PROCEDURE',36,'Syntax:\nDROP {PROCEDURE | FUNCTION} [IF EXISTS] sp_name\n\nThis statement is used to drop a stored procedure or function. That is,\nthe specified routine is removed from the server. As of MySQL 5.0.3,\nyou must have the ALTER ROUTINE privilege for the routine. (That\nprivilege is granted automatically to the routine creator.)\n\nThe IF EXISTS clause is a MySQL extension. It prevents an error from\noccurring if the procedure or function does not exist. A warning is\nproduced that can be viewed with SHOW WARNINGS.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/drop-procedure.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/drop-procedure.html');
INSERT INTO `mysql`.`help_topic` VALUES  (399,'CHECK TABLE',18,'Syntax:\nCHECK TABLE tbl_name [, tbl_name] ... [option] ...\n\noption = {FOR UPGRADE | QUICK | FAST | MEDIUM | EXTENDED | CHANGED}\n\nCHECK TABLE checks a table or tables for errors. CHECK TABLE works for\nMyISAM, InnoDB, and (as of MySQL 5.0.16) ARCHIVE tables. For MyISAM\ntables, the key statistics are updated as well.\n\nAs of MySQL 5.0.2, CHECK TABLE can also check views for problems, such\nas tables that are referenced in the view definition that no longer\nexist.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/check-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/check-table.html'),
 (400,'BIN',34,'Syntax:\nBIN(N)\n\nReturns a string representation of the binary value of N, where N is a\nlonglong (BIGINT) number. This is equivalent to CONV(N,10,2). Returns\nNULL if N is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT BIN(12);\n        -> \'1100\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (401,'DECLARE CURSOR',21,'Syntax:\nDECLARE cursor_name CURSOR FOR select_statement\n\nThis statement declares a cursor. Multiple cursors may be declared in a\nstored program, but each cursor in a given block must have a unique\nname.\n\nThe SELECT statement cannot have an INTO clause.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/declare-cursor.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/declare-cursor.html');
INSERT INTO `mysql`.`help_topic` VALUES  (402,'LOAD DATA',25,'Syntax:\nLOAD DATA [LOW_PRIORITY | CONCURRENT] [LOCAL] INFILE \'file_name\'\n    [REPLACE | IGNORE]\n    INTO TABLE tbl_name\n    [CHARACTER SET charset_name]\n    [{FIELDS | COLUMNS}\n        [TERMINATED BY \'string\']\n        [[OPTIONALLY] ENCLOSED BY \'char\']\n        [ESCAPED BY \'char\']\n    ]\n    [LINES\n        [STARTING BY \'string\']\n        [TERMINATED BY \'string\']\n    ]\n    [IGNORE number LINES]\n    [(col_name_or_user_var,...)]\n    [SET col_name = expr,...]\n\nThe LOAD DATA INFILE statement reads rows from a text file into a table\nat a very high speed. The filename must be given as a literal string.\n\nLOAD DATA INFILE is the complement of SELECT ... INTO OUTFILE. (See\nhttp://dev.mysql.com/doc/refman/5.0/en/select.html.) To write data from\na table to a file, use SELECT ... INTO OUTFILE. To read the file back\ninto a table, use LOAD DATA INFILE. The syntax of the FIELDS and LINES\nclauses is the same for both statements. Both clauses are optional, but\nFIELDS must precede LINES if both are specified.\n\nFor more information about the efficiency of INSERT versus LOAD DATA\nINFILE and speeding up LOAD DATA INFILE, see\nhttp://dev.mysql.com/doc/refman/5.0/en/insert-speed.html.\n\nThe character set indicated by the character_set_database system\nvariable is used to interpret the information in the file. SET NAMES\nand the setting of character_set_client do not affect interpretation of\ninput. If the contents of the input file use a character set that\ndiffers from the default, it is usually preferable to specify the\ncharacter set of the file by using the CHARACTER SET clause, which is\navailable as of MySQL 5.0.38.\n\nLOAD DATA INFILE interprets all fields in the file as having the same\ncharacter set, regardless of the data types of the columns into which\nfield values are loaded. For proper interpretation of file contents,\nyou must ensure that it was written with the correct character set. For\nexample, if you write a data file with mysqldump -T or by issuing a\nSELECT ... INTO OUTFILE statement in mysql, be sure to use a\n--default-character-set option with mysqldump or mysql so that output\nis written in the character set to be used when the file is loaded with\nLOAD DATA INFILE.\n\nNote that it is currently not possible to load data files that use the\nucs2 character set.\n\nAs of MySQL 5.0.19, the character_set_filesystem system variable\ncontrols the interpretation of the filename.\n\nYou can also load data files by using the mysqlimport utility; it\noperates by sending a LOAD DATA INFILE statement to the server. The\n--local option causes mysqlimport to read data files from the client\nhost. You can specify the --compress option to get better performance\nover slow networks if the client and server support the compressed\nprotocol. See http://dev.mysql.com/doc/refman/5.0/en/mysqlimport.html.\n\nIf you use LOW_PRIORITY, execution of the LOAD DATA statement is\ndelayed until no other clients are reading from the table. This affects\nonly storage engines that use only table-level locking (MyISAM, MEMORY,\nMERGE).\n\nIf you specify CONCURRENT with a MyISAM table that satisfies the\ncondition for concurrent inserts (that is, it contains no free blocks\nin the middle), other threads can retrieve data from the table while\nLOAD DATA is executing. Using this option affects the performance of\nLOAD DATA a bit, even if no other thread is using the table at the same\ntime.\n\nCONCURRENT is not replicated. See\nhttp://dev.mysql.com/doc/refman/5.0/en/replication-features-load.html,\nfor more information.\n\nThe LOCAL keyword, if specified, is interpreted with respect to the\nclient end of the connection:\n\no If LOCAL is specified, the file is read by the client program on the\n  client host and sent to the server. The file can be given as a full\n  pathname to specify its exact location. If given as a relative\n  pathname, the name is interpreted relative to the directory in which\n  the client program was started.\n\no If LOCAL is not specified, the file must be located on the server\n  host and is read directly by the server. The server uses the\n  following rules to locate the file:\n\n  o If the filename is an absolute pathname, the server uses it as\n    given.\n\n  o If the filename is a relative pathname with one or more leading\n    components, the server searches for the file relative to the\n    server\'s data directory.\n\n  o If a filename with no leading components is given, the server looks\n    for the file in the database directory of the default database.\n\nNote that, in the non-LOCAL case, these rules mean that a file named as\n./myfile.txt is read from the server\'s data directory, whereas the file\nnamed as myfile.txt is read from the database directory of the default\ndatabase. For example, if db1 is the default database, the following\nLOAD DATA statement reads the file data.txt from the database directory\nfor db1, even though the statement explicitly loads the file into a\ntable in the db2 database:\n\nLOAD DATA INFILE \'data.txt\' INTO TABLE db2.my_table;\n\nWindows pathnames are specified using forward slashes rather than\nbackslashes. If you do use backslashes, you must double them.\n\nFor security reasons, when reading text files located on the server,\nthe files must either reside in the database directory or be readable\nby all. Also, to use LOAD DATA INFILE on server files, you must have\nthe FILE privilege. See\nhttp://dev.mysql.com/doc/refman/5.0/en/privileges-provided.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/load-data.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/load-data.html'),
 (403,'MULTILINESTRING',22,'MultiLineString(ls1,ls2,...)\n\nConstructs a WKB MultiLineString value using WKB LineString arguments.\nIf any argument is not a WKB LineString, the return value is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-mysql-specific-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (404,'LOCALTIME',29,'Syntax:\nLOCALTIME, LOCALTIME()\n\nLOCALTIME and LOCALTIME() are synonyms for NOW().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (405,'MPOINTFROMTEXT',3,'MPointFromText(wkt[,srid]), MultiPointFromText(wkt[,srid])\n\nConstructs a MULTIPOINT value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkt-functions'),
 (406,'BLOB',19,'BLOB[(M)]\n\nA BLOB column with a maximum length of 65,535 (216 - 1) bytes. Each\nBLOB value is stored using a two-byte length prefix that indicates the\nnumber of bytes in the value.\n\nAn optional length M can be given for this type. If this is done, MySQL\ncreates the column as the smallest BLOB type large enough to hold\nvalues M bytes long.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (407,'SHA1',10,'Syntax:\nSHA1(str), SHA(str)\n\nCalculates an SHA-1 160-bit checksum for the string, as described in\nRFC 3174 (Secure Hash Algorithm). The value is returned as a binary\nstring of 40 hex digits, or NULL if the argument was NULL. One of the\npossible uses for this function is as a hash key. You can also use it\nas a cryptographic function for storing passwords. SHA() is synonymous\nwith SHA1().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','mysql> SELECT SHA1(\'abc\');\n        -> \'a9993e364706816aba3e25717850c26c9cd0d89d\'\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (408,'SUBSTR',34,'Syntax:\nSUBSTR(str,pos), SUBSTR(str FROM pos), SUBSTR(str,pos,len), SUBSTR(str\nFROM pos FOR len)\n\nSUBSTR() is a synonym for SUBSTRING().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (409,'PASSWORD',10,'Syntax:\nPASSWORD(str)\n\nCalculates and returns a password string from the plaintext password\nstr and returns a binary string, or NULL if the argument was NULL. This\nis the function that is used for encrypting MySQL passwords for storage\nin the Password column of the user grant table.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','mysql> SELECT PASSWORD(\'badpwd\');\n        -> \'*AAB3E285149C0135D51A520E1940DD3263DC008C\'\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (410,'CHAR',19,'[NATIONAL] CHAR[(M)] [CHARACTER SET charset_name] [COLLATE\ncollation_name]\n\nA fixed-length string that is always right-padded with spaces to the\nspecified length when stored. M represents the column length in\ncharacters. The range of M is 0 to 255. If M is omitted, the length is\n1.\n\n*Note*: Trailing spaces are removed when CHAR values are retrieved.\n\nBefore MySQL 5.0.3, a CHAR column with a length specification greater\nthan 255 is converted to the smallest TEXT type that can hold values of\nthe given length. For example, CHAR(500) is converted to TEXT, and\nCHAR(200000) is converted to MEDIUMTEXT. However, this conversion\ncauses the column to become a variable-length column, and also affects\ntrailing-space removal.\n\nIn MySQL 5.0.3 and later, a CHAR length greater than 255 is illegal and\nfails with an error:\n\nmysql> CREATE TABLE c1 (col1 INT, col2 CHAR(500));\nERROR 1074 (42000): Column length too big for column \'col\' (max = 255);\nuse BLOB or TEXT instead\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (411,'UTC_DATE',29,'Syntax:\nUTC_DATE, UTC_DATE()\n\nReturns the current UTC date as a value in \'YYYY-MM-DD\' or YYYYMMDD\nformat, depending on whether the function is used in a string or\nnumeric context.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT UTC_DATE(), UTC_DATE() + 0;\n        -> \'2003-08-14\', 20030814\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (412,'DIMENSION',33,'Dimension(g)\n\nReturns the inherent dimension of the geometry value g. The result can\nbe -1, 0, 1, or 2. The meaning of these values is given in\nhttp://dev.mysql.com/doc/refman/5.0/en/gis-class-geometry.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions\n\n','mysql> SELECT Dimension(GeomFromText(\'LineString(1 1,2 2)\'));\n+------------------------------------------------+\n| Dimension(GeomFromText(\'LineString(1 1,2 2)\')) |\n+------------------------------------------------+\n|                                              1 |\n+------------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions'),
 (413,'COUNT DISTINCT',15,'Syntax:\nCOUNT(DISTINCT expr,[expr...])\n\nReturns a count of the number of different non-NULL values.\n\nCOUNT(DISTINCT) returns 0 if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html\n\n','mysql> SELECT COUNT(DISTINCT results) FROM student;\n','http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html'),
 (414,'BIT',19,'BIT[(M)]\n\nA bit-field type. M indicates the number of bits per value, from 1 to\n64. The default is 1 if M is omitted.\n\nThis data type was added in MySQL 5.0.3 for MyISAM, and extended in\n5.0.5 to MEMORY, InnoDB, BDB, and NDBCLUSTER. Before 5.0.3, BIT is a\nsynonym for TINYINT(1).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (415,'EQUALS',28,'Equals(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 is spatially equal to g2.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/functions-that-test-spatial-relationships-between-geometries.html'),
 (416,'SHOW CREATE VIEW',25,'Syntax:\nSHOW CREATE VIEW view_name\n\nThis statement shows a CREATE VIEW statement that creates the given\nview.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-create-view.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-create-view.html'),
 (417,'INTERVAL',16,'Syntax:\nINTERVAL(N,N1,N2,N3,...)\n\nReturns 0 if N < N1, 1 if N < N2 and so on or -1 if N is NULL. All\narguments are treated as integers. It is required that N1 < N2 < N3 <\n... < Nn for this function to work correctly. This is because a binary\nsearch is used (very fast).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT INTERVAL(23, 1, 15, 17, 30, 44, 200);\n        -> 3\nmysql> SELECT INTERVAL(10, 1, 10, 100, 1000);\n        -> 2\nmysql> SELECT INTERVAL(22, 23, 30, 44, 200);\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (418,'FROM_DAYS',29,'Syntax:\nFROM_DAYS(N)\n\nGiven a day number N, returns a DATE value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT FROM_DAYS(730669);\n        -> \'2007-07-03\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (419,'ALTER PROCEDURE',36,'Syntax:\nALTER PROCEDURE proc_name [characteristic ...]\n\ncharacteristic:\n    { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }\n  | SQL SECURITY { DEFINER | INVOKER }\n  | COMMENT \'string\'\n\nThis statement can be used to change the characteristics of a stored\nprocedure. More than one change may be specified in an ALTER PROCEDURE\nstatement. However, you cannot change the parameters or body of a\nstored procedure using this statement; to make such changes, you must\ndrop and re-create the procedure using DROP PROCEDURE and CREATE\nPROCEDURE.\n\nAs of MySQL 5.0.3, you must have the ALTER ROUTINE privilege for the\nprocedure. (That privilege is granted automatically to the procedure\ncreator.)\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/alter-procedure.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/alter-procedure.html'),
 (420,'BIT_COUNT',17,'Syntax:\nBIT_COUNT(N)\n\nReturns the number of bits that are set in the argument N.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html\n\n','mysql> SELECT BIT_COUNT(29), BIT_COUNT(b\'101010\');\n        -> 4, 3\n','http://dev.mysql.com/doc/refman/5.0/en/bit-functions.html'),
 (421,'OCTET_LENGTH',34,'Syntax:\nOCTET_LENGTH(str)\n\nOCTET_LENGTH() is a synonym for LENGTH().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (422,'UTC_TIMESTAMP',29,'Syntax:\nUTC_TIMESTAMP, UTC_TIMESTAMP()\n\nReturns the current UTC date and time as a value in \'YYYY-MM-DD\nHH:MM:SS\' or YYYYMMDDHHMMSS.uuuuuu format, depending on whether the\nfunction is used in a string or numeric context.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT UTC_TIMESTAMP(), UTC_TIMESTAMP() + 0;\n        -> \'2003-08-14 18:08:04\', 20030814180804.000000\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (423,'AES_ENCRYPT',10,'Syntax:\nAES_ENCRYPT(str,key_str)\n\nAES_ENCRYPT() and AES_DECRYPT() allow encryption and decryption of data\nusing the official AES (Advanced Encryption Standard) algorithm,\npreviously known as \"Rijndael.\" Encoding with a 128-bit key length is\nused, but you can extend it up to 256 bits by modifying the source. We\nchose 128 bits because it is much faster and it is secure enough for\nmost purposes.\n\nAES_ENCRYPT() encrypts a string and returns a binary string.\nAES_DECRYPT() decrypts the encrypted string and returns the original\nstring. The input arguments may be any length. If either argument is\nNULL, the result of this function is also NULL.\n\nBecause AES is a block-level algorithm, padding is used to encode\nuneven length strings and so the result string length may be calculated\nusing this formula:\n\n16 x (trunc(string_length / 16) + 1)\n\nIf AES_DECRYPT() detects invalid data or incorrect padding, it returns\nNULL. However, it is possible for AES_DECRYPT() to return a non-NULL\nvalue (possibly garbage) if the input data or the key is invalid.\n\nYou can use the AES functions to store data in an encrypted form by\nmodifying your queries:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','INSERT INTO t VALUES (1,AES_ENCRYPT(\'text\',\'password\'));\n','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html'),
 (424,'+',4,'Syntax:\n+\n\nAddition:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html\n\n','mysql> SELECT 3+5;\n        -> 8\n','http://dev.mysql.com/doc/refman/5.0/en/arithmetic-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (425,'INET_NTOA',13,'Syntax:\nINET_NTOA(expr)\n\nGiven a numeric network address in network byte order (4 or 8 byte),\nreturns the dotted-quad representation of the address as a string.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html\n\n','mysql> SELECT INET_NTOA(3520061480);\n        -> \'209.207.224.40\'\n','http://dev.mysql.com/doc/refman/5.0/en/miscellaneous-functions.html'),
 (426,'ACOS',4,'Syntax:\nACOS(X)\n\nReturns the arc cosine of X, that is, the value whose cosine is X.\nReturns NULL if X is not in the range -1 to 1.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT ACOS(1);\n        -> 0\nmysql> SELECT ACOS(1.0001);\n        -> NULL\nmysql> SELECT ACOS(0);\n        -> 1.5707963267949\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (427,'ISOLATION',7,'Syntax:\nSET [GLOBAL | SESSION] TRANSACTION ISOLATION LEVEL\n  {\n       READ UNCOMMITTED\n     | READ COMMITTED\n     | REPEATABLE READ\n     | SERIALIZABLE\n   }\n\nThis statement sets the transaction isolation level globally, for the\ncurrent session, or for the next transaction:\n\no With the GLOBAL keyword, the statement sets the default transaction\n  level globally for all subsequent sessions. Existing sessions are\n  unaffected.\n\no With the SESSION keyword, the statement sets the default transaction\n  level for all subsequent transactions performed within the current\n  session.\n\no Without any SESSION or GLOBAL keyword, the statement sets the\n  isolation level for the next (not started) transaction performed\n  within the current session.\n\nA change to the global default isolation level requires the SUPER\nprivilege. Any session is free to change its session isolation level\n(even in the middle of a transaction), or the isolation level for its\nnext transaction.\n\nTo set the global default isolation level at server startup, use the\n--transaction-isolation=level option to mysqld on the command line or\nin an option file. Values of level for this option use dashes rather\nthan spaces, so the allowable values are READ-UNCOMMITTED,\nREAD-COMMITTED, REPEATABLE-READ, or SERIALIZABLE. For example, to set\nthe default isolation level to REPEATABLE READ, use these lines in the\n[mysqld] section of an option file:\n\n[mysqld]\ntransaction-isolation = REPEATABLE-READ\n\nTo determine the global and session transaction isolation levels at\nruntime, check the value of the tx_isolation system variable:\n\nSELECT @@GLOBAL.tx_isolation, @@tx_isolation;\n\nInnoDB supports each of the translation isolation levels described here\nusing different locking strategies. The default level is REPEATABLE\nREAD. For additional information about InnoDB record-level locks and\nhow it uses them to execute various types of statements, see\nhttp://dev.mysql.com/doc/refman/5.0/en/innodb-record-level-locks.html,\nand http://dev.mysql.com/doc/refman/5.0/en/innodb-locks-set.html.\n\nThe following list describes how MySQL supports the different\ntransaction levels:\n\no READ UNCOMMITTED\n\n  SELECT statements are performed in a non-locking fashion, but a\n  possible earlier version of a row might be used. Thus, using this\n  isolation level, such reads are not consistent. This is also called a\n  \"dirty read.\" Otherwise, this isolation level works like READ\n  COMMITTED.\n\no READ COMMITTED\n\n  A somewhat Oracle-like isolation level with respect to consistent\n  (non-locking) reads: Each consistent read, even within the same\n  transaction, sets and reads its own fresh snapshot. See\n  http://dev.mysql.com/doc/refman/5.0/en/innodb-consistent-read.html.\n\n  For locking reads (SELECT with FOR UPDATE or LOCK IN SHARE MODE),\n  InnoDB locks only index records, not the gaps before them, and thus\n  allows the free insertion of new records next to locked records. For\n  UPDATE and DELETE statements, locking depends on whether the\n  statement uses a unique index with a unique search condition (such as\n  WHERE id = 100), or a range-type search condition (such as WHERE id >\n  100). For a unique index with a unique search condition, InnoDB locks\n  only the index record found, not the gap before it. For range-type\n  searches, InnoDB locks the index range scanned, using gap locks or\n  next-key (gap plus index-record) locks to block insertions by other\n  sessions into the gaps covered by the range. This is necessary\n  because \"phantom rows\" must be blocked for MySQL replication and\n  recovery to work.\n\no REPEATABLE READ\n\n  This is the default isolation level for InnoDB. For consistent reads,\n  there is an important difference from the READ COMMITTED isolation\n  level: All consistent reads within the same transaction read the\n  snapshot established by the first read. This convention means that if\n  you issue several plain (non-locking) SELECT statements within the\n  same transaction, these SELECT statements are consistent also with\n  respect to each other. See\n  http://dev.mysql.com/doc/refman/5.0/en/innodb-consistent-read.html.\n\n  For locking reads (SELECT with FOR UPDATE or LOCK IN SHARE MODE),\n  UPDATE, and DELETE statements, locking depends on whether the\n  statement uses a unique index with a unique search condition, or a\n  range-type search condition. For a unique index with a unique search\n  condition, InnoDB locks only the index record found, not the gap\n  before it. For other search conditions, InnoDB locks the index range\n  scanned, using gap locks or next-key (gap plus index-record) locks to\n  block insertions by other sessions into the gaps covered by the\n  range.\n\no SERIALIZABLE\n\n  This level is like REPEATABLE READ, but InnoDB implicitly converts\n  all plain SELECT statements to SELECT ... LOCK IN SHARE MODE if\n  autocommit is disabled. If autocommit is enabled, the SELECT is its\n  own transaction. It therefore is known to be read only and can be\n  serialized if performed as a consistent (non-locking) read and need\n  not block for other transactions. (This means that to force a plain\n  SELECT to block if other transactions have modified the selected\n  rows, you should disable autocommit.)\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/set-transaction.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/set-transaction.html'),
 (428,'CEILING',4,'Syntax:\nCEILING(X)\n\nReturns the smallest integer value not less than X.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT CEILING(1.23);\n        -> 2\nmysql> SELECT CEILING(-1.23);\n        -> -1\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (429,'SIN',4,'Syntax:\nSIN(X)\n\nReturns the sine of X, where X is given in radians.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT SIN(PI());\n        -> 1.2246063538224e-16\nmysql> SELECT ROUND(SIN(PI()));\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (430,'DAYOFWEEK',29,'Syntax:\nDAYOFWEEK(date)\n\nReturns the weekday index for date (1 = Sunday, 2 = Monday, ..., 7 =\nSaturday). These index values correspond to the ODBC standard.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT DAYOFWEEK(\'2007-02-03\');\n        -> 7\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (431,'SHOW PROCESSLIST',25,'Syntax:\nSHOW [FULL] PROCESSLIST\n\nSHOW PROCESSLIST shows you which threads are running. You can also get\nthis information using the mysqladmin processlist command. If you have\nthe PROCESS privilege, you can see all threads. Otherwise, you can see\nonly your own threads (that is, threads associated with the MySQL\naccount that you are using). If you do not use the FULL keyword, only\nthe first 100 characters of each statement are shown in the Info field.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-processlist.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-processlist.html'),
 (432,'LINEFROMWKB',30,'LineFromWKB(wkb[,srid]), LineStringFromWKB(wkb[,srid])\n\nConstructs a LINESTRING value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (433,'GEOMETRYTYPE',33,'GeometryType(g)\n\nReturns as a string the name of the geometry type of which the geometry\ninstance g is a member. The name corresponds to one of the instantiable\nGeometry subclasses.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions\n\n','mysql> SELECT GeometryType(GeomFromText(\'POINT(1 1)\'));\n+------------------------------------------+\n| GeometryType(GeomFromText(\'POINT(1 1)\')) |\n+------------------------------------------+\n| POINT                                    |\n+------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#general-geometry-property-functions'),
 (434,'CREATE VIEW',36,'Syntax:\nCREATE\n    [OR REPLACE]\n    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]\n    [DEFINER = { user | CURRENT_USER }]\n    [SQL SECURITY { DEFINER | INVOKER }]\n    VIEW view_name [(column_list)]\n    AS select_statement\n    [WITH [CASCADED | LOCAL] CHECK OPTION]\n\nThe CREATE VIEW statement creates a new view, or replaces an existing\none if the OR REPLACE clause is given. This statement was added in\nMySQL 5.0.1. If the view does not exist, CREATE OR REPLACE VIEW is the\nsame as CREATE VIEW. If the view does exist, CREATE OR REPLACE VIEW is\nthe same as ALTER VIEW.\n\nThe select_statement is a SELECT statement that provides the definition\nof the view. (When you select from the view, you select in effect using\nthe SELECT statement.) select_statement can select from base tables or\nother views.\n\nThe view definition is \"frozen\" at creation time, so changes to the\nunderlying tables afterward do not affect the view definition. For\nexample, if a view is defined as SELECT * on a table, new columns added\nto the table later do not become part of the view.\n\nThe ALGORITHM clause affects how MySQL processes the view. The DEFINER\nand SQL SECURITY clauses specify the security context to be used when\nchecking access privileges at view invocation time. The WITH CHECK\nOPTION clause can be given to constrain inserts or updates to rows in\ntables referenced by the view. These clauses are described later in\nthis section.\n\nThe CREATE VIEW statement requires the CREATE VIEW privilege for the\nview, and some privilege for each column selected by the SELECT\nstatement. For columns used elsewhere in the SELECT statement you must\nhave the SELECT privilege. If the OR REPLACE clause is present, you\nmust also have the DROP privilege for the view.\n\nA view belongs to a database. By default, a new view is created in the\ndefault database. To create the view explicitly in a given database,\nspecify the name as db_name.view_name when you create it.\n\nmysql> CREATE VIEW test.v AS SELECT * FROM t;\n\nBase tables and views share the same namespace within a database, so a\ndatabase cannot contain a base table and a view that have the same\nname.\n\nViews must have unique column names with no duplicates, just like base\ntables. By default, the names of the columns retrieved by the SELECT\nstatement are used for the view column names. To define explicit names\nfor the view columns, the optional column_list clause can be given as a\nlist of comma-separated identifiers. The number of names in column_list\nmust be the same as the number of columns retrieved by the SELECT\nstatement.\n\n*Note*: When you modify an existing view, the current view definition\nis backed up and saved. It is stored in that table\'s database\ndirectory, in a subdirectory named arc. The backup file for a view v is\nnamed v.frm-00001. If you alter the view again, the next backup is\nnamed v.frm-00002. The three latest view backup definitions are stored.\nBacked up view definitions are not preserved by mysqldump, or any other\nsuch programs, but you can retain them using a file copy operation.\nHowever, they are not needed for anything but to provide you with a\nbackup of your previous view definition. It is safe to remove these\nbackup definitions, but only while mysqld is not running. If you delete\nthe arc subdirectory or its files while mysqld is running, you will\nreceive an error the next time you try to alter the view: mysql> ALTER\nVIEW v AS SELECT * FROM t; ERROR 6 (HY000): Error on delete of\n\'.\\test\\arc/v.frm-0004\' (Errcode: 2)\n\nColumns retrieved by the SELECT statement can be simple references to\ntable columns. They can also be expressions that use functions,\nconstant values, operators, and so forth.\n\nUnqualified table or view names in the SELECT statement are interpreted\nwith respect to the default database. A view can refer to tables or\nviews in other databases by qualifying the table or view name with the\nproper database name.\n\nA view can be created from many kinds of SELECT statements. It can\nrefer to base tables or other views. It can use joins, UNION, and\nsubqueries. The SELECT need not even refer to any tables. The following\nexample defines a view that selects two columns from another table, as\nwell as an expression calculated from those columns:\n\nmysql> CREATE TABLE t (qty INT, price INT);\nmysql> INSERT INTO t VALUES(3, 50);\nmysql> CREATE VIEW v AS SELECT qty, price, qty*price AS value FROM t;\nmysql> SELECT * FROM v;\n+------+-------+-------+\n| qty  | price | value |\n+------+-------+-------+\n|    3 |    50 |   150 |\n+------+-------+-------+\n\nA view definition is subject to the following restrictions:\n\no The SELECT statement cannot contain a subquery in the FROM clause.\n\no The SELECT statement cannot refer to system or user variables.\n\no Within a stored program, the definition cannot refer to program\n  parameters or local variables.\n\no The SELECT statement cannot refer to prepared statement parameters.\n\no Any table or view referred to in the definition must exist. However,\n  after a view has been created, it is possible to drop a table or view\n  that the definition refers to. In this case, use of the view results\n  in an error. To check a view definition for problems of this kind,\n  use the CHECK TABLE statement.\n\no The definition cannot refer to a TEMPORARY table, and you cannot\n  create a TEMPORARY view.\n\no Any tables named in the view definition must exist at definition\n  time.\n\no You cannot associate a trigger with a view.\n\nORDER BY is allowed in a view definition, but it is ignored if you\nselect from a view using a statement that has its own ORDER BY.\n\nFor other options or clauses in the definition, they are added to the\noptions or clauses of the statement that references the view, but the\neffect is undefined. For example, if a view definition includes a LIMIT\nclause, and you select from the view using a statement that has its own\nLIMIT clause, it is undefined which limit applies. This same principle\napplies to options such as ALL, DISTINCT, or SQL_SMALL_RESULT that\nfollow the SELECT keyword, and to clauses such as INTO, FOR UPDATE,\nLOCK IN SHARE MODE, and PROCEDURE.\n\nIf you create a view and then change the query processing environment\nby changing system variables, that may affect the results that you get\nfrom the view:\n\nmysql> CREATE VIEW v (mycol) AS SELECT \'abc\';\nQuery OK, 0 rows affected (0.01 sec)\n\nmysql> SET sql_mode = \'\';\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT \"mycol\" FROM v;\n+-------+\n| mycol |\n+-------+\n| mycol | \n+-------+\n1 row in set (0.01 sec)\n\nmysql> SET sql_mode = \'ANSI_QUOTES\';\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT \"mycol\" FROM v;\n+-------+\n| mycol |\n+-------+\n| abc   | \n+-------+\n1 row in set (0.00 sec)\n\nThe DEFINER and SQL SECURITY clauses determine which MySQL account to\nuse when checking access privileges for the view when a statement is\nexecuted that references the view. They were addded in MySQL 5.0.13,\nbut have no effect until MySQL 5.0.16. The legal SQL SECURITY\ncharacteristic values are DEFINER and INVOKER. These indicate that the\nrequired privileges must be held by the user who defined or invoked the\nview, respectively. The default SQL SECURITY value is DEFINER.\n\nIf a user value is given for the DEFINER clause, it should be a MySQL\naccount in \'user_name\'@\'host_name\' format (the same format used in the\nGRANT statement). The user_name and host_name values both are required.\nThe definer can also be given as CURRENT_USER or CURRENT_USER(). The\ndefault DEFINER value is the user who executes the CREATE VIEW\nstatement. This is the same as specifying DEFINER = CURRENT_USER\nexplicitly.\n\nIf you specify the DEFINER clause, these rules determine the legal\nDEFINER user values:\n\no If you do not have the SUPER privilege, the only legal user value is\n  your own account, either specified literally or by using\n  CURRENT_USER. You cannot set the definer to some other account.\n\no If you have the SUPER privilege, you can specify any syntactically\n  legal account name. If the account does not actually exist, a warning\n  is generated.\n\no If the SQL SECURITY value is DEFINER but the definer account does not\n  exist when the view is referenced, an error occurs.\n\nWithin a view definition, CURRENT_USER returns the view\'s DEFINER value\nby default as of MySQL 5.0.24. For older versions, and for views\ndefined with the SQL SECURITY INVOKER characteristic, CURRENT_USER\nreturns the account for the view\'s invoker. For information about user\nauditing within views, see\nhttp://dev.mysql.com/doc/refman/5.0/en/account-activity-auditing.html.\n\nWithin a stored routine that is defined with the SQL SECURITY DEFINER\ncharacteristic, CURRENT_USER returns the routine\'s DEFINER value. This\nalso affects a view defined within such a program, if the view\ndefinition contains a DEFINER value of CURRENT_USER.\n\nAs of MySQL 5.0.16 (when the DEFINER and SQL SECURITY clauses were\nimplemented), view privileges are checked like this:\n\no At view definition time, the view creator must have the privileges\n  needed to use the top-level objects accessed by the view. For\n  example, if the view definition refers to table columns, the creator\n  must have privileges for the columns, as described previously. If the\n  definition refers to a stored function, only the privileges needed to\n  invoke the function can be checked. The privileges required when the\n  function runs can be checked only as it executes: For different\n  invocations of the function, different execution paths within the\n  function might be taken.\n\no When a view is referenced, privileges for objects accessed by the\n  view are checked against the privileges held by the view creator or\n  invoker, depending on whether the SQL SECURITY characteristic is\n  DEFINER or INVOKER, respectively.\n\no If reference to a view causes execution of a stored function,\n  privilege checking for statements executed within the function depend\n  on whether the function is defined with a SQL SECURITY characteristic\n  of DEFINER or INVOKER. If the security characteristic is DEFINER, the\n  function runs with the privileges of its creator. If the\n  characteristic is INVOKER, the function runs with the privileges\n  determined by the view\'s SQL SECURITY characteristic.\n\nPrior to MySQL 5.0.16 (before the DEFINER and SQL SECURITY clauses were\nimplemented), privileges required for objects used in a view are\nchecked at view creation time.\n\nExample: A view might depend on a stored function, and that function\nmight invoke other stored routines. For example, the following view\ninvokes a stored function f():\n\nCREATE VIEW v AS SELECT * FROM t WHERE t.id = f(t.name);\n\nSuppose that f() contains a statement such as this:\n\nIF name IS NULL then\n  CALL p1();\nELSE\n  CALL p2();\nEND IF;\n\nThe privileges required for executing statements within f() need to be\nchecked when f() executes. This might mean that privileges are needed\nfor p1() or p2(), depending on the execution path within f(). Those\nprivileges must be checked at runtime, and the user who must possess\nthe privileges is determined by the SQL SECURITY values of the view v\nand the function f().\n\nThe DEFINER and SQL SECURITY clauses for views are extensions to\nstandard SQL. In standard SQL, views are handled using the rules for\nSQL SECURITY INVOKER.\n\nIf you invoke a view that was created before MySQL 5.0.13, it is\ntreated as though it was created with a SQL SECURITY DEFINER clause and\nwith a DEFINER value that is the same as your account. However, because\nthe actual definer is unknown, MySQL issues a warning. To make the\nwarning go away, it is sufficient to re-create the view so that the\nview definition includes a DEFINER clause.\n\nThe optional ALGORITHM clause is a MySQL extension to standard SQL. It\naffects how MySQL processes the view. ALGORITHM takes three values:\nMERGE, TEMPTABLE, or UNDEFINED. The default algorithm is UNDEFINED if\nno ALGORITHM clause is present. For more information, see\nhttp://dev.mysql.com/doc/refman/5.0/en/view-algorithms.html.\n\nSome views are updatable. That is, you can use them in statements such\nas UPDATE, DELETE, or INSERT to update the contents of the underlying\ntable. For a view to be updatable, there must be a one-to-one\nrelationship between the rows in the view and the rows in the\nunderlying table. There are also certain other constructs that make a\nview non-updatable.\n\nThe WITH CHECK OPTION clause can be given for an updatable view to\nprevent inserts or updates to rows except those for which the WHERE\nclause in the select_statement is true. The WITH CHECK OPTION clause\nwas implemented in MySQL 5.0.2.\n\nIn a WITH CHECK OPTION clause for an updatable view, the LOCAL and\nCASCADED keywords determine the scope of check testing when the view is\ndefined in terms of another view. The LOCAL keyword restricts the CHECK\nOPTION only to the view being defined. CASCADED causes the checks for\nunderlying views to be evaluated as well. When neither keyword is\ngiven, the default is CASCADED.\n\nFor more information about updatable views and the WITH CHECK OPTION\nclause, see\nhttp://dev.mysql.com/doc/refman/5.0/en/view-updatability.html.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-view.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/create-view.html'),
 (435,'TRIM',34,'Syntax:\nTRIM([{BOTH | LEADING | TRAILING} [remstr] FROM] str), TRIM([remstr\nFROM] str)\n\nReturns the string str with all remstr prefixes or suffixes removed. If\nnone of the specifiers BOTH, LEADING, or TRAILING is given, BOTH is\nassumed. remstr is optional and, if not specified, spaces are removed.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT TRIM(\'  bar   \');\n        -> \'bar\'\nmysql> SELECT TRIM(LEADING \'x\' FROM \'xxxbarxxx\');\n        -> \'barxxx\'\nmysql> SELECT TRIM(BOTH \'x\' FROM \'xxxbarxxx\');\n        -> \'bar\'\nmysql> SELECT TRIM(TRAILING \'xyz\' FROM \'barxxyz\');\n        -> \'barx\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (436,'IS',16,'Syntax:\nIS boolean_value\n\nTests a value against a boolean value, where boolean_value can be TRUE,\nFALSE, or UNKNOWN.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 1 IS TRUE, 0 IS FALSE, NULL IS UNKNOWN;\n        -> 1, 1, 1\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (437,'GET_FORMAT',29,'Syntax:\nGET_FORMAT({DATE|TIME|DATETIME}, {\'EUR\'|\'USA\'|\'JIS\'|\'ISO\'|\'INTERNAL\'})\n\nReturns a format string. This function is useful in combination with\nthe DATE_FORMAT() and the STR_TO_DATE() functions.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT DATE_FORMAT(\'2003-10-03\',GET_FORMAT(DATE,\'EUR\'));\n        -> \'03.10.2003\'\nmysql> SELECT STR_TO_DATE(\'10.31.2003\',GET_FORMAT(DATE,\'USA\'));\n        -> \'2003-10-31\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (438,'TINYBLOB',19,'TINYBLOB\n\nA BLOB column with a maximum length of 255 (28 - 1) bytes. Each\nTINYBLOB value is stored using a one-byte length prefix that indicates\nthe number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (439,'SAVEPOINT',7,'Syntax:\nSAVEPOINT identifier\nROLLBACK [WORK] TO [SAVEPOINT] identifier\nRELEASE SAVEPOINT identifier\n\nInnoDB supports the SQL statements SAVEPOINT and ROLLBACK TO SAVEPOINT.\nStarting from MySQL 5.0.3, RELEASE SAVEPOINT and the optional WORK\nkeyword for ROLLBACK are supported as well.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/savepoint.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/savepoint.html');
INSERT INTO `mysql`.`help_topic` VALUES  (440,'USER',14,'Syntax:\nUSER()\n\nReturns the current MySQL username and hostname as a string in the utf8\ncharacter set.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT USER();\n        -> \'davida@localhost\'\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (441,'ALTER TABLE',36,'Syntax:\nALTER [IGNORE] TABLE tbl_name\n    alter_specification [, alter_specification] ...\n\nalter_specification:\n    table_option ...\n  | ADD [COLUMN] col_name column_definition\n        [FIRST | AFTER col_name ]\n  | ADD [COLUMN] (col_name column_definition,...)\n  | ADD {INDEX|KEY} [index_name]\n        [index_type] (index_col_name,...) [index_type]\n  | ADD [CONSTRAINT [symbol]] PRIMARY KEY\n        [index_type] (index_col_name,...) [index_type]\n  | ADD [CONSTRAINT [symbol]]\n        UNIQUE [INDEX|KEY] [index_name]\n        [index_type] (index_col_name,...) [index_type]\n  | ADD [FULLTEXT|SPATIAL] [INDEX|KEY] [index_name]\n        (index_col_name,...) [index_type]\n  | ADD [CONSTRAINT [symbol]]\n        FOREIGN KEY [index_name] (index_col_name,...)\n        reference_definition\n  | ALTER [COLUMN] col_name {SET DEFAULT literal | DROP DEFAULT}\n  | CHANGE [COLUMN] old_col_name new_col_name column_definition\n        [FIRST|AFTER col_name]\n  | MODIFY [COLUMN] col_name column_definition\n        [FIRST | AFTER col_name]\n  | DROP [COLUMN] col_name\n  | DROP PRIMARY KEY\n  | DROP {INDEX|KEY} index_name\n  | DROP FOREIGN KEY fk_symbol\n  | DISABLE KEYS\n  | ENABLE KEYS\n  | RENAME [TO] new_tbl_name\n  | ORDER BY col_name [, col_name] ...\n  | CONVERT TO CHARACTER SET charset_name [COLLATE collation_name]\n  | [DEFAULT] CHARACTER SET [=] charset_name [COLLATE [=] collation_name]\n  | DISCARD TABLESPACE\n  | IMPORT TABLESPACE\n\nindex_col_name:\n    col_name [(length)] [ASC | DESC]\n\nindex_type:\n    USING {BTREE | HASH | RTREE}\n\nALTER TABLE enables you to change the structure of an existing table.\nFor example, you can add or delete columns, create or destroy indexes,\nchange the type of existing columns, or rename columns or the table\nitself. You can also change the comment for the table and type of the\ntable.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/alter-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/alter-table.html'),
 (442,'MPOINTFROMWKB',30,'MPointFromWKB(wkb[,srid]), MultiPointFromWKB(wkb[,srid])\n\nConstructs a MULTIPOINT value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (443,'CHAR BYTE',19,'The CHAR BYTE data type is an alias for the BINARY data type. This is a\ncompatibility feature.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html'),
 (444,'REPAIR TABLE',18,'Syntax:\nREPAIR [NO_WRITE_TO_BINLOG | LOCAL] TABLE\n    tbl_name [, tbl_name] ...\n    [QUICK] [EXTENDED] [USE_FRM]\n\nREPAIR TABLE repairs a possibly corrupted table. By default, it has the\nsame effect as myisamchk --recover tbl_name. REPAIR TABLE works for\nMyISAM and for ARCHIVE tables. See\nhttp://dev.mysql.com/doc/refman/5.0/en/myisam-storage-engine.html, and\nhttp://dev.mysql.com/doc/refman/5.0/en/archive-storage-engine.html.\n\nThis statement requires SELECT and INSERT privileges for the table.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/repair-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/repair-table.html'),
 (445,'MERGE',36,'The MERGE storage engine, also known as the MRG_MyISAM engine, is a\ncollection of identical MyISAM tables that can be used as one.\n\"Identical\" means that all tables have identical column and index\ninformation. You cannot merge MyISAM tables in which the columns are\nlisted in a different order, do not have exactly the same columns, or\nhave the indexes in different order. However, any or all of the MyISAM\ntables can be compressed with myisampack. See\nhttp://dev.mysql.com/doc/refman/5.0/en/myisampack.html. Differences in\ntable options such as AVG_ROW_LENGTH, MAX_ROWS, or PACK_KEYS do not\nmatter.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/merge-storage-engine.html\n\n','mysql> CREATE TABLE t1 (\n    ->    a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,\n    ->    message CHAR(20)) ENGINE=MyISAM;\nmysql> CREATE TABLE t2 (\n    ->    a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,\n    ->    message CHAR(20)) ENGINE=MyISAM;\nmysql> INSERT INTO t1 (message) VALUES (\'Testing\'),(\'table\'),(\'t1\');\nmysql> INSERT INTO t2 (message) VALUES (\'Testing\'),(\'table\'),(\'t2\');\nmysql> CREATE TABLE total (\n    ->    a INT NOT NULL AUTO_INCREMENT,\n    ->    message CHAR(20), INDEX(a))\n    ->    ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=LAST;\n','http://dev.mysql.com/doc/refman/5.0/en/merge-storage-engine.html'),
 (446,'CREATE TABLE',36,'Syntax:\nCREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name\n    (create_definition,...)\n    [table_option] ...\n\nOr:\n\nCREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name\n    [(create_definition,...)]\n    [table_option] ...\n    select_statement\n\nOr:\n\nCREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name\n    { LIKE old_tbl_name | (LIKE old_tbl_name) }\n\ncreate_definition:\n    col_name column_definition\n  | [CONSTRAINT [symbol]] PRIMARY KEY [index_type] (index_col_name,...)\n        [index_type]\n  | {INDEX|KEY} [index_name] [index_type] (index_col_name,...)\n        [index_type]\n  | [CONSTRAINT [symbol]] UNIQUE [INDEX|KEY]\n        [index_name] [index_type] (index_col_name,...)\n        [index_type]\n  | {FULLTEXT|SPATIAL} [INDEX|KEY] [index_name] (index_col_name,...)\n        [index_type]\n  | [CONSTRAINT [symbol]] FOREIGN KEY\n        [index_name] (index_col_name,...) reference_definition\n  | CHECK (expr)\n\ncolumn_definition:\n    data_type [NOT NULL | NULL] [DEFAULT default_value]\n      [AUTO_INCREMENT] [UNIQUE [KEY] | [PRIMARY] KEY]\n      [COMMENT \'string\'] [reference_definition]\n\ndata_type:\n    BIT[(length)]\n  | TINYINT[(length)] [UNSIGNED] [ZEROFILL]\n  | SMALLINT[(length)] [UNSIGNED] [ZEROFILL]\n  | MEDIUMINT[(length)] [UNSIGNED] [ZEROFILL]\n  | INT[(length)] [UNSIGNED] [ZEROFILL]\n  | INTEGER[(length)] [UNSIGNED] [ZEROFILL]\n  | BIGINT[(length)] [UNSIGNED] [ZEROFILL]\n  | REAL[(length,decimals)] [UNSIGNED] [ZEROFILL]\n  | DOUBLE[(length,decimals)] [UNSIGNED] [ZEROFILL]\n  | FLOAT[(length,decimals)] [UNSIGNED] [ZEROFILL]\n  | DECIMAL[(length[,decimals])] [UNSIGNED] [ZEROFILL]\n  | NUMERIC[(length[,decimals])] [UNSIGNED] [ZEROFILL]\n  | DATE\n  | TIME\n  | TIMESTAMP\n  | DATETIME\n  | YEAR\n  | CHAR[(length)]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | VARCHAR(length)\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | BINARY[(length)]\n  | VARBINARY(length)\n  | TINYBLOB\n  | BLOB\n  | MEDIUMBLOB\n  | LONGBLOB\n  | TINYTEXT [BINARY]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | TEXT [BINARY]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | MEDIUMTEXT [BINARY]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | LONGTEXT [BINARY]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | ENUM(value1,value2,value3,...)\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | SET(value1,value2,value3,...)\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | spatial_type\n\nindex_col_name:\n    col_name [(length)] [ASC | DESC]\n\nindex_type:\n    USING {BTREE | HASH | RTREE}\n\nreference_definition:\n    REFERENCES tbl_name (index_col_name,...)\n      [MATCH FULL | MATCH PARTIAL | MATCH SIMPLE]\n      [ON DELETE reference_option]\n      [ON UPDATE reference_option]\n\nreference_option:\n    RESTRICT | CASCADE | SET NULL | NO ACTION\n\ntable_option:\n    {ENGINE|TYPE} [=] engine_name\n  | AUTO_INCREMENT [=] value\n  | AVG_ROW_LENGTH [=] value\n  | [DEFAULT] CHARACTER SET [=] charset_name\n  | CHECKSUM [=] {0 | 1}\n  | [DEFAULT] COLLATE [=] collation_name\n  | COMMENT [=] \'string\'\n  | CONNECTION [=] \'connect_string\'\n  | DATA DIRECTORY [=] \'absolute path to directory\'\n  | DELAY_KEY_WRITE [=] {0 | 1}\n  | INDEX DIRECTORY [=] \'absolute path to directory\'\n  | INSERT_METHOD [=] { NO | FIRST | LAST }\n  | MAX_ROWS [=] value\n  | MIN_ROWS [=] value\n  | PACK_KEYS [=] {0 | 1 | DEFAULT}\n  | PASSWORD [=] \'string\'\n  | ROW_FORMAT [=] {DEFAULT|DYNAMIC|FIXED|COMPRESSED|REDUNDANT|COMPACT}\n  | UNION [=] (tbl_name[,tbl_name]...)\n\nselect_statement:\n    [IGNORE | REPLACE] [AS] SELECT ...   (Some legal select statement)\n\nCREATE TABLE creates a table with the given name. You must have the\nCREATE privilege for the table.\n\nRules for allowable table names are given in\nhttp://dev.mysql.com/doc/refman/5.0/en/identifiers.html. By default,\nthe table is created in the default database. An error occurs if the\ntable exists, if there is no default database, or if the database does\nnot exist.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/create-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/create-table.html');
INSERT INTO `mysql`.`help_topic` VALUES  (447,'>',16,'Syntax:\n>\n\nGreater than:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT 2 > 2;\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (448,'ANALYZE TABLE',18,'Syntax:\nANALYZE [NO_WRITE_TO_BINLOG | LOCAL] TABLE\n    tbl_name [, tbl_name] ...\n\nANALYZE TABLE analyzes and stores the key distribution for a table.\nDuring the analysis, the table is locked with a read lock for MyISAM\nand BDB. For InnoDB the table is locked with a write lock. This\nstatement works with MyISAM, BDB, and InnoDB tables. For MyISAM tables,\nthis statement is equivalent to using myisamchk --analyze.\n\nFor more information on how the analysis works within InnoDB, see\nhttp://dev.mysql.com/doc/refman/5.0/en/innodb-restrictions.html.\n\nMySQL uses the stored key distribution to decide the order in which\ntables should be joined when you perform a join on something other than\na constant. In addition, key distributions can be used when deciding\nwhich indexes to use for a specific table within a query.\n\nThis statement requires SELECT and INSERT privileges for the table.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/analyze-table.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/analyze-table.html'),
 (449,'MICROSECOND',29,'Syntax:\nMICROSECOND(expr)\n\nReturns the microseconds from the time or datetime expression expr as a\nnumber in the range from 0 to 999999.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT MICROSECOND(\'12:00:00.123456\');\n        -> 123456\nmysql> SELECT MICROSECOND(\'2009-12-31 23:59:59.000010\');\n        -> 10\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (450,'CONSTRAINT',36,'InnoDB supports foreign key constraints. The syntax for a foreign key\nconstraint definition in InnoDB looks like this:\n\n[CONSTRAINT [symbol]] FOREIGN KEY\n    [index_name] (index_col_name, ...)\n    REFERENCES tbl_name (index_col_name,...)\n    [ON DELETE reference_option]\n    [ON UPDATE reference_option]\n\nreference_option:\n    RESTRICT | CASCADE | SET NULL | NO ACTION\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/innodb-foreign-key-constraints.html\n\n','CREATE TABLE product (category INT NOT NULL, id INT NOT NULL,\n                      price DECIMAL,\n                      PRIMARY KEY(category, id)) ENGINE=INNODB;\nCREATE TABLE customer (id INT NOT NULL,\n                       PRIMARY KEY (id)) ENGINE=INNODB;\nCREATE TABLE product_order (no INT NOT NULL AUTO_INCREMENT,\n                            product_category INT NOT NULL,\n                            product_id INT NOT NULL,\n                            customer_id INT NOT NULL,\n                            PRIMARY KEY(no),\n                            INDEX (product_category, product_id),\n                            FOREIGN KEY (product_category, product_id)\n                              REFERENCES product(category, id)\n                              ON UPDATE CASCADE ON DELETE RESTRICT,\n                            INDEX (customer_id),\n                            FOREIGN KEY (customer_id)\n                              REFERENCES customer(id)) ENGINE=INNODB;\n','http://dev.mysql.com/doc/refman/5.0/en/innodb-foreign-key-constraints.html'),
 (451,'FIELD',34,'Syntax:\nFIELD(str,str1,str2,str3,...)\n\nReturns the index (position) of str in the str1, str2, str3, ... list.\nReturns 0 if str is not found.\n\nIf all arguments to FIELD() are strings, all arguments are compared as\nstrings. If all arguments are numbers, they are compared as numbers.\nOtherwise, the arguments are compared as double.\n\nIf str is NULL, the return value is 0 because NULL fails equality\ncomparison with any value. FIELD() is the complement of ELT().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT FIELD(\'ej\', \'Hej\', \'ej\', \'Heja\', \'hej\', \'foo\');\n        -> 2\nmysql> SELECT FIELD(\'fo\', \'Hej\', \'ej\', \'Heja\', \'hej\', \'foo\');\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (452,'MAKETIME',29,'Syntax:\nMAKETIME(hour,minute,second)\n\nReturns a time value calculated from the hour, minute, and second\narguments.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT MAKETIME(12,15,30);\n        -> \'12:15:30\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (453,'CURDATE',29,'Syntax:\nCURDATE()\n\nReturns the current date as a value in \'YYYY-MM-DD\' or YYYYMMDD format,\ndepending on whether the function is used in a string or numeric\ncontext.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT CURDATE();\n        -> \'2008-06-13\'\nmysql> SELECT CURDATE() + 0;\n        -> 20080613\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (454,'SET PASSWORD',8,'Syntax:\nSET PASSWORD [FOR user] =\n    {\n        PASSWORD(\'some password\')\n      | OLD_PASSWORD(\'some password\')\n      | \'encrypted password\'\n    }\n\nThe SET PASSWORD statement assigns a password to an existing MySQL user\naccount.\n\nIf the password is specified using the PASSWORD() or OLD_PASSWORD()\nfunction, the literal text of the password should be given. If the\npassword is specified without using either function, the password\nshould be the already-encrypted password value as returned by\nPASSWORD().\n\nWith no FOR clause, this statement sets the password for the current\nuser. Any client that has connected to the server using a non-anonymous\naccount can change the password for that account.\n\nWith a FOR clause, this statement sets the password for a specific\naccount on the current server host. Only clients that have the UPDATE\nprivilege for the mysql database can do this. The user value should be\ngiven in user_name@host_name format, where user_name and host_name are\nexactly as they are listed in the User and Host columns of the\nmysql.user table entry. For example, if you had an entry with User and\nHost column values of \'bob\' and \'%.loc.gov\', you would write the\nstatement like this:\n\nSET PASSWORD FOR \'bob\'@\'%.loc.gov\' = PASSWORD(\'newpass\');\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/set-password.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/set-password.html'),
 (455,'ENUM',19,'ENUM(\'value1\',\'value2\',...) [CHARACTER SET charset_name] [COLLATE\ncollation_name]\n\nAn enumeration. A string object that can have only one value, chosen\nfrom the list of values \'value1\', \'value2\', ..., NULL or the special \'\'\nerror value. An ENUM column can have a maximum of 65,535 distinct\nvalues. ENUM values are represented internally as integers.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (456,'IF FUNCTION',6,'Syntax:\nIF(expr1,expr2,expr3)\n\nIf expr1 is TRUE (expr1 <> 0 and expr1 <> NULL) then IF() returns\nexpr2; otherwise it returns expr3. IF() returns a numeric or string\nvalue, depending on the context in which it is used.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html\n\n','mysql> SELECT IF(1>2,2,3);\n        -> 3\nmysql> SELECT IF(1<2,\'yes\',\'no\');\n        -> \'yes\'\nmysql> SELECT IF(STRCMP(\'test\',\'test1\'),\'no\',\'yes\');\n        -> \'no\'\n','http://dev.mysql.com/doc/refman/5.0/en/control-flow-functions.html'),
 (457,'DATABASE',14,'Syntax:\nDATABASE()\n\nReturns the default (current) database name as a string in the utf8\ncharacter set. If there is no default database, DATABASE() returns\nNULL. Within a stored routine, the default database is the database\nthat the routine is associated with, which is not necessarily the same\nas the database that is the default in the calling context.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT DATABASE();\n        -> \'test\'\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (458,'POINTFROMWKB',30,'PointFromWKB(wkb[,srid])\n\nConstructs a POINT value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions\n\n','','http://dev.mysql.com/doc/refman/5.0/en/creating-spatial-values.html#gis-wkb-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (459,'POWER',4,'Syntax:\nPOWER(X,Y)\n\nThis is a synonym for POW().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (460,'ATAN',4,'Syntax:\nATAN(X)\n\nReturns the arc tangent of X, that is, the value whose tangent is X.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT ATAN(2);\n        -> 1.1071487177941\nmysql> SELECT ATAN(-2);\n        -> -1.1071487177941\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (461,'STRCMP',34,'Syntax:\nSTRCMP(expr1,expr2)\n\nSTRCMP() returns 0 if the strings are the same, -1 if the first\nargument is smaller than the second according to the current sort\norder, and 1 otherwise.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-comparison-functions.html\n\n','mysql> SELECT STRCMP(\'text\', \'text2\');\n        -> -1\nmysql> SELECT STRCMP(\'text2\', \'text\');\n        -> 1\nmysql> SELECT STRCMP(\'text\', \'text\');\n        -> 0\n','http://dev.mysql.com/doc/refman/5.0/en/string-comparison-functions.html'),
 (462,'INSERT DELAYED',25,'Syntax:\nINSERT DELAYED ...\n\nThe DELAYED option for the INSERT statement is a MySQL extension to\nstandard SQL that is very useful if you have clients that cannot or\nneed not wait for the INSERT to complete. This is a common situation\nwhen you use MySQL for logging and you also periodically run SELECT and\nUPDATE statements that take a long time to complete.\n\nWhen a client uses INSERT DELAYED, it gets an okay from the server at\nonce, and the row is queued to be inserted when the table is not in use\nby any other thread.\n\nAnother major benefit of using INSERT DELAYED is that inserts from many\nclients are bundled together and written in one block. This is much\nfaster than performing many separate inserts.\n\nNote that INSERT DELAYED is slower than a normal INSERT if the table is\nnot otherwise in use. There is also the additional overhead for the\nserver to handle a separate thread for each table for which there are\ndelayed rows. This means that you should use INSERT DELAYED only when\nyou are really sure that you need it.\n\nThe queued rows are held only in memory until they are inserted into\nthe table. This means that if you terminate mysqld forcibly (for\nexample, with kill -9) or if mysqld dies unexpectedly, any queued rows\nthat have not been written to disk are lost.\n\nThere are some constraints on the use of DELAYED:\n\no INSERT DELAYED works only with MyISAM, MEMORY, and ARCHIVE tables.\n  See\n  http://dev.mysql.com/doc/refman/5.0/en/myisam-storage-engine.html,\n  http://dev.mysql.com/doc/refman/5.0/en/memory-storage-engine.html,\n  and\n  http://dev.mysql.com/doc/refman/5.0/en/archive-storage-engine.html.\n\no For MyISAM tables, if there are no free blocks in the middle of the\n  data file, concurrent SELECT and INSERT statements are supported.\n  Under these circumstances, you very seldom need to use INSERT DELAYED\n  with MyISAM.\n\no INSERT DELAYED should be used only for INSERT statements that specify\n  value lists. The server ignores DELAYED for INSERT ... SELECT or\n  INSERT ... ON DUPLICATE KEY UPDATE statements.\n\no Because the INSERT DELAYED statement returns immediately, before the\n  rows are inserted, you cannot use LAST_INSERT_ID() to get the\n  AUTO_INCREMENT value that the statement might generate.\n\no DELAYED rows are not visible to SELECT statements until they actually\n  have been inserted.\n\no DELAYED is ignored on slave replication servers, so that INSERT\n  DELAYED is treated as a normal INSERT on slaves. This is because\n  DELAYED could cause the slave to have different data than the master.\n\no Pending INSERT DELAYED statements are lost if a table is write locked\n  and ALTER TABLE is used to modify the table structure.\n\no INSERT DELAYED is not supported for views.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/insert-delayed.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/insert-delayed.html');
INSERT INTO `mysql`.`help_topic` VALUES  (463,'SHOW PROFILE',25,'Syntax:\nSHOW PROFILES\n\nThe SHOW PROFILE statement display profiling information that indicates\nresource usage for statements executed during the course of the current\nsession. It is used together with SHOW PROFILES; see [HELP SHOW\nPROFILES].\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-profile.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-profile.html'),
 (464,'SHOW PROCEDURE CODE',25,'Syntax:\nSHOW PROCEDURE CODE proc_name\n\nThis statement is a MySQL extension that is available only for servers\nthat have been built with debugging support. It displays a\nrepresentation of the internal implementation of the named stored\nprocedure. A similar statement, SHOW FUNCTION CODE, displays\ninformation about stored functions (see [HELP SHOW FUNCTION CODE]).\n\nBoth statements require that you be the owner of the routine or have\nSELECT access to the mysql.proc table.\n\nIf the named routine is available, each statement produces a result\nset. Each row in the result set corresponds to one \"instruction\" in the\nroutine. The first column is Pos, which is an ordinal number beginning\nwith 0. The second column is Instruction, which contains an SQL\nstatement (usually changed from the original source), or a directive\nwhich has meaning only to the stored-routine handler.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-procedure-code.html\n\n','mysql> DELIMITER //\nmysql> CREATE PROCEDURE p1 ()\n    -> BEGIN\n    ->   DECLARE fanta INT DEFAULT 55;\n    ->   DROP TABLE t2;\n    ->   LOOP\n    ->     INSERT INTO t3 VALUES (fanta);\n    ->     END LOOP;\n    ->   END//\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SHOW PROCEDURE CODE p1//\n+-----+----------------------------------------+\n| Pos | Instruction                            |\n+-----+----------------------------------------+\n|   0 | set fanta@0 55                         |\n|   1 | stmt 9 \"DROP TABLE t2\"                 |\n|   2 | stmt 5 \"INSERT INTO t3 VALUES (fanta)\" |\n|   3 | jump 2                                 |\n+-----+----------------------------------------+\n4 rows in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.0/en/show-procedure-code.html'),
 (465,'MEDIUMTEXT',19,'MEDIUMTEXT [CHARACTER SET charset_name] [COLLATE collation_name]\n\nA TEXT column with a maximum length of 16,777,215 (224 - 1) characters.\nThe effective maximum length is less if the value contains multi-byte\ncharacters. Each MEDIUMTEXT value is stored using a three-byte length\nprefix that indicates the number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/string-type-overview.html');
INSERT INTO `mysql`.`help_topic` VALUES  (466,'LN',4,'Syntax:\nLN(X)\n\nReturns the natural logarithm of X; that is, the base-e logarithm of X.\nIf X is less than or equal to 0, then NULL is returned.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT LN(2);\n        -> 0.69314718055995\nmysql> SELECT LN(-2);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (467,'RETURN',21,'Syntax:\nRETURN expr\n\nThe RETURN statement terminates execution of a stored function and\nreturns the value expr to the function caller. There must be at least\none RETURN statement in a stored function. There may be more than one\nif the function has multiple exit points.\n\nThis statement is not used in stored procedures or triggers.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/return.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/return.html'),
 (468,'SHOW COLLATION',25,'Syntax:\nSHOW COLLATION\n    [LIKE \'pattern\' | WHERE expr]\n\nThe output from SHOW COLLATION includes all available character sets.\nThe LIKE clause, if present, indicates which collation names to match.\nThe WHERE clause can be given to select rows using more general\nconditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.0/en/extended-show.html. For example:\n\nmysql> SHOW COLLATION LIKE \'latin1%\';\n+-------------------+---------+----+---------+----------+---------+\n| Collation         | Charset | Id | Default | Compiled | Sortlen |\n+-------------------+---------+----+---------+----------+---------+\n| latin1_german1_ci | latin1  |  5 |         |          |       0 |\n| latin1_swedish_ci | latin1  |  8 | Yes     | Yes      |       0 |\n| latin1_danish_ci  | latin1  | 15 |         |          |       0 |\n| latin1_german2_ci | latin1  | 31 |         | Yes      |       2 |\n| latin1_bin        | latin1  | 47 |         | Yes      |       0 |\n| latin1_general_ci | latin1  | 48 |         |          |       0 |\n| latin1_general_cs | latin1  | 49 |         |          |       0 |\n| latin1_spanish_ci | latin1  | 94 |         |          |       0 |\n+-------------------+---------+----+---------+----------+---------+\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/show-collation.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/show-collation.html'),
 (469,'LOG',4,'Syntax:\nLOG(X), LOG(B,X)\n\nIf called with one parameter, this function returns the natural\nlogarithm of X. If X is less than or equal to 0, then NULL is returned.\n\nThe inverse of this function (when called with a single argument) is\nthe EXP() function.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT LOG(2);\n        -> 0.69314718055995\nmysql> SELECT LOG(-2);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (470,'SET SQL_LOG_BIN',25,'Syntax:\nSET sql_log_bin = {0|1}\n\nDisables or enables binary logging for the current connection\n(sql_log_bin is a session variable) if the client has the SUPER\nprivilege. The statement is refused with an error if the client does\nnot have that privilege.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/set-sql-log-bin.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/set-sql-log-bin.html'),
 (471,'!=',16,'Syntax:\n<>, !=\n\nNot equal:\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT \'.01\' <> \'0.01\';\n        -> 1\nmysql> SELECT .01 <> \'0.01\';\n        -> 0\nmysql> SELECT \'zapp\' <> \'zappp\';\n        -> 1\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (472,'WHILE',21,'Syntax:\n[begin_label:] WHILE search_condition DO\n    statement_list\nEND WHILE [end_label]\n\nThe statement list within a WHILE statement is repeated as long as the\nsearch_condition is true. statement_list consists of one or more\nstatements.\n\nA WHILE statement can be labeled. end_label cannot be given unless\nbegin_label also is present. If both are present, they must be the\nsame.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/while-statement.html\n\n','CREATE PROCEDURE dowhile()\nBEGIN\n  DECLARE v1 INT DEFAULT 5;\n\n  WHILE v1 > 0 DO\n    ...\n    SET v1 = v1 - 1;\n  END WHILE;\nEND\n','http://dev.mysql.com/doc/refman/5.0/en/while-statement.html'),
 (473,'AES_DECRYPT',10,'Syntax:\nAES_DECRYPT(crypt_str,key_str)\n\nThis function allows decryption of data using the official AES\n(Advanced Encryption Standard) algorithm. For more information, see the\ndescription of AES_ENCRYPT().\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (474,'DAYNAME',29,'Syntax:\nDAYNAME(date)\n\nReturns the name of the weekday for date. As of MySQL 5.0.25, the\nlanguage used for the name is controlled by the value of the\nlc_time_names system variable\n(http://dev.mysql.com/doc/refman/5.0/en/locale-support.html).\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html\n\n','mysql> SELECT DAYNAME(\'2007-02-03\');\n        -> \'Saturday\'\n','http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html'),
 (475,'COERCIBILITY',14,'Syntax:\nCOERCIBILITY(str)\n\nReturns the collation coercibility value of the string argument.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT COERCIBILITY(\'abc\' COLLATE latin1_swedish_ci);\n        -> 0\nmysql> SELECT COERCIBILITY(USER());\n        -> 3\nmysql> SELECT COERCIBILITY(\'abc\');\n        -> 4\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (476,'INT',19,'INT[(M)] [UNSIGNED] [ZEROFILL]\n\nA normal-size integer. The signed range is -2147483648 to 2147483647.\nThe unsigned range is 0 to 4294967295.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.0/en/numeric-type-overview.html'),
 (477,'GLENGTH',11,'GLength(ls)\n\nReturns as a double-precision number the length of the LineString value\nls in its associated spatial reference.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT GLength(GeomFromText(@ls));\n+----------------------------+\n| GLength(GeomFromText(@ls)) |\n+----------------------------+\n|            2.8284271247462 |\n+----------------------------+\n','http://dev.mysql.com/doc/refman/5.0/en/geometry-property-functions.html#linestring-property-functions');
INSERT INTO `mysql`.`help_topic` VALUES  (478,'RADIANS',4,'Syntax:\nRADIANS(X)\n\nReturns the argument X, converted from degrees to radians. (Note that\nπ radians equals 180 degrees.)\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html\n\n','mysql> SELECT RADIANS(90);\n        -> 1.5707963267949\n','http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html'),
 (479,'COLLATION',14,'Syntax:\nCOLLATION(str)\n\nReturns the collation of the string argument.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT COLLATION(\'abc\');\n        -> \'latin1_swedish_ci\'\nmysql> SELECT COLLATION(_utf8\'abc\');\n        -> \'utf8_general_ci\'\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html'),
 (480,'COALESCE',16,'Syntax:\nCOALESCE(value,...)\n\nReturns the first non-NULL value in the list, or NULL if there are no\nnon-NULL values.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html\n\n','mysql> SELECT COALESCE(NULL,1);\n        -> 1\nmysql> SELECT COALESCE(NULL,NULL,NULL);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html'),
 (481,'VERSION',14,'Syntax:\nVERSION()\n\nReturns a string that indicates the MySQL server version. The string\nuses the utf8 character set.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/information-functions.html\n\n','mysql> SELECT VERSION();\n        -> \'5.0.72-standard\'\n','http://dev.mysql.com/doc/refman/5.0/en/information-functions.html');
INSERT INTO `mysql`.`help_topic` VALUES  (482,'MAKE_SET',34,'Syntax:\nMAKE_SET(bits,str1,str2,...)\n\nReturns a set value (a string containing substrings separated by \",\"\ncharacters) consisting of the strings that have the corresponding bit\nin bits set. str1 corresponds to bit 0, str2 to bit 1, and so on. NULL\nvalues in str1, str2, ... are not appended to the result.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT MAKE_SET(1,\'a\',\'b\',\'c\');\n        -> \'a\'\nmysql> SELECT MAKE_SET(1 | 4,\'hello\',\'nice\',\'world\');\n        -> \'hello,world\'\nmysql> SELECT MAKE_SET(1 | 4,\'hello\',\'nice\',NULL,\'world\');\n        -> \'hello\'\nmysql> SELECT MAKE_SET(0,\'a\',\'b\',\'c\');\n        -> \'\'\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html'),
 (483,'FIND_IN_SET',34,'Syntax:\nFIND_IN_SET(str,strlist)\n\nReturns a value in the range of 1 to N if the string str is in the\nstring list strlist consisting of N substrings. A string list is a\nstring composed of substrings separated by \",\" characters. If the first\nargument is a constant string and the second is a column of type SET,\nthe FIND_IN_SET() function is optimized to use bit arithmetic. Returns\n0 if str is not in strlist or if strlist is the empty string. Returns\nNULL if either argument is NULL. This function does not work properly\nif the first argument contains a comma (\",\") character.\n\nURL: http://dev.mysql.com/doc/refman/5.0/en/string-functions.html\n\n','mysql> SELECT FIND_IN_SET(\'b\',\'a,b,c,d\');\n        -> 2\n','http://dev.mysql.com/doc/refman/5.0/en/string-functions.html');
UNLOCK TABLES;
/*!40000 ALTER TABLE `help_topic` ENABLE KEYS */;


--
-- Definition of table `mysql`.`host`
--

DROP TABLE IF EXISTS `mysql`.`host`;
CREATE TABLE  `mysql`.`host` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_view_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Show_view_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_routine_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_routine_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Execute_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  PRIMARY KEY  (`Host`,`Db`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Host privileges;  Merged with database privileges';

--
-- Dumping data for table `mysql`.`host`
--

/*!40000 ALTER TABLE `host` DISABLE KEYS */;
LOCK TABLES `host` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `host` ENABLE KEYS */;


--
-- Definition of table `mysql`.`proc`
--

DROP TABLE IF EXISTS `mysql`.`proc`;
CREATE TABLE  `mysql`.`proc` (
  `db` char(64) character set utf8 collate utf8_bin NOT NULL default '',
  `name` char(64) NOT NULL default '',
  `type` enum('FUNCTION','PROCEDURE') NOT NULL,
  `specific_name` char(64) NOT NULL default '',
  `language` enum('SQL') NOT NULL default 'SQL',
  `sql_data_access` enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA') NOT NULL default 'CONTAINS_SQL',
  `is_deterministic` enum('YES','NO') NOT NULL default 'NO',
  `security_type` enum('INVOKER','DEFINER') NOT NULL default 'DEFINER',
  `param_list` blob NOT NULL,
  `returns` char(64) NOT NULL default '',
  `body` longblob NOT NULL,
  `definer` char(77) character set utf8 collate utf8_bin NOT NULL default '',
  `created` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL default '0000-00-00 00:00:00',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE') NOT NULL default '',
  `comment` char(64) character set utf8 collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`db`,`name`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stored Procedures';

--
-- Dumping data for table `mysql`.`proc`
--

/*!40000 ALTER TABLE `proc` DISABLE KEYS */;
LOCK TABLES `proc` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `proc` ENABLE KEYS */;


--
-- Definition of table `mysql`.`procs_priv`
--

DROP TABLE IF EXISTS `mysql`.`procs_priv`;
CREATE TABLE  `mysql`.`procs_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Routine_name` char(64) collate utf8_bin NOT NULL default '',
  `Routine_type` enum('FUNCTION','PROCEDURE') collate utf8_bin NOT NULL,
  `Grantor` char(77) collate utf8_bin NOT NULL default '',
  `Proc_priv` set('Execute','Alter Routine','Grant') character set utf8 NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Procedure privileges';

--
-- Dumping data for table `mysql`.`procs_priv`
--

/*!40000 ALTER TABLE `procs_priv` DISABLE KEYS */;
LOCK TABLES `procs_priv` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `procs_priv` ENABLE KEYS */;


--
-- Definition of table `mysql`.`tables_priv`
--

DROP TABLE IF EXISTS `mysql`.`tables_priv`;
CREATE TABLE  `mysql`.`tables_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Table_name` char(64) collate utf8_bin NOT NULL default '',
  `Grantor` char(77) collate utf8_bin NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view') character set utf8 NOT NULL default '',
  `Column_priv` set('Select','Insert','Update','References') character set utf8 NOT NULL default '',
  PRIMARY KEY  (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table privileges';

--
-- Dumping data for table `mysql`.`tables_priv`
--

/*!40000 ALTER TABLE `tables_priv` DISABLE KEYS */;
LOCK TABLES `tables_priv` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `tables_priv` ENABLE KEYS */;


--
-- Definition of table `mysql`.`time_zone`
--

DROP TABLE IF EXISTS `mysql`.`time_zone`;
CREATE TABLE  `mysql`.`time_zone` (
  `Time_zone_id` int(10) unsigned NOT NULL auto_increment,
  `Use_leap_seconds` enum('Y','N') NOT NULL default 'N',
  PRIMARY KEY  (`Time_zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zones';

--
-- Dumping data for table `mysql`.`time_zone`
--

/*!40000 ALTER TABLE `time_zone` DISABLE KEYS */;
LOCK TABLES `time_zone` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone` ENABLE KEYS */;


--
-- Definition of table `mysql`.`time_zone_leap_second`
--

DROP TABLE IF EXISTS `mysql`.`time_zone_leap_second`;
CREATE TABLE  `mysql`.`time_zone_leap_second` (
  `Transition_time` bigint(20) NOT NULL,
  `Correction` int(11) NOT NULL,
  PRIMARY KEY  (`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Leap seconds information for time zones';

--
-- Dumping data for table `mysql`.`time_zone_leap_second`
--

/*!40000 ALTER TABLE `time_zone_leap_second` DISABLE KEYS */;
LOCK TABLES `time_zone_leap_second` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone_leap_second` ENABLE KEYS */;


--
-- Definition of table `mysql`.`time_zone_name`
--

DROP TABLE IF EXISTS `mysql`.`time_zone_name`;
CREATE TABLE  `mysql`.`time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone names';

--
-- Dumping data for table `mysql`.`time_zone_name`
--

/*!40000 ALTER TABLE `time_zone_name` DISABLE KEYS */;
LOCK TABLES `time_zone_name` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone_name` ENABLE KEYS */;


--
-- Definition of table `mysql`.`time_zone_transition`
--

DROP TABLE IF EXISTS `mysql`.`time_zone_transition`;
CREATE TABLE  `mysql`.`time_zone_transition` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_time` bigint(20) NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`Time_zone_id`,`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transitions';

--
-- Dumping data for table `mysql`.`time_zone_transition`
--

/*!40000 ALTER TABLE `time_zone_transition` DISABLE KEYS */;
LOCK TABLES `time_zone_transition` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone_transition` ENABLE KEYS */;


--
-- Definition of table `mysql`.`time_zone_transition_type`
--

DROP TABLE IF EXISTS `mysql`.`time_zone_transition_type`;
CREATE TABLE  `mysql`.`time_zone_transition_type` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  `Offset` int(11) NOT NULL default '0',
  `Is_DST` tinyint(3) unsigned NOT NULL default '0',
  `Abbreviation` char(8) NOT NULL default '',
  PRIMARY KEY  (`Time_zone_id`,`Transition_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transition types';

--
-- Dumping data for table `mysql`.`time_zone_transition_type`
--

/*!40000 ALTER TABLE `time_zone_transition_type` DISABLE KEYS */;
LOCK TABLES `time_zone_transition_type` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone_transition_type` ENABLE KEYS */;


--
-- Definition of table `mysql`.`user`
--

DROP TABLE IF EXISTS `mysql`.`user`;
CREATE TABLE  `mysql`.`user` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Password` varchar(41) collate utf8_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Reload_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Shutdown_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Process_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `File_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Show_db_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Super_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Execute_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Repl_slave_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Repl_client_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_view_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Show_view_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_routine_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_routine_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_user_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `ssl_type` enum('','ANY','X509','SPECIFIED') character set utf8 NOT NULL default '',
  `ssl_cipher` blob NOT NULL,
  `x509_issuer` blob NOT NULL,
  `x509_subject` blob NOT NULL,
  `max_questions` int(11) unsigned NOT NULL default '0',
  `max_updates` int(11) unsigned NOT NULL default '0',
  `max_connections` int(11) unsigned NOT NULL default '0',
  `max_user_connections` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`Host`,`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and global privileges';

--
-- Dumping data for table `mysql`.`user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
LOCK TABLES `user` WRITE;
INSERT INTO `mysql`.`user` VALUES  (0x6C6F63616C686F7374,0x726F6F74,0x2A31313546464233384434393244314637323638373146453335383946413435323343333337353243,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0),
 (0x736B6974746C6573,0x726F6F74,0x2A31313546464233384434393244314637323638373146453335383946413435323343333337353243,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0),
 (0x3132372E302E302E31,0x726F6F74,0x2A31313546464233384434393244314637323638373146453335383946413435323343333337353243,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0),
 (0x6C6F63616C686F7374,0x64656269616E2D7379732D6D61696E74,0x2A37333534423033443938413043363638393841344544393645443437333636373036464545313441,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','N','N','N','N','N','','','','',0,0,0,0),
 (0x25,0x63686174746572,'','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0);
INSERT INTO `mysql`.`user` VALUES  (0x31302E25,0x726F6F74,0x2A31313546464233384434393244314637323638373146453335383946413435323343333337353243,'N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),
 (0x25,0x7265736F7572636572657175657374,0x2A37433130443834334245384344313133464241333234363731413942373838364530423836384634,'N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),
 (0x3132372E25,0x7265736F7572636572657175657374,0x2A37433130443834334245384344313133464241333234363731413942373838364530423836384634,'N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0);
UNLOCK TABLES;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


--
-- Definition of table `mysql`.`user_info`
--

DROP TABLE IF EXISTS `mysql`.`user_info`;
CREATE TABLE  `mysql`.`user_info` (
  `User` varchar(16) collate utf8_bin NOT NULL,
  `Full_name` varchar(60) collate utf8_bin default NULL,
  `Description` varchar(255) collate utf8_bin default NULL,
  `Email` varchar(80) collate utf8_bin default NULL,
  `Contact_information` text collate utf8_bin,
  `Icon` blob,
  PRIMARY KEY  (`User`),
  KEY `user_info_Full_name` (`Full_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Stores additional user information';

--
-- Dumping data for table `mysql`.`user_info`
--

/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
LOCK TABLES `user_info` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
