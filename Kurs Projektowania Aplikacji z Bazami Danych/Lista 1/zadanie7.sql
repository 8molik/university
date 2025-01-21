DROP TABLE IF EXISTS Test;

CREATE TABLE Test (
	TestID INT IDENTITY(1000, 10) PRIMARY KEY,
	Name CHAR(100)
)

CREATE TABLE Test1 (
	TestID INT IDENTITY(1000, 10) PRIMARY KEY,
	Name CHAR(100)
)

INSERT INTO Test (Name) VALUES ('v1');
INSERT INTO Test (Name) VALUES ('v2');
INSERT INTO Test (Name) VALUES ('v3');
INSERT INTO Test1 (Name) VALUES ('v1');

SELECT 
    @@IDENTITY AS LastInsertedIdentity,
    IDENT_CURRENT('Test') AS LastIdentityInTable;

-- @@IDENTITY zwraca ostatni dodany element do jakiejkolwiek tabeli
-- IDENT_CURRENT zwraca ostatni element dodany do konkretnej tabeli