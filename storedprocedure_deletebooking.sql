DELIMITER $$
CREATE DEFINER=`workbench`@`localhost` PROCEDURE `DeleteBooking`(IN id INT)
BEGIN
	DELETE FROM Bookings WHERE BookingID=id;
    SELECT CONCAT('Booking ', id, ' cancelled') AS Confirmation FROM Bookings LIMIT 1;
END$$
DELIMITER ;
