use AdventureWorks2022
go


--select * from  Sales.SalesOrderHeader ;
--select * from Sales.Customer;
--select * from Person.Person;

create view vw_FrequentCustomers
as
	----script tsql AdventureWorks2022
SELECT
    CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName) AS FullName,
    COUNT(o.SalesOrderID) AS OrderCount
FROM 
    Sales.SalesOrderHeader o
    JOIN Sales.Customer c ON o.CustomerID = c.CustomerID
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
GROUP BY 
 CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName)
HAVING 
    COUNT(o.SalesOrderID) > 3
;
go