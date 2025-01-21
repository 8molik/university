USE AdventureWorksLT2022
DROP TABLE IF EXISTS Product_Backup;
DECLARE 
	@StartTime DATETIME, 
	@EndTime DATETIME

SELECT 
	Name,
	ProductNumber,
	Color,
	StandardCost
INTO Product_Backup
FROM SalesLT.Product
WHERE 1 = 0 ; --kopiuje wszystkie kolumny i wiersze, ale bez wartoœci


-- Copying data using query
SET @StartTime = GETDATE();

INSERT INTO Product_Backup 
SELECT 
	Name,
	ProductNumber,
	Color,
	StandardCost
FROM SalesLT.Product

SET @EndTime = GETDATE();
SELECT DATEDIFF(MILLISECOND, @StartTime, @EndTime);


-- Copying data using cursor
DECLARE 
	@Name nvarchar(50),
	@ProductNumber nvarchar(25),
	@Color nvarchar(15),
	@StandardCost money

DECLARE MyCursor CURSOR FOR
SELECT 
	Name,
	ProductNumber,
	Color,
	StandardCost
FROM SalesLT.Product

SET @StartTime = GETDATE();

OPEN MyCursor
FETCH NEXT FROM MyCursor 
INTO 
    @Name, 
    @ProductNumber,
	@Color,
	@StandardCost

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO Product_Backup (
        Name,
        ProductNumber,
        Color,
        StandardCost
    ) VALUES (
        @Name,
        @ProductNumber,
        @Color,
        @StandardCost
    );

    FETCH NEXT FROM MyCursor INTO 
        @Name, 
        @ProductNumber,
        @Color,
        @StandardCost;
END

CLOSE MyCursor;
DEALLOCATE MyCursor;

SET @EndTime = GETDATE();
SELECT DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS Cursor_Execution_Time;