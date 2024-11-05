--Customer Demography Analysis: This query analyzes customer demography by identifying the most effective ones for attracting new customers
With Demography as
				(
				
					SELECT		 Customerid
								,Case	
										When MaritalStatus = 0 then 'Single'
										When MaritalStatus = 1 then 'Married'
										End as MaritalStatus
								,Case 
		
										When AnnualIncome < 50000 then 'LowIncome'
										When AnnualIncome >= 50000 and AnnualIncome < 70000 then 'MidIncome'
										Else 'HighIncome'
										End as IncomeLevel
								,DATEDIFF(yy,birthdate,getdate()) As Age
					From		Customer
			--		Group by Customerid
				)
	,AgeCat as 
					(
						Select *
							   ,Case 
										When Age <25 Then 'Young'
										When Age>=25 And Age<45 Then 'MiddleAged'
										When Age>=45 Then 'Senior'
										End As AgeCategory
						from Demography 
					)
Select	COUNT(*) AS NOofCustomers
		,Demography.MaritalStatus
		,Demography.IncomeLevel
		,AgeCat.AgeCategory

From Customer
Join Demography on Demography.Customerid = Customer.CustomerID
Join AgeCat on AgeCat.customerid = customer.customerid

Where		Demography.MaritalStatus= 'Single' 
		  --AND Demography.IncomeLevel='HighIncome' 
		  AND AgeCat.AgeCategory='MiddleAged'
Group by  Demography.MaritalStatus
		 ,Demography.IncomeLevel
		 ,AgeCat.AgeCategory
Order by COUNT(*) Desc
