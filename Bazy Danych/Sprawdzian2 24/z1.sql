SELECT c.id, c.name, COUNT(DISTINCT o.id) AS offer_number
FROM company c
JOIN offer o
ON c.id = o.company_id
JOIN employment_details e 
ON e.offer_id = o.id
WHERE o.remote = true
AND e.currency ILIKE 'PLN'
AND c.id NOT IN (
    SELECT c.id
    FROM company c
    JOIN offer o
    ON c.id = o.company_id
    JOIN employment_details e 
    ON e.offer_id = o.id
    WHERE o.remote = true
    AND e.currency ILIKE 'PLN'
    AND e.type ILIKE 'permanent'
) 
GROUP BY c.id, c.name
ORDER BY offer_number DESC, c.name;
