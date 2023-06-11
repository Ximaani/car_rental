-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 11, 2023 at 07:35 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rentaldb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_charging` (IN `_month_id` INT, IN `_year` VARCHAR(50), IN `_description` TEXT, IN `_account_id` INT, IN `_user_id` VARCHAR(100))   BEGIN

if(read_salary() > read_balance(_account_id))THEN

SELECT "Deny" as msg;
ELSE
INSERT IGNORE INTO `charge`(`emp_id`, `title_id`, `Amount`, `month_id`, `year`, `description`, `account_id`,`user_id`, `date`)
SELECT e.emp_id,j.title_id,j.salary,_month_id,_year,_description,_account_id,_user_id,
CURRENT_DATE from employee e JOIN jop_title j on e.title_id=j.title_id;

if(row_count()> 0)THEN
SELECT "Registered" as msg;

ELSE

SELECT "Not" as msg;
END IF;
END IF;
 
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_rent_price` (IN `_customers_id` INT)   BEGIN
SELECT ca.car_id,ca.car_name,ca.rental_price, r.taken_date,r.return_date,TIMESTAMPDIFF(DAY,r.taken_date,r.return_date)*ca.rental_price as Total_amount from rent r JOIN car ca on r.car_id=ca.car_id JOIN customer c on r.customer_id=c.customer_id where r.customer_id=_customers_id;


END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `read_balance` (`_account_id` INT) RETURNS INT(11)  BEGIN
set @balance=0.00;
SELECT sum(balance)into @balance from account
WHERE account_id =_account_id;
RETURN @balance;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `read_salary` () RETURNS DECIMAL(11,2)  BEGIN
set @salary=0.00;

SELECT sum(salary)into @salary from jop_title;

RETURN @salary;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `account_id` int(11) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `holder_name` varchar(100) NOT NULL,
  `account_number` varchar(100) NOT NULL,
  `balance` decimal(10,0) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`account_id`, `bank_name`, `holder_name`, `account_number`, `balance`, `date`) VALUES
(1, 'Salaam Bank', 'Mohamed Abdullahi Omer', '1234567', '3920', '2023-06-10 08:09:22'),
(2, 'dahabshiil', 'garaad xuseen', '12345', '0', '2023-06-10 08:10:01'),
(3, 'Premmier Bank', 'Raashid moalim', '123459', '4820', '2023-06-08 20:06:38');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `bill_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `month` varchar(100) NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`bill_id`, `emp_id`, `month`, `amount`, `user_id`, `account_id`, `date`) VALUES
(3, 1, '1', '0.00', 1, 1, '0000-00-00'),
(11, 2, '2', '250.00', 0, 2, '2023-05-31'),
(13, 1, '2', '250.00', 0, 2, '2023-06-03');

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_name`, `address`, `date`) VALUES
(1, 'bakaaro', 'hodan', '2023-05-21 09:07:19'),
(2, 'Bulsho2', 'KM4', '2023-05-23 17:38:34'),
(6, 'Bulsho3', 'Sanco', '2023-05-23 18:08:58'),
(7, 'Bulsho4', 'Warshadaha', '2023-05-23 18:17:01'),
(8, 'Bulsho5', 'Ceelasha', '2023-05-27 08:36:45'),
(9, 'bulsho5', 'bakaaro', '2023-05-29 10:32:09');

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

CREATE TABLE `car` (
  `car_id` int(11) NOT NULL,
  `car_name` varchar(100) NOT NULL,
  `car_number` varchar(100) NOT NULL,
  `modal_id` int(11) NOT NULL,
  `transmission_id` int(11) NOT NULL,
  `type_fuel_id` int(11) NOT NULL,
  `rental_price` float NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`car_id`, `car_name`, `car_number`, `modal_id`, `transmission_id`, `type_fuel_id`, `rental_price`, `data`) VALUES
(1, 'hondia', 'abv12', 3, 2, 3, 80, '2023-05-29 08:17:48'),
(2, 'zuzuki', 'b123', 2, 2, 4, 50, '2023-05-29 08:18:25'),
(4, 'barada', '1234', 2, 1, 3, 180, '2023-06-10 08:25:33'),
(5, 'marshedis', 'ab1213', 6, 1, 3, 60, '2023-06-03 19:31:48');

-- --------------------------------------------------------

--
-- Table structure for table `charge`
--

