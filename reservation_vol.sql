-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 01, 2021 at 08:16 AM
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
(1, 'admin', 'admin1'),
(2, 'admin', 'admin2');

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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`idClient`, `Nom`, `Prenom`, `email`, `telephone`) VALUES
(90, 'ELHANCHAOUI', 'Taoufiq', 'admin@gmail.com', '0606060606'),
(91, 'ELHANCHAOUI', 'Taoufiq', 'admin@gmail.com', '0606060606'),
(92, 'ELHANCHAOUI', 'Taoufiq', 'admin@gmail.com', '0606060606'),
(93, 'ELHANCHAOUI', 'Taoufiq', 't.elhanchaoui@gmail.com', '0606060606'),
(94, 'ELHANCHAOUI', 'Taoufiq', 'admin@gmail.com', '0606060606'),
(95, 'ELHANCHAOUI', 'Taoufiq', 'admin@gmail.com', '0606060606'),
(96, 'ELHANCHAOUI', 'Taoufiq', 'admin@gmail.com', '0606060606'),
(97, '', '', '', ''),
(98, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `idPayment` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `cardNumber` int(20) NOT NULL,
  `dateExp` date NOT NULL,
  `cvs` int(3) NOT NULL,
  `idReservation` int(11) NOT NULL,
  PRIMARY KEY (`idPayment`),
  KEY `idReservation` (`idReservation`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`idPayment`, `name`, `cardNumber`, `dateExp`, `cvs`, `idReservation`) VALUES
(1, 'ZZZZZZZZZZZ', 123456, '2021-11-11', 3333, 0),
(2, 'taoufiq', 9, '2021-02-26', 6, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`IdReservation`, `IdClient`, `IdVol`, `nbrPlaceReserver`, `dateReservation`) VALUES
(82, 90, 79, 12, '2021-01-31 23:05:44'),
(83, 91, 79, 1, '2021-01-31 23:07:33'),
(84, 92, 79, 3, '2021-01-31 23:18:17'),
(85, 92, 79, 3, '2021-01-31 23:45:09'),
(86, 92, 79, 3, '2021-02-01 00:34:36'),
(87, 92, 79, 3, '2021-02-01 00:40:53'),
(88, 92, 79, 3, '2021-02-01 00:41:37'),
(89, 93, 79, 1, '2021-02-01 01:05:23'),
(90, 93, 79, 1, '2021-02-01 01:10:45'),
(91, 94, 79, 2, '2021-02-01 01:13:06'),
(92, 95, 79, 3, '2021-02-01 01:14:53'),
(93, 96, 79, 1, '2021-02-01 01:20:10');

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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vols`
--

INSERT INTO `vols` (`IdVol`, `ville_depart`, `ville_arrive`, `heur_depart`, `heur_arrive`, `date_depart`, `date_arrive`, `escale`, `nombrePlace`) VALUES
(79, 'Agadir', 'tanger', '12:00', '12:00', '2021/02/11', '2021/02/11', 'safi-casa', 16);

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
