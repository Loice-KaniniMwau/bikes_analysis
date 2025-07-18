-- --examining the dataste, looking for missing null values - 
select * from tbl_brands
SELECT * from tbl_payments
-- --payment modes- cheque(denoted by 2) vs cash(denoted by 1)-- 
order_idselect * from tbl_categories
select * from tbl_customer_categories
select * from tbl_customers
-- from the customers table phone numbers are inconsistent
-- standardizing phone column to begin with the country code--  

-- cleaning emails--
UPDATE tbl_customers SET email= NULL WHERE email = '';
select email from tbl_customers
-- phone records--  
SET SQL_SAFE_UPDATES = 0;
-- --replacing 07 with +254-- 
UPDATE tbl_customers
SET phone= CONCAT('+254', SUBSTRING(phone,2))
WHERE phone LIKE '07%';
-- --replacing 01 with +254-- 
UPDATE tbl_customers
SET phone= CONCAT('+254', SUBSTRING(phone,2))
WHERE phone LIKE '01%'



-- --removing extra spaces from the phone records--  
UPDATE tbl_customers
SET phone= REPLACE (phone,' ', '')

select * from tbl_customers

-- --email field with a phone number entry, replace the phone number with null


-- --revenue after discounts-- 
select sum(total) AS grand_total_revenue
from tbl_orders 

-- --revenue per month--
select * from tbl_orders
select DATE_FORMAT(created_at, '%Y-%M') AS sales_by_month, SUM(total) AS monthly_revenue
from tbl_orders
group by sales_by_month
order by monthly_revenue desc

-- --sales by product type-- 
-- alll the product types are null
select product_type from tbl_products
SELECT
    p.product_type,
    SUM(oi.total_amount) AS gross_sales
FROM
    tbl_order_items AS oi
JOIN
    tbl_products AS p ON oi.product_id = p.id
GROUP BY
    p.product_type
ORDER BY
    gross_sales DESC;


-- Sales by Brand
-- high selling brand LS2 Helmets
SELECT
    b.name AS brtotal_amountand_name,
    SUM(oi.total_amount) AS gross_sales
FROM
    tbl_order_items AS oi
JOIN
    tbl_products AS p ON oi.product_id = p.id
JOIN
    tbl_brands AS b ON p.brand_id = b.id
GROUP BY
    b.name
ORDER BY
    gross_sales DESC;

-- 4. ⁠Sales by Categories
SELECT
    c.name AS category_name,
    SUM(oi.total_amount) AS gross_sales
FROM
    tbl_order_items AS oi
JOIN
    tbl_products AS p ON oi.product_id = p.id
JOIN
    tbl_categories AS c ON p.category_id = c.id
GROUP BY
    c.name
ORDER BY
    gross_sales DESC;
    
-- ---common payment method-- 
select * from tbl_payments
-- --if a transaction code exists- payment via mpesa, if transaction code is null payment by cash
-- --1- denotes cash, 2 denotes mpesa
SELECT
    CASE
        WHEN payment_mode = 1 THEN 'Cash'
        WHEN payment_mode = 2 THEN 'M-Pesa'
        WHEN payment_mode = 3 THEN 'Cheque'
        ELSE 'Other'
    END AS payment_method,
    COUNT(id) AS number_of_transactions
FROM
    tbl_payments
GROUP BY
    payment_method
ORDER BY
    number_of_transactions DESC;
    
-- --identifying repeat customers
-- --the meaning of repeat customers is up for intepretation can be more than 2 order, 5 or 6 etc 
SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    c.phone AS customer_phone,
    COUNT(o.id) AS number_of_orders
FROM
    tbl_orders AS o
JOIN
    tbl_customers AS c ON o.customer_id = c.id
WHERE
    o.customer_id IS NOT NULL
GROUP BY
    c.id, c.name, c.phone
HAVING
    COUNT(o.id) >= 2
ORDER BY
    number_of_orders DESC;


