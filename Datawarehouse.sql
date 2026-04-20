USE SupplyChainDB
--Fact Table
CREATE TABLE fact_orders (
    Fact_ID INT IDENTITY(1,1) PRIMARY KEY,
    Order_ID INT,
    Customer_ID INT,
    Product_Card_ID INT,
    Order_Date DATE,
    Shipping_Date DATE,
    Delivery_Time INT,
    Is_Delayed INT,
    Order_Item_Price FLOAT,
    Quantity INT,
    TotalAmount FLOAT
);

-- Dimention Table 

Create Table dim_Customer ([Customer ID] int primary key,
                           [Customer City] varchar(300),
                           [Customer State] varchar(300),
                           [Customer Country] varchar(300),
                           [Customer Segment] varchar(300)
                           )
--Now entering values inside them 

INSERT INTO dim_customer (
    [Customer ID],
    [Customer City],
    [Customer State],
    [Customer Country],
    [Customer Segment]
)
SELECT 
    [Customer ID],
    MAX([Customer City]) AS Customer_City,
    MAX([Customer State]) AS Customer_State,
    MAX([Customer Country]) AS Customer_Country,
    MAX([Customer Segment]) AS Customer_Segment
FROM supply_chain_data
GROUP BY [Customer ID];

Select top 5 * from dim_Customer
Create Table dim_Product([Product Card Id] int primary key ,
                         [Product_Name] varchar(300),
                         [Category_Name] varchar(300),
                         [Department_Name] varchar(300))

Insert into dim_Product([Product Card Id],[Product_Name],[Category_Name],[Department_Name])
Select [Product Card ID], MAX([Product Name]) as Product_Name, 
       MAX([Category Name]) AS Category_Name, 
       MAX([Department Name]) as Department_Name
from supply_chain_data
group by [Product Card ID]


Create Table dim_date (Date date Primary key,
                       Day int,
                       Month int ,
                       Month_Name varchar(300),
                       Year int,
                       quarter int,
                       Weekday_Name varchar(300),)

insert into dim_date
select distinct d.date,day(d.DATE) AS Day,
                MONTH(d.DATE) AS Month,
                DATENAME(month,d.date) as Month_Name,
                year(d.date) as Year,
                DATEPART(QUARTER,d.DATE) as Quarter,
                Datename(weekday,d.date) as Weekday_Name
from (Select [Order_Date] as Date from Supply_chain_data
      union 
      Select [Shipping_date] from supply_chain_data
      )d
WHERE d.Date IS NOT NULL
AND d.Date NOT IN (SELECT Date FROM dim_date);

''' Facing Error to insert the data '''

            

