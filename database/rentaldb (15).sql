-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 27, 2023 at 06:30 PM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `amount_pl` (IN `_emp_id` INT)   BEGIN

SELECT sum(Amount) as salary FROM charge WHERE emp_id=_emp_id
and active='Charged';


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fff` ()   BEGIN

SELECT concat(cu.fristname,' ',cu.lastname) AS customer_name,c.car_name, r.taken_date,r.return_date FROM rent r JOIN customer cu ON r.customer_id=cu.customer_id JOIN car c on r.car_id=c.car_id;

END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `invoice_report` (IN `_tellophone` INT)   BEGIN
if(_tellophone = '0000-00-00')THEN
SELECT concat(c.fristname,' ',c.lastname) AS customer_name,i.car_id AS Car_name,i.rental_price AS Rent_Per_day,i.taken_date,i.return_date,i.total_amount FROM invoice i JOIN rent r ON i.rent_id=r.rent_id JOIN customer c ON r.customer_id=c.customer_id;
ELSE
SELECT concat(c.fristname,' ',c.lastname) AS customer_name,i.car_id AS Car_name,i.rental_price AS Rent_Per_day,i.taken_date,i.return_date,i.total_amount FROM invoice i JOIN rent r ON i.rent_id=r.rent_id JOIN customer c ON r.customer_id=c.customer_id WHERE c.phone =_tellophone;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `payment_repo` (IN `_tellphone` INT)   BEGIN
if(_tellphone = '0000-00-00')THEN
SELECT concat(c.fristname,' ',c.lastname) AS customer_name,p.amount,a.bank_name FROM payment p JOIN rent r ON p.rent_id=r.rent_id JOIN customer c ON r.customer_id=c.customer_id JOIN account a ON p.account_id=a.account_id;
ELSE
SELECT concat(c.fristname,' ',c.lastname) AS customer_name,p.amount,a.bank_name FROM payment p JOIN rent r ON p.rent_id=r.rent_id JOIN customer c ON r.customer_id=c.customer_id JOIN account a ON p.account_id=a.account_id WHERE c.phone=_tellphone;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_all_rent_per_day` (IN `_rent_id` INT)   BEGIN

SELECT r.rent_id,c.car_name,c.rental_price,r.taken_date,r.return_date, TIMESTAMPDIFF(DAY,r.taken_date,r.return_date)*r.quantity*c.rental_price as amount from rent r JOIN car c on r.car_id=c.car_id where r.rent_id=_rent_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_bill_repot` (IN `_tellphone` INT)   BEGIN
if(_tellphone= '0000-00-00')THEN
SELECT concat(e.emp_first_name, ' ', e.emp_last_name) as employe_name,b.amount as salary, b.user,b.date from bill b JOIN employee e on b.emp_id=e.emp_id;
else
SELECT concat(e.emp_first_name, ' ', e.emp_last_name) as employe_name,b.amount as salary, b.user,b.date from bill b JOIN employee e on b.emp_id=e.emp_id WHERE e.phone=_tellphone;
END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_charge_repo` (IN `_month_name` VARCHAR(100))   BEGIN

SELECT concat(e.emp_first_name,' ',e.emp_last_name) AS employee_name,j.position,m.month_name,ch.year,ch.description,a.bank_name,ch.user_id as user FROM charge ch JOIN employee e ON ch.emp_id=e.emp_id JOIN jop_title j ON ch.title_id=j.title_id JOIN month m ON ch.month_id=m.month_id JOIN account a ON ch.account_id=a.account_id WHERE active ='Charged' and m.month_name=_month_name;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_customer_rent_car` (IN `_rent_id` INT)   BEGIN
SELECT  r.rent_id,c.car_id,r.quantity from rent r JOIN car c on r.car_id=c.car_id
WHERE r.action='paid' AND r.rent_id=_rent_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_level` (IN `_course_id` INT)   BEGIN

SELECT c.Course_id,l.level_id,l.level_name  from course c JOIN level l on c.level_id=l.level_id WHERE c.Course_id=_course_id;




END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_rent_price` (IN `_rent_id` INT)   BEGIN
SELECT i.total_amount from invoice i  WHERE i.rent_id=_rent_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_expense_sp` (IN `_id` INT, IN `_amount` FLOAT(12,0), IN `_type` VARCHAR(100), IN `_desc` TEXT, IN `_userId` VARCHAR(100), IN `_Account_id` INT)   BEGIN
 if(_type = 'Expense')THEN

if((SELECT read_balance(_Account_id) < _amount))THEN

