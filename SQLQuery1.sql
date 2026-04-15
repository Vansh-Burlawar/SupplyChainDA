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
Select Is_Delayed , sum(TotalAmount) as  TotalAmount 
from supply_chain_data
group by Is_Delayed
--The revenue is very less when there are delays as compair to without delay

-- 8 Best Performing State

Select top 5  [Customer State] , Avg(TotalAmount) as Total
from supply_chain_data
group by [Customer State]
order by Total desc 


--9 Worst Performing Region

Select top 5  [Customer State] , Avg(TotalAmount) as Total
from supply_chain_data
group by [Customer State]
order by Total  

--10. Which Regions Cause Maximum Delays?

Select [Order State] , count(*) as TotalOrders,
       Sum(Delivery_Time) as AvgDeliveryTimePerState
from supply_chain_data
where is_Delayed = 1 
group by [Order State]
Order by 3 desc 

--11. Which Months Have Worst Performance?

Select top 3 datename(month,Order_Date) as Month, 
       sum(TotalAmount) as TotalRevinue , 
       count(*) as TotalOrders
from supply_chain_data
group by datename(month,Order_Date)
order by TotalRevinue

--12. Customer Segment Impact

Select [Customer Segment],
       SUM([TotalAmount]) as TotalInThatSegment,
       Avg(Delivery_Time) as AvgDeliverytime 
from supply_chain_data
where Is_Delayed = 1
GROUP by  [Customer Segment]
order by AvgDeliverytime

--13. Delay Rate by Country

SELECT [Customer Country],
       COUNT(*) AS Total,
       Sum(delivery_Time) as DelayTime
FROM supply_chain_data
GROUP BY [Customer Country]
ORDER BY DelayTime DESC;

--14. Delay Rate
SELECT 
    COUNT(CASE WHEN Is_Delayed = 1 THEN 1 END) * 100.0 / COUNT(*) AS Delay_Percentage
FROM supply_chain_data;

