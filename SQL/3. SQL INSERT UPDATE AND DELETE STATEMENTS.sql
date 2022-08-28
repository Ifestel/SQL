USE Employees;

-- SQL INSERT STATEMENT
SELECT 
    *
FROM
    employees
    ORDER BY emp_no DESC
LIMIT 10;

USE employees;

-- INSERT use to insert more data into the database

INSERT INTO employees
( 
	emp_no, 
	birth_date,
	first_name,
	last_name, 
	gender, 
	hire_date
) VALUES
( 
	999901,
	'1986-04-21',
	'John',
	'Smith',
	'M',
	'2011-01-01'
);
-- Integers must be typed as plain numbers, without using quotes
-- We must put the VALUES in the exact order we have listed the COLUMN NAMES
INSERT INTO employees
( 
	birth_date,
	emp_no, 
	first_name,
	last_name, 
	gender, 
	hire_date
) VALUES
( 
	'1973-03-26',
	999902,
	'Patricia',
	'Lawrence',
	'F',
	'2005-01-01'
);

INSERT INTO employees
VALUES
(
	999903,
    '1977-09-14'
    'Jonathan',
	'Creek'
);

INSERT INTO employees
VALUES
(
	999903,
    '1977-09-14',
    'Jonathan',
	'Creek',
    'M',
    '1999-01-01'
    );

-- Exercise 19
-- Task 1:
/* Select ten records from the 'titles' table to get a better idea about its content.
Then, in the same table, insert information about employee number 999903. State that he/she is a 'Senior Engineer' 
who has started working in this position on October 1st, 1997.
At the end, sort the records from the 'titles' table in descending order to check if you have successfully inserted the new record.
Hint: To solve this exercise, you'll need to insert data in only 3 columns! */

SELECT 
    *
FROM
    titles
LIMIT 10;

INSERT INTO titles
(
	emp_no,
	title, 
    from_date
)
VALUES
(
	999903,
    'Senior_Engineer',
	'1997-01-10'
);

SELECT * FROM titles ORDER BY emp_no DESC;

-- Task 2:
/* Insert information about the individual with employee number 999903 into the 'dept_emp' table.
 He/She is working for department number 5, and has started work on October 1st, 1997; her/his contract is for an indefinite period of time.
Hint: Use the date '9999-01-01' to designate the contract is for an indefinite period. */

INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
VALUES (999903, 'd005', '1997-10-01','9999-01-01');            -- Recheck

-- ENDS --

-- Inserting Data Into a New Table
SELECT 
    *
FROM
    departments
LIMIT 10;

DROP TABLE departments_dup;
CREATE TABLE departments_dup
(
	dept_no CHAR (4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

SELECT
*
FROM
	departments_dup;
    
INSERT INTO departments_dup
(
	dept_no,
    dept_name
)
SELECT
	*
FROM
	departments;

SELECT
*
FROM
	departments_dup
ORDER BY dept_no;
-- Complying with constraints is essential

-- Exercise 20
/* Create a new department called "Business Analysis". Register it under number "d010".
Hint: To solve this exercise, use the "departments" table. */

DELETE FROM departments
WHERE  
dept_no = 'd010' AND 
dept_name = 'business_analysis';

SELECT * FROM departments;

INSERT INTO departments
VALUES 
(
'd010',
'business_analysis'
);
-- ENDS --

-- UPDATE Statement
-- Used  to update the values of existing records in a table

USE employees;
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;
    
UPDATE employees
SET
	first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
	emp_no = 999901;

SELECT
*
FROM
employees
ORDER BY emp_no DESC
LIMIT 10;
    
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

COMMIT;

UPDATE departments_dup
SET
	dept_no = 'd011',
    dept_name = 'Quality Control';
    
ROLLBACK;

COMMIT;

-- Exercise 21
/* Change the "Business Analysis" department name to "Data Analysis".
Hint: To solve this exercise, use the "departments" table. */
UPDATE departments
set
dept_name = 'Data Analysis'
WHERE
dept_no = 'd010';

SELECT * FROM departments;

-- ENDS --

-- SQL DELECT Statements
COMMIT;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;
    
SELECT 
    *
FROM
   titles
WHERE
    emp_no = 999903;

DELETE FROM employees
    WHERE
		emp_no = 999903;
        
ROLLBACK;

-- UNSAFE DELETE Statement
-- NOTE if you forget to attach a conditon in the WHERE Clause, you will loose all your information.
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

DELETE FROM departments_dup;

ROLLBACK;

-- Exercise 22
/* Remove the department number 10 record from the "departments" table.
Hint: To solve this exercise, use the "departments" table. */
COMMIT;

DELETE FROM Departments_dup
where dept_no = 'd010';

ROLLBACK;

-- ENDS --

-- DROP vs DELETE vs TRUNCATE 
/* DROP: you won't be able to roll back to its initial state, or t the last COMMIT Statement 
Use drop table only when you are sure you are not going to use the table in question anymore

TRUNCATE: will remove ALL records from the table just as if you have used the DELETE statement without using the WHERE Clause 
but the structure will remain. When truncating, auto increment values will be reset 

DELETE: removes records row by row. Only the rows specified in the WHERE Condition will be deleted. If the Where clause is omitted, 
the out put will be the same as that obtained with TRUNCATE.

Differences: Truncate delivers the output much quicker than Delete because it does not need to remove information row by row
Auto increment values are not reset with Delete */



 
 