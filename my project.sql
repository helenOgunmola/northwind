/*Task 1: Retrieve a Subset of Customers from the USA
We need to analyze a sample of our US-based customers. Write a query to retrieve the first five
customers from the Customers table who are located in the United States. This will help us
understand the structure of our customer data*/
select *
from customers
where country = 'USA'
order by customerid
limit  5;

/*Task 2: Identify Large Orders Shipped to Germany.
To better understand our shipping costs, find all orders where the destination (ShipCountry) is
Germany and the Freight charge exceeds 50. These insights will help the logistics team optimize
high-cost shipments*/

select * 
from orders 
where ShipCountry = 'germany'
and freight >50
order by freight desc ;


/*Task 3: Retrieve Employee Details for a Specific Last Name
Human Resources is compiling records on certain employees. Fetch all details of employees
who have the last name ‘Davolio’ and were hired after January 1, 1993. This will be used for
tenure-based benefits assessment*/
select *
from employees 
where lastname = 'Davolio'
and hiredate >'1993-01-01';

 
/*Task 4: List Expensive Products That Are Currently in Stock
The sales team wants to focus on premium products that are available for immediate sale.
Retrieve all products from the Products table where the unit price is greater than 50 and the
stock level (UnitsInStock) is above zero.*/
select * 
from products
where UnitPrice >50 
and UnitsInStock >0;


/*Task 5: Extract Orders Based on Date and Destination
For reporting purposes, retrieve all orders that were placed after January 1, 1997, but only if
they were shipped to either the USA or Canada. This will help us track recent sales trends in
these key markets.*/
select *
from orders
where ShipCountry in ( 'USA', 'Canada')
and OrderDate > '1997-01-01';

 
select *
from orders 
where freight >100
and OrderDate < '1996-07-01';



/*Task 7: Filter Customers in Mexico Based on Company Name
The marketing department needs a targeted list of customers in Mexico whose company name
begins with the letter ‘B’. Extract this data from the Customers table for their upcoming
outreach campaign.*/

select *
 from customers 
where  country = 'mexico'
and companyname like 'B%';


/*Task 8: Retrieve Premium Beverages
The procurement team is reviewing high-value products. Fetch the names and prices of the ten
most expensive products that have a unit price greater than 30 and belong to the ‘Beverages’
category.*/
SELECT p.productname, p.CategoryID, c.categoryname, p.unitprice
from products p
join categories c on p.CategoryID = c.CategoryID
where p. UnitPrice > 30 
and c.categoryname = 'beverages'
order by p.UnitPrice desc
limit 10;


/*Task 9: Find Non-US Suppliers with Company Names Starting with 'A'
We need to identify international suppliers for potential partnerships. Retrieve all suppliers
whose company name starts with ‘A’ and who are not based in the United States.*/
SELECT *
FROM Suppliers
WHERE CompanyName LIKE 'A%'
  AND Country <> 'USA';


/*Task 10: Identify Out-of-Stock Products with Pending Orders
Operations wants to know which products are out of stock but have pending orders. List all
products where UnitsInStock is zero, but the number of UnitsOnOrder is greater than ten.*/
select *
from products 
where UnitsInStock = 0
and UnitsOnOrder >10;

/*Task 11: Locate Orders to Brazil with Missing Shipment Dates
Some orders to Brazil have not been shipped yet. Retrieve all orders where the ShipCountry is
Brazil, the ShippedDate is missing (NULL), and the RequiredDate was before July 1, 1997. This
will help the logistics team investigate potential delays.*/
select *
from orders
where ShippedDate = null
and shipcountry= 'brazil'
and RequiredDate < '1997-07-01';


/*Task 12: Analyze a Specific Customer’s Orders from 1997
We need to examine the order history of the customer with CustomerID = 'ALFKI', but only for
transactions that occurred in the year 1997. Extract this data to support a customer retention
analysis.*/
select *
from orders
where orderdate> '1997-01-01'
and OrderDate < '1998-01-01'
and CustomerID = 'ALFKI';

/*Task 13: Retrieve Employees in Sales Based in London
Management is reviewing the sales team in London. Retrieve details of all employees whose job
title includes ‘Sales’ and who are based in the London office.*/
SELECT *
from employees
where Title like '%sales%'
and city = 'london';


/*Task 14: Identify Products with High Demand but Limited Stock
To prevent stock shortages, find all products that have more than 20 units on order but fewer
than 50 units currently in stock. This will help with restocking decisions.*/
select *
from products 
where UnitsOnOrder >20
and UnitsInStock <50;


/*Task 15: Identify Late Deliveries with High Freight Costs
Customer service needs to follow up on delayed orders. Retrieve all orders where the required
delivery date was earlier than the actual shipping date and where the freight cost exceeded 75.*/
select *
from orders
where RequiredDate < ShippedDate
and freight > 75;

