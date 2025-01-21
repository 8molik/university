--trigger instead of jest u¿ywany zamiast operacji insert/update/delete
--zwyk³y trigger after jest wywo³ywany tu¿ bo tych operacjach

--widok w SQL to wirtualna tabela, która jest wynikiem zapytania SELECT, ale nie przechowuje danych fizycznie,
--zamiast tego, widok przechowuje zapytanie, które jest wykonywane za ka¿dym razem, gdy próbujemy uzyskaæ dostêp do widoku

-- Create the production schema if it doesn't exist

--drop table production.brand_approvals
--drop table production.brands
--drop trigger production.trg_vw_brands
--drop view production.vw_brands
--drop schema production

CREATE SCHEMA production;
GO

-- Create the brand_approvals table in the production schema
CREATE TABLE production.brand_approvals(
    brand_id INT IDENTITY PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);

-- Create the brands table (necessary for the view)
CREATE TABLE production.brands(
    brand_id INT IDENTITY PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);
GO

-- Create the view based on the brand_approvals and brands tables
CREATE VIEW production.vw_brands AS
SELECT
    brand_name,
    'Approved' AS approval_status
FROM
    production.brands
UNION
SELECT
    brand_name,
    'Pending Approval' AS approval_status
FROM
    production.brand_approvals;
GO

-- Create the INSTEAD OF trigger for the view
CREATE TRIGGER production.trg_vw_brands
ON production.vw_brands
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO production.brand_approvals (brand_name)
    SELECT i.brand_name
    FROM inserted i
    WHERE NOT EXISTS (
        SELECT 1
        FROM production.brands b
        WHERE b.brand_name = i.brand_name
    );
END;

-- Insert into the vw_brands view (which will trigger the INSTEAD OF logic)
INSERT INTO production.vw_brands (brand_name)
VALUES ('Eddy1 Merckx');

SELECT
	*
FROM
	production.vw_brands;

SELECT 
	*
FROM 
	production.brand_approvals;