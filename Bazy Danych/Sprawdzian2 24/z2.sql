WITH filtered_offers AS (
SELECT s.name, min(e.salary_from) as min_salary
    FROM offer o
    JOIN skill s 
    ON o.id = s.offer_id 
    JOIN employment_details e
    ON o.id = e.offer_id
    WHERE e.type = 'permanent'
        AND e.salary_from > 0
        AND e.currency = 'pln'
        AND o.city = 'Wrocław'
    GROUP BY s.name
)

SELECT name, min_salary
FROM filtered_offers
WHERE min_salary > (
    SELECT AVG(e.salary_from) FROM employment_details e
    JOIN offer o ON o.id = e.offer_id
    WHERE e.type = 'permanent'
        AND e.salary_from > 0
        AND e.currency = 'pln'
        AND o.city = 'Wrocław'
)
ORDER BY 2 DESC, 1