USE SupplyChainDB

Create table fact_Orders ([Order ID] int ,
                          [Customer ID] int,
                          [Product Card ID] int,
                          Order_Date date,
                          Shipping_Date int,
                          Delivery_Time int,
                          Is_Delayed int ,
                          TotalAmount float)