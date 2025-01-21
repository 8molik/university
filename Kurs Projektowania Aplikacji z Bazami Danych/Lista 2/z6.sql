--DROP TABLE IF EXISTS #LocalTable; 
DROP TABLE IF EXISTS ##GlobalTable; 

-- table variable
DECLARE @TableVar TABLE (ID INT, Name NVARCHAR(50));
INSERT INTO @TableVar VALUES (1, 'Table Variable');

-- local table
CREATE TABLE #LocalTable (ID INT, Name NVARCHAR(50));
INSERT INTO #LocalTable VALUES (1, 'Local Table');

-- global table
CREATE TABLE ##GlobalTable (ID INT, Name NVARCHAR(50));
INSERT INTO ##GlobalTable VALUES (1, 'Global Table');

-- check existence in tempdb
SELECT * 
FROM tempdb.INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '#%' OR TABLE_NAME LIKE '##%';

-- check content of each table
SELECT 'Table Variable', * FROM @TableVar;
SELECT 'Local Table', * FROM #LocalTable;
SELECT 'Global Table', * FROM ##GlobalTable;
