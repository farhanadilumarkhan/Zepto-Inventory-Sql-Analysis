-- Database Creation

CREATE DATABASE Zepto_Inventory_DB;
USE zepto_inventory_db;

DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto(
	Sku_Id INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(100),
	Name VARCHAR(255) NOT NULL,
	Mrp DECIMAL(10, 2),
    Discount_Percent DECIMAL(5, 2),
	Available_Quantity INT,
	Discounted_Selling_Price DECIMAL(10, 2),
    Weight_In_Gms DECIMAL(10, 2),
    Out_Of_Stock VARCHAR(10),
	Quantity INT
);

-- Data Exploration

-- Count of Rows
SELECT COUNT(*) FROM zepto;

-- Sample Data
SELECT * FROM zepto
LIMIT 10;

-- Null Values
SELECT * FROM zepto
WHERE Category IS NULL
OR 
Name IS NULL
OR 
Mrp IS NULL
OR 
Discount_Percent IS NULL
OR 
Available_Quantity IS NULL
OR 
Discounted_Selling_Price IS NULL
OR 
Weight_In_Gms IS NULL
OR 
Out_Of_Stock IS NULL
OR 
Quantity IS NULL;

-- Product Categories
SELECT DISTINCT Category
FROM zepto
ORDER BY Category;

-- Product Availability (In Stock VS Out of Stock)
SELECT Out_Of_Stock, COUNT(Sku_Id) AS Count 
FROM zepto
GROUP BY Out_Of_Stock;

-- Product names present multiple times
SELECT Name, COUNT(Sku_Id) AS Number_Of_Skus
FROM zepto
GROUP BY Name
HAVING COUNT(Sku_Id) > 1
ORDER BY Number_Of_Skus DESC;

-- Data Cleaning --
-- Products with 0 Price

SELECT * FROM zepto
WHERE Mrp = 0 OR Discounted_Selling_Price = 0;

-- DELETE Product with 0 Price

DELETE FROM zepto
WHERE Sku_Id = 3603;

-- Convert Paise to Rupees

UPDATE zepto
SET Mrp = Mrp / 100.0 ,
Discounted_Selling_Price = Discounted_Selling_Price / 100.0;

-- Data Analysis

-- Q1. Find the top 10 best-value products based on the discount percentage?

SELECT DISTINCT Name, Category, Discount_Percent
FROM zepto
ORDER BY Discount_Percent DESC
LIMIT 10;

-- Q2.What are the Products with High MRP but Out of Stock?

SELECT DISTINCT Sku_Id, Name, Category, Mrp
FROM zepto
WHERE Out_Of_Stock = 'True' AND Mrp > 300
ORDER BY Mrp DESC;

-- Q3.Calculate Estimated Revenue for each category?

SELECT Category, 
SUM(Discounted_Selling_Price * Available_Quantity) AS Revenue
FROM zepto
GROUP BY Category
ORDER BY Revenue DESC;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%?

SELECT DISTINCT Sku_Id, Name, Category, Mrp, Discount_Percent
FROM zepto
WHERE Mrp > 500 AND Discount_Percent < 10
ORDER BY Mrp DESC, Discount_Percent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage?

SELECT Category, 
ROUND(AVG(Discount_Percent) , 2) AS AVG_Discount_Percentage
FROM zepto
GROUP BY Category
ORDER BY AVG_Discount_Percentage DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value?

SELECT DISTINCT Name, Weight_In_Gms, Discounted_Selling_Price,
ROUND((Discounted_Selling_price / Weight_In_Gms), 2)  AS Price_Per_Gram
FROM zepto
WHERE Weight_In_Gms > 100
ORDER BY Price_Per_Gram DESC;

-- Q7.Group the products into categories like Low, Medium, Bulk?

SELECT DISTINCT Name, Weight_In_Gms,
CASE
	WHEN Weight_In_Gms < 1000 THEN 'Low'
    WHEN Weight_In_Gms < 5000 THEN 'Medium'
    ELse 'Bulk'
    END AS Weight_Category
From zepto;

-- Q8.What is the Total Inventory Weight Per Category?

SELECT Category, SUM(Weight_In_Gms * Available_Quantity) AS Category_Weight , 
ROUND(SUM(Weight_In_Gms * Available_Quantity) / 1000, 2) AS Weight_KG
FROM zepto
GROUP BY Category
ORDER BY Category_Weight DESC;







