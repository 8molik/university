BEGIN;

CREATE TABLE salaries_abroad(LIKE employment_details);
ALTER TABLE salaries_abroad ADD COLUMN country_code text;

ALTER TABLE salaries_abroad ADD PRIMARY KEY (offer_id, type);
ALTER TABLE salaries_abroad ADD FOREIGN KEY (offer_id) REFERENCES offer(id);

INSERT INTO salaries_abroad 
SELECT e.* FROM employment_details e
JOIN offer o
ON e.offer_id = o.id
WHERE o.country_code != 'PL';

ROLLBACK;