DROP TABLE IF EXISTS firstnames;
GO

DROP TABLE IF EXISTS lastnames;
GO

DROP TABLE IF EXISTS fldata;
GO


CREATE TABLE firstnames (
	id INT PRIMARY KEY IDENTITY(1,1),
	firstname VARCHAR(50)
);

CREATE TABLE lastnames (
	id INT PRIMARY KEY IDENTITY(1,1),
	lastname VARCHAR(50)
);

CREATE TABLE fldata (
	firstname VARCHAR(50),
    lastname VARCHAR(50),
    PRIMARY KEY (firstname, lastname)
);

-- Wstawianie danych do firstnames
INSERT INTO firstnames (firstname) VALUES 
('John'), ('Jane'), ('Alice'), ('Bob'), ('Charlie'), 
('David'), ('Emma'), ('Frank'), ('Grace'), ('Hannah');

-- Wstawianie danych do lastnames
INSERT INTO lastnames (lastname) VALUES 
('Smith'), ('Johnson'), ('Williams'), ('Jones'), ('Brown'), 
('Davis'), ('Miller'), ('Wilson'), ('Moore'), ('Taylor');

DROP PROCEDURE IF EXISTS InsertRandomPairs;
GO

CREATE PROCEDURE InsertRandomPairs
	@n INT
AS 
BEGIN 
	DELETE FROM fldata;
	
	DECLARE @max_pairs INT;
	SELECT @max_pairs = COUNT(*) * (SELECT COUNT(*) FROM firstnames) FROM lastnames;

	IF @n > @max_pairs
	BEGIN
		THROW 500000, 'ERROR', 1;
	END

	DECLARE @iterator INT = 0; 
	DECLARE @firstname VARCHAR(50);
	DECLARE @lastname VARCHAR(50);

	DECLARE @temp_table TABLE (firstname VARCHAR(50), lastname VARCHAR(50));
	--CREATE TABLE #temp_table (firstname VARCHAR(50), lastname VARCHAR(50));
	
	WHILE @iterator < @n
	BEGIN 
	    --Selecting random pair
		SELECT TOP 1 @firstname = firstname
        FROM firstnames
        ORDER BY NEWID();

        SELECT TOP 1 @lastname = lastname
        FROM lastnames
        ORDER BY NEWID();

		--Checking if pair is unique
		IF NOT EXISTS (SELECT 1 FROM @temp_table
						WHERE firstname = @firstname AND lastname = @lastname)
		BEGIN
			INSERT INTO @temp_table (firstname, lastname) 
				VALUES (@firstname, @lastname)
			SET @iterator = @iterator + 1;
		END
	END
	
	INSERT INTO fldata (firstname, lastname)
		SELECT firstname, lastname FROM @temp_table;

END;
GO

EXEC InsertRandomPairs @n = 110;
SELECT * FROM fldata;
