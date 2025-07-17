use AdventureWorks2022
go


--select * from Sales.SalesOrderHeader;
--select * from Sales.Customer;
--select * from Person.Person;

create view vw_SalesOrderSummary
as
	----script tsql AdventureWorks2022
SELECT 
    o.SalesOrderID,
    o.OrderDate,
    CONCAT(p.FirstName,' ',p.MiddleName, ' ',p.LastName) AS FullName,
    o.TotalDue as TotalDueAmount
FROM 
    Sales.SalesOrderHeader o
    JOIN Sales.Customer c ON o.CustomerID = c.CustomerID
    JOIN Person.Person p ON c.CustomerID = p.BusinessEntityID
go