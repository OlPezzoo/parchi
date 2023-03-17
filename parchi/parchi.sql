DROP database IF EXISTS parchi; 
create database parchi; 
use parchi;  
-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: parchi
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `animale`
--

DROP TABLE IF EXISTS `animale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animale` (
  `idAnimale` int(11) NOT NULL AUTO_INCREMENT,
  `nomeAnimale` varchar(255) NOT NULL,
  `dataNascita` date NOT NULL,
  `sesso` char(1) NOT NULL,
  `idSpecie` int(11) NOT NULL,
  `idParco` int(11) NOT NULL,
  `statoSalute` varchar(255) NOT NULL,
  PRIMARY KEY (`idAnimale`),
  KEY `idx_idSpecie` (`idSpecie`),
  KEY `animale_idx_idParco` (`idParco`),
  CONSTRAINT `fk_idSpecie` FOREIGN KEY (`idSpecie`) REFERENCES `specie` (`idSpecie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_parco` FOREIGN KEY (`idParco`) REFERENCES `parco` (`idParco`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animale`
--

LOCK TABLES `animale` WRITE;
/*!40000 ALTER TABLE `animale` DISABLE KEYS */;
INSERT INTO `animale` VALUES (1,'Trota fario','2021-01-07','M',2,3,'Discreto'),(2,'Trota iridea','2022-01-21','M',2,3,'Ottimo'),(3,'Trota fario','2020-03-03','F',2,3,'Buono'),(4,'Scoiattolo rosso','2022-02-15','F',1,5,'Ottimo'),(5,'Trota fario','2013-01-10','M',2,3,'Buono');
/*!40000 ALTER TABLE `animale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordine` (
  `idOrdine` int(11) NOT NULL AUTO_INCREMENT,
  `nomeOrdine` varchar(255) NOT NULL,
  PRIMARY KEY (`idOrdine`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (1,'Anfibi'),(2,'Mammiferi'),(3,'Rettili'),(4,'Pesci'),(5,'Uccelli');
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parco`
--

DROP TABLE IF EXISTS `parco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parco` (
  `idParco` int(11) NOT NULL AUTO_INCREMENT,
  `nomeParco` varchar(255) NOT NULL,
  `idRegione` int(11) NOT NULL,
  PRIMARY KEY (`idParco`),
  KEY `idx_idRegione` (`idRegione`),
  CONSTRAINT `fk_idRegione` FOREIGN KEY (`idRegione`) REFERENCES `regione` (`idRegione`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parco`
--

LOCK TABLES `parco` WRITE;
/*!40000 ALTER TABLE `parco` DISABLE KEYS */;
INSERT INTO `parco` VALUES (1,'Parco del Gran Sasso',1),(2,'Parco dei Colli di Bergamo',2),(3,'Parco del Serio',2),(4,'Parco dello Stelvio',2),(5,'Parco di Monza',2),(6,'Parco del Gargano',3),(7,'Gran Paradiso',4);
/*!40000 ALTER TABLE `parco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regione`
--

DROP TABLE IF EXISTS `regione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regione` (
  `idRegione` int(11) NOT NULL AUTO_INCREMENT,
  `nomeRegione` varchar(255) NOT NULL,
  PRIMARY KEY (`idRegione`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regione`
--

LOCK TABLES `regione` WRITE;
/*!40000 ALTER TABLE `regione` DISABLE KEYS */;
INSERT INTO `regione` VALUES (1,'Abruzzo'),(2,'Lombardia'),(3,'Puglia'),(4,'Valle d\'Aosta');
/*!40000 ALTER TABLE `regione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specie`
--

DROP TABLE IF EXISTS `specie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specie` (
  `idSpecie` int(11) NOT NULL AUTO_INCREMENT,
  `nomeSpecie` varchar(255) NOT NULL,
  `idOrdine` int(11) NOT NULL,
  `idParco` int(11) NOT NULL,
  PRIMARY KEY (`idSpecie`),
  KEY `idx_idOrdine` (`idOrdine`),
  KEY `idx_idParco` (`idParco`),
  CONSTRAINT `fk_idOrdine` FOREIGN KEY (`idOrdine`) REFERENCES `ordine` (`idOrdine`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_idParco` FOREIGN KEY (`idParco`) REFERENCES `parco` (`idParco`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specie`
--

LOCK TABLES `specie` WRITE;
/*!40000 ALTER TABLE `specie` DISABLE KEYS */;
INSERT INTO `specie` VALUES (1,'Scoiattolo',2,5),(2,'Trota',4,3);
/*!40000 ALTER TABLE `specie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-17 22:58:13
