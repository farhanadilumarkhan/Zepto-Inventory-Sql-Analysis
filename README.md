# 🛒 Zepto Inventory Analysis (SQL)

An end-to-end SQL project on quick-commerce inventory data from Zepto — covering database setup, data exploration, data cleaning, and business analysis on pricing, discounts, stock availability, and revenue potential.

---

## 📌 Problem Statement

Quick-commerce platforms manage thousands of SKUs across many categories, with prices, discounts, and stock levels changing constantly. Poor visibility into this data leads to lost sales (high-value products out of stock), margin leakage (wrong discounting), and inefficient inventory planning.

This project uses SQL to answer questions such as:
- Which products offer the best discounts, and which categories discount the most?
- Which high-value products are out of stock?
- What is the estimated revenue potential of each category?
- How is inventory distributed by weight, and which products give the best value per gram?

---

## 🗂️ Dataset

Zepto product inventory data (`zepto_v2.csv`):
- **3,732 SKU records** across **14 categories**
- Columns: `Category`, `Name`, `Mrp`, `Discount_Percent`, `Available_Quantity`, `Discounted_Selling_Price`, `Weight_In_Gms`, `Out_Of_Stock`, `Quantity`
- Prices in the raw file are stored in **paise** and converted to **rupees** during cleaning

---

## 🛠️ Tools & Tech Stack

| Tool | Purpose |
|------|---------|
| **MySQL** | Database creation, data cleaning, analysis |
| **SQL** | Aggregations, `CASE` logic, filtering, data transformation |

---

## ⚙️ Approach

### 1. Database Setup
Created the `Zepto_Inventory_DB` database and a `zepto` table with an auto-increment primary key (`Sku_Id`) and appropriate data types for prices, weights, and quantities.

### 2. Data Exploration
- Checked total row count and previewed sample records
- Scanned all columns for `NULL` values
- Listed distinct product categories
- Compared in-stock vs. out-of-stock product counts
- Identified product names that appear under multiple SKUs

### 3. Data Cleaning
- Found and removed records with a **zero MRP / zero selling price** (invalid pricing data)
- Converted `Mrp` and `Discounted_Selling_Price` from **paise to rupees** (divided by 100)

### 4. Business Analysis
Eight business questions answered with SQL (see below).

---

## 🔑 Business Questions Answered

| # | Business Question | SQL Technique |
|---|---|---|
| 1 | Top 10 best-value products by discount percentage | `ORDER BY` + `LIMIT` |
| 2 | High-MRP products (> ₹300) that are out of stock | Multi-condition filtering |
| 3 | Estimated revenue for each category | `SUM()` + `GROUP BY` |
| 4 | Premium products (MRP > ₹500) with low discounts (< 10%) | Filtering on multiple columns |
| 5 | Top 5 categories by average discount percentage | `AVG()` + `GROUP BY` + `LIMIT` |
| 6 | Price per gram for products above 100g, sorted by best value | Calculated column + `ROUND()` |
| 7 | Classify products into Low / Medium / Bulk weight groups | `CASE WHEN` |
| 8 | Total inventory weight per category (grams and kg) | `SUM()` of derived values |

---

## 📊 Key Findings

- The dataset contains **3,732 SKUs across 14 categories** with no `NULL` values, but **1 record had an invalid zero price** and was removed
- **453 SKUs (~12%) are out of stock**, representing missed sales opportunities
- **Fruits & Vegetables has the highest average discount (~15.5%)**, followed by Meats, Fish & Eggs (~11%) — consistent with perishable items being discounted aggressively
- **8 high-value products (MRP > ₹300) are currently out of stock** — priority items for restocking
- **82 premium products (MRP > ₹500) carry discounts under 10%**, suggesting limited price competition on high-ticket items
- Many product names appear under **multiple SKUs** (different sizes/variants/pack types), which matters for catalog and inventory planning

---

## 🚀 How to Run This Project

1. Open MySQL Workbench and run `Zepto_Inventory_SQL.sql` to create the database and table
2. Import `zepto_v2.csv` into the `zepto` table (Table Data Import Wizard)
3. Run the exploration, cleaning, and analysis sections in order

---

## 📁 Repository Structure

```
├── Zepto_Inventory_SQL.sql   # Database setup, exploration, cleaning, analysis
├── zepto.csv              # Raw dataset
└── README.md
```

---

## 👤 Author

**Farhan Adil**
Data Scientist | AI Automation Enthusiast
