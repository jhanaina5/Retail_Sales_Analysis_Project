USE RetailSalesDB;

DELETE FROM dbo.People
WHERE [Regional Manager] = 'Regional Manager'
  AND Region = 'Region';

 SELECT COUNT(*) AS Total_People_Records
FROM dbo.People;

SELECT *
FROM dbo.People;