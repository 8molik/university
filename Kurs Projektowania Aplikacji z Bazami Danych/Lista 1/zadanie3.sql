USE AdventureWorksLT2022;

SELECT 
    A.City AS CityName,
    COUNT(DISTINCT CA.CustomerID) AS NumberOfCustomers,
	COUNT(DISTINCT C.SalesPerson) AS NumberOfSalesPeople
FROM 
    SalesLT.Address AS A
JOIN 
    SalesLT.CustomerAddress AS CA
    ON A.AddressID = CA.AddressID
JOIN
	SalesLT.Customer AS C
	ON C.CustomerID = CA.CustomerID

GROUP BY 
    A.City
