DROP PROCEDURE IF EXISTS GetBorrowedDays;
GO

DROP TYPE IF EXISTS ReaderIDTable;
GO

CREATE TYPE ReaderIDTable AS TABLE (
	Czytelnik_ID INT
);
GO

CREATE PROCEDURE GetBorrowedDays 
	@ReaderID ReaderIDTable READONLY
AS
BEGIN
	SELECT 
		W.Czytelnik_ID,
		SUM(W.Liczba_Dni) AS TotalBorrowed
	FROM 
		Wypozyczenie W
	JOIN 
        @ReaderID R ON W.Czytelnik_ID = R.Czytelnik_ID
	GROUP BY 
        W.Czytelnik_ID;
END;
GO

DECLARE @ReaderID ReaderIDTable;
INSERT INTO @ReaderID (Czytelnik_ID) VALUES (1), (2), (3), (4);

EXEC GetBorrowedDays @ReaderID;
