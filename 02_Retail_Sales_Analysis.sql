SELECT COUNT(*) AS Total_Rows
FROM dbo.Orders;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Orders';

SELECT TOP 10 *
FROM dbo.Orders;

SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit)AS Total_Profit,
    SUM(Quantity)AS Total_Quantity
FROM dbo.Orders;

SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Region
ORDER BY Total_Sales DESC;

SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit)AS Total_Profit
FROM dbo.Orders
GROUP BY
      YEAR(Order_Date),
      MONTH(Order_Date)
ORDER BY
      Order_Year,
      Order_Month;

SELECT TOP 10
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit)AS Total_Profit
FROM dbo.Orders
GROUP BY Product_Name
ORDER BY Total_Sales DESC;

SELECT 
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Product_Name
HAVING SUM(Profit)<0
ORDER BY Total_Profit ASC;


SELECT
    Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Discount
ORDER BY Discount ASC;

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE='BASE TABLE';

SELECT COUNT(*) AS Total_Return_Records
FROM dbo.Orders;

USE RetailSalesDB;

SELECT DB_NAME() AS Current_Database;

SELECT
    'Orders' AS Table_Name,
    COUNT(*) AS Total_Rows
FROM dbo.Orders

UNION ALL

SELECT
    'Returns' AS Table_Name,
    COUNT(*) AS Total_Rows
FROM dbo.Returns;

USE RetailSalesDB;

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

USE RetailSalesDB;
SELECT COUNT(*) AS Total_People_Records
FROM dbo.Orders;

USE RetailSalesDB;
SELECT TOP 10 *
FROM dbo.People;


SELECT COUNT(*) AS Total_People_Records
FROM dbo.People;

SELECT *
FROM dbo.People;


USE RetailSalesdb;
SELECT TOP 20
       o.Order_ID,
       o.Product_Name,
       o.Sales,
       o.Profit,
       r.Returned
FROM dbo.Orders AS o
LEFT JOIN dbo.Returns AS r
ON o.Order_ID=r.Order_ID;


USE RetailSalesdb;
SELECT TOP 20
       o.Order_ID,
       o.Region,
       p.[Regional Manager]
FROM  dbo.Orders AS o
LEFT JOIN dbo.People AS p
ON o.Region=p.Region;


USE RETAILSALESdb;
SELECT
    Order_ID,
    Product_Name,
    Profit,
    Sales,
CASE
    WHEN Profit>0 THEN 'Profitable'
    WHEN Profit<0 THEN 'Loss Making'
    ELSE 'Break-Even'
END AS Profit_Status
FROM dbo.Orders;


USE RETAILSALESdb;
SELECT
    Product_Name,
    SUM(Sales) AS Total_Sales
FROM dbo.Orders
GROUP BY Product_Name
HAVING SUM(Sales)>(
       SELECT AVG(Product_Sales)
       FROM(
           SELECT SUM(Sales) AS Product_Sales
           FROM dbo.Orders
           GROUP BY Product_Name
           ) AS ProductTotals
        )
    ORDER BY Total_Sales DESC;


USE RETAILSALESdb;
WITH MonthlySales AS(
     SELECT
         YEAR(Order_Date) AS Order_Year,
         MONTH(Order_Date) AS Order_Month,
         SUM(Sales) AS Total_Sales,
         SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY
      YEAR(Order_Date),
      MONTH(Order_Date)
)
SELECT
    Order_Year,
    Order_Month,
    Total_Sales,
    Total_Profit
FROM MonthlySales
ORDER BY Order_Year,Order_Month;


USE RetailSalesDB;

WITH ProductSales AS (
    SELECT
        Product_Name,
        SUM(Sales) AS Total_Sales
    FROM dbo.Orders
    GROUP BY Product_Name
)
SELECT
    Product_Name,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM ProductSales
ORDER BY Sales_Rank;