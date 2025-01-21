USE AdventureWorksLT2022

--INSERT INTO SalesLT.ProductCategory (Name, ParentProductCategoryID) VALUES ('Super Fork', 14)
--INSERT INTO SalesLT.Product (Name, ProductCategoryID, ProductNumber, StandardCost, ListPrice, SellStartDate) VALUES ('Golden fork', 12, 'Fork Product', 10.0, 15.0, '2022-13-14') 

SELECT 
	PC.Name,
	P.Name,
	P.ProductCategoryID,
	PC.ParentProductCategoryID

FROM SalesLT.Product as P

JOIN SalesLT.ProductCategory as PC
	ON P.ProductCategoryID = PC.ProductCategoryID

WHERE 
    PC.ProductCategoryID IN (       
		SELECT DISTINCT PC.ParentProductCategoryID
		FROM SalesLT.ProductCategory AS PC
		WHERE 
			PC.ParentProductCategoryID IS NOT NULL
    )

ORDER BY
P.Name