      ----- section 1 ---------
---- number 1
select Name,ListPrice from Production.product
where ListPrice > 1000;

--- number 2
select * from HumanResources.Employee
where HireDate > '2012-01-01';

---- number 3
select top 10 Name,ListPrice from Production.Product
order by ListPrice desc;

---- number 4
select Name from Production.Product
where Name like 'B%'

		----section 2------
--- number 5
select CONCAT(b.firstName, ' ', b.middleName, ' ', b.lastName) AS FullName, c.OrderDate, c.TotalDue
from sales.customer a 
left join Person.Person b on a.PersonID=b.BusinessEntityID
right join Sales.SalesOrderHeader c on a.customerID = c.CustomerID

--- number 6
select a.Name as ProductName,b.Name as SubcategoryName
from Production.Product a
left join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID

--- number 7
select * from HumanResources.Employee;
select * from Person.Person;
select CONCAT(b.firstName, ' ', b.middleName, ' ', b.lastName) AS FullName, a.JobTitle
from HumanResources.Employee a
left join Person.Person b on a.BusinessEntityID=b.BusinessEntityID

--- number 8
select a.SalesOrderID, a.TotalDue, CONCAT(c.firstName, ' ', c.middleName, ' ', c.lastName) AS SalesPersonName
from Sales.SalesOrderHeader a
Left Join sales.SalesPerson b on a.SalesPersonID = b.BusinessEntityID
Left join Person.Person c on a.SalesPersonID = c.BusinessEntityID

		----section 3 -----
--- number 9
select ProductLine, count(productID) as Total
from Production.Product
group by ProductLine;

--- number 10
select ProductSubcategoryID, AVG(ListPrice) as AverageListPrice
from Production.Product
group by ProductSubcategoryID;

--- number 11
select jobtitle, count(NationalIDNumber) as [Total Employee]
from HumanResources.Employee
group by JobTitle

--- number 12
select Year(OrderDate) as Year, count(SalesOrderID) as TotalOrder
from Sales.SalesOrderHeader
group by Year(OrderDate)

		---- Section 4 --------
---- number 13
select CONCAT(c.firstName, ' ', c.middleName, ' ', c.lastName) AS CustomerName, SUM(a.TotalDue) as SumTotalDue
from Sales.SalesOrderHeader a
Left Join sales.customer b on a.CustomerID = b.CustomerID
Left join Person.Person c on b.PersonID = c.BusinessEntityID
group by CONCAT(c.firstName, ' ', c.middleName, ' ', c.lastName)

select*from Sales.SalesPerson
---- number 14
select CONCAT(c.firstName, ' ', c.middleName, ' ', c.lastName) AS SalesPersonName, Count(b.SalesOrderID)
from Sales.SalesPerson a
left join sales.SalesOrderHeader b on a.BusinessEntityID = b.SalesPersonID
left join person.Person c on a.BusinessEntityID = c.BusinessEntityID
group by CONCAT(c.firstName, ' ', c.middleName, ' ', c.lastName)

---number 15
select Year(OrderDate) as Year, Avg(TotalDue) as AverageOrderAmount
from sales.SalesOrderHeader
group by Year(OrderDate)

---number 16
select top 5 b.Name, sum(orderqty) SumOrderQty
from Sales.SalesOrderDetail a
left join Production.Product b on a.ProductID=b.ProductID
group by b.Name
order by SumOrderQty desc

---- number 17
select b.Name, count(a.productID) as Total
from Production.Product a
left join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID
where ListPrice > 500
group by b.Name
order by Total desc

--- number 18
SELECT TOP 1
    CONCAT(p.firstName, ' ', p.middleName, ' ', p.lastName) AS SalespersonName,
    COUNT(a.SalesOrderID) AS TotalOrdersHandled
FROM Sales.SalesOrderHeader a
JOIN
    Sales.SalesPerson b ON a.SalesPersonID = b.BusinessEntityID
JOIN
    Person.Person p ON b.BusinessEntityID = p.BusinessEntityID
GROUP BY CONCAT(p.firstName, ' ', p.middleName, ' ', p.lastName)
ORDER BY TotalOrdersHandled desc;
