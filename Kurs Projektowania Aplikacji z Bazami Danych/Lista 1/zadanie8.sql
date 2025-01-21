USE AdventureWorksLT2022

--1. Try to set value against constraint
--UPDATE SalesLT.SalesOrderHeader
--SET ShipDate = '2008-05-08'
--WHERE SalesOrderID = 71774; 
--The UPDATE statement conflicted with the CHECK constraint "CK_SalesOrderHeader_ShipDate"

--2. Turn off constraint
ALTER TABLE SalesLT.SalesOrderHeader
NOCHECK CONSTRAINT CK_SalesOrderHeader_ShipDate

UPDATE SalesLT.SalesOrderHeader
SET ShipDate = '2008-05-08'
WHERE SalesOrderID = 71774; 

--Turn on constraint again
ALTER TABLE SalesLT.SalesOrderHeader
CHECK CONSTRAINT CK_SalesOrderHeader_ShipDate

SELECT * FROM SalesLT.SalesOrderHeader
WHERE ShipDate < OrderDate;