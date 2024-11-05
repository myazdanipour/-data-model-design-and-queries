--Identify At-Risk Customers and customer churn

WITH LastPurchase AS (
						SELECT 
								c.CustomerID
								,MAX(so.OrderDate) AS LastPurchaseDate
							  FROM Customer c
							  INNER JOIN SalesOrder so ON c.CustomerID = so.CustomerID
							  GROUP BY c.CustomerID
)
SELECT 
		c.CustomerID,
		c.FirstName + ' ' + c.LastName AS CustomerName,
		DATEDIFF(day, LP.LastPurchaseDate, GETDATE()) AS DaysSinceLastPurchase
FROM Customer c
INNER JOIN LastPurchase LP ON c.CustomerID = LP.CustomerID
Where DATEDIFF(day, LP.LastPurchaseDate, GETDATE()) > 60  -- Adjusted threshold
ORDER BY DaysSinceLastPurchase DESC;