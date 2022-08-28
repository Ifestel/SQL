-- SQL SELECT STATEMENT
-- SELECT... FROM... Statement

USE Employees;

SELECT 
    first_name, last_name
FROM
    Employees;

--  * Used to select all columns
SELECT 
    *
FROM
    employees;
    
    -- Exercise 1
-- Select the information from the "dept_no" column of the "departments" table.
SELECT 
    dept_no
FROM
    departments;
    
-- Select all data from the "departments" table.
    SELECT 
    *
FROM
    departments;
    -- END--
    
-- WHERE Statement

SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Denis';
    
-- Exercise 2
-- Select all people from the "employees" table whose first name is "Elvis".
SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Elvis';
-- End --

-- AND Statement

SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Denis' AND gender = 'M';
    
-- Exercise 3
-- Retrieve a list with all female employees whose first name is Kellie.
SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Kellie' AND gender = 'F';
-- End --

-- OR Staement
SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Denis' OR first_name = 'Elvis';
    
SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Denis' AND first_name = 'Elvis';
    
-- OPERATOR Precedence
-- AND ... OR with WHERE Statement: 0R use to retrieve data from same column

 SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Denis' AND gender = 'M' OR gender = 'F';
    
    /* Wrongs cos SQL follow logical operator precedence. AND comes before OR
    So SQL picked above all male with last name Denis and ALL female rgardless of last name
    Parentheses is used to correct this by placing it around the gender. */
    
  SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Denis' AND (gender = 'M' OR gender = 'F');   
    
-- Exercise 4 
-- Retrieve a list with all female employees whose first name is either Kellie or Aruna.
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie' OR first_name = 'Aruna');  
-- End --

/* IN - NOT Statement
IN returns all the data inside the parentheses ( )
While NOT IN returns every other data in the seleted column not in the parentheses */

SELECT 
    *
FROM
    employees
WHERE
	first_name = 'Cathie'
    OR first_name = 'Mark'
    OR first_name = 'Nathan';

SELECT 
    *
FROM
    employees
WHERE
	first_name IN ('Cathie', 'Mark', 'Nathan');
    
SELECT 
    *
FROM
    employees
WHERE
	first_name NOT IN ('Cathie', 'Mark', 'Nathan');

/* Exercise 5
Task 1:
Use the IN operator to select all individuals from the â€œemployees table, whose first name is either Denis or Elvis. */
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
    
-- Task 2:
-- Extract all records from the employees table, aside from those with employees named John, Mark, or Jacob.
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
-- END --

-- LIKE NOT LIKE
-- Pattern with Percenage sign infront (%) inside a Parentheses () returns data that  the start with same pattern
SELECT 
    *
FROM
    employees
WHERE
	first_name LIKE ('%ar');
    
-- % sign after a Pattern returns the datas that ends with the Pattern  
SELECT 
    *
FROM
    employees
WHERE
	first_name LIKE ('Mar%');
    
-- Pattern in between % signs returns data with the pattern in between
SELECT 
    *
FROM
    employees
WHERE
	first_name LIKE ('%ar%');
    
-- Pattern with an underscore (_) returns a 4 letter character.
SELECT 
    *
FROM
    employees
WHERE
	first_name LIKE ('Mar_');

-- NOT LIKE
-- Opposite of LIKE. It returns data that do not have the pattern in the parentheses  
SELECT 
    *
FROM
    employees
WHERE
	first_name NOT LIKE ('%ar%');

-- Exercise 6 --
/* with the "employees" table, use the LIKE operator to select the data about all individuals, 
whose first name starts with "Mark"; specify that the name can be succeeded by any sequence of characters. */
SELECT 
    *
FROM
    employees
WHERE
	first_name LIKE ('%Mark');
    
-- Retrieve a list with all employees who have been hired in the year 2000.
SELECT 
    *
FROM
    employees
WHERE
	hire_date >= '2000-01-01';
    
-- Retrieve a list with all employees whose employee number is written with 5 characters, and starts with "1000".
SELECT  
    *
FROM
    employees
WHERE
	emp_no LIKE ('%1000_');
-- END --

