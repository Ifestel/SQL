USE Employees;

-- MYSQL Aggregate Functions --
/* COUNTS Function:
Applicable to both numeric and non-numeric data
Also known as summarizing functions

COUNT(DISTINCT):
Helps us find the number of times unique values are encountered in a given column
Aggrgate functions typically ignores NULL values throughout the field to which they are applied. This can happen only if you have indicated a specific 
column name within the parentheses.

Alternatively, COUNT(*) returns the number of all rows of the table, NULL vlaues included
The * symbol goes ONLY with the COUNT() Function
The parentheses and the argunment must be attacched to the name of the aggregate function.alter
You shouldn't leave WHITE SPACE before opening the parentheses */

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

SELECT 
    COUNT(salary)       
FROM
    salaries;
 -- Applicable to both numeric and non-numeric data
-- To kow how many employees start date are in the database-- 
SELECT 
    COUNT(from_date)       
FROM
    salaries;

-- COUNT(DISTINCT)
-- Helps us find the number of times unique values are encountered in a given column
SELECT 
    COUNT(DISTINCT from_date)       
FROM
    salaries;

-- SUM()
-- with the other functions apart from COUNT() work ONLY wih Numeric data 
-- How much salaries spent so far in the company
 SELECT 
    SUM(salary)    
FROM
    salaries;

-- MIN() And MAX()
-- Returns the Minimum and Maximum value of a column respectively

-- Which is the highest salary we offer
SELECT 
    MAX(salary)
FROM
    salaries;
-- Which is the Lowest salary we offer
SELECT 
    MIN(salary)
FROM
    salaries;
    
-- Exercise 23
-- 1. Which is the lowest employee number in the database?
SELECT
MIN(emp_no)
FROM
employees;

-- 2. Which is the highest employee number in the database?
SELECT
MAX(emp_no)
FROM
employees;

-- AVG()
-- which is the Average annual salary the company's employee received?
SELECT 
    AVG(salary)
FROM
    salaries;
-- Aggregate functions can be applied to any group of data values with a certain column
-- Which is why it is frequesntly used together with a GROUP BY Clause

-- Exercise 24
-- What is the average annual salary paid to employees who started after the 1st of January 1997?
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
-- END --

-- ROUND()
-- Is a numeric or math function use by MYSQL
-- It is applied to the single values that aggregate functions return
SELECT 
    ROUND(AVG(salary))
FROM
    salaries;

-- 2nd way is specifying the number of digits after the decimal places
SELECT 
    ROUND(AVG(salary),2)
FROM
    salaries;

-- Exercise 25
-- Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents.
SELECT 
    ROUND(AVG(salary),2)
FROM
    employees
WHERE 
	from_date > '1997-01-01';

-- IFNULL() and COALESCE()
/* IFNULL() and COALESCE() are advanced SQL Function. They are used when you have null values in your data table 
and would like to substitue them wil another value */

SELECT 
    *
FROM
    departments_dup;

DROP TABLE departments_dup;
CREATE TABLE departments_dup
(
	dept_no CHAR (4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

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
    departments_dup;
    
ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup(dept_no) VALUES ('D010'), ('D011');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

ALTER TABLE employees.departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

COMMIT;

SELECT 
    dept_no,
    IFNULL(dept_name,
            'Department name not provided')  AS dept_name
FROM
    departments_dup;

-- IFNULL() cannot contain more than two parameters

-- COALESCE()
/* Allows you to insert N arguments in a parentheses.
Will always return a single calue of the ones we have within parentheses and this value will be 
the first mon-null value of this list, reading the calus from left to right.
If COALESCE has two arguments, it will work precisely like IFNULL()*/ 

SELECT
    dept_no,
    COALESCE(dept_name,
            'Department name not provided')  AS dept_name
FROM
    departments_dup;
    
-- COALESCE with 3 arguments
SELECT 
    dept_no,
    dept_name,
COALESCE( dept_manager, dept_name, 'N/A')  AS dept_manager
FROM departments_dup
ORDER BY dept_no ASC;

-- Note: IFNULL() and COALESCE() do not make any changes to the data set, they merely create an output 
-- where certain data values appear in place of NULL values
-- single argument example
SELECT 
    dept_no,
    dept_name,
COALESCE( 'department manager name')  AS fake_col
FROM departments_dup;

-- Exercise 26
/* Task 1:
Select the department number and name from the departments_dup table and add a third column where you name the department number (dept_no) 
as dept_info. If dept_no does not have a value, use dept_name. */
SELECT 
    dept_no,
    dept_name,
COALESCE(dept_no)  AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;                 

/* Task 2:
Modify the code obtained from the previous exercise in the following way. Apply the IFNULL() function to the values from the first and second column, 
so that N/A is displayed whenever a department number has no value, and Department name not provided is shown if there is no value for dept_name. */

SELECT 
IFNULL(dept_no, 'N/A')  AS dept_no,
IFNULL(dept_name, 'Department name not provided') AS dept_name,
COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;           

-- ENDS --