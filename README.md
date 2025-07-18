# bikes_analysis
# The Bikes Shop - Sales Data Analysis

## Overview

This project involves a comprehensive analysis of the sales data for "The Bikes Shop." The primary goal was to clean a raw SQL database dump, standardize customer information, and derive key metrics to understand sales performance, customer behavior, and product trends. The entire process, from data cleaning to final analysis, was conducted using SQL within MySQL Workbench.


## 🛠️ Tools Used

* **Database:** MySQL Server
* **IDE:** MySQL Workbench
* **Language:** SQL


##  methodology

The analysis was performed in three main stages: data examination, data cleaning, and metric extraction.

### 1. Data Examination

The first step was to load the `thebikes_shop.sql` database dump and perform an initial exploration of the tables to understand the schema and identify data quality issues. Key tables examined included `tbl_customers`, `tbl_orders`, `tbl_products`, `tbl_brands`, and `tbl_payments`.

Initial findings revealed inconsistencies in customer contact information, such as varied phone number formats and empty strings in the email column.

### 2. Data Cleaning

Significant effort was placed on cleaning and standardizing the customer data in `tbl_customers` to ensure accuracy for analysis and future outreach.

Standardizing Phone Numbers:** Phone numbers were updated to a consistent international format (`+254...`).
  
Cleaning Emails:** Empty email fields, which were stored as empty strings `''`, were updated to `NULL` for better data integrity.


### 3. Data Analysis

With a cleaner dataset, a series of SQL queries were executed to answer key business questions and generate performance metrics.

## 📊 Key Findings and Insights

Total Revenue: The total revenue generated after discounts is 1,087,050.00.
Top Selling Brand: LS2 Helmets is the highest-grossing brand, indicating strong market preference.
Top Selling Category: Helmets are, by a large margin, the most popular product category.
Most Common Payment Method:Cash is the most frequently used payment method, followed closely by M-Pesa.
Repeat Customers:The analysis successfully identified a list of repeat customers (customers who’ve made more than 2 orders or more)


## 🚀 How to Reproduce

To reproduce this analysis, you will need:
1.  A running MySQL or compatible database server.
2.  A database client, such as MySQL Workbench.
3.  Import the `thebikes_shop - 18-07-2024.sql` file to create and populate the database.

