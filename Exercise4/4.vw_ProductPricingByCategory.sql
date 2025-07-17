use AdventureWorks2022
go


--select * from  Production.Product ;
--select * from Production.ProductSubcategory;
--select * from Production.ProductCategory;

create view vw_ProductPricingByCategory
as
	----script tsql AdventureWorks2022
SELECT 
    p.Name as ProductName,
    ps.Name as SubCategoryName,
    pc.Name as CategoryName,
    p.ListPrice
FROM 
    Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice > 0
;
go