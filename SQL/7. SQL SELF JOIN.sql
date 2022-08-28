USE employees;

-- SELF JOIN
/* Applied when a table must join itself
	- If you'd like to combine certain rows of a table with other rows of the same table, you need a SELF JOIN
In a Self Join staement, you will have to comply with the same logical and syntactic structure. 
However the 2 tables will be identical to the table you'll be using in the self join
You can think of them as virtual projections of the underlying BASE TABLE
The self join will reference both implied tables and will treat them as two seperate tables in its operation
The data used will come from a single source, which is the underlying table that stores data pysically
In self join, using aliases is obligatory as it will help us to distinguish the 2 virtual tables
These references to the original table let you use different blocks of the available data
You can either filter both in the join or you can filter one of them in the WHERE CLAUSE, and the other - in the Join */

-- Task
-- From the emp_manager table, extract the record data only of those employees who are managers as well

SELECT * FROM emp_manager ORDER BY emp_manager.emp_no;

SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;

SELECT 
    e2.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
-- Obtaining result from emp_no and dept_no from e1 and manager_no from e2
SELECT 
    e1.emp_no, e1.dept_no, e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
-- How to get only 2 rows of data 1) using SELECT DISTINCT and 2) using a WHERE CLAUSE
SELECT DISTINCT
    e1.*       -- e1.emp_no, e1.dept_no, e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);      -- Using more sophisticated WHERE CLAUSE

SELECT 
    manager_no
FROM
    emp_manager;

