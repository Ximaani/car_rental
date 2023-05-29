-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2023 at 01:05 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `instructor_evaluation`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `login_sp` (IN `_username` VARCHAR(100), IN `_password` VARCHAR(100))   BEGIN

if EXISTS(SELECT * FROM users WHERE users.username = _username and users.password = MD5(_password))THEN	


if EXISTS(SELECT * FROM users WHERE users.username = _username and 	users.status = 'Active')THEN
 
SELECT * FROM users where users.username = _username;

ELSE

SELECT 'Locked' Msg;

end if;
ELSE


SELECT 'Deny' Msg;

END if;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_level` (IN `_course_id` INT)   BEGIN

SELECT c.Course_id,l.level_id,l.level_name  from course c JOIN level l on c.level_id=l.level_id WHERE c.Course_id=_course_id;




END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `assign_course`
--

CREATE TABLE `assign_course` (
  `assign_course_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  `Course_id` int(11) NOT NULL,
  `level_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assign_course`
--

INSERT INTO `assign_course` (`assign_course_id`, `instructor_id`, `Course_id`, `level_id`) VALUES
(1, 1, 2, 'Intermediate'),
(2, 3, 7, 'Advanced'),
(3, 4, 4, 'Advanced'),
(4, 5, 3, 'Advanced'),
(5, 6, 5, 'Advanced'),
(6, 7, 9, 'Biginer'),
(7, 8, 8, 'Biginer'),
(8, 9, 10, 'Biginer');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `Course_id` int(11) NOT NULL,
  `Course_name` varchar(100) NOT NULL,
  `Course_description` text NOT NULL,
  `level_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`Course_id`, `Course_name`, `Course_description`, `level_id`) VALUES
(1, 'php', 'php for profitional', 1),
(2, 'c#', 'php for profitional', 2),
(3, 'javascript', 'php for profitional', 3),
(4, 'Environmental Science', 'provitional', 3),
(5, 'Java', 'full_java', 3),
(6, 'C++', 'profitional', 3),
(7, 'Python', 'provitional', 3),
(8, 'Ruby', 'biginer_course', 1),
(9, 'HTML/CSS', 'biginer', 1),
(10, 'Front-End Frameworks (e.g., React, Angular)', 'biginer', 1),
(11, 'Back-End Development (e.g., Node.js, Django, Ruby on Rails)', 'provitional', 3);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Department_id` int(11) NOT NULL,
  `darpt_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`Department_id`, `darpt_name`) VALUES
(1, 'Accounting and finance'),
(2, 'Agriculture'),
(3, 'Animal Husbandury'),
(4, 'Bussines Administration'),
(5, 'Banking and Finance'),
(6, 'Biology/Chemistry'),
(7, 'computer science'),
(8, 'Ecnomics');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation`
--

CREATE TABLE `evaluation` (
  `evaluation_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  `Course` varchar(100) NOT NULL,
  `rating_id` int(11) NOT NULL,
  `EvaluationDate` date NOT NULL,
  `Comments` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluation`
--

INSERT INTO `evaluation` (`evaluation_id`, `student_id`, `instructor_id`, `Course`, `rating_id`, `EvaluationDate`, `Comments`, `date`) VALUES
(1, 1, 3, 'Python', 5, '2023-05-05', 'eber waaye\n              ', '2023-05-18 10:39:33');

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `instructor_id` int(11) NOT NULL,
  `fristname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `Department_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructor`
--

INSERT INTO `instructor` (`instructor_id`, `fristname`, `lastname`, `phone`, `city`, `state`, `Department_id`, `date`) VALUES
(1, 'cali', 'faarax', '16682', 'mugdisho', 'banadir', 7, '2023-05-18 07:29:44'),
(3, 'Anwar', 'isaakh', '71662726987', 'mugdisho', 'banadir', 6, '2023-05-18 07:28:30'),
(4, 'shuuriye', 'salaad', '897654567', 'mugdisho', 'banadir', 4, '2023-05-18 07:28:34'),
(5, 'usaama', 'axmed', '87654387654', 'mugdisho', 'banadir', 5, '2023-05-18 07:28:38'),
(6, 'farxaan', 'isaakh', '76543278', 'mugdisho', 'banadir', 3, '2023-05-18 07:28:41'),
(7, 'cismaan', 'nuur', '976543567', 'mugdisho', 'banadir', 7, '2023-05-18 07:28:46'),
(8, 'salaad', 'xaashi', '71662726987', 'mugdisho', 'banadir', 7, '2023-05-18 07:48:33'),
(9, 'abdimaalik', 'nuur', '797867899', 'mugdisho', 'banadir', 7, '2023-05-18 07:28:53'),
(10, 'farxiya', 'cali', '56757869878', 'mugdisho', 'banadir', 7, '2023-05-18 07:28:57');

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE `level` (
  `level_id` int(11) NOT NULL,
  `level_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`level_id`, `level_name`) VALUES
