DELIMITER $$
CREATE DEFINER=`workbench`@`localhost` PROCEDURE `GetMaxQuantity`()
BEGIN
SELECT MAX(Quantity)AS 'Max Quantity in Order' FROM Orders;
END$$
DELIMITER ;