SELECT 'Deny' as Message;

ELSE

INSERT into expense(expense.amount,expense.type,expense.description,expense.user_id,expense.Account_id)
VALUES(_amount,_type,_desc,_userId,_Account_id);

SELECT 'Registered' as Message;

END if;
ELSE
if(_type = 'Expense')THEN

if((SELECT read_balance(_Account_id) < _amount))THEN

SELECT 'Deny' as Message;
END IF;
ELSE
if EXISTS( SELECT * FROM expense WHERE expense.id = _id)THEN
UPDATE expense SET expense.amount = _amount, expense.type = _type, expense.description = _desc,expense.user_id=_userId,expense.Account_id=_Account_id
WHERE expense.id = _id;

SELECT 'Updated' as Message;
ELSE

INSERT into expense(expense.amount,expense.type,expense.description,expense.user_id,expense.Account_id)
VALUES(_amount,_type,_desc,_userId,_Account_id);

SELECT 'Registered' as Message;

END if;
END IF;

END if;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rent_cars` (IN `_customer_id` INT, IN `_car_id` INT, IN `_quantity` INT, IN `_taken_date` DATE, IN `_return_date` DATE)   BEGIN

if(_quantity > read_quantity(_car_id))THEN

SELECT 'Deny' AS massage;

ELSE
INSERT INTO rent(customer_id,car_id,quantity,taken_date,return_date)VALUES
(_customer_id,_car_id,_quantity,_taken_date,_return_date
);

SELECT 'Registered' AS massage;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rent_repo` (IN `_car_name` VARCHAR(100))   BEGIN
if(_car_name = ' ')THEN
SELECT concat(cu.fristname,' ',cu.lastname) AS Customer_name,c.car_name,r.taken_date,r.return_date FROM rent r JOIN customer cu ON r.customer_id=cu.customer_id JOIN car c ON r.car_id=c.car_id;
ELSE
SELECT concat(cu.fristname,' ',cu.lastname) AS Customer_name,c.car_name,r.taken_date,r.return_date FROM rent r JOIN customer cu ON r.customer_id=cu.customer_id JOIN car c ON r.car_id=c.car_id WHERE c.car_name =_car_name;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `return_car_insert` (IN `_rent_id` INT, IN `_car_id` VARCHAR(40), IN `_quantity` INT, IN `_rt_quantity` INT, IN `_return_date` DATE)   BEGIN

if(_rt_quantity > _quantity)THEN

SELECT 'Deny' as msg;
ELSE
INSERT INTO `returncar`(`rent_id`, `car_id`, `quantity`, `rt_quantity`, `return_date`) 
VALUES (_rent_id,_car_id,_quantity,_rt_quantity,_return_date);
SELECT 'Registered' as msg;
END if;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_balance_fn` (`_userId` VARCHAR(50)) RETURNS FLOAT(12,0)  BEGIN

SET @balance= 00.0;

SET @income = (SELECT SUM(expense.amount) FROM expense WHERE
              expense.type='income' AND expense.user_id= _userId);


SET @expense = (SELECT SUM(expense.amount) FROM expense WHERE
              expense.type='Expense' AND expense.user_id= _userId);

SET @balance = (ifnull(@income,0) - ifnull(@expense,0));

RETURN @balance;


END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `read_balance` (`_account_id` INT) RETURNS INT(11)  BEGIN
set @balance=0.00;
SELECT sum(balance)into @balance from account
WHERE account_id =_account_id;
RETURN @balance;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `read_quantity` (`_car_id` INT) RETURNS INT(11)  BEGIN
set @quantity=0.00;
SELECT sum(quantity)into @quantity from car
WHERE car_id =_car_id;
RETURN @quantity;

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
(1, 'Salaam Bank', 'Mohamed Abdullahi Omer', '1234567', '14854', '2023-06-27 16:15:56'),
(2, 'dahabshiil', 'garaad xuseen', '12345', '3810', '2023-06-27 16:13:48'),
(3, 'Premmier Bank', 'Raashid moalim', '123459', '19880', '2023-06-18 11:00:58');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `bill_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `user` varchar(40) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`bill_id`, `emp_id`, `amount`, `user`, `date`) VALUES
(1, 3, '180.00', 'ximaani', '2023-06-16 11:14:51'),
(2, 6, '180.00', 'ximaani', '2023-06-16 13:11:20'),
(3, 2, '360.00', 'misbil', '2023-06-18 11:03:47'),
(4, 8, '500.00', 'misbil', '2023-06-18 11:04:09');

