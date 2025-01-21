USE AdventureWorksLT2022
GO

CREATE TRIGGER MyTrigger
ON SalesLT.Customer
AFTER UPDATE
AS
BEGIN
	DECLARE @Date DATETIME;
	SET @Date = GETDATE();

	UPDATE SalesLT.Customer
	SET ModifiedDate = @Date 
	WHERE CustomerID IN (SELECT CustomerID FROM inserted);
END;

UPDATE SalesLT.Customer
SET FirstName = 'John'
WHERE CustomerID = 1;  