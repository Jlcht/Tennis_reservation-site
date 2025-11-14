-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 12 mai 2024 à 13:54
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `reservation_tennis`
--

-- --------------------------------------------------------

--
-- Structure de la table `club_de_tennis`
--

CREATE TABLE `club_de_tennis` (
  `id_club` int(255) NOT NULL,
  `nom_club` varchar(30) NOT NULL,
  `date_creatiion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `club_de_tennis`
--

INSERT INTO `club_de_tennis` (`id_club`, `nom_club`, `date_creatiion`) VALUES
(3, 'Club A', '2024-05-08');

-- --------------------------------------------------------

--
-- Structure de la table `court_de_tennis`
--

CREATE TABLE `court_de_tennis` (
  `id_court` int(255) NOT NULL,
  `club_organisateur` int(255) NOT NULL,
  `id_emplacement` int(255) NOT NULL,
  `id_surface` int(255) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `statut` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `court_de_tennis`
--

INSERT INTO `court_de_tennis` (`id_court`, `club_organisateur`, `id_emplacement`, `id_surface`, `nom`, `statut`) VALUES
(1, 3, 1, 1, 'Entrainement (belfort)', 'Bloque'),
(2, 3, 2, 3, 'Entrainement sur gazon', 'Disponible');

-- --------------------------------------------------------

--
-- Structure de la table `emplacement`
--

CREATE TABLE `emplacement` (
  `id_emplacement` int(255) NOT NULL,
  `nom_emplacement` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `emplacement`
--

INSERT INTO `emplacement` (`id_emplacement`, `nom_emplacement`) VALUES
(1, 'Belfort'),
(2, 'Sevenans');

-- --------------------------------------------------------

--
-- Structure de la table `membre_club`
--

CREATE TABLE `membre_club` (
  `id_utilisateur` int(255) NOT NULL,
  `id_club` int(255) NOT NULL,
  `statut` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `membre_club`
--

INSERT INTO `membre_club` (`id_utilisateur`, `id_club`, `statut`) VALUES
(10005, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

CREATE TABLE `reservation` (
  `id_reservation` int(255) NOT NULL,
  `duree` time NOT NULL,
  `heure debut` time NOT NULL DEFAULT current_timestamp(),
  `partenaire_1` int(255) NOT NULL,
  `partenaire_2` int(255) NOT NULL,
  `partenaire_3` int(255) NOT NULL,
  `club_organisateur` int(255) NOT NULL,
  `id_court` int(255) NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`id_reservation`, `duree`, `heure debut`, `partenaire_1`, `partenaire_2`, `partenaire_3`, `club_organisateur`, `id_court`, `date`) VALUES
(16, '02:00:00', '14:00:00', 1, 1, 2, 3, 2, '2024-05-20');

-- --------------------------------------------------------

--
-- Structure de la table `surface`
--

CREATE TABLE `surface` (
  `id_surface` int(255) NOT NULL,
  `nom_surface` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `surface`
--

INSERT INTO `surface` (`id_surface`, `nom_surface`) VALUES
(1, 'Dur'),
(2, 'terre battue'),
(3, 'gazon');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id_utilisateur` int(255) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `mdp` text NOT NULL,
  `email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `nom`, `prenom`, `mdp`, `email`) VALUES
(1, 'Invite', 'Invite', 'invite', 'invite'),
(2, 'aucun', 'aucun', 'aucun', 'aucun'),
(10005, 'Léon', 'Norbert', '$2y$10$QR0BvnQolHmfpPdrI1DG/uDjj21Q9VdEB4eR3fz/PnzPwUypPJfC2', 'test@gmail.com');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `club_de_tennis`
--
ALTER TABLE `club_de_tennis`
  ADD PRIMARY KEY (`id_club`);

--
-- Index pour la table `court_de_tennis`
--
ALTER TABLE `court_de_tennis`
  ADD PRIMARY KEY (`id_court`),
  ADD KEY `cleorganisateur` (`club_organisateur`),
  ADD KEY `cleemplacement` (`id_emplacement`),
  ADD KEY `clesurface` (`id_surface`);

--
-- Index pour la table `emplacement`
--
ALTER TABLE `emplacement`
  ADD PRIMARY KEY (`id_emplacement`);

--
-- Index pour la table `membre_club`
--
ALTER TABLE `membre_club`
  ADD KEY `cleid_utilisateur` (`id_utilisateur`) USING BTREE,
  ADD KEY `cleid_club` (`id_club`) USING BTREE;

--
-- Index pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id_reservation`),
  ADD KEY `cleutilisateur` (`club_organisateur`),
  ADD KEY `clecourt` (`id_court`) USING BTREE,
  ADD KEY `clepartenaire_1` (`partenaire_1`) USING BTREE,
  ADD KEY `clepartenaire_2` (`partenaire_2`) USING BTREE,
  ADD KEY `clepartenaire_3` (`partenaire_3`) USING BTREE;

--
-- Index pour la table `surface`
--
ALTER TABLE `surface`
  ADD PRIMARY KEY (`id_surface`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `club_de_tennis`
--
ALTER TABLE `club_de_tennis`
  MODIFY `id_club` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `court_de_tennis`
--
ALTER TABLE `court_de_tennis`
  MODIFY `id_court` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `emplacement`
--
ALTER TABLE `emplacement`
  MODIFY `id_emplacement` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id_reservation` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `surface`
--
ALTER TABLE `surface`
  MODIFY `id_surface` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id_utilisateur` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10006;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `court_de_tennis`
--
ALTER TABLE `court_de_tennis`
  ADD CONSTRAINT `court_de_tennis_ibfk_1` FOREIGN KEY (`id_surface`) REFERENCES `surface` (`id_surface`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `court_de_tennis_ibfk_2` FOREIGN KEY (`id_emplacement`) REFERENCES `emplacement` (`id_emplacement`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `court_de_tennis_ibfk_3` FOREIGN KEY (`club_organisateur`) REFERENCES `club_de_tennis` (`id_club`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `membre_club`
--
ALTER TABLE `membre_club`
  ADD CONSTRAINT `membre_club_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membre_club_ibfk_2` FOREIGN KEY (`id_club`) REFERENCES `club_de_tennis` (`id_club`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`partenaire_1`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`id_court`) REFERENCES `court_de_tennis` (`id_court`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`partenaire_2`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`partenaire_3`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_5` FOREIGN KEY (`club_organisateur`) REFERENCES `club_de_tennis` (`id_club`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
