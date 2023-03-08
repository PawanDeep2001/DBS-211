-- ***********************
-- Name: Pawan Deep
-- ID: 111144218
-- Date: 02/09/2022
-- Purpose: Lab 04 DBS211
-- ***********************

-- Q1 SOLUTION --

SELECT customernumber AS "Customer Number",
       c.customername AS "Customer Name",
       TO_CHAR(p.paymentdate, 'Mon DD,YYYY') AS "Payment Date",
       p.amount AS "Amount"
FROM payments p
INNER JOIN customers c
USING(customernumber)
WHERE c.country='Canada'
ORDER BY customernumber;

-- Q2 SOLUTION --

SELECT e.employeenumber AS "Employee Number",
       e.firstname|| ' ' || e.lastname AS "Employee Full Name",
       e.email AS "Email"
FROM customers c
RIGHT JOIN employees e
ON e.employeenumber= c.salesrepemployeenumber
WHERE c.salesrepemployeenumber IS NULL
ORDER BY "Employee Full Name";

-- Q3 SOLUTION --

CREATE VIEW vw_customer_order AS
SELECT customernumber AS "Customer Number",
       ordernumber AS "Order Number",
       orderdate AS "Order Date",
       productname AS "Product Name",
       quantityordered AS "Quantity Ordered",
       priceeach AS "Price"
FROM orders 
INNER JOIN orderdetails 
USING(ordernumber)
INNER JOIN products 
USING(productcode);

-- Q4 SOLUTION --

SELECT w."Customer Number",
       o.ordernumber,
       w."Product Name",
       o.orderlinenumber
FROM vw_customer_order w
INNER JOIN products p
ON w."Product Name"=p.productname
INNER JOIN orderdetails o
ON o.ordernumber=w."Order Number" AND o.productcode=p.productcode
WHERE w."Customer Number" =124
ORDER BY w."Order Number",
orderlinenumber;

-- Q5 SOLUTION --

SELECT customernumber,
       contactfirstname,
       contactlastname,
       phone,
       creditlimit
FROM customers 
LEFT JOIN orders 
USING(customernumber)
WHERE ordernumber IS NULL;

-- Q6 SOLUTION --

CREATE VIEW vw_employee_manager AS
SELECT e1.*,
       e2.lastname|| ' ' || e2.firstname AS  "Manager Fullname"
FROM employees e1
LEFT JOIN employees e2
ON e1.reportsto=e2.employeenumber;

-- Q7 SOLUTION --

CREATE OR REPLACE VIEW vw_employee_manager AS
SELECT e1.*,
       e2.lastname|| ' ' || e2.firstname AS  "Manager Fullname"
FROM employees e1
INNER JOIN employees e2
ON e1.reportsto=e2.employeenumber;

-- Q8 SOLUTION --

DROP VIEW vw_customer_order;
DROP VIEW vw_employee_manager;




