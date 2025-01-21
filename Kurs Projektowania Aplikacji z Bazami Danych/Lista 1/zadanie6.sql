USE AdventureWorksLT2022

SELECT 
	C.FirstName AS FirstName,
	C.LastName AS FirstName,
	SUM(SOD.UnitPrice * SOD.OrderQty - SOD.LineTotal) AS TotalDiscount
FROM SalesLT.Customer AS C

JOIN SalesLT.SalesOrderHeader AS SOH
	ON SOH.CustomerID = C.CustomerID

JOIN SalesLT.SalesOrderDetail AS SOD
	ON SOD.SalesOrderID = SOH.SalesOrderID

GROUP BY
	C.FirstName, C.LastName;