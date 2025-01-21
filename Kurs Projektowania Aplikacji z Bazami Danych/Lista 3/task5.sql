USE AdventureWorksLT2022

DROP TABLE IF EXISTS SalesLT.ProductPriceHistory

CREATE TABLE SalesLT.ProductPriceHistory (
    ProductID INT,
    StandardCost DECIMAL(18, 2),
    ListPrice DECIMAL(18, 2),
    ChangeDate DATETIME,
    CONSTRAINT PriceHistory PRIMARY KEY (ProductID, ChangeDate)
);
GO

DROP TRIGGER IF EXISTS SalesLT.MyTrigger;
GO

CREATE TRIGGER MyTrigger
ON SalesLT.Product
AFTER UPDATE
AS
BEGIN
	DECLARE @Date DATETIME;
	SET @Date = GETDATE();

	INSERT INTO SalesLT.ProductPriceHistory (ProductID, StandardCost, ListPrice, ChangeDate)

	SELECT i.ProductID, i.StandardCost, i.ListPrice, @Date
	FROM inserted AS i

	--deleted zawiera wartoœci tabeli przed aktualizacj¹, inserted po
	INNER JOIN 
		deleted as d ON i.ProductID = d.ProductID
	--bierzemy te wartoœci, które ró¿ni¹ obie tabele, czyli siê zmieni³y
	WHERE 
		i.StandardCost <> d.StandardCost OR i.ListPrice <> d.ListPrice;
END

INSERT INTO SalesLT.ProductPriceHistory (ProductID, StandardCost, ListPrice, ChangeDate)
SELECT P.ProductID, P.StandardCost, P.ListPrice, P.ModifiedDate
FROM SalesLT.Product AS P
WHERE ProductID = 680; 

UPDATE SalesLT.Product
SET StandardCost = 13
WHERE ProductID = 680; 
GO

UPDATE SalesLT.Product
SET StandardCost = 133
WHERE ProductID = 680; 
GO

-- Check the history table for changes
SELECT * FROM SalesLT.ProductPriceHistory;
