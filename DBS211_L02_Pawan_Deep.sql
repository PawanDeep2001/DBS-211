-- ***********************
-- Name: Pawan Deep
-- ID: 111144218
-- Date: 01/24/2022
-- Purpose: Lab 02 DBS211
-- ***********************

-- Q1 SOLUTION --
SELECT  officecode,
        city,
        state,
        country,
        phone
FROM offices;

-- Q2 Solution –-
SELECT  employeenumber,
        firstname,
        lastname,
        extension
FROM  employees
WHERE officecode=1
ORDER BY employeenumber;

-- Q3 Solution –-
SELECT  customernumber AS "Customer Number",
        customername AS "Customer Name",
        contactlastname || ', ' || contactfirstname AS "Contact Name",
        phone AS "Phone"
FROM customers
WHERE country= 'Canada'
ORDER BY "Customer Name";

-- Q4 Solution –-
SELECT DISTINCT customernumber
FROM payments
ORDER BY customernumber;

-- Q5 Solution –-

SELECT  customernumber,
        checknumber,
        amount
FROM payments
WHERE amount NOT BETWEEN 1500 
AND 120000
ORDER BY amount DESC;

-- Q6 Solution –-

SELECT  productcode,
        productname,
        buyprice,
        msrp,
        (msrp - buyprice) AS "MARKUP",
        ROUND(100 * (msrp - buyprice)  / buyprice, 1)  AS "PERCMARKUP"
FROM products
WHERE (100 * (msrp - buyprice) / buyprice) > 140
ORDER BY "PERCMARKUP";

-- Q7 Solution –-

SELECT  REPLACE(productcode,'_', ' ') AS "PRODUCTCODE",
        productname,
        quantityinstock
FROM products
WHERE LOWER(productname) LIKE '%co%'
ORDER BY quantityinstock;

-- Q8 Solution –-

SELECT  customernumber,
        contactfirstname,
        contactlastname
FROM customers
WHERE LOWER(contactfirstname) LIKE 's%e%'
ORDER BY customernumber;