--
-- Triggers `bill`
--
DELIMITER $$
CREATE TRIGGER `update_active` AFTER INSERT ON `bill` FOR EACH ROW BEGIN

update charge set active ='Received'
WHERE emp_id=new.emp_id;


END
$$
DELIMITER ;

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
  `conditions_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` varchar(200) NOT NULL DEFAULT 'availible',
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`car_id`, `car_name`, `car_number`, `modal_id`, `transmission_id`, `type_fuel_id`, `rental_price`, `conditions_id`, `quantity`, `status`, `data`) VALUES
(1, 'Lanbo Geni', 'AB123', 1, 1, 3, 100, 1, 32, 'availible', '2023-06-27 16:10:28'),
(2, 'hondia', 'AB134', 2, 2, 3, 80, 2, 13, 'availible', '2023-06-27 15:19:29'),
(3, 'bmw', 'AD1234', 3, 1, 4, 120, 2, 4, 'availible', '2023-06-27 16:16:16'),
(4, 'marcedes', 'AC2354', 6, 2, 4, 150, 1, 14, 'availible', '2023-06-26 10:27:52'),
(5, 'barada', 'AB2345', 2, 1, 3, 100, 1, 3, 'availible', '2023-06-26 10:58:56');

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
  `active` varchar(100) NOT NULL DEFAULT 'Charged',
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `charge`
--

INSERT INTO `charge` (`charge_id`, `emp_id`, `title_id`, `Amount`, `month_id`, `year`, `description`, `account_id`, `user_id`, `active`, `date`) VALUES
(1, 2, 1, '180', 1, '2023', 'mushaar', 3, 'ximaani', 'Received', '2023-06-18 11:03:47'),
(2, 3, 1, '180', 1, '2023', 'mushaar', 3, 'ximaani', 'Received', '2023-06-16 11:14:51'),
(3, 5, 1, '180', 1, '2023', 'mushaar', 3, 'ximaani', 'Charged', '2023-06-15 21:00:00'),
(4, 6, 1, '180', 1, '2023', 'mushaar', 3, 'ximaani', 'Received', '2023-06-16 13:11:20'),
(5, 7, 1, '180', 1, '2023', 'mushaar', 3, 'ximaani', 'Charged', '2023-06-15 21:00:00'),
(6, 1, 2, '800', 1, '2023', 'mushaar', 3, 'ximaani', 'Charged', '2023-06-15 21:00:00'),
(7, 4, 2, '800', 1, '2023', 'mushaar', 3, 'ximaani', 'Charged', '2023-06-15 21:00:00'),
(8, 2, 1, '180', 2, '2023', 'mushaar', 3, 'misbil', 'Received', '2023-06-18 11:03:47'),
(9, 3, 1, '180', 2, '2023', 'mushaar', 3, 'misbil', 'Charged', '2023-06-17 21:00:00'),
(10, 5, 1, '180', 2, '2023', 'mushaar', 3, 'misbil', 'Charged', '2023-06-17 21:00:00'),
(11, 6, 1, '180', 2, '2023', 'mushaar', 3, 'misbil', 'Charged', '2023-06-17 21:00:00'),
(12, 7, 1, '180', 2, '2023', 'mushaar', 3, 'misbil', 'Charged', '2023-06-17 21:00:00'),
(13, 1, 2, '800', 2, '2023', 'mushaar', 3, 'misbil', 'Charged', '2023-06-17 21:00:00'),
(14, 4, 2, '800', 2, '2023', 'mushaar', 3, 'misbil', 'Charged', '2023-06-17 21:00:00'),
(15, 8, 3, '500', 2, '2023', 'mushaar', 3, 'misbil', 'Received', '2023-06-18 11:04:09');

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
-- Table structure for table `conditions`
--

