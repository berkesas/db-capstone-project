DELIMITER $$
CREATE DEFINER=`workbench`@`localhost` PROCEDURE `CancelOrder`(in order_id INT)
BEGIN
	DELETE FROM Orders WHERE OrderID=order_id;
    SELECT CONCAT('Order ', order_id, ' is cancelled') AS 'Confirmation' FROM Orders LIMIT 1;
END$$
DELIMITER ;
