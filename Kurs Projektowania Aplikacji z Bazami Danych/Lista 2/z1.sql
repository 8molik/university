use Test

DROP FUNCTION IF EXISTS dbo.check_who_is_late;
GO

CREATE FUNCTION dbo.check_who_is_late(@Days INT)
RETURNS TABLE 
AS 
RETURN 
(
    SELECT 
        CZ.PESEL,
        COUNT(W.Egzemplarz_ID) AS NumberOfCopies
    FROM 
        Czytelnik AS CZ
    JOIN 
        Wypozyczenie AS W ON CZ.Czytelnik_ID = W.Czytelnik_ID
    WHERE 
        W.Liczba_Dni >= @Days
    GROUP BY 
        CZ.PESEL
);
GO
SELECT * FROM check_who_is_late(10);