USE employees;

-- SQL Subqueries with In nested INSIDE WHERE
-- Subqueries = inner queries = nested queries
-- Alternatively called Inner Select or Outer Select
-- Subqueries are queries embedded in a query
-- Subqueries should always be placed in a parentheses

SELECT 
    *
FROM
    dept_manager;

SELECT
e.first_name, e.last_name
FROM
employees e 
WHERE
e.emp_no IN ( SELECT
		  dm.emp_no
		FROM
		  dept_manager dm);              -- retrieves all employees working as managers
		
        

-- EXERCISE
-- Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
SELECT
*
FROM dept_manager 
WHERE
emp_no IN (SELECT emp_no
		FROM
			employees WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01'); 
            

-- SQL Subqueries with ESIST-NOT EXIST nested inside WHERE

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);
		
-- Adding ORDER BY

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
		ORDER BY emp_no;

-- Exercise
-- Select the entire information for all employees whose job title is "Assistant Engineer".
-- Hint: To solve this exercise, use the 'employees' table.  

Select e.*, t.title 
from
employees e,
titles t
where e.emp_no = t.emp_no and 
Exists(select * from titles  
where t.title = "Assistant Engineer");

/* Select e.*, t.title 
from
employees e,
titles t
where e.emp_no = t.emp_no and 
Exists(select * from titles  
where t.emp_no = e.emp_no
and t.title = "Assistant Engineer"); */

/* select e.*, t.title from employees e
        join titles t on e.emp_no = t.emp_no
        where title = 'Assistant Engineer'; */           -- Exercise attempted with Join Clause

        

-- SQL Subqueries with nested in SELECT and FROM
-- Subqueries can be executed with a SELECT and FROM Clause not just the WHERE Clause. Can be placed anywhere so long as it makes sense to do so

-- Task
-- Assign employee no 110022 as a manager to all employees from 10001 - 10020 and employees number 110039 to all employees from 10021 - 10040
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
 -- Task
 -- From the emp_manager table,extract the record data only of those employees who are managers as we;
SELECT 
    *
FROM
    emp_manager
ORDER BY emp_manager.emp_no;

SELECT e1.*
FROM
emp_manager e1
JOIN
emp_manager e2 ON e1.emp_no = e2.manager_no;

-- Exercise
/* Starting your code with DROP TABLE, create a table called emp_manager (emp_no integer of 11, not null; dept_no CHAR of 4, null; 
manager_no integer of 11, not null).
 */
DROP TABLE emp_manager;
CREATE TABLE emp_manager
(
	emp_no INT (11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT (11) NOT NULL
);
--  Task 2:
-- Fill emp_manager with data about employees, the number of the department they are working in, and their managers.

Insert INTO emp_manager SELECT
U.*
FROM
(select A.* 
    from (select e.emp_no AS employee_ID,
			MIN(de.dept_no) AS department_code,
			(select emp_no 
			from dept_manager 
            where emp_no = 110022) AS manager_ID
	from employees e
            join dept_emp de on e.emp_no = de.emp_no
            where e.emp_no <= 10020
            group by e.emp_no
            order by e.emp_no) AS A
	UNION
    select B.* from (select e.emp_no AS employee_ID,
			MIN(de.dept_no) AS department_code,
            (select emp_no 
            from dept_manager 
            where emp_no = 110039) AS manager_ID
            from 
            employees e
            join dept_emp de on e.emp_no = de.emp_no
            where e.emp_no > 10020
            group by e.emp_no
            order by e.emp_no 
            LIMIT 20) AS B
	UNION
    select C.* 
    from (select e.emp_no AS employee_ID,
			MIN(de.dept_no) AS department_code,
			(select emp_no 
			from dept_manager 
            where emp_no =  110039) AS manager_ID
	from employees e
            join dept_emp de on e.emp_no = de.emp_no
            where e.emp_no = 110022
            group by e.emp_no
            order by e.emp_no) AS C
	UNION
    select D.* from (select e.emp_no AS employee_ID,
			MIN(de.dept_no) AS department_code,
            (select emp_no 
            from dept_manager 
            where emp_no = 110022) AS manager_ID
            from 
            employees e
            join dept_emp de on e.emp_no = de.emp_no
            where e.emp_no = 110039
            group by e.emp_no
            order by e.emp_no) AS D) AS U;
		
SELECT * FROM emp_manager;




                 (A)
UNION (B) UNION (C) UNION (D) AS U;

/* A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). In other words, assign employee 
number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A), and employee number 110039 as a manager to all employees from 
10021 to 10040 (this must be subset B).

Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.

Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 as a manager to employee 110039.

Your output must contain 42 rows. */

-- USING SQL VIEWS

-- Exercise
-- Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent. 
-- If you have worked correctly, after executing the view from the Schemas section in Workbench, you should obtain the value of 66924.27.