(1, 'Biginer'),
(2, 'Intermediate'),
(3, 'Advanced');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL,
  `rating_name` varchar(100) NOT NULL,
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`rating_id`, `rating_name`, `points`) VALUES
(1, 'Excellent', 100),
(2, 'Good', 50),
(3, 'Fair', 30),
(4, 'Poor', 20),
(5, 'Very Poor', 1);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `fristname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `Department_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `fristname`, `lastname`, `phone`, `Department_id`, `date`) VALUES
(1, 'mohamaed', 'muqtaar', '8765', 7, '2023-05-15 22:58:11'),
(2, 'cali', 'faarax', '26676782', 7, '2023-05-17 05:42:14'),
(3, 'maxamed', 'nuur', '16682', 2, '2023-05-17 20:47:02'),
(4, 'abdifitaax', 'mohamed', '6182928920', 6, '2023-05-17 21:07:06'),
(5, 'abdalla', 'axmed', '8765456', 1, '2023-05-17 21:07:23'),
(6, 'xasan', 'cismaan', '965467', 4, '2023-05-17 21:07:59'),
(7, 'liibaan', 'abduwali', '89765', 7, '2023-05-17 21:08:22'),
(8, 'cabdikaafi', 'cusmaan', '8765678', 3, '2023-05-17 21:08:40'),
(9, 'shamso', 'saciid', '615272767', 3, '2023-05-18 08:01:58'),
(10, 'najmo', 'nuur', '612566762', 5, '2023-05-18 08:02:18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(100) NOT NULL,
  `student_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'active',
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `student_id`, `username`, `password`, `image`, `status`, `date`) VALUES
('USR001', 1, 'moha', '202cb962ac59075b964b07152d234b70', 'USR001.png', 'active', '2023-05-16 20:31:22'),
('USR002', 2, 'cali', '202cb962ac59075b964b07152d234b70', 'USR002.png', 'active', '2023-05-17 20:44:11'),
('USR003', 3, 'maxamed', '202cb962ac59075b964b07152d234b70', 'USR003.png', 'active', '2023-05-17 20:47:31'),
('USR004', 4, 'abdi', '202cb962ac59075b964b07152d234b70', 'USR004.png', 'active', '2023-05-17 21:09:16'),
('USR005', 5, 'abdalla', '202cb962ac59075b964b07152d234b70', 'USR005.png', 'active', '2023-05-17 21:09:35'),
('USR006', 6, 'xasan', '202cb962ac59075b964b07152d234b70', 'USR006.png', 'active', '2023-05-17 21:09:55'),
('USR007', 7, 'liibaan', '202cb962ac59075b964b07152d234b70', 'USR007.png', 'active', '2023-05-17 21:10:15'),
('USR008', 8, 'kaafi', '202cb962ac59075b964b07152d234b70', 'USR008.png', 'active', '2023-05-17 21:10:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assign_course`
--
ALTER TABLE `assign_course`
  ADD PRIMARY KEY (`assign_course_id`),
  ADD KEY `Course_id` (`Course_id`),
  ADD KEY `instructor_id` (`instructor_id`),
  ADD KEY `level_id` (`level_id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`Course_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Department_id`);

--
-- Indexes for table `evaluation`
--
ALTER TABLE `evaluation`
  ADD PRIMARY KEY (`evaluation_id`),
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD KEY `instructor_id` (`instructor_id`),
  ADD KEY `rating_id` (`rating_id`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`level_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`rating_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assign_course`
--
ALTER TABLE `assign_course`
  MODIFY `assign_course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `Course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `Department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `evaluation`
--
ALTER TABLE `evaluation`
  MODIFY `evaluation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `instructor`
--
ALTER TABLE `instructor`
  MODIFY `instructor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
  MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assign_course`
--
ALTER TABLE `assign_course`
  ADD CONSTRAINT `assign_course_ibfk_1` FOREIGN KEY (`Course_id`) REFERENCES `course` (`Course_id`),
  ADD CONSTRAINT `assign_course_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`);

--
-- Constraints for table `evaluation`
--
ALTER TABLE `evaluation`
  ADD CONSTRAINT `evaluation_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `evaluation_ibfk_3` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`),
  ADD CONSTRAINT `evaluation_ibfk_4` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
