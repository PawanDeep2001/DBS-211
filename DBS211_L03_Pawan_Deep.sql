-- ***********************
-- Name: Pawan Deep
-- ID: 111144218
-- Date: 02/01/2022
-- Purpose: Lab 03 DBS211
-- ***********************

SET AUTOCOMMIT ON;

-- Q1 SOLUTION --

INSERT INTO employees2
       SELECT *
       FROM employees;

-- Q2 SOLUTION –-

--to find the largest employeenumber
--SELECT employeenumber
--FROM emplyees2
--ORDER BY employeenumber DESC;

INSERT INTO employees2(employeenumber,
                       lastname,
                       firstname,
                       extension,
                       email,
                       officecode,
                       reportsto,
                       jobtitle)
VALUES(1703,
       'Deep',
       'Pawan',
       'x2222',
       'pdeep1@myseneca.ca',
       '4',
       1088,
       'Head Cashier');
        
-- Q3 SOLUTION –-

INSERT INTO employees2(employeenumber,
                       lastname,
                       firstname,
                       extension,
                       email,
                       officecode,
                       reportsto,
                       jobtitle)
VALUES(1704,
       'Zhou',
       'Angelo',
       'x2222',
       'azhou@myseneca.ca',
       '4',
       1703,
       'Cashier');
        
-- Q4 SOLUTION –-

DELETE FROM employees2
WHERE employeenumber=1703;
--This row cannot be deleted because it has a child record, that means the fake employee has the "reportsto" column equal to my "employeenumber".--  

-- Q5 SOLUTION –-

DELETE FROM employees2
WHERE employeenumber=1704;

DELETE FROM employees2
WHERE employeenumber=1703;
--This row this time got deleted because the fake employee has already been deleted so there are no child records in the other rows.--

-- Q6 SOLUTION –-

INSERT ALL
INTO employees2(employeenumber,
                lastname,
                firstname,
                extension,
                email,
                officecode,
                reportsto,
                jobtitle)
VALUES(1704,
       'Zhou',
       'Angelo',
       'x2222',
       'azhou@myseneca.ca',
       '4',
       1088,
       'Cashier')
INTO employees2(employeenumber,
                lastname,
                firstname,
                extension,
                email,
                officecode,
                reportsto,
                jobtitle)
VALUES(1703,
       'Deep',
       'Pawan',
       'x2222',
       'pdeep1@myseneca.ca',
       '4',
       1088,
       'Head Cashier')
SELECT *
FROM dual;

-- QUESTION 7 --

DELETE FROM employees2
WHERE employeenumber IN(1703,1704);

-- QUESTION 8 --

UPDATE employees2 SET
firstname='Pawan',
lastname='Deep'
WHERE employeenumber = 1002;

-- QUESTION 9 --

DELETE FROM employees2;










