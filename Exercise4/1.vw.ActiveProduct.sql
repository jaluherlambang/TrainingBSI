use AdventureWorks2022
go

create view vwActiveProductCatalog
as
	----script tsql AdventureWorks2022
SELECT 
    p.Name AS ProductName,
    p.ProductNumber,
    p.ListPrice,
    p.SellStartDate
FROM 
    Production.Product p
WHERE
    p.SellEndDate = NULL;
go