-- WILD Character
/* Wildcard character used whenever you wished to put anything on its place
% (Percentage Sign) used as a substitute for a sequence of  characters. Represent '0' or more letters that come after a pattern
_ (Underscore) helps you match a single character
* (Star) delivers a list of 'all' columns in a table
the wildcards can be used to count all 'rows' of a table */

-- Exercise 7 --

-- Extract all individuals from the "employees" table whose first name contains "Jack".
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Jack');
    
-- Once you have done that, extract another list containing the names of employees that do not contain "Jack".

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack');
-- END --

-- BETWEEN... AND... Character
-- Helps us designate the interval to which a given value belongs 
SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';
    
/* NOT BETWEEN... AND...
NOT refers to the interval composed of 2 parts
an interval below the first value indicated
a second interval above the second value */

SELECT 
    *
FROM
    employees
WHERE
    hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';
    
-- Exercise 8 --
-- Select all the information from the "salaries" table regarding contracts from 66,000 to 70,000 dollars per year.
CREATE TABLE salaries;
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN '66000' AND 70000;
-- Retrieve a list with all individuals whose employee number is not between "10004" and "10012".
SELECT 
    *
FROM
    salaries
WHERE
    salary NOT BETWEEN '10004' AND 10012;
-- Select the names of all departments with numbers between "d003" and "d006".
SELECT 
    *
FROM
    departments
WHERE
   dept_no BETWEEN 'd003' AND 'd006';
-- END --

-- IS NOT NULL / IS NULL Character
-- IS NOT NULL used to extrac values that are not NULL 

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;

-- Exercise 10 --
-- Select the names of all departments whose department number value is not null.
SELECT 
    *
FROM
departments
WHERE
    dept_no IS NOT NULL;
-- ENDS --
    
-- Other Comparison Operator
-- <> and != means not equal to

SELECT 
    *
FROM
    employees
WHERE
    first_name != 'Mark';

SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000,01,01';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date >='2000,01,01';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date < '1985,02,01';

SELECT 
    *
FROM
    employees
WHERE
    hire_date <='1985,02,01';
    
/* Exercise 11  
Retrieve a list with data about all female employees who were hired in the year 2000 or after.
Hint: If you solve the task correctly, SQL should return 7 rows. */
SELECT 
    *
FROM
    employees
WHERE
	gender = 'F'
AND hire_date >= '2000,01,01';

-- Extract a list with all employees' salaries higher than $150,000 per annum.
SELECT 
    *
FROM
    salaries
WHERE
salary > '150000';
-- END --

-- SECELCT DISTINCT Statement
-- Select statement can retriece rows from a designated columns given some criteria
SELECT 
    gender
FROM
    employees;

/* Contains both genders but NO duplicate Values? Use 'Select Distinct'
SELECT DISTINCT selects all distinct, different data values */

SELECT DISTINCT
    gender
FROM
    employees;

-- Exercise 12
-- Obtain a list with all different "hire dates" from the "employees" table.
SELECT DISTINCT
   hire_date
FROM
    employees;
    
-- Expand this list and click on "Limit to 1000 rows". This way you will set the limit of output rows displayed back to the default of 1000.
SELECT DISTINCT
   hire_date
FROM
    employees;
-- ENDS --

-- INTRODUCTION TO AGGREGRATE FUNCTION
/* Aggregate Fuction are applied on multiple rows of a single column of a table and return an output of a single values
COUNT() counts the number of NON  NULL records in a field
SUM() sum all the NON NULL values in a column
MIN() returns the minimun value from the entire list
MAX() returns themaximun value from the entire list
AVG() calculate the average of all NON NULL values belonging to a certain column of a table
COUNT() is requently used in combination with the reserved word 'DISTINCT' */

SELECT 
    COUNT(emp_no)
FROM
    employees;
    
-- IS NULL Operator
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;
    
SELECT 
    COUNT(first_name)
FROM
    employees;
    
-- Count Distinct help count the distinct name( different names)/values
SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;

-- Exercise 13
-- How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table? 
SELECT 
    COUNT(salary >= '100000')
FROM
    salaries;
