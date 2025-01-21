USE AdventureWorksLT2022

--1. With all orders
SELECT 
	SOH.SalesOrderID,
	SOH.SalesOrderNumber,
	SOH.PurchaseOrderNumber,
	SUM(SOD.OrderQty * SOD.UnitPrice) AS WithoutDiscount,
	SUM(SOD.LineTotal) AS WithDiscount
FROM SalesLT.SalesOrderHeader AS SOH

JOIN SalesLT.SalesOrderDetail AS SOD
	ON SOH.SalesOrderID = SOD.SalesOrderID

GROUP BY SOH.SalesOrderID, SOH.SalesOrderNumber, SOH.PurchaseOrderNumber;

--2. With order with the highest total discount
SELECT 
	SOH.SalesOrderID,
	SOH.SalesOrderNumber,
	SOH.PurchaseOrderNumber,
	SUM(SOD.OrderQty * SOD.UnitPrice) - SUM(SOD.LineTotal) AS TotalDiscount

FROM SalesLT.SalesOrderHeader AS SOH

JOIN SalesLT.SalesOrderDetail AS SOD
	ON SOH.SalesOrderID = SOD.SalesOrderID

GROUP BY SOH.SalesOrderID, SOH.SalesOrderNumber, SOH.PurchaseOrderNumber

ORDER BY TotalDiscount DESC; --desc - odwrotna kolejnos