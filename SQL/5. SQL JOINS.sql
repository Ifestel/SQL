USE Employees;

-- SQL JOINs
-- Introduction to JOINs
/* JOINs is an SQL tools that allows us to construct a relationship between objects
A JOIN shows a result set containing fields derived from two or more tables
We must first find a related column from the two tables that contains the same type of data
We will be free to add columns from these two tables to our output
NOTE: The columns used to relate tables must represent the same objects such as id
The tables you are considering may not be logically adjacent in the relational schema */

-- Exercise 1
/* If you currently have the departments_dup table set up, use DROP COLUMN to remove the dept_manager column from the departments_dup table.
Then, use CHANGE COLUMN to change the dept_no and dept_name columns to NULL.
(If you don't currently have the departments_dup table set up, create it. Let it contain two columns: dept_no and dept_name. Let the data type of 
dept_no be CHAR of 4, and the data type of dept_name be VARCHAR of 40. Both columns are allowed to have null values. Finally, insert the
 information contained in departments into departments_dup.)

Then, insert a record whose department name is Public Relations.
Delete the record(s) related to department number two.
Insert two new records in the departments_dup table. Let their values in the dept_no column be d010 and d011 */

ALTER TABLE departments_dup
DROP COLUMN dept_manager;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

/* DELETE FROM departments_dup
WHERE
    dept_name = 'Public Relations'; */

DELETE FROM departments_dup
WHERE
    dept_no = 'd002'; 
    
DELETE FROM dept_manager_dup
WHERE
    emp_no = '110228'; 

INSERT INTO dept_manager_dup (emp_no, dept_no, from_date, to_date)
Values  ('110228', 'd003', '1992-03-21', '9999-01-01');


/* INSERT INTO departments_dup
SELECT * from departments;*/

INSERT INTO departments_dup (dept_no)
VALUES ('d010'), ('d011');    
                      
-- Task 2:
-- Create and fill in the dept_manager_dup table, using the following code */

DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
SELECT * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                (999904, '2017-01-01'),
                            (999905, '2017-01-01'),
                            (999906, '2017-01-01'),
                            (999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd002';

-- ENDS --

-- INNER JOIN 
/* Inner Join is illustrated using Venn diagrame. It is a mathematical tool represnting all possiblelogical relations between a finite collectionof sets
Inner Joins helps us extract this result sets.alterWith Inner Joins we can match the result of 2 or more tables.
The same result showing in both tables is called the Matching Value or Matching Records.
The resul that do not appear will not appear in our output. This is called the Non-Matching values or Non Matching records */
/* ALIASES is used in joining syntax 
It is use in shortening tables name eg. Dept_manager_table as d etc */
  
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;        

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;                    

/* INNER JOINs extract only records in whcih the values in the related column match
NULL Value(s) appearing in just one of the 2 tables and not appearing in the other, are not displayed
Only non-null matching values are in play */

-- INNER JOIN 2
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN
departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;                              

-- Exercise 2
-- Extract a list containing information about all managers' employee number, first and 
-- last name, department number, and hire date.     

SELECT e.emp_no, e.first_name, last_name, f.dept_no, e.hire_date
FROM employees e
JOIN dept_manager f                 -- Why did dept_emp return 1000 rows?
on e.emp_no = f.emp_no;                -- RECONFIRM --

/*SELECT e.emp_no, e.first_name, last_name, d.dept_no, e.hire_date
FROM employees e
JOIN dept_emp d                 -- Why did dept_emp return 1000 rows?
on e.emp_no = d.emp_no;  */              -- RECONFIRM --
-- ENDS --

-- Notes on using JOINs
SELECT m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM dept_manager_dup m
INNER JOIN
departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;      

-- Duplicate Records
/* Also known as duplicate rows are identical rows in an SQL table
Used For a pair of duplicate records,the values in each column coincide
Duplicate rows are not always allowed in a database or a data table. They are sometimes encountered especially in new, raw or uncontrolled data */

INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '1999-01-01');  

INSERT INTO dept_manager_dup
VALUES ('110085', 'd002', '1985-01-01', '1989-12-17'), ('110114', 'd002', '1989-12-17', '9999-01-01');  

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');    

/* SELECT * FROM dept_manager_dup ORDER BY dept_no ASC;
SELECT * FROM departments_dup ORDER BY dept_no ASC; */

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN
departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

-- To remove duplicate datas, use GROUP BY dept_no before the ORDER BY Function
/* SELECT m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM dept_manager_dup m
INNER JOIN
departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no; */   
-- To remove duplicates from tables --  
/* DELETE FROM dept_manager_dup
WHERE emp_no = '110228'; */

-- LEFT JOIN --
/* Left Join retrieves all matching values of the two tables +
All values from the left table that match no value from the right table */ 

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
LEFT JOIN
departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;                           
              
