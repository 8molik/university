Use RecurviseTriggerDb;

ALTER DATABASE RecurviseTriggerDb SET RECURSIVE_TRIGGERS ON;

CREATE TABLE Counter_ (
    id INT PRIMARY KEY,
    value INT
); 
GO

CREATE TRIGGER MyTrigger
ON Counter_
AFTER UPDATE
AS
BEGIN
    DECLARE @Current INT;
    
    SELECT @Current = value FROM inserted;
        UPDATE Counter_
        SET value = @Current + 1
        WHERE id IN (SELECT id FROM inserted);
   
END;

INSERT INTO Counter_ (id, value) VALUES (2, 5);
UPDATE Counter_ SET value = value WHERE id = 1;

SELECT name AS 'Database name', is_recursive_triggers_on AS 'Recursive Triggers Enabled'
FROM sys.databases