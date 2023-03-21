DELIMITER $$
CREATE DEFINER=`workbench`@`localhost` PROCEDURE `UpdateBooking`(IN id INT, IN booking_date DATE)
BEGIN
	UPDATE Bookings SET BookingDate=booking_date WHERE BookingID=id;
    SELECT CONCAT('Booking ', id, ' updated') AS Confirmation FROM Bookings LIMIT 1;
END$$
DELIMITER ;