/* SELECT m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM dept_manager_dup m
INNER JOIN
departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no; */

-- In Left Join, the other in whcih you match the tables matter and can change the output

SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT JOIN
dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY m.dept_no;                         

/* DELETE FROM departments_dup
WHERE
    dept_no = 'd002'; */

SELECT d.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT OUTER JOIN
dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;              

-- To sort out/remove the Null values, the GROUP BY Clause is used before the ORDER BY clasue
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT JOIN
dept_manager_dup m ON m.dept_no = d.dept_no
GROUP BY m.emp_no 
ORDER BY m.dept_no;                  

-- Exercise 3
/* Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
See if the output contains a manager with that name. 
Hint: Create an output containing information corresponding to the following fields: "emp_no", "first_name", "last_name", "dept_no", "from_date".
Order by 'dept_no' descending, and then by 'emp_no'. */
 
SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM  employees e
LEFT JOIN
dept_manager m ON e.emp_no = m.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY m.dept_no  DESC, e.emp_no;
-- ENDS --

-- RIGHT JOINS
/* It has same functionality as the Left Join with the only difference being that the direction of the operation is inverted. 
Whether we run a Left or Right Join, we will get the same Result but we should remember to keep the same Aliases (AS) we used before. 
Right Join is seldom used in SQL.
When applying a Right Join, all the records from the right table will be included in the reslult set.
Values from the Left table will be included only if their linking column contains a value coinciding or matching with a value 
from the linking column of the Right table.
Linking Column = Matching Column */

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN
departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;                               
 
-- The New and The Old Join
-- JOIN or WHERE?
/* Out put retrieved with both Join and Where Clause are identical
Using     is more time consuming
WHERE syntax is perceived as morally old and is rarely employed by proffessionals
The Join syntax allows you to modify the connection between tables easily
2 tables overlapping gives several entries with same employees nos. Such entries are called 'CONNECTION POINT' */

-- WHERE (Old Join Syntax)
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m, departments_dup d
WHERE
m.dept_no = d.dept_no
ORDER BY dept_no;
          
-- Exercise 4
-- Extract a list containing information about all managers' employee number, first and last name, department number, and hire date.
-- Use the old type of join syntax to obtain the result.
   
SELECT m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM  employees e, dept_manager m 
WHERE m.emp_no = e.emp_no;
-- ENDS --

-- JOIN and WHERE used Together
/* JOIN is used for connecting two tables
WHERE is used to define the condition or conditions that will determne which will be the connecting points between 2 tables */ 

SELECT e.emp_no, e.First_name, e.last_name, s.salary 
FROM employees e
Join
salaries s ON e.emp_no = s.emp_no
WHERE
s.salary > 145000;

-- Exercise 5
-- Select the first and last name, the hire date, and the job title of all employees whose first name is "Margareta" 
-- and have the last name "Markovitch".

SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM  employees e JOIN titles t 
ON e.emp_no = t.emp_no
WHERE first_name = 'Margareta' and last_name = 'Markovitch';

-- CROSS JOIN
/* Will take the values from a certain table and connect them with all the values from the table we want to join it with
Unlike INNER JOIN, it connects all the values not juest those that match
From a mathematical point of view, it is a CARTERIAN products of the values of 2 ot more sets
Particularly useful when the tables in a database are not well connected
CROSS JOIN can be used for more than 2 tables but if the record is a lot, the result might be too big */

-- Retrieving all the data about Managers and the departments they can be assigned to
SELECT dm.*, d.* 
FROM
dept_manager dm
CROSS JOIN
departments d
ORDER BY dm.emp_no = d.dept_no; 

SELECT dm.*, d.* 
FROM
dept_manager dm, departments d
ORDER BY dm.emp_no = d.dept_no;         -- Old Join syntax using comma (,) instead of Join

SELECT dm.*, d.* 
FROM
dept_manager dm
INNER JOIN
departments d                          -- 3rd way of writing the query
ORDER BY dm.emp_no = d.dept_no;       -- SQL interpretes them as CROSS JOIN cos there is no conditions assigned

-- Writing INNER JOIN without the key word ON is not considered best practice
-- While CROSS JOIN gives a more clearer result/output in reading the code

SELECT dm.*, d.* 
FROM
departments d
CROSS JOIN
dept_manager dm
WHERE d.dept_no <> dm.dept_no                        
ORDER BY dm.emp_no, d.dept_no;          -- Retrieves ONLY output where the manager is the currently heading

-- CROSS JOIN = INNER JOIN = OLD JOIN SYNTAX
-- JOIN + ON CLAUSE instead of CROSS JOIN + WHERE Clause
SELECT e.*, d.* 
FROM
departments d
	CROSS JOIN
dept_manager dm
JOIN employees e ON dm.emp_no = e.emp_no
WHERE d.dept_no <> dm.dept_no                        
ORDER BY dm.emp_no, d.dept_no;         -- CROSS JOIN + INNER JOIN

