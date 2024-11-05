--Top 2 Best selling products in each ProductCategory

With BestSellingProducts As (
							Select 
									pc.Name as ProductCategoryName
									,p.Name as ProductName
									,p.ProductID
									,sum(so.OrderQty) SoldQuantity
									,ROW_NUMBER() OVER (PARTITION BY pc.Name ORDER BY SUM(so.OrderQty) DESC) AS Rank

							From [dbo].[SalesOrderDetail] so
							Inner join [dbo].[Product] p on p.ProductID = so.ProductID
							Inner join [dbo].[ProductCategory] pc on pc.ProductCategoryID = p.ProductCategoryID
							Group by p.Name, pc.Name,p.ProductID
							
							)
Select 
		bs.ProductCategoryName
		,bs.ProductID
		,bs.ProductName
From BestSellingProducts bs
Where bs.Rank<=2 -- The number of best seller products in each category



