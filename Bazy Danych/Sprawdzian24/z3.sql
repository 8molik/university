SELECT DISTINCT c.name
FROM company c
LEFT JOIN offer o 
ON c.id = o.company_id
AND o.remote = true
WHERE o.remote is NULL
ORDER BY 1;


SELECT DISTINCT c.name
FROM company c
JOIN offer o 
ON c.id = o.company_id
WHERE c.id NOT IN (
    SELECT o.company_id FROM offer o WHERE o.remote = true
);
ORDER BY 1;