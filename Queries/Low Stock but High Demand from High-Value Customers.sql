--Products with Low Stock Levels but High Demand from High-Value Customers

With HighValueCustomers As (	
							Select c.CustomerID
									,sum(sd.OrderQty * sd.UnitPrice) As TotalSpending
							From [dbo].[Customer] c
							Inner join [dbo].[SalesOrder] s on s.CustomerID = c.CustomerID
							Inner join [dbo].[SalesOrderDetail] sd on sd.SalesOrderID = s.SalesOrderID
							Group by c.CustomerID
							Having sum(sd.OrderQty * sd.UnitPrice)>1000   -- Adjust threshold for high-value customers
	
							)
Select  p.ProductID
		,p.Name as ProductName
		,p.Stock
		,sum(sd.OrderQty) as OrderQuantity
from [dbo].[Product] p
Inner join [dbo].[SalesOrderDetail] sd on sd.ProductID = p.ProductID 
Inner join [dbo].[SalesOrder] s on s.SalesOrderID = sd.SalesOrderID
Inner join HighValueCustomers hvc on hvc.CustomerID = s.CustomerID
Group by p.ProductID
		,p.Name
		,p.Stock
Having p.Stock<sum(sd.OrderQty) And sum(sd.OrderQty)>30    -- Adjust thresholds for low stock and high demand


