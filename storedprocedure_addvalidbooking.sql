CREATE DEFINER=`workbench`@`localhost` PROCEDURE `AddValidBooking`(IN booking_date DATE, IN booking_table INT)
BEGIN
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
        ROLLBACK;
END