use Test;

DROP TABLE IF EXISTS Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
);

INSERT INTO Products (ProductID, ProductName)
VALUES (1, 'Laptop'),
       (2, 'Smartphone'),
       (3, 'Headphones');


SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION;

SELECT * FROM Products;

COMMIT;


BEGIN TRANSACTION;

SELECT * FROM Products WITH (NOLOCK);

COMMIT;
