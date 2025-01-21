DROP PROCEDURE IF EXISTS UpdateDiscontinuedDate;
GO

DROP TYPE IF EXISTS ProductIDListType;
GO

CREATE TYPE ProductIDListType AS TABLE (
	ProductID INT
);
GO

CREATE PROCEDURE UpdateDiscontinuedDate 
	@ProductIDs ProductIDListType READONLY,
	@DiscontinuedDate DATE
AS
BEGIN
	DECLARE @ProductID INT;
    DECLARE @CurrentDiscontinuedDate DATE;

    -- Iterator do przechodzenia przez kolejne produkty w pêtli
    DECLARE ProductCursor CURSOR FOR
    SELECT ProductID
    FROM @ProductIDs;

    OPEN ProductCursor;

    FETCH NEXT FROM ProductCursor INTO @ProductID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @CurrentDiscontinuedDate = DiscontinuedDate
        FROM SalesLT.Product
        WHERE ProductID = @ProductID;

        IF @CurrentDiscontinuedDate IS NULL
        BEGIN
            UPDATE SalesLT.Product
            SET DiscontinuedDate = @DiscontinuedDate
            WHERE ProductID = @ProductID;
        END
        ELSE
        BEGIN
            PRINT 'Product ' + CAST(@ProductID AS VARCHAR(10)) + ' already has a DiscontinuedDate: ' 
                  + CAST(@CurrentDiscontinuedDate AS VARCHAR(10)); 
        END;

        -- WeŸ kolejny produkt
        FETCH NEXT FROM ProductCursor INTO @ProductID;
    END;
    CLOSE ProductCursor;
    DEALLOCATE ProductCursor;
END;
GO

DECLARE @ProductList ProductIDListType;

INSERT INTO @ProductList (ProductID)
VALUES (721), (722), (715);

EXEC UpdateDiscontinuedDate @ProductList, '2024-10-23';

SELECT * FROM @ProductList

SELECT * FROM SalesLT.Product