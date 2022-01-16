-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2022 at 03:24 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `careerhome`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `sno` int(3) NOT NULL,
  `fullname` varchar(100) NOT NULL COMMENT 'Full name of the user',
  `email` varchar(50) NOT NULL COMMENT 'Email id of the user',
  `mobile` varchar(10) NOT NULL COMMENT 'Mobile number of the user',
  `skill` varchar(20) DEFAULT NULL COMMENT 'Skill selected',
  `exp` varchar(10) NOT NULL COMMENT 'Experience of the user',
  `activesince` datetime NOT NULL COMMENT 'Date time when user was registered'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`sno`, `fullname`, `email`, `mobile`, `skill`, `exp`, `activesince`) VALUES
(1, 'Myra', 'myra@gmail.com', '8978765657', NULL, '2', '2021-12-22 00:41:54'),
(2, 'Myra', 'myra@gmail.com', '8978765657', 'No skill selected', '2', '2021-12-22 00:43:10'),
(3, 'Myra', 'myra@gmail.com', '8978765657', 'No skill selected', '2', '2021-12-22 00:44:32'),
(4, 'Myra', 'myra@gmail.com', '8978765657', 'No skill selected', '2', '2021-12-22 00:47:23'),
(5, 'Mishu', 'mishu@gmail.com', '9866454768', 'No skill selected', '4', '2021-12-22 00:56:09'),
(6, 'Mishu', 'mishu@gmail.com', '9866454768', 'No skill selected', '4', '2021-12-22 00:58:22'),
(7, 'Mishu', 'mishu@gmail.com', '9866454768', 'No skill selected', '4', '2021-12-22 01:01:43'),
(8, 'fdsf', 'dfs@fhg', '5345435663', 'No skill selected', '4', '2021-12-22 01:01:59'),
(9, 'fdsf', 'dfs@fhg', '5345435663', 'No skill selected', '4', '2021-12-22 01:09:22'),
(10, 'JOey', 'joey@ab.com', '8964646578', 'No skill selected', '3', '2021-12-22 01:09:41'),
(11, 'JOey', 'joey@ab.com', '8964646578', 'python', '3', '2021-12-22 01:11:13'),
(12, 'fds', 'dsfds@hj.com', '6765656454', 'java', '2', '2021-12-22 01:11:29'),
(13, 'fdsfds', 'dsfds@hh.com', '9886565764', 'cplus', '8', '2021-12-22 01:19:38'),
(14, 'fsdfds', 'dsfsdf@we.com', '1111111111', 'cplus', '7', '2021-12-22 01:21:38'),
(15, 'Damon', 'damon@gmail.com', '8768764545', 'cplus', '9', '2021-12-22 19:50:54'),
(16, 'Dr Sneha Gupta', 'sneha@gmail.com', '5467675675', 'medical', '10', '2021-12-22 19:58:51'),
(17, 'DummY', 'dum@dum.com', '6576576574', 'NA', '88', '2021-12-22 20:14:27'),
(18, 'DummY', 'dum@dum.com', '6576576574', 'NA', '88', '2021-12-22 20:17:31'),
(19, 'DummY', 'dum@dum.com', '6576576574', 'medical', '88', '2021-12-22 20:17:38'),
(20, 'dsfdsf', 'dsf@jjjj.com', '7675645457', '', '3', '2021-12-22 20:18:36'),
(21, 'dsfdsf', 'dsf@jjjj.com', '7675645457', '', '3', '2021-12-22 20:19:46'),
(22, 'df', 'ds@as.com', '4543665665', 'NA', '6', '2021-12-22 20:23:03'),
(23, 'dsfdsf', 'fddsf@hkhk.com', '4564564564', 'NA', '65', '2021-12-22 20:24:45'),
(24, 'Ian', 'ian@gmail.com', '8967565765', 'medical', '8', '2021-12-23 18:28:57'),
(25, 'df123', 'fgdfg@we.com', '7657657657', 'python', '4', '2021-12-23 18:33:27'),
(26, 'df123', 'fgdfg@we.com', '7657657657', 'python', '4', '2021-12-23 18:35:57'),
(27, 'df123', 'fgdfg@we.com', '7657657657', 'python', '4', '2021-12-23 18:39:17'),
(28, 'hjgj', 'gfh@ghgj.com', '4354354354', 'medical', '6', '2021-12-23 18:40:22'),
(29, 'jooioi', 'kjkh@as.com', '7765644545', 'medical', '3', '2021-12-23 18:49:39'),
(30, 'dsfsdf', 'hk@ga.com', '7656565465', 'medical', '3', '2021-12-23 18:54:53'),
(31, 'MojoJojo', 'mojo@abc.com', '9876556564', 'python', '6', '2021-12-23 19:11:22'),
(32, 'Blossom', 'buttercup@gmail.com', '9765664564', 'medical', '9', '2021-12-23 19:14:03'),
(33, 'Bubbles', 'bub@fm.com', '7676556566', 'medical', '3', '2021-12-23 19:32:45'),
(34, 'popatlal', 'chitra81289@gmail.com', '7867565454', 'trade', '5', '2021-12-23 19:35:44'),
(35, 'Jacky', 'jack@abc.com', '8765658678', 'medical', '3', '2021-12-23 19:47:52'),
(36, 'fdsf', 'dsfs@son.com', '7545454787', 'python', '5', '2021-12-23 19:50:27'),
(37, 'fgfdg', 'kjkj@hjhk.com', '5656598787', 'python', '8', '2021-12-23 19:51:14'),
(38, 'Flames', 'fla@gmail.com', '8676576565', 'python', '3', '2021-12-23 19:59:59'),
(39, 'Chitra Methwani', 'chits@gmail112.com', '9897767678', 'medical', '3', '2022-01-11 23:24:35'),
(40, 'Demo123', 'keepalladdr@gamillll.c', '9887878788', 'python', '4', '2022-01-11 23:31:17'),
(41, 'Geeks', 'chitra.methwani@gmail.com', '8978676765', 'medical', '8', '2022-01-15 23:43:25'),
(42, 'Nikita', 'nikitanayak330@gmail.com', '8987676766', 'python', '6', '2022-01-16 15:05:20'),
(43, 'Amit', 'sonicemel@gmail.com', '6788867674', 'python', '15', '2022-01-16 15:31:31'),
(44, 'Amit Kumbhar', 'sonicemel@gmail.com', '7867655656', 'python', '15', '2022-01-16 16:21:23'),
(45, 'Chits', 'chitra.methwani@gmail.com', '9787655454', 'medical', '8', '2022-01-16 16:22:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `sno` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
