
--Analyzing the effect of discount on quantity sold

With 
Sale_Analysis as
(
Select		Product.Name As 'Product_Name'
			,SUM(sod.orderqty) as 'Quantity_Sold'
		    ,SUM(UnitPriceDiscount * sod.OrderQty) As 'Total_Discount'
		    ,SUM(UnitPrice * sod.OrderQty) as 'Total_Sold'
			,SUM((UnitPrice-UnitPriceDiscount) * sod.OrderQty) as 'Total_Sold_After_Discount'

From SalesOrderDetail sod
join Product on Product.ProductID = sod.ProductID
Group By Product.Name
)
Select * from Sale_Analysis

Where  Total_Discount <> 0

Order by [Quantity_Sold] desc