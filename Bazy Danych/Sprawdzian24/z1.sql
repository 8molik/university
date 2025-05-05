SELECT DISTINCT o.city
FROM offer o JOIN
company c ON c.id=o.company_id
WHERE
c.name='Siepomaga.pl'
ORDER BY 1