/*Task 16: Find UK-Based Suppliers with a Specific Contact Name
We are searching for suppliers in the UK who have a contact person named 'John'. Retrieve all
suppliers located in the United Kingdom where the ContactName field contains 'John'.*/
select *
from suppliers
where ContactName LIKE '%john%'
and country = 'UK';
/*Task 17: Locate Chocolate Products from a Specific Supplier
A retail partner in France specializes in chocolate products. Retrieve all products that contain
‘chocolate’ in their ProductName and are supplied by a company based in France.*/
SELECT p.ProductName, s.country
from products p
join suppliers s on p.SupplierID = s. SupplierID 
where p. ProductName like '%chocolate%'
and s.Country = 'france';


/*Task 18: Analyze Early Orders from a Specific Customer
Retrieve the first five orders placed by the customer with CustomerID = 'VINET', but only if those
orders were shipped after March 1, 1997. This will be used to study the customer’s purchase
behavior.*/
select *
from orders
where customerid = 'vinet'
and shippeddate > '1997-03-01'
order by orderdate desc
limit 5;



/*Task 19: Extract Orders for Specific European Countries
Before 1998 To analyze historical sales trends, retrieve all orders where the shipping country is
either France, Germany, or Italy, and the order was placed before January 1, 1998.*/
select *
from orders
where ShipCountry in ('france', 'germany', 'italy')
and orderdate < '1998-01-01';


/*Task 20: Generate a Combined Contact Column for Spanish Customers
For a customer relationship project, retrieve the CustomerID and CompanyName from
customers based in Spain, and create a new column that combines the ContactName and
ContactTitle into a single field for easier reference*/
SELECT 
  CustomerID, 
  CompanyName, 
  ContactName || ' ('||  ContactTitle || ')' AS ContactInfo
FROM Customers
WHERE Country = 'Spain';


/*Task 21: List Top 3 Customers by Total Purchase Amount
Retrieve the top 3 customers by total purchase amount. Include CustomerID, CompanyName,
and the total spent using a SUM over OrderDetails.*/
SELECT 
  c.CustomerID,
  c.CompanyName,
  SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalSpent DESC
LIMIT 3;


/*Task 22: Retrieve Orders with Product Category and Quantity Breakdown
Join Orders, OrderDetails, Products, and Categories to list OrderID, CategoryName,
ProductName, and Quantity.*/
SELECT 
  o.OrderID,
  c.CategoryName,
  p.ProductName,
  od.Quantity
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID;


/*Task 23: Use CASE to Categorize Freight Charges
Return OrderID, Freight, and a derived column called FreightCategory:
• "Low" if Freight < 50
• "Medium" if Freight between 50–100
• "High" if Freight > 100*/
 select orderid, freight,
 
 case 
      when freight < 50 then 'low' 
      when freight between 50 and 100 then 'medium'
      when freight > 100 then 'high'
      end as freightcategory 
      from orders;
      
      
/*Task 24: Compare Employee Sales Performance Using Window Functions
Show each employee’s total sales and their rank among all employees using RANK () or
DENSE_RANK ().*/
SELECT 
  e.EmployeeID,
  e.FirstName || ' ' || e.LastName AS EmployeeName,
  SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales,
  RANK() OVER (ORDER BY SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) DESC) AS SalesRank
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

/*Task 25: Average Order Value Per Customer (Over All Time)
List CustomerID, CompanyName, and AVG(OrderTotal) using a subquery to compute order total
for each order.*/
SELECT 
  c.CustomerID,
  c.CompanyName,
  AVG(order_totals.OrderTotal) AS AvgOrderValue
FROM Customers c
JOIN (
  SELECT 
    o.CustomerID,
    o.OrderID,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS OrderTotal
  FROM Orders o
  JOIN `Order Details` od ON o.OrderID = od.OrderID
  GROUP BY o.OrderID, o.CustomerID
) AS order_totals ON c.CustomerID = order_totals.CustomerID
GROUP BY c.CustomerID, c.CompanyName;


/*Task 26: Retrieve Orders with Repeated Customers Using Window Function
Using ROW_NUMBER (), return all orders from customers who have made more than one
purchase.*/
WITH RankedOrders AS (
  SELECT 
    CustomerID,
    OrderID,
    OrderDate,
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RowNum
  FROM Orders
)
SELECT *
FROM RankedOrders
WHERE CustomerID IN (
  SELECT CustomerID
  FROM RankedOrders
  GROUP BY CustomerID
  HAVING COUNT(*) > 1
);



