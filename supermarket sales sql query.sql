

--add time of the day column
ALTER TABLE supermarket_sales
ADD  TimeOfDay VARCHAR(10);

-- Update time of the day values
UPDATE supermarket_sales
SET TimeOfDay = CASE
    WHEN datepart(HOUR FROM Time) < 12 THEN 'Morning'
    WHEN datepart(HOUR FROM Time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
END;



--add sales per unit of each product
ALTER TABLE supermarket_sales
ADD SalesPerUnit NUMERIC;

UPDATE supermarket_sales
SET SalesPerUnit = Total / Quantity

--total sales from all branches put together
select SUM(total) as Revenue
from supermarket_sales

--productline with the highest sales
SELECT [Product line] tLine, SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY [Product line]
order by [Product line] desc

--product line with the highest quantity sold

SELECT
	SUM(quantity) as qty,
    [Product line]
FROM supermarket_sales
GROUP BY [Product line]
ORDER BY qty DESC

--how many branches does the supermarket have
select  distinct branch
from supermarket_sales

--where each branch is located
select city, branch
from supermarket_sales
group by City, Branch

--how many unique product line
select  distinct [Product line]
from supermarket_sales

--total revenue from each branch
select branch, sum(total) as revenue
from supermarket_sales
group by Branch
order by revenue desc

--average rating of each product line
SELECT [product line],  round(AVG(Rating), 2) AS AvgRating
FROM supermarket_sales
group by [Product line]
order by AvgRating desc


---daily sales
SELECT Date, SUM(Total) AS DailySales
FROM supermarket_sales
GROUP BY Date

--monthly gross profit
SELECT 
    FORMAT(Date, 'MMMM yyyy') AS MonthYear,
    SUM("Gross Income") AS TotalProfit
FROM supermarket_sales
GROUP BY FORMAT(Date, 'MMMM yyyy')
ORDER BY MIN(Date)

--sales by payment method
SELECT 
    Payment,
    SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY Payment
order by TotalSales desc

--top selling product line by branch

SELECT 
    Branch,
    [Product line],
    SUM(Quantity) AS TotalQuantity
FROM supermarket_sales
GROUP BY Branch, [Product line]
ORDER BY TotalQuantity DESC

---sales by time of the day

SELECT TimeOfDay, SUM(Total) AS TotalSales
FROM supermarket_sales
WHERE TimeOfDay IN ('Morning', 'Afternoon', 'evening')
GROUP BY TimeOfDay
order by TotalSales desc

--monthly sales trend
SELECT 
    FORMAT(Date, 'MMMM yyyy') AS MonthYear,
    SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY FORMAT(Date, 'MMMM yyyy')
ORDER BY MIN(Date)


--total number of male and female based on customer type
SELECT Gender, [Customer type], COUNT(*) AS CustomerCount
FROM supermarket_sales
GROUP BY Gender, [Customer type]




---total revenue by customer type
SELECT  [Customer type], sum(total) as revenue
FROM supermarket_sales
GROUP BY [Customer type]


--average sales per unit product
SELECT [Product line], AVG(SalesPerUnit) AS AvgSalesPerUnit
FROM supermarket_sales
GROUP BY [Product line]


--city with the highest revenue
select city, Branch, sum(Total) as revenue
from supermarket_sales
group by City, Branch
order by revenue desc


--which customer type pay the highest VAT
select [Customer type], AVG([Tax 5%]) as totalTax
from supermarket_sales
group by [Customer type]
order by totalTax

--which branch has the most rating
select branch, AVG(Rating) as avgRating
from supermarket_sales
group by Branch
order by avgRating desc




