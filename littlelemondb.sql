-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 22, 2023 at 07:50 PM
-- Server version: 5.7.23
-- PHP Version: 7.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `littlelemondb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`workbench`@`localhost` PROCEDURE `AddBooking` (IN `id` INT, IN `customer_id` INT, IN `table_no` INT, IN `booking_date` DATE)  BEGIN
	INSERT INTO Bookings (BookingID, BookingDate, TableNo, CustomerID, EmployeeID)
	VALUES (id, booking_date, table_no, customer_id, 1);
    SELECT 'New booking added' AS Confirmation FROM Bookings LIMIT 1;
END$$

CREATE DEFINER=`workbench`@`localhost` PROCEDURE `AddValidBooking` (IN `booking_date` DATE, IN `booking_table` INT)  BEGIN
	START TRANSACTION;
		SET @maxID:=0;
        SELECT @maxID:=MAX(BookingID) FROM Bookings;
		INSERT INTO Bookings (BookingID, BookingDate, TableNo, CustomerID, EmployeeID)
        VALUES (@maxID+1, booking_date, booking_table, 1, 1);
		SET @booked:=0;
        SELECT COUNT(BookingID) INTO @booked
		FROM Bookings
		WHERE BookingDate=booking_date AND TableNo=booking_table;
		SELECT IF(@booked>0, CONCAT('Table ',booking_table,' is already booked - booking cancelled'),CONCAT('Table ',booking_table,' is available. Booking committed.')) AS BookingStatus FROM Bookings LIMIT 1;
        IF @booked=0 THEN
			COMMIT;
		ELSE
			ROLLBACK;
		END IF;
END$$

CREATE DEFINER=`workbench`@`localhost` PROCEDURE `CancelOrder` (IN `order_id` INT)  BEGIN
	DELETE FROM Orders WHERE OrderID=order_id;
    SELECT CONCAT('Order ', order_id, ' is cancelled') AS 'Confirmation' FROM Orders LIMIT 1;
END$$

CREATE DEFINER=`workbench`@`localhost` PROCEDURE `CheckBooking` (IN `checkDate` DATE, IN `checkTable` INT)  BEGIN
	SELECT IF(COUNT(BookingID)>0,CONCAT('Table ',checkTable,' is already booked'),CONCAT('Table ',checkTable,' is available')) AS BookingStatus
    FROM Bookings
    WHERE TableNo=checkTable AND BookingDate=checkDate;
END$$

CREATE DEFINER=`workbench`@`localhost` PROCEDURE `DeleteBooking` (IN `id` INT)  BEGIN
	DELETE FROM Bookings WHERE BookingID=id;
    SELECT CONCAT('Booking ', id, ' cancelled') AS Confirmation FROM Bookings LIMIT 1;
END$$

CREATE DEFINER=`workbench`@`localhost` PROCEDURE `GetMaxQuantity` ()  BEGIN
SELECT MAX(Quantity)AS 'Max Quantity in Order' FROM Orders;
END$$

CREATE DEFINER=`workbench`@`localhost` PROCEDURE `new_procedure` ()  BEGIN
SELECT MAX(Quantity)AS 'Max Quantity in Order' FROM Orders;
END$$

CREATE DEFINER=`workbench`@`localhost` PROCEDURE `UpdateBooking` (IN `id` INT, IN `booking_date` DATE)  BEGIN
	UPDATE Bookings SET BookingDate=booking_date WHERE BookingID=id;
    SELECT CONCAT('Booking ', id, ' updated') AS Confirmation FROM Bookings LIMIT 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `BookingID` int(11) NOT NULL,
  `BookingDate` date NOT NULL,
  `TableNo` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `EmployeeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`BookingID`, `BookingDate`, `TableNo`, `CustomerID`, `EmployeeID`) VALUES