CREATE TABLE `conditions` (
  `conditions_id` int(11) NOT NULL,
  `conditions_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `conditions`
--

INSERT INTO `conditions` (`conditions_id`, `conditions_name`) VALUES
(1, 'Brand_new'),
(2, 'Used');

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
(8, 'bashiir', 'ciise', '4453434', 'Darulsalaam', 'mogadisho', '2023-05-26 10:14:11'),
(11, 'misbil', 'feysal', '78758', 'banaadir', 'xamar', '2023-06-18 10:45:23');

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
(2, 'kaariye', 'yuusuf', '6544332', 'karaan', 1, 1, '2023-06-10 08:04:46'),
(3, 'kk', 'hh', '6544332', 'karaan', 1, 1, '2023-06-11 18:40:20'),
(4, 'ximaa', 'ni', '64753', 'karaan', 2, 1, '2023-06-12 12:43:52'),
(5, 'yuusuf', 'xasan', '566656', 'hodan', 1, 2, '2023-06-12 16:51:14'),
(6, 'paana', 'abdi', '7676767', 'bakaaro', 1, 7, '2023-06-16 06:43:37'),
(7, 'adirahmaac', 'km', '5657657', 'karaan', 1, 8, '2023-06-13 09:32:13'),
(8, 'misbil', 'feysal', '678687', 'karaan', 3, 1, '2023-06-18 10:42:39');

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` int(11) NOT NULL,
  `amount` float(11,2) NOT NULL,
  `type` varchar(15) NOT NULL,
  `description` text NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `Account_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`id`, `amount`, `type`, `description`, `user_id`, `Account_id`, `date`) VALUES
(1, 100.00, 'Expense', 'mushaar', 'ximaani', 2, '2023-06-12 16:29:04'),
(2, 500.00, 'Income', 'xayeesiin', 'ximaani', 2, '2023-06-12 18:53:19'),
(3, 100.00, 'Income', 'kiro', 'ximaani', 1, '2023-06-14 14:29:06'),
(4, 100.00, 'Expense', 'mushaar', 'ximaani', 1, '2023-06-14 14:29:43'),
(5, 100.00, 'Income', 'adverticement', 'ximaani', 1, '2023-06-16 06:45:02'),
(6, 100.00, 'Income', 'share', 'misbil', 1, '2023-06-18 10:56:43'),
(7, 50.00, 'Income', 'mmm', 'ximaani', 1, '2023-06-19 13:41:32'),
(8, 66.00, 'Income', 'mudss', 'ximaani', 1, '2023-06-19 14:06:11');

--
-- Triggers `expense`
--
DELIMITER $$
CREATE TRIGGER `update_accountt` AFTER INSERT ON `expense` FOR EACH ROW BEGIN
    IF NEW.type = 'Income' THEN
        UPDATE account
        SET balance = balance+new.amount
        WHERE account_id=new.Account_id;
        
        ELSE
                UPDATE account
        SET balance = balance-new.amount
        WHERE account_id=new.Account_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` varchar(100) NOT NULL,
  `rent_id` int(11) NOT NULL,
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

INSERT INTO `invoice` (`invoice_id`, `rent_id`, `car_id`, `rental_price`, `taken_date`, `return_date`, `total_amount`, `date`) VALUES
('INV001', 1, 'Lanbo Geni', '100', '2023-06-27', '2023-06-30', '300', '2023-06-27 16:09:50'),
('INV002', 2, 'bmw', '120', '2023-06-27', '2023-06-29', '240', '2023-06-27 16:13:33'),
('INV003', 3, 'bmw', '120', '2023-06-27', '2023-07-01', '480', '2023-06-27 16:15:35');

--
-- Triggers `invoice`
--
DELIMITER $$
CREATE TRIGGER `update_invoice_active` AFTER INSERT ON `invoice` FOR EACH ROW BEGIN

update rent r set r.action ='Invoiced'
WHERE r.rent_id=new.rent_id;


END
$$
DELIMITER ;

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
(1, 'cleaner', 180, '2023-06-08 20:19:39'),
(2, 'manager', 800, '2023-06-12 10:16:01'),
(3, 'Renter', 500, '2023-06-16 06:52:31');

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
  `rent_id` int(11) NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `rent_id`, `amount`, `payment_method_id`, `account_id`, `date`) VALUES
(1, 1, '300.00', 6, 2, '2023-06-27 16:10:10'),
(2, 2, '240.00', 6, 2, '2023-06-27 16:13:48'),
(3, 3, '480.00', 1, 1, '2023-06-27 16:15:56');

--
-- Triggers `payment`
--
DELIMITER $$
CREATE TRIGGER `update_acount_balance` BEFORE INSERT ON `payment` FOR EACH ROW BEGIN
UPDATE account SET balance= balance+new.amount
WHERE account_id=new.account_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_rent_paid_active` BEFORE INSERT ON `payment` FOR EACH ROW BEGIN

update rent set action ='Paid'
WHERE rent_id=new.rent_id;


END
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
  `quantity` int(11) NOT NULL,
  `taken_date` varchar(200) NOT NULL,
  `return_date` varchar(100) NOT NULL,
  `action` varchar(50) NOT NULL DEFAULT 'pending',
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rent`
--

