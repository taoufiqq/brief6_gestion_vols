-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 01, 2021 at 11:51 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.4.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reservation_vol`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`idUser`, `username`, `password`) VALUES
(1, 'admin', 'admin1');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(254) DEFAULT NULL,
  `Prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  PRIMARY KEY (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `paiment`
--

DROP TABLE IF EXISTS `paiment`;
CREATE TABLE IF NOT EXISTS `paiment` (
  `idPayment` int(11) NOT NULL AUTO_INCREMENT,
  `idReservation` int(11) NOT NULL,
  `nom` text NOT NULL,
  `cardNumber` int(11) NOT NULL,
  `dateExp` date NOT NULL,
  `cvs` int(11) NOT NULL,
  PRIMARY KEY (`idPayment`),
  KEY `idReservation` (`idReservation`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `IdReservation` int(11) NOT NULL AUTO_INCREMENT,
  `IdClient` int(11) DEFAULT NULL,
  `IdVol` int(11) DEFAULT NULL,
  `nbrPlaceReserver` int(11) NOT NULL,
  `dateReservation` datetime NOT NULL,
  PRIMARY KEY (`IdReservation`),
  KEY `IdClient` (`IdClient`),
  KEY `IdVol` (`IdVol`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4;

--
-- Triggers `reservation`
--
DROP TRIGGER IF EXISTS `CheckNbrPlace`;
DELIMITER $$
CREATE TRIGGER `CheckNbrPlace` AFTER INSERT ON `reservation` FOR EACH ROW BEGIN

DECLARE nbrPlaceRes int;
DECLARE SelectIdV INT;
set nbrPlaceRes = new.nbrPlaceReserver;
set SelectIdV= NEW.IdVol;

UPDATE vols set nombrePlace = nombrePlace - nbrPlaceRes 
where IdVol=SelectIdV;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `vols`
--

DROP TABLE IF EXISTS `vols`;
CREATE TABLE IF NOT EXISTS `vols` (
  `IdVol` int(11) NOT NULL AUTO_INCREMENT,
  `ville_depart` varchar(255) NOT NULL,
  `ville_arrive` varchar(255) NOT NULL,
  `heur_depart` varchar(255) NOT NULL,
  `heur_arrive` varchar(255) NOT NULL,
  `date_depart` text NOT NULL DEFAULT current_timestamp(),
  `date_arrive` text NOT NULL DEFAULT '0000-00-00',
  `escale` text NOT NULL,
  `nombrePlace` int(11) NOT NULL,
  PRIMARY KEY (`IdVol`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`IdClient`) REFERENCES `client` (`idClient`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`IdVol`) REFERENCES `vols` (`IdVol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
