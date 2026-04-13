CREATE DATABASE SupplyChainDB;
use SupplyChainDB


--1.Average DeliveryTime 
Select AVG(Delivery_Time) as AverageTimeToDeliver 
from DBO.supply_chain_data  -- So Average DeliveryTime is of 3

select top 5 * from supply_chain_data

--2.Which Regions Have Highest Delay?


SELECT Top 10 [Order Region] ,[Order State], AVG(Delivery_Time) AS Avg_Time
FROM supply_chain_data
GROUP BY [Order Region] ,[Order State] 
having AVG(Delivery_Time) > ( Select Avg(Delivery_Time) from supply_chain_data)
ORDER BY Avg_Time DESC; -- So most of can be seen in west africa , east africa  , south america

--3.Delay Percentage

SELECT 
    COUNT(CASE WHEN Is_Delayed = 1 THEN 1 END) * 100.0 / COUNT(*) AS Delay_Percentage
FROM supply_chain_data;
-- there is 16% chances of Delay when the order is shipped 

--4.Shipping Mode Performance

SELECT [Shipping Mode], AVG(Delivery_Time) AS Avg_Time
FROM supply_chain_data
GROUP BY [Shipping Mode]
ORDER BY Avg_Time desc; 
--So Standard class has the most delay 

--5.Top Products Causing Delays

Select [Product Name] , MAX(Delivery_Time) as MaxDelivery_Time 
from supply_chain_data
GROUP BY [Product Name]
Order by MaxDelivery_Time DESC;
--All this 117 product causes most delays 

--6.Monthly Trend Analysis

Select Month(Shipping_Date) as MonthName ,
       Sum([Order Profit Per Order]) as ProfitPerMonth
from supply_chain_data
group by Month(Shipping_Date)
order by ProfitPerMonth desc
--So August was the most Profitable and December is the least Profitable 

--7. Revenue Impact of Delays
