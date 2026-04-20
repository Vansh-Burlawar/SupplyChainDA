USE SupplyChainDB
--Fact Table
Create table fact_Orders ([Order ID] int ,
                          [Customer ID] int,
                          [Product Card ID] int,
                          Order_Date date,
                          Shipping_Date date,
                          Delivery_Time int,
                          Is_Delayed int ,
                          TotalAmount float)

-- Dimention Table 

Create Table dim_Customer ([Customer ID] int ,
                           [Customer City] varchar(300),
                           [Customer State] varchar(300),
                           [Customer Country] varchar(300),
                           [Customer Segment] varchar(300)
                           )
--Now entering values inside them 

insert into dim_Customer([Customer ID],[Customer City],[Customer State] ,[Customer Country],[Customer Segment])
Select Distinct [Customer ID],[Customer City],[Customer State] ,[Customer Country],[Customer Segment]
FROM supply_chain_data;