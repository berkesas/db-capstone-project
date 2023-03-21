DELIMITER $$
CREATE DEFINER=`workbench`@`localhost` PROCEDURE `AddBooking`(IN id INT, IN customer_id INT, IN table_no INT,IN booking_date DATE)
BEGIN
	INSERT INTO Bookings (BookingID, BookingDate, TableNo, CustomerID, EmployeeID)
	VALUES (id, booking_date, table_no, customer_id, 1);
    SELECT 'New booking added' AS Confirmation FROM Bookings LIMIT 1;
END$$
DELIMITER ;