-- Exercise 6
-- Task 1:
-- Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.
SELECT dm.*, d.*
FROM departments d
CROSS JOIN
dept_manager dm 
WHERE d.dept_no = 'd009'
ORDER BY d.dept_no;                                        

-- Task 2:
-- Return a list with the first 10 employees with all the departments they can be assigned to.
-- Hint: Don't use LIMIT; use a WHERE clause.
SELECT e.*, d.*
FROM employees e
CROSS JOIN departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no;

select emp_no
from employees;

-- USING AGGREGATE FUNCTION WITH JOINS
-- Finding the average salary of men and women in the company
SELECT
e.gender, AVG(salary) AS average_salary
FROM employees e
JOIN
salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

-- JOIN MORE THAN 2 TABLES IN SQL
-- To do this, you have to have an idea of how you will want your table to be/look
SELECT
e.first_name,
e.last_name,
e.hire_date,
m.from_date,
d.dept_name
FROM
employees e
	JOIN
dept_manager m ON e.emp_no = m.emp_no
JOIN
departments d ON m.dept_no = d.dept_no;                  

-- Inverting the tables
SELECT
e.first_name,
e.last_name,
e.hire_date,
m.from_date,
d.dept_name
FROM
departments d
	JOIN
dept_manager m ON d.dept_no = m.dept_no
JOIN
employees e ON e.emp_no = e.emp_no;                      

-- Exercise 7
-- Select all managers' first and last name, hire date, job title, start date, and department name.
SELECT e.first_name, e.last_name, e.hire_date, t.title, dm.from_date, d.dept_name
FROM employees e 
JOIN titles t ON e.emp_no = t.emp_no
JOIN dept_manager dm ON t.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no
WHERE t.title = 'manager';                            
-- ENDS --

-- TIPS AND TRICKS ON JOIN

-- Feature of JOINS
-- One should lool for key columns whcih are common between the tables involved in the analysis and are necessary to solve the task at hand
-- These columns do not need to be foregin or private key
SELECT
d.dept_name, AVG(salary)            
FROM
departments d
JOIN
dept_manager m ON d.dept_no = m.dept_no
JOIN
salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name;

SELECT
d.dept_name, AVG(salary) AS average_salary           	-- AS used to rename the salary column
FROM
departments d
JOIN
dept_manager m ON d.dept_no = m.dept_no
JOIN
salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name 									-- with the Group by MYSQL will work by default selecting one row from the table
HAVING average_salary									-- departments in which the average salary if higher or lower than a certain amount												-- T
ORDER BY average_salary DESC;                            -- Gives out a better arranged output

-- Exercise 8
-- How many male and how many female managers do we have in the "employees" database?
SELECT e.gender, COUNT(dm.emp_no)
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender
ORDER BY gender;
-- ENDS --

-- UNION VS UNION ALL
/* UNION ALL: used to combine a few select statements in a single output
You can think of it as a tool that allows you to unify tables
SELECT
	N Coumns
FROM
	table_1
UNION ALL
	N Columns
FROM
	table_2; 
    
You must select the same number of columns from each table
These columns should have the same, should be in the same order, and should contain related date types

When unifying two identically organized tables:
	UNION: displays only distinct values in the output
It uses mor MYSQL resources ie it requires more computation power and storage space especially when applied to logic table
	UNION ALL: retrieves the duplicates as well
    
	For better results; use UNION
    For Optimization performance: use UNION ALL */

DROP TABLE IF EXISTS employees_dup;
CREATE TABLE employees_dup (
emp_no int(11),
birth_date date,
first_name varchar(14),
last_name varchar(16),
gender enum('M', 'F'),
hire_date date);

INSERT INTO employees_dup
SELECT
e.*
FROM
employees e
LIMIT 20;

SELECT
*
FROM
employees_dup;

INSERT INTO employees_dup 
VALUES ('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

-- Check Output
SELECT
*
FROM
employees_dup;

SELECT
e.emp_no,
e.first_name,
e.last_name,
NULL AS dept_no,
NULL AS from_date
FROM
employees_dup e
WHERE e.emp_no = 10001
UNION ALL SELECT
NULL AS emp_no,
NULL AS first_name,
NULL AS last_name,
m.dept_no,
m.from_date
FROM
dept_manager m;

-- Union Without ALL
SELECT
e.emp_no,
e.first_name,
e.last_name,
NULL AS dept_no,
NULL AS from_date
FROM
employees_dup e
WHERE e.emp_no = 10001
UNION SELECT
NULL AS emp_no,
NULL AS first_name,
NULL AS last_name,
m.dept_no,
m.from_date
FROM
dept_manager m;

-- Exercise 9
-- Go forward to the solution and execute the query. What do you think is the meaning of the minus sign before subset A in the 
-- last row (ORDER BY -a.emp_no DESC)?