/*Task 27: Identify Highest Freight Paid in Each Country
Use a PARTITION BY with RANK () to get the highest freight per ShipCountry.*/
WITH RankedFreight AS (
  SELECT 
    OrderID,
    ShipCountry,
    Freight,
    RANK() OVER (PARTITION BY ShipCountry ORDER BY Freight DESC) AS FreightRank
  FROM Orders
)
SELECT *
FROM RankedFreight
WHERE FreightRank = 1;


/*Task 28: Orders with More Than One Product Category
List OrderIDs that include products from more than one category using GROUP BY and HAVING
COUNT (DISTINCT CategoryID) > 1.*/
SELECT 
  o.OrderID
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING COUNT(DISTINCT p.CategoryID) > 1;


/*Task 29: Product Sales Summary with Total Revenue
List each product, total quantity sold, and total revenue generated. Use JOIN and aggregation on
OrderDetails.*/
SELECT 
  p.ProductID,
  p.ProductName,
  SUM(od.Quantity) AS TotalQuantitySold,
  SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalRevenue
FROM Products p
JOIN `Order Details` od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC;



/*Task 30: Employees Managing the Most Territories
Find the employee(s) with the most territories using EmployeeTerritories. Use COUNT () and
ORDER BY.*/
SELECT 
  et.EmployeeID,
  COUNT(et.TerritoryID) AS TerritoryCount
FROM EmployeeTerritories et
GROUP BY et.EmployeeID
ORDER BY TerritoryCount DESC
LIMIT 1;


/*Task 31: List Orders and Calculate Delivery Time
For each order, show OrderID, OrderDate, ShippedDate, and a new column DeliveryDays
(difference in days). Use DATEDIFF.*/
SELECT 
  OrderID,
  OrderDate,
  ShippedDate,
  DATEDIFF(ShippedDate, OrderDate) AS DeliveryDays
FROM Orders;


/*Task 32: Calculate Running Total of Freight Costs Over Time
Use SUM(Freight) OVER (ORDER BY OrderDate) to compute a cumulative freight cost per order.*/
SELECT 
  OrderID,
  OrderDate,
  Freight,
  SUM(Freight) OVER (ORDER BY OrderDate) AS RunningTotalFreight
FROM Orders;


/*Task 33: Count of Employees Per Title Per City
List Title, City, and number of employees using GROUP BY.*/

select title, city,
count(*) as employeecount
from employees 
group by title, city
order by title, city;

/*Task 34: Find Orders with At Least One Beverage Item
Join with Categories and filter for CategoryName = 'Beverages'. Use DISTINCT.*/
SELECT DISTINCT o.OrderID
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages';

/*Task 35: Customers and Their Most Recent Order
For each customer, return their most recent order using ROW_NUMBER () over OrderDate
DESC.*/
WITH RankedOrders AS (
  SELECT 
    CustomerID,
    OrderID,
    OrderDate,
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS RowNum
  FROM Orders
)
SELECT 
  CustomerID,
  OrderID,
  OrderDate
FROM RankedOrders
WHERE RowNum = 1;


/*Task 36: Retrieve Orders with Unusually High Item Quantity
List orders where the quantity for any product is higher than the average product quantity using
a subquery.*/
select od.orderid, od.productid, od.quantity
from `order details` od 
where od.Quantity >( 
select avg(quantity) from `order details`);
/*Task 37: Products Never Reordered
List products with ReorderLevel > 0 that have UnitsOnOrder = 0 and never appear in
OrderDetails.*/

SELECT 
  p.ProductID,
  p.ProductName,
  p.ReorderLevel,
  p.UnitsOnOrder
FROM Products p
WHERE 
  p.ReorderLevel > 0
  AND p.UnitsOnOrder = 0
  AND p.ProductID NOT IN (
    SELECT DISTINCT ProductID FROM `Order Details`
  );

/*Task 38: Employees and Their Hire Date Percentile
Use PERCENT_RANK () over HireDate to classify employees based on hiring timeline.*/
SELECT 
  EmployeeID,
  FirstName,
  LastName,
  HireDate,
  PERCENT_RANK() OVER (ORDER BY HireDate) AS HireDatePercentile
FROM Employees;


/*Task 39: List Top 5 Orders with Most Expensive Line Items
Use ORDER BY UnitPrice DESC within a JOIN across Orders, OrderDetails, and Products.*/
SELECT 
  o.OrderID,
  p.ProductName,
  od.UnitPrice,
  od.Quantity
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
ORDER BY od.UnitPrice DESC
LIMIT 5;

/*Task 40: Average Discount Per Customer
Return customers and their average discount across all orders using JOIN and AVG(Discount).*/
SELECT 
  c.CustomerID,
  c.CompanyName,
  AVG(od.Discount) AS AverageDiscount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY AverageDiscount DESC;