(1, '2022-10-10', 5, 1, 1),
(2, '2022-11-12', 3, 3, 1),
(3, '2023-01-02', 2, 2, 1),
(4, '2022-10-13', 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL,
  `FullName` varchar(255) NOT NULL,
  `ContactNumber` int(11) NOT NULL,
  `Email` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustomerID`, `FullName`, `ContactNumber`, `Email`) VALUES
(1, 'Jack Sparrow', 99365401, 'jack@gmain.com'),
(2, 'Amitabh Bachan', 965401, 'ab@gmain.com'),
(3, 'Orhan Pumak', 9065401, 'orri@gmain.com');

-- --------------------------------------------------------

--
-- Table structure for table `deliverystatus`
--

CREATE TABLE `deliverystatus` (
  `DeliveryID` int(11) NOT NULL,
  `DeliveryDate` date NOT NULL,
  `DeliveryStatus` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `deliverystatus`
--

INSERT INTO `deliverystatus` (`DeliveryID`, `DeliveryDate`, `DeliveryStatus`) VALUES
(1, '2023-03-22', '1'),
(2, '2023-03-01', '0');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `FullName` varchar(255) NOT NULL,
  `Role` varchar(45) NOT NULL,
  `Salary` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`EmployeeID`, `FullName`, `Role`, `Salary`) VALUES
(1, 'Kim John', 'Manager', '15000');

-- --------------------------------------------------------

--
-- Table structure for table `menuitems`
--

CREATE TABLE `menuitems` (
  `MenuItemID` int(11) NOT NULL,
  `CourseName` varchar(45) NOT NULL,
  `StarterName` varchar(45) NOT NULL,
  `DessertName` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menuitems`
--

INSERT INTO `menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DessertName`) VALUES
(1, 'Borek', 'Start', 'Tatli'),
(2, 'Baklava', 'Dessert', 'Dessert');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `MenuID` int(11) NOT NULL,
  `Cuisine` varchar(45) NOT NULL,
  `MenuName` varchar(45) NOT NULL,
  `MenuItemID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`MenuID`, `Cuisine`, `MenuName`, `MenuItemID`) VALUES
(1, 'Turkish', 'Hamurlu', 1),
(2, 'Turkish', 'Tatli', 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `OrderDate` date NOT NULL,
  `Quantity` int(11) NOT NULL,
  `TotalCost` decimal(10,0) DEFAULT NULL,
  `BookingID` int(11) NOT NULL,
  `DeliveryID` int(11) NOT NULL,
  `MenuID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`OrderID`, `OrderDate`, `Quantity`, `TotalCost`, `BookingID`, `DeliveryID`, `MenuID`) VALUES
(1, '2023-03-15', 5, '67', 1, 1, 1),
(2, '2023-03-09', 7, '78', 2, 2, 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ordersview`
-- (See below for the actual view)
--
CREATE TABLE `ordersview` (
`OrderID` int(11)
,`Quantity` int(11)
,`TotalCost` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Structure for view `ordersview`
--
DROP TABLE IF EXISTS `ordersview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`workbench`@`localhost` SQL SECURITY DEFINER VIEW `ordersview`  AS SELECT `orders`.`OrderID` AS `OrderID`, `orders`.`Quantity` AS `Quantity`, `orders`.`TotalCost` AS `TotalCost` FROM `orders` WHERE (`orders`.`Quantity` > 2) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `fk_Bookings_Customers_idx` (`CustomerID`),
  ADD KEY `fk_Bookings_Employees1_idx` (`EmployeeID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `deliverystatus`
--
ALTER TABLE `deliverystatus`
  ADD PRIMARY KEY (`DeliveryID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Indexes for table `menuitems`
--
ALTER TABLE `menuitems`
  ADD PRIMARY KEY (`MenuItemID`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`MenuID`),
  ADD KEY `fk_Menus_MenuItems1_idx` (`MenuItemID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `fk_Orders_Bookings1_idx` (`BookingID`),
  ADD KEY `fk_Orders_DeliveryStatus1_idx` (`DeliveryID`),
  ADD KEY `fk_Orders_Menus1_idx` (`MenuID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `fk_Bookings_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Bookings_Employees1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `fk_Menus_MenuItems1` FOREIGN KEY (`MenuItemID`) REFERENCES `menuitems` (`MenuItemID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_Orders_Bookings1` FOREIGN KEY (`BookingID`) REFERENCES `bookings` (`BookingID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Orders_DeliveryStatus1` FOREIGN KEY (`DeliveryID`) REFERENCES `deliverystatus` (`DeliveryID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Orders_Menus1` FOREIGN KEY (`MenuID`) REFERENCES `menus` (`MenuID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