CREATE TABLE `charge` (
  `charge_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `title_id` int(11) NOT NULL,
  `Amount` decimal(12,0) NOT NULL,
  `month_id` int(11) NOT NULL,
  `year` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `charge`
--

INSERT INTO `charge` (`charge_id`, `emp_id`, `title_id`, `Amount`, `month_id`, `year`, `description`, `account_id`, `user_id`, `date`) VALUES
(1, 2, 1, '180', 1, '2023', 'mushaar', 2, 'USR001', '2023-06-09 21:00:00'),
(2, 2, 1, '180', 2, '2023', 'mushaar', 1, 'USR001', '2023-06-09 21:00:00'),
(3, 2, 1, '180', 3, '2023', 'mushaar', 1, 'USR001', '2023-06-09 21:00:00'),
(4, 2, 1, '180', 5, '2023', 'mushaar', 1, 'USR001', '2023-06-09 21:00:00'),
(5, 2, 1, '180', 6, '2023', 'mushaar', 2, 'USR001', '2023-06-09 21:00:00');

--
-- Triggers `charge`
--
DELIMITER $$
CREATE TRIGGER `update_balance` AFTER INSERT ON `charge` FOR EACH ROW BEGIN

UPDATE account SET balance=balance-new.amount WHERE
account_id=new.account_id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `fristname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `fristname`, `lastname`, `phone`, `city`, `state`, `date`) VALUES
(1, 'mohamed', 'abdullahi', '615325823', 'Darulsalaam', 'mogadisho', '2023-05-23 10:25:05'),
(3, 'jaamac', 'yabarow', '989898', 'Darulsalaam', 'mogadisho', '2023-05-23 17:21:02'),
(4, 'faarax', 'gedi', '78798', 'mogadisho', 'xamar', '2023-05-26 08:42:08'),
(5, 'hasan', 'jamaal', '6544332', 'Darulsalaam', 'mogadisho', '2023-05-26 08:42:26'),
(6, 'libaana', 'geedi', '65456456', 'Darulsalaam', 'mogadisho', '2023-05-26 08:42:47'),
(7, 'yaxye', 'haashi', '6544332', 'Darulsalaam', 'mogadisho', '2023-05-26 09:07:17'),
(8, 'bashiir', 'ciise', '4453434', 'Darulsalaam', 'mogadisho', '2023-05-26 10:14:11');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `emp_first_name` varchar(100) NOT NULL,
  `emp_last_name` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `title_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `emp_first_name`, `emp_last_name`, `phone`, `address`, `title_id`, `branch_id`, `date`) VALUES
(1, 'anwar', 'km', '6544332', 'kraan', 2, 1, '2023-06-08 19:59:47'),
(2, 'kaariye', 'yuusuf', '6544332', 'karaan', 1, 1, '2023-06-10 08:04:46');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` varchar(100) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `car_id` varchar(40) NOT NULL,
  `rental_price` decimal(12,0) NOT NULL,
  `taken_date` date NOT NULL,
  `return_date` date NOT NULL,
  `total_amount` decimal(12,0) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoice_id`, `customer_id`, `car_id`, `rental_price`, `taken_date`, `return_date`, `total_amount`, `date`) VALUES
('INV001', 3, 'barada', '180', '2023-06-01', '2023-06-22', '3780', '2023-06-10 13:59:50'),
('INV002', 3, 'barada', '180', '2023-06-01', '2023-06-22', '3780', '2023-06-10 14:00:01'),
('INV003', 1, 'zuzuki', '50', '2023-06-01', '2023-06-16', '750', '2023-06-10 14:00:14'),
('INV004', 3, 'barada', '180', '2023-06-01', '2023-06-22', '3780', '2023-06-10 14:08:44'),
('INV005', 1, 'zuzuki', '50', '2023-06-01', '2023-06-16', '750', '2023-06-10 14:12:14');

-- --------------------------------------------------------

--
-- Table structure for table `jop_title`
--

CREATE TABLE `jop_title` (
  `title_id` int(11) NOT NULL,
  `position` varchar(100) NOT NULL,
  `salary` float NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jop_title`
--

INSERT INTO `jop_title` (`title_id`, `position`, `salary`, `date`) VALUES
(1, 'cleaner', 180, '2023-06-08 20:19:39');

-- --------------------------------------------------------

--
-- Table structure for table `modal`
--

CREATE TABLE `modal` (
  `modal_id` int(11) NOT NULL,
  `modal_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `modal`
--

INSERT INTO `modal` (`modal_id`, `modal_name`) VALUES
(1, 'modal c'),
(2, 'modal b'),
(3, 'g145'),
(6, 'c12');

-- --------------------------------------------------------

--
-- Table structure for table `month`
--

CREATE TABLE `month` (
  `month_id` int(11) NOT NULL,
  `month_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `month`
--

INSERT INTO `month` (`month_id`, `month_name`) VALUES
(1, 'jan'),
(2, 'feb'),
(3, 'march'),
(4, 'april'),
(5, 'may'),
(6, 'jun'),
(7, 'july');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `customer_id`, `amount`, `payment_method_id`, `account_id`, `date`) VALUES
(4, 3, '1760.00', 6, 2, '2023-06-10 09:10:14');

--
-- Triggers `payment`
--
DELIMITER $$
CREATE TRIGGER `update_price` AFTER INSERT ON `payment` FOR EACH ROW begin

UPDATE rent SET Total_amount=Total_amount-new.amount
WHERE customer_id=customer_id;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `payment_method_id` int(11) NOT NULL,
  `method_name` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`payment_method_id`, `method_name`, `date`) VALUES