INSERT INTO `rent` (`rent_id`, `customer_id`, `car_id`, `quantity`, `taken_date`, `return_date`, `action`, `date`) VALUES
(1, 1, 1, 1, '2023-06-27', '2023-06-30', 'Returned', '2023-06-27 16:10:28'),
(2, 1, 3, 1, '2023-06-27', '2023-06-29', 'Returned', '2023-06-27 16:14:08'),
(3, 1, 3, 1, '2023-06-27', '2023-07-01', 'Returned', '2023-06-27 16:16:16');

--
-- Triggers `rent`
--
DELIMITER $$
CREATE TRIGGER `test2` AFTER INSERT ON `rent` FOR EACH ROW BEGIN
Update car set status = 'unavialible'
where quantity =0 and car_id = new.car_id;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `yes` AFTER INSERT ON `rent` FOR EACH ROW BEGIN 
Update car set quantity = quantity - NEW.quantity
where car_id = NEW.car_id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `returncar`
--

CREATE TABLE `returncar` (
  `returncar_id` int(11) NOT NULL,
  `rent_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `rt_quantity` int(11) NOT NULL,
  `return_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `returncar`
--

INSERT INTO `returncar` (`returncar_id`, `rent_id`, `car_id`, `quantity`, `rt_quantity`, `return_date`) VALUES
(1, 1, 1, 1, 1, '2023-06-27'),
(2, 2, 3, 1, 1, '2023-06-27'),
(3, 3, 3, 1, 1, '2023-06-27');

--
-- Triggers `returncar`
--
DELIMITER $$
CREATE TRIGGER `update_car_quantity` AFTER INSERT ON `returncar` FOR EACH ROW BEGIN 
Update car c set quantity = quantity + NEW.rt_quantity
where c.car_id =NEW.car_id;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_rent_paid` BEFORE INSERT ON `returncar` FOR EACH ROW BEGIN

UPDATE rent r set r.action='Returned' WHERE 
r.rent_id=new.rent_id;

END
$$
DELIMITER ;

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
('USR001', 1, 'anwarr', 'd41d8cd98f00b204e9800998ecf8427e', 'USR001.png', 'active', '2023-06-24 18:17:15'),
('USR002', 3, 'kk', 'd41d8cd98f00b204e9800998ecf8427e', 'USR002.png', 'active', '2023-06-11 19:42:50'),
('USR003', 4, 'ximaani', '81dc9bdb52d04dc20036dbd8313ed055', 'USR003.png', 'active', '2023-06-12 12:44:20'),
('USR004', 8, 'misbil', '81dc9bdb52d04dc20036dbd8313ed055', 'USR004.png', 'active', '2023-06-18 10:44:17');

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
  ADD KEY `emp_id` (`emp_id`);

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
  ADD KEY `type_fuel_id` (`type_fuel_id`),
  ADD KEY `conditions_id` (`conditions_id`);

--
-- Indexes for table `charge`
--
ALTER TABLE `charge`
  ADD PRIMARY KEY (`charge_id`),
  ADD UNIQUE KEY `emp_id` (`emp_id`,`month_id`);

--
-- Indexes for table `conditions`
--
ALTER TABLE `conditions`
  ADD PRIMARY KEY (`conditions_id`);

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
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD KEY `car_id` (`car_id`),
  ADD KEY `customer_id` (`rent_id`);

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
  ADD KEY `instructor_id` (`rent_id`),
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
  ADD KEY `rent_ibfk_1` (`customer_id`);

--
-- Indexes for table `returncar`
--
ALTER TABLE `returncar`
  ADD PRIMARY KEY (`returncar_id`);

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
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `charge_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `conditions`
--
ALTER TABLE `conditions`
  MODIFY `conditions_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `jop_title`
--
ALTER TABLE `jop_title`
  MODIFY `title_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rent`
--
ALTER TABLE `rent`
  MODIFY `rent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `returncar`
--
ALTER TABLE `returncar`
  MODIFY `returncar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- Constraints for table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`modal_id`) REFERENCES `modal` (`modal_id`),
  ADD CONSTRAINT `car_ibfk_2` FOREIGN KEY (`transmission_id`) REFERENCES `transmission` (`transmission_id`),
  ADD CONSTRAINT `car_ibfk_3` FOREIGN KEY (`type_fuel_id`) REFERENCES `typefuel` (`type_fuel_id`),
  ADD CONSTRAINT `car_ibfk_4` FOREIGN KEY (`conditions_id`) REFERENCES `conditions` (`conditions_id`);

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
  ADD CONSTRAINT `rent_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

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
