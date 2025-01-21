--1. Create new table
--ALTER TABLE SalesLT.Customer
--ADD CreditCardNumber CHAR(20);

--2. Add Approval code for 3 random Cards
--UPDATE SalesLT.SalesOrderHeader
--SET CreditCardApprovalCode = '2121'
--WHERE SalesOrderID IN (
--	SELECT TOP 3 SalesOrderID --3 pierwsze wyniki
--	FROM SalesLT.SalesOrderHeader
--	ORDER BY NEWID() --generuje losowe identyfikatory
--)

--3. Change Credit Card number for X, for cards which have
--   approval code set.

--UPDATE SalesLT.Customer
--SET CreditCardNumber = 'XXXXXX'
--WHERE CustomerID IN (
--	SELECT SOH.CustomerID
--	FROM SalesLT.SalesOrderHeader as SOH
--	WHERE CreditCardApprovalCode IS NOT NULL
--)

--Alternate Version
UPDATE C
SET C.CreditCardNumber = 'X'
FROM SalesLT.Customer AS C
JOIN SalesLT.SalesOrderHeader AS SOH
	ON C.CustomerID = SOH.CustomerID
WHERE CreditCardApprovalCode IS NOT NULL
