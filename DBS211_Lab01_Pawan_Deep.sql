--answer 1
CUSTOMERNUMBER      CUSTOMERNAME        CONTACTLASTNAME     CONTACTFIRSTNAME    PHONE       ADRESSLINE1     ADRESSLINE2     CITY    STATE   POSTALCODE      COUNTRY     SALESREPEMPLOYEENUMBER      CREDITLIMIT
103                 Atelier graphique   Schmitt             Carine              40.32.2555  54, rue Royale  (null)          Nantes  (null)  44000           France      1370                        21000

--answer 2
TABLE NAME      ROWS        COLUMNS
CUSTOMERS       122         13
EMPLOYEES       23          8
OFFICES         7           9
ORDERDETAILS    2996        5
ORDERS          326         7
PAYMENT         273         4
PRODUCTLINE     7           4
PRODUCT         110         9

--ANSWER 3

The result of the statement desc offices; is 
the first column has the column names of offices table
the second column represents the required columns with not null and the not required ones have no value in it
the third column represents the type of data and the maximum bytes

Name         Null?    Type         
------------ -------- ------------ 
OFFICECODE   NOT NULL VARCHAR2(10) 
CITY         NOT NULL VARCHAR2(50) 
PHONE        NOT NULL VARCHAR2(50) 
ADDRESSLINE1 NOT NULL VARCHAR2(50) 
ADDRESSLINE2          VARCHAR2(50) 
STATE                 VARCHAR2(50) 
COUNTRY      NOT NULL VARCHAR2(50) 
POSTALCODE   NOT NULL VARCHAR2(15) 
TERRITORY    NOT NULL VARCHAR2(10) 


--ANSWER 4

The first statement (SELECT * FROM employees;) output is the entire employees data table.
the second statement (SELECT * FROM customers ORDER BY ContactLastName;) output is the customers data table sorted by the column ContactLastName.