/*Task 41: Most Popular Product Per Category
Use a subquery or ROW_NUMBER () to return one product per category with the highest order
quantity.*/
WITH ProductSales AS (
  SELECT 
    c.CategoryID,
    c.CategoryName,
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantity,
    ROW_NUMBER() OVER (PARTITION BY c.CategoryID ORDER BY SUM(od.Quantity) DESC) AS rn
  FROM Categories c
  JOIN Products p ON c.CategoryID = p.CategoryID
  JOIN `Order Details` od ON p.ProductID = od.ProductID
  GROUP BY c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
)
SELECT 
  CategoryID,
  CategoryName,
  ProductID,
  ProductName,
  TotalQuantity
FROM ProductSales
WHERE rn = 1;


/*Task 42: Month-on-Month Growth in Orders
Group orders by month and calculate order count and percentage growth over previous month
using LAG ().*/
WITH MonthlyOrders AS (
  SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS OrderMonth,
    COUNT(*) AS OrderCount
  FROM Orders
  GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
),
Growth AS (
  SELECT 
    OrderMonth,
    OrderCount,
    LAG(OrderCount) OVER (ORDER BY OrderMonth) AS PreviousMonthCount
  FROM MonthlyOrders
)
SELECT 
  OrderMonth,
  OrderCount,
  PreviousMonthCount,
  ROUND(
    CASE 
      WHEN PreviousMonthCount IS NULL OR PreviousMonthCount = 0 THEN NULL
      ELSE ((OrderCount - PreviousMonthCount) / PreviousMonthCount) * 100
    END, 2
  ) AS PercentGrowth
FROM Growth;

/*Task 43: Identify Orders with All Items Discounted
List OrderIDs where every OrderDetail has a Discount > 0.*/
SELECT 
  od.OrderID
FROM `Order Details` od
GROUP BY od.OrderID
HAVING 
  COUNT(*) = SUM(CASE WHEN od.Discount > 0 THEN 1 ELSE 0 END);

/*Task 44: Detect Repeat Purchases of the Same Product
List customers who ordered the same product more than once (same ProductID across different
orders).*/

/*Task 45: Calculate Category-wise Inventory Value
Return each category and the total inventory value (UnitPrice × UnitsInStock) of products.*/
SELECT 
  c.CategoryID,
  c.CategoryName,
  ROUND(SUM(p.UnitPrice * p.UnitsInStock), 2) AS TotalInventoryValue
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalInventoryValue DESC;

/*Task 46: Cross Join Employees and Territories
List all combinations of employees and territories using a CROSS JOIN. Limit to 100 rows.*/
SELECT 
  e.EmployeeID,
  e.FirstName,
  e.LastName,
  t.TerritoryID,
  t.TerritoryDescription
FROM Employees e
CROSS JOIN Territories t
LIMIT 100;

/*Task 47: Combine Customer and Order Counts by Country
List each country and total number of customers and total orders from that country.(*/
SELECT 
  c.Country,
  COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
  COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Country
ORDER BY TotalOrders DESC;

/*Task 48: Determine Employee Sales Contribution as % of Total
Show each employee’s total sales and percentage of overall company sales using window
functions.*/
WITH EmployeeSales AS (
  SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
  FROM Employees e
  JOIN Orders o ON e.EmployeeID = o.EmployeeID
  JOIN `Order Details` od ON o.OrderID = od.OrderID
  GROUP BY e.EmployeeID, e.FirstName, e.LastName
),
SalesWithPercentage AS (
  SELECT 
    EmployeeID,
    FirstName,
    LastName,
    TotalSales,
    SUM(TotalSales) OVER () AS CompanyTotalSales
  FROM EmployeeSales
)
SELECT 
  EmployeeID,
  FirstName,
  LastName,
  ROUND(TotalSales, 2) AS TotalSales,
  ROUND((TotalSales / CompanyTotalSales) * 100, 2) AS SalesPercentage
FROM SalesWithPercentage
ORDER BY TotalSales DESC;

/*Task 49: Orders That Include Products from 'Exotic Liquids'
List all orders that contain at least one product from the supplier 'Exotic Liquids'.*/
SELECT   o.OrderID, p.productname, s.companyname
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.CompanyName = 'Exotic Liquids';

-- Task 50: Show Latest 3 Orders per Customer
-- Use ROW_NUMBER () to retrieve the latest 3 orders placed by each customer.
WITH RankedOrders AS (
  SELECT 
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    ROW_NUMBER() OVER (PARTITION BY o.CustomerID ORDER BY o.OrderDate DESC) AS rn
  FROM Orders o
)
SELECT 
  OrderID,
  CustomerID,
  OrderDate
FROM RankedOrders
WHERE rn <= 3
ORDER BY CustomerID, OrderDate DESC;



