--Analyze Customer Lifetime Value (CLTV) Segmentation by Demographics
With Customers as (
					Select  c.CustomerID
							,DATEDIFF(Year,c.BirthDate, GETDATE()) as Age	
					From [dbo].[Customer] c
					)
	,Demography as (
					Select *
							,Case 
									When Age<25 Then '0-25'
									When Age>=25 And Age<35 Then '25-35'
									When Age>=35 And Age<45 Then '35-45'
									When Age>=45 Then '45+'

							End As DemographyCategory
					from Customers 
				)

Select d.DemographyCategory, sum(sd.OrderQty * sd.UnitPrice) As TotalCLTV 
from Demography d
Inner join [dbo].[SalesOrder] s on s.CustomerID = d.CustomerID
Inner join [dbo].[SalesOrderDetail] sd on sd.SalesOrderID = s.SalesOrderID
--Where d.DemographyCategory  in ('0-25','45+')   -- Use this WHERE clause to show the result for specific DemographyCategories.
Group by d.DemographyCategory




