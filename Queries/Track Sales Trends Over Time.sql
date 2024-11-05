--Track Sales Trends Over Time (Monthly)

 SELECT datepart(mm,so.OrderDate) Month
		,datepart(yy,so.OrderDate) Year
		,AVG(sod.OrderQty * p.Price) AS AverageSpent
FROM SalesOrder so
INNER JOIN SalesOrderDetail sod ON sod.SalesOrderID = so.SalesOrderID
INNER JOIN Customer c ON so.CustomerID = c.CustomerID
INNER JOIN Product p ON sod.ProductID = p.ProductID
GROUP BY datepart(mm,so.OrderDate),datepart(yy,so.OrderDate)