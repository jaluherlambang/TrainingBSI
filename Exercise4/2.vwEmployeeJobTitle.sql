use AdventureWorks2022
go


create view vwEmployeeDirectory
as
	----script tsql AdventureWorks2022
SELECT 
    CONCAT(p.FirstName,' ',p.MiddleName, ' ',p.LastName) AS FullName,
    ea.EmailAddress,
    e.JobTitle
FROM 
    HumanResources.Employee e
    JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN Person.EmailAddress ea ON e.BusinessEntityID = ea.BusinessEntityID;
go