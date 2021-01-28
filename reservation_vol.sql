-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 28 jan. 2021 à 10:28
-- Version du serveur :  10.4.10-MariaDB
-- Version de PHP :  7.4.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `reservation_vol`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(254) DEFAULT NULL,
  `Prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  PRIMARY KEY (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`idClient`, `Nom`, `Prenom`, `email`, `telephone`) VALUES
(67, 'mohamed', '', '', ''),
(68, 'hdddddd', '', '', ''),
(69, 'jhdc', '', '', ''),
(70, 'hhhhhhh', '', '', ''),
(71, 'youness', '', '', '');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `IdReservation` int(11) NOT NULL AUTO_INCREMENT,
  `IdClient` int(11) DEFAULT NULL,
  `IdVol` int(11) DEFAULT NULL,
  `nbrPlaceReserver` int(11) DEFAULT NULL,
  `DateReservation` datetime DEFAULT NULL,
  PRIMARY KEY (`IdReservation`),
  KEY `IdClient` (`IdClient`),
  KEY `IdVol` (`IdVol`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`IdReservation`, `IdClient`, `IdVol`, `nbrPlaceReserver`, `DateReservation`) VALUES
(46, 69, 1, 0, '2020-05-17 00:00:00'),
(47, 70, 1, 0, '2020-05-17 00:00:00'),
(48, 71, 1, 0, '2020-05-17 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `vols`
--

DROP TABLE IF EXISTS `vols`;
CREATE TABLE IF NOT EXISTS `vols` (
  `IdVol` int(11) NOT NULL AUTO_INCREMENT,
  `ville_depart` varchar(255) NOT NULL,
  `ville_arrive` varchar(255) NOT NULL,
  `heur_depart` varchar(255) NOT NULL,
  `heur_arrive` varchar(255) NOT NULL,
  `date_depart` date NOT NULL,
  `date_arrive` date NOT NULL,
  `nombrePlace` int(11) NOT NULL,
  PRIMARY KEY (`IdVol`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `vols`
--

INSERT INTO `vols` (`IdVol`, `ville_depart`, `ville_arrive`, `heur_depart`, `heur_arrive`, `date_depart`, `date_arrive`, `nombrePlace`) VALUES
(1, 'Agadir', 'rabat', '21:00', '02:30', '2021-01-26', '2021-01-27', 9),
(2, 'Agadir', 'safi', '14:30', '19:30', '2021-01-26', '2021-01-26', 10),
(3, 'casablanca', 'agadir', '12:00', '21:00', '2021-01-27', '2021-01-26', 20);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`IdClient`) REFERENCES `client` (`idClient`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`IdVol`) REFERENCES `vols` (`IdVol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
