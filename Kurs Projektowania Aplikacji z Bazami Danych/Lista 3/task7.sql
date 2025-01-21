USE Test

drop table Books
drop table Specimens

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL
);

CREATE TABLE Specimens (
    SpecimenID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    SpecimenCondition VARCHAR(255),
    FOREIGN KEY (BookID) REFERENCES books(BookID)
);
GO

CREATE TRIGGER LimitSpecimens
ON Specimens
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @BookID INT;
    DECLARE @Count INT;

    SELECT @BookID = BookID FROM inserted;

    -- sprawdŸ ile jest egzemplarzy
    SELECT @Count = COUNT(*) 
    FROM Specimens
    WHERE BookID = @BookID;
	
    IF @Count >= 5
    BEGIN
        RAISERROR('A book can have a maximum of 5 specimens', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Specimens (BookID, SpecimenCondition)
        SELECT BookID, SpecimenCondition FROM inserted;
    END
END;

INSERT INTO Books (BookID, title) VALUES (1, 'Book 1');

INSERT INTO Specimens (BookID, SpecimenCondition) VALUES (1, 'New');
INSERT INTO Specimens (BookID, SpecimenCondition) VALUES (1, 'Good');
INSERT INTO Specimens (BookID, SpecimenCondition) VALUES (1, 'Fair');
INSERT INTO Specimens (BookID, SpecimenCondition) VALUES (1, 'Poor');
INSERT INTO Specimens (BookID, SpecimenCondition) VALUES (1, 'Damaged');

INSERT INTO Specimens (BookID, SpecimenCondition) VALUES (1, 'Very Damaged');

SELECT * FROM Specimens