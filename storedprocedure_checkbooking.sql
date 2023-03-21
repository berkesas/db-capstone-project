CREATE PROCEDURE `CheckBooking` (IN checkDate DATE, IN checkTable INT)
BEGIN
	SELECT IF(COUNT(BookingID)>0,CONCAT('Table ',checkTable,' is already booked'),CONCAT('Table ',checkTable,' is available')) AS BookingStatus
    FROM Bookings
    WHERE TableNo=checkTable AND BookingDate=checkDate;
END
