-- WORKSHOP 02
--Calculate the total amount per BusinessEntity on all orders in the
--system and filter only total orders greater than 635558

SELECT BusinessEntityId,
SUM(TotalPrice) AS TotalAmount
FROM Orders
GROUP BY BusinessEntityID
HAVING SUM(TotalPrice) > 635558;

--Calculate the total amount per BusinessEntity on all orders in the
--system from Customers with ID < 20 and filter only total orders less than 100000

SELECT BusinessEntityId,
SUM(TotalPrice) AS TotalAmount
FROM Orders
WHERE CustomerId < 20
GROUP BY BusinessEntityId
HAVING SUM(TotalPrice) < 100000;

--Find the Maximal Order amount, and the Average Order amount
--per BusinessEntity on all orders in the system. Filter only records
--where Total order amount is more than 4x bigger than average

SELECT BusinessEntityId,
MAX(TotalPrice) AS MaxOrderAmount,
AVG(TotalPrice) AS AverageOrderAmount
FROM Orders
GROUP BY BusinessEntityId
HAVING MAX(TotalPrice) > 4 * AVG(TotalPrice);



--WORKSHOP 03
--Create new view (vv_CustomerOrders) that will List all CustomerIds and sum of total Orders per customer
CREATE VIEW vv_CustomerOrders
AS
SELECT CustomerId, SUM(o.TotalPrice) AS TotalOrdersPerCustomer 
FROM Orders o
GROUP BY CustomerId

--Change the view to show Customer Names instead of CustomerId
ALTER VIEW vv_CustomerOrders 
AS
SELECT c.Name, SUM(TotalPrice) AS TotalOrdersPerCustomer
FROM Orders o
JOIN Customers c ON o.CustomerId = c.Id
GROUP BY c.Name

--Change the view to show the results ordered by the customer with biggest total price
ALTER VIEW vv_CustomerOrders 
AS
SELECT c.Name, o.TotalPrice 
FROM Orders o
JOIN Customers c ON o.CustomerId = c.Id
GROUP BY c.Name, o.TotalPrice
SELECT *
FROM vv_CustomerOrders
ORDER BY TotalPrice DESC;

--Create new view (vv_EmployeeOrders) that will List all Employees 
--(FirstName and LastName) , Product name and total quantity sold
CREATE OR alter VIEW vv_EmployeeOrders AS
SELECT e.FirstName, e.LastName, p.Name AS ProductName, SUM(od.Quantity) as TotalQuantitySold 
FROM Employees e
INNER JOIN Orders o ON e.Id = o.EmployeeId
INNER JOIN OrderDetails od ON o.Id = od.OrderId
INNER JOIN Products p ON od.ProductId = p.Id
GROUP BY e.FirstName, e.LastName, p.Name

--Alter the view to show only sales from Business entities belonging to region 'Skopski'
CREATE OR ALTER VIEW vv_EmployeeOrders AS
SELECT e.FirstName, e.LastName, p.Name AS ProductName, SUM(od.Quantity) AS TotalQuantitySold
FROM Employees e
INNER JOIN Orders o ON e.Id = o.EmployeeId
INNER JOIN OrderDetails od ON o.Id = od.OrderId
INNER JOIN Products p ON od.ProductId = p.Id
INNER JOIN BusinessEntities be ON o.BusinessEntityId = be.Id
WHERE be.Region = 'Skopski'
GROUP BY e.FirstName, e.LastName, p.Name

select * from vv_EmployeeOrders
