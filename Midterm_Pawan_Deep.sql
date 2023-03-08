-- QUESTION 1--

CREATE TABLE inventory(
product_id      NUMBER(30,0)PRIMARY KEY,
product_name    VARCHAR2(100)UNIQUE     NOT NULL,
last_procured   DATE        DEFAULT SYSDATE-1,
stock_quantity  NUMBER(3,0) DEFAULT 0,
cost_per_piece  NUMBER(5,2),
perishable      VARCHAR2(1) CHECK(perishable IN('Y','N')));

-- QUESTION 2--

CREATE TABLE invoices(
invoice_number  NUMBER(20,0),
product_id      NUMBER(30,0)    REFERENCES inventory(product_id)    ON DELETE CASCADE,
quantity_sold   NUMBER(3,0)     DEFAULT 1   CHECK(quantity_sold>0),
rate            NUMBER(5,2)     NOT NULL,
payment_type    VARCHAR2(30),
CONSTRAINT pk_invoices 
PRIMARY KEY(invoice_number));

-- QUESTION 3--

CREATE OR REPLACE VIEW vw_inventory_invoices AS
SELECT invoice_number,
       product_id,
       product_name,
       TO_CHAR(last_procured, 'Day, DD Mon, YYYY') AS "last_procured",
       cost_per_piece* quantity_sold AS "total_cost_price",
       rate * quantity_sold AS "total_selling_price"
FROM inventory
LEFT JOIN invoices
USING(product_id)
WHERE cost_per_piece IS NOT NULL;
