-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 05, 2019 at 02:00 AM
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_registro_incidentes`
--

-- --------------------------------------------------------

--
-- Table structure for table `adjunto`
--

CREATE TABLE `adjunto` (
  `id_adjunto` int(11) NOT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `id_incidencias` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `asignacion`
--

CREATE TABLE `asignacion` (
  `id_asignacion` int(11) NOT NULL,
  `fecha_asignacion` date DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `departamento` varchar(45) DEFAULT NULL,
  `id_usuario_asignado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `edificio`
--

CREATE TABLE `edificio` (
  `id_edificio` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `sede` varchar(45) DEFAULT NULL,
  `nivel` varchar(45) DEFAULT NULL,
  `aula` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `historial`
--

CREATE TABLE `historial` (
  `id_historial` int(11) NOT NULL,
  `comentario` date DEFAULT NULL,
  `id_usuario_modifica` int(11) DEFAULT NULL,
  `id_incidencias` int(11) DEFAULT NULL,
  `evento` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `incidencias`
--

CREATE TABLE `incidencias` (
  `id_incidencias` int(11) NOT NULL,
  `fecha_inicia` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `id_incidencia_tipo` int(11) DEFAULT NULL,
  `id_edificio` int(11) DEFAULT NULL,
  `id_asignacion` int(11) DEFAULT NULL,
  `id_usuario_creador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `incidencias_tipo`
--

CREATE TABLE `incidencias_tipo` (
  `id_incidencia_tipo` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `tipo_incidencia` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adjunto`
--
ALTER TABLE `adjunto`
  ADD PRIMARY KEY (`id_adjunto`),
  ADD KEY `FK_adjunto_incidencia_id_adjunto` (`id_incidencias`);

--
-- Indexes for table `asignacion`
--
ALTER TABLE `asignacion`
  ADD PRIMARY KEY (`id_asignacion`),
  ADD KEY `FK_historial_asignacion_id_usuario` (`id_usuario_asignado`);

--
-- Indexes for table `edificio`
--
ALTER TABLE `edificio`
  ADD PRIMARY KEY (`id_edificio`);

--
-- Indexes for table `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `FK_incidentes_incidente` (`id_incidencias`),
  ADD KEY `FK_historial_usuario_id_usuario_modifica` (`id_usuario_modifica`);

--
-- Indexes for table `incidencias`
--
ALTER TABLE `incidencias`
  ADD PRIMARY KEY (`id_incidencias`),
  ADD KEY `FK_incidecias_asignacion` (`id_asignacion`),
  ADD KEY `FK_incidecias_tipo_id_incidencia` (`id_incidencia_tipo`),
  ADD KEY `FK_incidecias_edificio_id_edificio` (`id_edificio`),
  ADD KEY `FK_incidecias_usuario_id_usuario_creador` (`id_usuario_creador`);

--
-- Indexes for table `incidencias_tipo`
--
ALTER TABLE `incidencias_tipo`
  ADD PRIMARY KEY (`id_incidencia_tipo`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adjunto`
--
ALTER TABLE `adjunto`
  ADD CONSTRAINT `FK_adjunto_incidencia_id_adjunto` FOREIGN KEY (`id_incidencias`) REFERENCES `incidencias` (`id_incidencias`);

--
-- Constraints for table `asignacion`
--
ALTER TABLE `asignacion`
  ADD CONSTRAINT `FK_historial_asignacion_id_usuario` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `usuario` (`id_usuario`);

--
-- Constraints for table `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `FK_historial_usuario_id_usuario_modifica` FOREIGN KEY (`id_usuario_modifica`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `FK_incidentes_incidente` FOREIGN KEY (`id_incidencias`) REFERENCES `incidencias` (`id_incidencias`);

--
-- Constraints for table `incidencias`
--
ALTER TABLE `incidencias`
  ADD CONSTRAINT `FK_incidecias_asignacion` FOREIGN KEY (`id_asignacion`) REFERENCES `asignacion` (`id_asignacion`),
  ADD CONSTRAINT `FK_incidecias_edificio_id_edificio` FOREIGN KEY (`id_edificio`) REFERENCES `edificio` (`id_edificio`),
  ADD CONSTRAINT `FK_incidecias_tipo_id_incidencia` FOREIGN KEY (`id_incidencia_tipo`) REFERENCES `incidencias_tipo` (`id_incidencia_tipo`),
  ADD CONSTRAINT `FK_incidecias_usuario_id_usuario_creador` FOREIGN KEY (`id_usuario_creador`) REFERENCES `usuario` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
