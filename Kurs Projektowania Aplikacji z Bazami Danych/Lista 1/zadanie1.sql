use AdventureWorksLT2022

SELECT DISTINCT A.City --distinct usuwa duplikaty
FROM SalesLT.Address as A

--JOIN SalesLT.SalesOrderHeader AS SOH 
--	ON SOH.ShipToAddressID = A.AddressID

WHERE A.AddressID in (
	SELECT SOH.ShipToAddressID 
	FROM SalesLT.SalesOrderHeader AS SOH
)
