USE employees;

-- Using SQL VIEWS

/* A VIEW is a VIRTUAL table whose contents are obtained from an existing table or tables called BASE TABLES. 
The retrieval happens through an SQL stmt, incorporated into the view.
- Think of a view object as a view into the base table.
- The view itself does not contain any real data; the data is physically stored in the base table.
- It simply shows the data contained in the base table. 
EG
Using the dept_emp table that contains emp_no, dept_no and from_date, to_date
Let's consider the dept each employee works and their date dates of empt */


SELECT * FROM dept_emp;

SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS NUM
FROM
    dept_emp
GROUP BY emp_no   -- Some employee nos are inserted more than once, to retrieve the data of employees whose emp_no 
HAVING NUM > 1;   -- appear more than once due to change of dept

SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS NUM
FROM
    dept_emp
GROUP BY emp_no
HAVING NUM > 1;

/* To see the number of each employee showing only once, You visualise the period encompassing the last contract of each employee
THe Syntax is,
CREATE VIEW view_name AS
SELECT 
column_1, column_2, ....column_n
FROM 
table_name; */

-- We assign views using V_ or W_
-- The query bellow creates our view

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
SELECT 
emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
dept_emp
GROUP BY emp_no;
-- Get the output from the schemas side from the views from the 3rd square box of the 3 right bottons

-- If we run the select Statement side seperately, we obtain the result that will populate our view each time it's run
SELECT 
emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
dept_emp
GROUP BY emp_no;

/*  A view acts as a shortcut for writing the same SELECT statement every time a new
request has been made
- It saves a lot of coding time
- Because it's written only once, it occupies no extra memory
- It acts as a dynamic table because it instantly reflects and structural changes
in the base table
- They are advantagious when used logically
- Don't forget they are not real physical data sets, meaning we cannot insert or update 
the info that has already been extracted. 
- They should be seen as temporary virtual data tables retrieving info from base tables. */

-- Exercise
/* Create a view that will extract the average salary of all managers registered in the database. 
Round this value to the nearest cent. If you have worked correctly, after executing the view from 
the Schemas section in Workbench, you should obtain the value of 66924.27.*/

CREATE OR REPLACE VIEW v_dept_manager_salary AS
SELECT 
dm.emp_no, ROUND(AVG(salary), 2)
FROM
salaries s
JOIN dept_manager dm ON dm.emp_no = s.emp_no; 

SELECT 
dm.emp_no, ROUND(AVG(salary), 2)
FROM
salaries s
JOIN dept_manager dm ON dm.emp_no = s.emp_no; 

-- ENDS --