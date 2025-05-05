SELECT c.name, o.title
FROM company c 
JOIN offer o
ON c.id = o.company_id
JOIN skill s
ON o.id = s.offer_id
WHERE s.name ILIKE '%kotlin%' 
AND s.value < 5
AND o.city = 'Warszawa'
ORDER BY 1, 2