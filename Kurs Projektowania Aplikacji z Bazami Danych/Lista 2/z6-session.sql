SELECT * FROM ##GlobalTable;

-- Verify existence in tempdb
SELECT * 
FROM tempdb.INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '#%' OR TABLE_NAME LIKE '##%';

-- SELECT * FROM @TableVar;
-- SELECT * FROM #LocalTable;


