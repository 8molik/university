USE Test

DROP PROCEDURE IF EXISTS AddCzytelnik;
GO

CREATE PROCEDURE AddCzytelnik
    @PESEL VARCHAR(11),
    @Nazwisko NVARCHAR(30),
	@Miasto VARCHAR(30),
    @Data_Urodzenia DATE
AS
BEGIN
    IF LEN(@PESEL) != 11 OR PATINDEX('%[^0-9]%', @PESEL) > 0
    BEGIN 
		THROW 500000, 'Invalid PESEL', 1;
	END

	IF LEN(@Nazwisko) < 2 OR LEFT(@Nazwisko, 1) COLLATE Latin1_General_CS_AS NOT LIKE '[A-Z]'
    BEGIN
        THROW 500001, 'Invalid Last Name', 1;
    END

	IF TRY_CAST(@Data_Urodzenia AS DATE) IS NULL
    BEGIN
        THROW 500002, 'Invalid Birth Date', 1;
    END

	--INSERT INTO Czytelnik (PESEL, Nazwisko, Miasto, Data_Urodzenia)
    --VALUES (@PESEL, @Nazwisko, @Miasto, @Data_Urodzenia);

    PRINT 'New reader added successfully.';
END;
GO

--EXEC AddCzytelnik @PESEL = '12345678901', @Nazwisko = 'Kowalski', @Miasto = 'Warsaw', @Data_Urodzenia = '1990-01-01';
--EXEC AddCzytelnik @PESEL = '3343242342314', @Nazwisko = 'Nowak', @Miasto = 'Warsaw', @Data_Urodzenia = '1990-01-01';
EXEC AddCzytelnik @PESEL = '33432423334', @Nazwisko = 'Aak', @Miasto = 'Warsaw', @Data_Urodzenia = '199001-01';

SELECT * from Czytelnik