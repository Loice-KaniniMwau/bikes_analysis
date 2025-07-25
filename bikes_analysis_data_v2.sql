-- --examining the dataste, looking for missing null values - 
select * from tbl_brands
SELECT * from tbl_payments
-- --payment modes- cheque(denoted by 2) vs cash(denoted by 1)-- 
select * from tbl_categories
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

UPDATE tbl_customers
SET phone= '+254728138003'
WHERE phone LIKE '+254728138003uthomi%'

-- --removing extra spaces from the phone records--  
UPDATE tbl_customers
SET phone= REPLACE (phone,' ', '')

select * from tbl_customers

-- --email field with a phone number entry, replace the phone number with null
UPDATE tbl_customers
SET email= NULL
WHERE email LIKE '0728138003%'

-- --revenue after discounts-- 
select sum(total) AS grand_total_revenue
from tbl_orders 
where status !=2

-- --revenue per month--
SELECT DATE_FORMAT(created_at, '%Y-%M') AS sales_by_month, SUM(total) AS monthly_revenue
FROM tbl_orders
WHERE status != 2
GROUP BY sales_by_month
ORDER BY monthly_revenue DESC;


-- --sales by product type-- 
-- alll the product types are null
select product_type from tbl_products;

SELECT
    p.product_type,
    SUM(oi.total_amount) AS gross_sales
FROM
    tbl_order_items AS oi
JOIN
    tbl_products AS p ON oi.product_id = p.id
JOIN tbl_orders AS o ON oi.order_id=o.id
WHERE o.status !=2
GROUP BY
    p.product_type
ORDER BY
    gross_sales DESC;


-- Sales by Brand
-- high selling brand LS2 Helmets
SELECT b.name AS brand_name,SUM(oi.total_amount) AS gross_sales
FROM tbl_order_items AS oi
JOIN tbl_products AS p ON oi.product_id = p.id
JOIN tbl_brands AS b ON p.brand_id = b.id
JOIN tbl_orders AS o ON oi.order_id=o.id
WHERE o.status !=2
GROUP BY b.name
ORDER BY gross_sales DESC;

-- 4. ⁠Sales by Categories
SELECT c.name AS category_name,SUM(oi.total_amount) AS gross_sales
FROM
    tbl_order_items AS oi
JOIN
    tbl_products AS p ON oi.product_id = p.id
JOIN
    tbl_categories AS c ON p.category_id = c.id
JOIN tbl_orders AS 	o ON oi.id=o.id
WHERE o.status !=2
GROUP BY c.name
ORDER BY gross_sales DESC;
    
-- ---common payment method-- 
select * from tbl_payments;
-- --if a transaction code excists- payment via mpesa, if transaction cdie in null payment by cash
-- --1- denotes cash, 2 denotes mpesa

SELECT
    CASE
        WHEN p.payment_mode = 1 THEN 'Cash'
        WHEN p.payment_mode = 2 THEN 'M-Pesa'
        WHEN p.payment_mode = 3 THEN 'Cheque'
        ELSE 'Other'
    END AS payment_method,
    COUNT(p.id) AS number_of_transactions
FROM tbl_payments as p
JOIN tbl_orders AS o ON p.order_id = o.id
WHERE o.status !=2
GROUP BY payment_method
ORDER BY number_of_transactions DESC;
    
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
    o.status !=2 AND o.customer_id IS NOT NULL
GROUP BY
    c.id, c.name, c.phone
HAVING
    COUNT(o.id) >= 2
ORDER BY
    number_of_orders DESC;

-- Number of Customers--
SELECT
  COUNT(id) AS 'Total Customers'
FROM
  tbl_customers
WHERE
  deleted_at IS NULL;

-- How many new customers are acquired each month--
SELECT
  DATE_FORMAT(created_at, '%Y-%m') AS 'Month',
  COUNT(id) AS 'New Customers'
FROM
  tbl_customers
WHERE
  deleted_at IS NULL
GROUP BY
  DATE_FORMAT(created_at, '%Y-%m')
ORDER BY
  DATE_FORMAT(created_at, '%Y-%m');

-- customers by cost of orders
-- will consider only the amount paid

select c.id ,c.name,sum(amount_paid) as cost_of_orders
from tbl_orders o
join tbl_customers c on o.customer_id = c.id
where status !=2
group by c.id ,c.name
order by cost_of_orders desc
limit 10



