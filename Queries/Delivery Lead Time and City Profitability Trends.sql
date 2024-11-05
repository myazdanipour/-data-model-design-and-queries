
--Delivery Lead Time and City Profitability Trends

--Delivery Lead Time---Average Delivery Waiting Days for Customers

Select 
		Avg (datediff (dd,orderdate,shipdate))
from salesorder
;

--City Profitability Trends----Cities' Profitability over the years

Select	 		DATEPART(yy,SalesOrder.OrderDate) As Year
		        ,CityName as City
				,SUM (sod.unitprice * sod.orderqty) As Revenue
	            ,SUM (p.OriginalPrice * sod.orderqty) - sum(p.Cost * sod.orderqty) As Profit

from SalesOrderDetail sod
join Product p on sod.ProductID = p.ProductID
join SalesOrder on sod.SalesOrderID=SalesOrder.SalesOrderID
join Customer on SalesOrder.CustomerID = Customer.CustomerID
join City on Customer.CityID = City.CityID

Group by CityName
		,DATEPART(yy,SalesOrder.OrderDate)
Order By Profit DESC , Year Desc