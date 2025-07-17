use AdventureWorks2022
go


--select * from  Sales.SalesOrderHeader ;
--select * from Sales.SalesPerson;
--select * from Person.Person;

CREATE VIEW vw_SalespersonPerformance AS
SELECT 
    CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName) AS FullName,
    SUM(o.TotalDue) AS TotalSalesAmount,
    COUNT(o.SalesOrderID) AS OrderCount
FROM 
    Sales.SalesOrderHeader o
    INNER JOIN Sales.SalesPerson sp ON o.SalesPersonID = sp.BusinessEntityID
    INNER JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
WHERE 
    o.SalesPersonID IS NOT NULL
GROUP BY 
    CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName)
GO