-- How many managers do we have in the employees database? Use the star symbol (*) in your code to solve this exercise.
SELECT 
   *, COUNT(emp_no)
FROM
    dept_manager;    
-- END --

-- ORDER BY Statement
-- Arranges the values in an alphebetical/Ascending(ASC)/Descending(DESC) order

SELECT 
    *
FROM
    employees
ORDER BY first_name ASC;

-- DESCENDING Order(DESC)
SELECT 
    *
FROM
    employees
ORDER BY first_name DESC;

-- Can also Order Numbers
SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;

-- Can also Order 2 columns at the same time
SELECT 
    *
FROM
    employees
ORDER BY first_name ASC;

SELECT 
    *
FROM
    employees
ORDER BY first_name, last_name ASC;

-- Exercise 14
-- Select all data from the "employees" table, ordering it by "hire date" in descending order.
SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

-- END --

/* GROUP BY Statement
When working in SQL, results can be grouped according to a specific field or fields using the GROUP BY Clause
GROUP BY must be place immediately after the WHERE condition if any and just before the ORDER BY clause
GROUP BY is one of the most powerful and useful tools in SQL */

SELECT 
    first_name
FROM
    employees;

SELECT 
    first_name
FROM
    employees
GROUP BY first_name;

SELECT DISTINCT
    first_name
FROM
    employees;
    
-- When you need an aggregate function, you must add a GROUP BY clause in your query too
SELECT 
    COUNT(first_name)
FROM
    employees
GROUP BY first_name;

-- Always include the field you have grouped your results by in the SELECT statement
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name;

-- ORDER BY BLOCK CAN BE USE IMMEDIATELY AFTER THE GROUP BY BLOCK
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

/* USING ALIASES (AS) Statement
Alias used to rename a selection from your query
This is done by using the keyword AS */

SELECT 
    first_name, COUNT(first_name) AS name_count 
FROM
    employees
GROUP BY first_name
ORDER BY first_name;

/* Exercise 15
This will be a slightly more sophisticated task.
Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
The second column, renamed to "emps_with_same_salary", must show the number of employees contracted to that salary. 
Lastly, sort the output by the first column. */
SELECT salary, COUNT(emp_no) AS emp_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY emp_no
ORDER BY emp_no;
-- END --

/* HAVING Statement
A clause frequently implemented with GROUP BY
Refines the output from records that do not satisfy a certain condition
Inserted between GROUP BY and ORDER BY
Used when you have a condition with an aggregate function */

SELECT
*
FROM
employees
WHERE
hire_date >= '2000,01,01';

SELECT
first_name, COUNT(first_name) as names_count
FROM
employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

/* Exercise 16
Select all employees whose average salary is higher than $120,000 per annum.
Hint: You should obtain 101 records */
SELECT 
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING
    AVG(salary) >= 120000
ORDER BY emp_no;
-- Compare the output you obtained with the output of the following two queries:
SELECT 
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

SELECT 
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

-- END --

/* WHERE vs HAVING
Where allows us to set conditions that refer to subsets of individual rows
These conditions are applied before re-organizing the output into groups
The output can be further improved or filtered with the condition specified by the HAVING clause */

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

/*RULES: You cannot have both the agrregated and non aggregated condition in the same HAVING Clause
Aggregated Function uses GROUP BY and HAVING
General conditions uses WHERE */

/* Exercise 17
Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.
Hint: To solve this exercise, use the "dept_emp" table. */
SELECT 
    emp_no, COUNT(emp_no) AS no_employee
FROM
    dept_emp
WHERE
    emp_no > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY emp_no ASC;
-- END --

-- LIMIT Statement

SELECT 
    *
FROM
    salaries;
    
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC;

-- Setting Number limit
SELECT  
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

-- Different result when ordering by another column
SELECT  
    *
FROM
    salaries
ORDER BY emp_no DESC
LIMIT 10;

-- Limit Syntax
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC
LIMIT 100;

-- Exercise 18
-- Select the first 100 rows from the 'dept_emp' table.
SELECT 
    *
FROM
    dept_emp
LIMIT 100; 

-- ENDS --

