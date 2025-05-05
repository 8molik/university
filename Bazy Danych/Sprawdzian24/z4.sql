SELECT DISTINCT c.name, 
                o.title, 
                o.experience_level, 
                ed.salary_from, 
                ed.salary_to,
                round(ed.salary_to - ed.salary_from) as diff, 
                round(ed.salary_to - ed.salary_from / ed.salary_from * 100)
FROM company c
JOIN offer o ON c.id = o.company_id
JOIN employment_details ed ON ed.offer_id = o.id
WHERE ed.type = 'b2b'
AND ed.salary_from > 0
AND ed.currency = 'pln'
AND DATE(o.published_at) = DATE('2023-09-01')

ORDER BY 7, 1