(1, 'evc', '2023-05-28 20:15:45'),
(6, 'Banking', '2023-05-28 20:16:28');

-- --------------------------------------------------------

--
-- Table structure for table `rent`
--

CREATE TABLE `rent` (
  `rent_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `taken_date` varchar(200) NOT NULL,
  `return_date` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rent`
--

INSERT INTO `rent` (`rent_id`, `customer_id`, `car_id`, `taken_date`, `return_date`, `date`) VALUES
(1, 3, 4, '2023-06-01', '2023-06-22', '2023-06-10 09:56:38'),
(5, 1, 2, '2023-06-01', '2023-06-16', '2023-06-10 12:43:43');

-- --------------------------------------------------------

--
-- Table structure for table `transmission`
--

CREATE TABLE `transmission` (
  `transmission_id` int(11) NOT NULL,
  `transmission_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transmission`
--

INSERT INTO `transmission` (`transmission_id`, `transmission_name`) VALUES
(1, 'manual'),
(2, 'auto');

-- --------------------------------------------------------

--
-- Table structure for table `typefuel`
--

CREATE TABLE `typefuel` (
  `type_fuel_id` int(11) NOT NULL,
  `fuel_name` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `typefuel`
--

INSERT INTO `typefuel` (`type_fuel_id`, `fuel_name`, `date`) VALUES
(3, 'Dissal', '2023-05-22 09:28:12'),
(4, 'Fuel', '2023-05-22 09:28:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(100) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'active',
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `emp_id`, `username`, `password`, `image`, `status`, `date`) VALUES
('USR001', 1, 'anwar', '81dc9bdb52d04dc20036dbd8313ed055', 'USR001.png', 'active', '2023-06-08 20:53:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`bill_id`),
  ADD KEY `emp_id` (`emp_id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`);

--
-- Indexes for table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`car_id`),
  ADD KEY `modal_id` (`modal_id`),
  ADD KEY `transmission_id` (`transmission_id`),
  ADD KEY `type_fuel_id` (`type_fuel_id`);

--
-- Indexes for table `charge`
--
ALTER TABLE `charge`
  ADD PRIMARY KEY (`charge_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `title_id` (`title_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD KEY `car_id` (`car_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `jop_title`
--
ALTER TABLE `jop_title`
  ADD PRIMARY KEY (`title_id`);

--
-- Indexes for table `modal`
--
ALTER TABLE `modal`
  ADD PRIMARY KEY (`modal_id`);

--
-- Indexes for table `month`
--
ALTER TABLE `month`
  ADD PRIMARY KEY (`month_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `Course_id` (`payment_method_id`),
  ADD KEY `instructor_id` (`customer_id`),
  ADD KEY `level_id` (`account_id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`payment_method_id`);

--
-- Indexes for table `rent`
--
ALTER TABLE `rent`
  ADD PRIMARY KEY (`rent_id`),
  ADD UNIQUE KEY `student_id` (`customer_id`),
  ADD KEY `instructor_id` (`car_id`);

--
-- Indexes for table `transmission`
--
ALTER TABLE `transmission`
  ADD PRIMARY KEY (`transmission_id`);

--
-- Indexes for table `typefuel`
--
ALTER TABLE `typefuel`
  ADD PRIMARY KEY (`type_fuel_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD KEY `student_id` (`emp_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `car`
--
ALTER TABLE `car`
  MODIFY `car_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `charge`
--
ALTER TABLE `charge`
  MODIFY `charge_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jop_title`
--
ALTER TABLE `jop_title`
  MODIFY `title_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `modal`
--
ALTER TABLE `modal`
  MODIFY `modal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `month`
--
ALTER TABLE `month`
  MODIFY `month_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rent`
--
ALTER TABLE `rent`
  MODIFY `rent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transmission`
--
ALTER TABLE `transmission`
  MODIFY `transmission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `typefuel`
--
ALTER TABLE `typefuel`
  MODIFY `type_fuel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`),
  ADD CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`);

--
-- Constraints for table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`modal_id`) REFERENCES `modal` (`modal_id`),
  ADD CONSTRAINT `car_ibfk_2` FOREIGN KEY (`transmission_id`) REFERENCES `transmission` (`transmission_id`),
  ADD CONSTRAINT `car_ibfk_3` FOREIGN KEY (`type_fuel_id`) REFERENCES `typefuel` (`type_fuel_id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `jop_title` (`title_id`),
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  ADD CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`);

--
-- Constraints for table `rent`
--
ALTER TABLE `rent`
  ADD CONSTRAINT `rent_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `rent_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `update_accoun` ON SCHEDULE EVERY 1 DAY STARTS '2023-05-29 09:40:16' ON COMPLETION NOT PRESERVE ENABLE DO update rent set rent_price=rent_price+80 where rent_id=rent_id AND status = 'prossing'$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
