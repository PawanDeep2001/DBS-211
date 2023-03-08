-- ***********************
-- Name: Pawan Deep
-- ID: 111144218
-- Date: 02-22-2022
-- Purpose: Lab 06 DBS211
-- ***********************

-- Q1 SOLUTION --

CREATE TABLE new_employees(
employeenumber  NUMBER(38,0)PRIMARY KEY,
lastname        VARCHAR2(50)NOT NULL,
firstname       VARCHAR2(50)NOT NULL,
extension       VARCHAR2(10)NOT NULL,
email           VARCHAR2(100)NOT NULL,
officecode      VARCHAR2(10)NOT NULL,
reportsto       NUMBER(38,0)DEFAULT NULL,
jobtitle        VARCHAR2(50)NOT NULL);

-- Q2 SOLUTION --

SET AUTOCOMMIT OFF;
SET TRANSACTION READ WRITE;

-- Q3 SOLUTION --

INSERT ALL
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(100,
       'Patel',
       'Ralph',
       '22333',
       'rpatel@mail.com',
       '1',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(101,
       'Denis',
       'Betty',
       '33444',
       'bdenis@mail.com',
       '4',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(102,
       'Biri',
       'Ben',
       '44555',
       'bbirir@mail.com',
       '2',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(103,
       'Newman',
       'Chad',
       '66777',
       'cnewman@mail.com',
       '3',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(104,
       'Ropeburn',
       'Audrey',
       '77888',
       'aropebur@mail.com',
       '1',
       'Sales Rep')
SELECT *
FROM dual;
              
-- Q4 SOLUTION --

SELECT *
FROM new_employees;
--5 rows has been fetched.

-- Q5 SOLUTION --

ROLLBACK;

SELECT *
FROM new_employees;
--0 rows has been fetched 

-- Q6 SOLUTION --

--EXECUTE TASK 3;
INSERT ALL
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(100,
       'Patel',
       'Ralph',
       '22333',
       'rpatel@mail.com',
       '1',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(101,
       'Denis',
       'Betty',
       '33444',
       'bdenis@mail.com',
       '4',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(102,
       'Biri',
       'Ben',
       '44555',
       'bbirir@mail.com',
       '2',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(103,
       'Newman',
       'Chad',
       '66777',
       'cnewman@mail.com',
       '3',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(104,
       'Ropeburn',
       'Audrey',
       '77888',
       'aropebur@mail.com',
       '1',
       'Sales Rep')
SELECT *
FROM dual;
            
COMMIT;

SELECT *
FROM new_employees;
--5 rows has been fetched
 
-- Q7 SOLUTION -- 

UPDATE new_employees SET
jobtitle='unknown';
     
-- Q8 SOLUTION --

COMMIT;

-- Q9a SOLUTION --

ROLLBACK;

SELECT *
FROM new_employees
WHERE jobtitle='unknown';
-- all column are updated because we made our changes permanent with commit.

-- Q9b SOLUTION --

-- No this time the revert was not effective because we had a commit before the
-- rollback so the changes were already permanent.

-- Q9c SOLUTION --

-- in task number 5 there were no changes that were made permanent, so they got 
-- deleted as soon as we executed the rollback, on the other side now we have 
-- already committed the changes so the task 9 rollback wasn't effective.

-- Q10 SOLUTION --

COMMIT;

DELETE FROM new_employees;

-- Q11 SOLUTION --
    
CREATE VIEW vw_new_emps AS
SELECT *
FROM new_employees
ORDER BY lastname, firstname;
    
-- Q12 SOLUTION --
    
ROLLBACK;

-- Q12a SOLUTION --
-- there are no employees in new_employees table

-- Q12b SOLUTION --
-- the delete was not undone because the DDL statements triggers an auto-commit. 
-- So after creating the view the delete statement also got committed.

-- Q13 SOLUTION --
    
COMMIT;

INSERT ALL
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(100,
       'Patel',
       'Ralph',
       '22333',
       'rpatel@mail.com',
       '1',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(101,
       'Denis',
       'Betty',
       '33444',
       'bdenis@mail.com',
       '4',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(102,
       'Biri',
       'Ben',
       '44555',
       'bbirir@mail.com',
       '2',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(103,
       'Newman',
       'Chad',
       '66777',
       'cnewman@mail.com',
       '3',
       'Sales Rep')
INTO new_employees(employeenumber,
                   lastname,
                   firstname,
                   extension,
                   email,
                   officecode,
                   jobtitle)
VALUES(104,
       'Ropeburn',
       'Audrey',
       '77888',
       'aropebur@mail.com',
       '1',
       'Sales Rep')
SELECT *
FROM dual;
    
-- Q14 SOLUTION --
    
SAVEPOINT insertion;
    
-- Q15 SOLUTION --
    
UPDATE new_employees SET
jobtitle='unknown';

SELECT *
FROM new_employees
WHERE jobtitle='unknown';

-- Q16 SOLUTION --
    
ROLLBACK TO insertion;

SELECT *
FROM new_employees;
-- the update has been undone because it has been rolled back to the savepoint.
-- the jobtitle is back to Sales Rep.
    
-- Q17 SOLUTION --
    
ROLLBACK;

SELECT *
FROM new_employees;
-- after this rollback even the insert statement has been undone so there is
-- no data in the new_employees table. 0 rows has been fetched.

-- Q18 SOLUTION --

REVOKE ALL ON new_employees FROM PUBLIC;

-- Q19 SOLUTION --

GRANT READ ON new_employees TO dbs211_221i44;

-- Q20 SOLUTION --

GRANT INSERT, UPDATE, DELETE ON new_employees TO dbs211_221i44;

-- Q21 SOLUTION --

REVOKE ALL ON new_employees FROM dbs211_221i44;

-- Q22 SOLUTION --

DROP TABLE new_employees;
DROP VIEW vw_new_emps;



     
     
     
     
     
     
     
     
     
     
     
     
     
       
       
       
       
       
       