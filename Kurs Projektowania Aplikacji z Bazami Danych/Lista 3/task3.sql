--CREATE DATABASE ProductsDB;
--GO

USE ProductsDB;
GO

drop table if exists Prices
drop table if exists Rates
drop table if exists Products

CREATE TABLE Products (
	ID INT PRIMARY KEY,
	ProductName NVARCHAR(50)
);

CREATE TABLE Rates (
	Currency NVARCHAR(10) PRIMARY KEY,
	PricePLN DECIMAL(18, 2)
);

CREATE TABLE Prices (
	ProductID INT REFERENCES Products(ID),
	Currency NVARCHAR(10),-- REFERENCES Rates(Currency),
	Price DECIMAL(18, 2)
);

INSERT INTO Products (ID, ProductName) VALUES
	(1, 'Product 1'),
	(2, 'Product 2'),
	(3, 'Product 3')

INSERT INTO Rates (Currency, PricePLN) VALUES
	('EUR', 4.25),
	('USD', 3.95),
	('CHF', 4.60),
	('GBP', 5.20)

INSERT INTO Prices (ProductID, Currency, Price) VALUES
    (1, 'PLN', 10.00),
    (1, 'USD', 11.00),
    (1, 'RUB', 900.50),
    (2, 'EUR', 15.00),
    (2, 'GBP', 12.00),
    (3, 'USD', 20.00);

DECLARE 
	@ProductID INT,
	@Currency NVARCHAR(10),
	@PricePLN DECIMAL(18, 2),
	@Price DECIMAL(18, 2)

DECLARE MyCursor CURSOR FOR
SELECT
	ProductID, Currency, Price 
FROM Prices WHERE Currency <> 'PLN'; --skip PLNs

OPEN MyCursor
FETCH NEXT FROM MyCursor INTO @ProductID, @Currency, @Price 

WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Rates WHERE Currency = @Currency)
	BEGIN
		DELETE FROM Prices 
		WHERE ProductID = @ProductID AND Currency = @Currency
	END

	ELSE
	BEGIN
		UPDATE Prices
			SET Price = @Price * (SELECT PricePLN FROM Rates WHERE Currency = @Currency)
			WHERE ProductID = @ProductID AND Currency = @Currency	
	END
	FETCH NEXT FROM MyCursor INTO @ProductID, @Currency, @Price 
END

CLOSE MyCursor
DEALLOCATE MyCursor

SELECT * FROM Prices