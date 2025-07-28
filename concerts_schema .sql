-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2024 at 10:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `modified_concerts_schema`
--

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `album_id` int(11) NOT NULL,
  `album_title` varchar(100) NOT NULL,
  `release_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `album_songs`
--

CREATE TABLE `album_songs` (
  `album_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `artist_id` int(11) NOT NULL,
  `artist_name` varchar(100) NOT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `debut_year` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `concerts`
--

CREATE TABLE `concerts` (
  `concert_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `concert_artists`
--

CREATE TABLE `concert_artists` (
  `concert_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `concert_songs`
--

CREATE TABLE `concert_songs` (
  `concert_id` int(10) NOT NULL,
  `song_id` int(10) NOT NULL,
  `order_performance` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fans`
--

CREATE TABLE `fans` (
  `fan_id` int(11) NOT NULL,
  `fan_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `age` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fan_favorites`
--

CREATE TABLE `fan_favorites` (
  `fan_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seating`
--

CREATE TABLE `seating` (
  `seat_number` varchar(5) NOT NULL,
  `seat_zone` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shared_tickets`
--

CREATE TABLE `shared_tickets` (
  `ticket_id` int(11) NOT NULL,
  `fan_id` int(11) NOT NULL,
  `seat_number` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `song_id` int(11) NOT NULL,
  `song_title` varchar(100) NOT NULL,
  `solo_flag` char(1) NOT NULL,
  `song_length` int(11) DEFAULT NULL,
  `release_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `song_artists`
--

CREATE TABLE `song_artists` (
  `artist_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `concert_id` int(11) NOT NULL,
  `Shared_Ticket_flag` char(1) NOT NULL,
  `seat_number` varchar(5) NOT NULL,
  `purchase_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`album_id`);

--
-- Indexes for table `album_songs`
--
ALTER TABLE `album_songs`
  ADD PRIMARY KEY (`album_id`,`song_id`),
  ADD KEY `song_id` (`song_id`);

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`artist_id`);

--
-- Indexes for table `concerts`
--
ALTER TABLE `concerts`
  ADD PRIMARY KEY (`concert_id`);

--
-- Indexes for table `concert_artists`
--
ALTER TABLE `concert_artists`
  ADD PRIMARY KEY (`concert_id`,`artist_id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `concert_songs`
--
ALTER TABLE `concert_songs`
  ADD PRIMARY KEY (`concert_id`,`song_id`),
  ADD UNIQUE KEY `PERFORMANCE_ORDER` (`concert_id`,`order_performance`);

--
-- Indexes for table `fans`
--
ALTER TABLE `fans`
  ADD PRIMARY KEY (`fan_id`);

--
-- Indexes for table `fan_favorites`
--
ALTER TABLE `fan_favorites`
  ADD PRIMARY KEY (`fan_id`,`artist_id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `seating`
--
ALTER TABLE `seating`
  ADD PRIMARY KEY (`seat_number`);

--
-- Indexes for table `shared_tickets`
--
ALTER TABLE `shared_tickets`
  ADD PRIMARY KEY (`ticket_id`,`fan_id`,`seat_number`),
  ADD KEY `fan_id` (`fan_id`),
  ADD KEY `seat_number` (`seat_number`);

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`song_id`);

--
-- Indexes for table `song_artists`
--
ALTER TABLE `song_artists`
  ADD PRIMARY KEY (`artist_id`,`song_id`),
  ADD KEY `song_id` (`song_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD UNIQUE KEY `concert_seat` (`concert_id`,`seat_number`),
  ADD KEY `seat_number` (`seat_number`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `album_songs`
--
ALTER TABLE `album_songs`
  ADD CONSTRAINT `album_songs_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`),
  ADD CONSTRAINT `album_songs_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`);

--
-- Constraints for table `concert_artists`
--
ALTER TABLE `concert_artists`
  ADD CONSTRAINT `concert_artists_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`),
  ADD CONSTRAINT `concert_artists_ibfk_2` FOREIGN KEY (`concert_id`) REFERENCES `concerts` (`concert_id`);

--
-- Constraints for table `fan_favorites`
--
ALTER TABLE `fan_favorites`
  ADD CONSTRAINT `fan_favorites_ibfk_1` FOREIGN KEY (`fan_id`) REFERENCES `fans` (`fan_id`),
  ADD CONSTRAINT `fan_favorites_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`);

--
-- Constraints for table `shared_tickets`
--
ALTER TABLE `shared_tickets`
  ADD CONSTRAINT `shared_tickets_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`ticket_id`),
  ADD CONSTRAINT `shared_tickets_ibfk_2` FOREIGN KEY (`fan_id`) REFERENCES `fans` (`fan_id`),
  ADD CONSTRAINT `shared_tickets_ibfk_3` FOREIGN KEY (`seat_number`) REFERENCES `seating` (`seat_number`);

--
-- Constraints for table `song_artists`
--
ALTER TABLE `song_artists`
  ADD CONSTRAINT `song_artists_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`),
  ADD CONSTRAINT `song_artists_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`);

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`concert_id`) REFERENCES `concerts` (`concert_id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`seat_number`) REFERENCES `seating` (`seat_number`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
