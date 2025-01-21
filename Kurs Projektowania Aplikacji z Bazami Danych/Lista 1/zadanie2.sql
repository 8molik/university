USE AdventureWorksLT2022;

SELECT 
	PM.Name AS ProductName,
	COUNT(P.ProductModelID) AS ProductQuantity
FROM SalesLT.ProductModel AS PM

JOIN SalesLT.Product AS P 
	ON P.ProductModelID = PM.ProductModelID
GROUP BY  -- niezbedne przy funkcjach agregujacych - dlaczego?
	PM.Name

HAVING
	COUNT(P.ProductModelID) > 1;

