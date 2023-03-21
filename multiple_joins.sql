SELECT Customers.CustomerID, Customers.FullName, Orders.OrderID, Orders.TotalCost, Menus.MenuName, MenuItems.CourseName, MenuItems.StarterName
FROM Customers
INNER JOIN Bookings ON Customers.CustomerID=Bookings.CustomerID
INNER JOIN Orders ON Bookings.BookingID=Orders.BookingID
INNER JOIN Menus ON Orders.MenuID=Menus.MenuID
INNER JOIN MenuItems ON Menus.MenuItemID=MenuItems.MenuItemID
WHERE Orders.TotalCost>150
ORDER BY Orders.TotalCost ASC;