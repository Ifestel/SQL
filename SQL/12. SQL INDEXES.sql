USE employees;

# MYSQL INDEXES:

/* They work like the indexes found in the library. The index of a table works like the index of a book
Basically, data is taken from a column of the table and is stored in a certain order in a distinct place,
called an index.
Working with small datasets will return results fast, But Your datasets will typically contain thousands
of millions of records. Logically, the larger a dataset is, the slower the process of finding the
record or records you need. 
For a large database such as the employees database, we can use an index that'll increase the speed of the 
searches related to a table. The Syntax is;
CREATE INDEX index_name
ON table_name (column_1, column_2, ...); The parentheses serve us to indicate the column names on which
our search will be based. It'll be sped up and the data will be filtered in a quicker way. Technically, the idea is
to choose columns so your search will be optimised. These must be fields from your data table you'll search frequently.*/
-- E.g
-- How many pple have been hired after the 1st of Jan 2000?

SELECT * FROM employees WHERE hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);  # the above query will now run faster than when no index was created

# Select all employees bearing the name 'Georgi Facello'

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';

-- Another useful feature is the COMPOSITE INDEXES
-- They are applied to multiple columns and not just a single one.
-- The syntactical structure is the same as indexes. 
/* CREATE INDEX index_name
 ON table_name (column_1, column_2, ...); */
 -- All a programmer needs to do is to pick the columns that'll optimize your search
 
 SELECT * FROM employees WHERE hire_date > '2000-01-01';
 
 SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';
        
 CREATE INDEX i_composite ON employees(first_name, last_name); # Run this query and re-run the above query, it will be returned quicker
 
 -- There are other types of indexes in MySQL, such as PRIMARY and UNIQUE KEYS.
 -- They represent columns on which a person can base his search
 -- E.g the primary key emp_no from the employees table represent unique values an Analyst could take
 -- advantage of to extract distinct values from the data table. 
 
 # To show created indexes;
 
 SHOW INDEX FROM employees FROM employees;
	# OR
 -- Open the info section of the database in use and select the indexes tab. 
 
 -- SQL specialists are always aiming for a good balance btw the improvt of speed search and the resources
 -- used for its execution. 
 -- For small datasets - The ost of having an index might be higher than the benefits. 
 -- For large datasets - A well optimized index can make a positive impact on the search process. 
 
-- Exercise
/* Task 1:
Drop the i_hire_date index.
Task 2:
Select all records from the salaries table of people whose salary is higher than $89,000 per annum.
Then, create an index on the salary column of that table, and check if it has sped up the search of the same SELECT statement.*/

Drop index i_hire_date on employees;

SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;

create index i_salary on salaries(salary);

-- THE CASE STATEMENT
/* There are many ways a condition can be expressed in SQL. One may want to run an output when a certain condition has been satisfied
and another output when a certain condition has not been satisfied.One way to apply such conditions is the Coalesce or Ifnull stmts. 
Another type of conditional construct is the CASE STATEMENT
It's used within a select stmt when we want to return a specific value based on some condition. 
It's syntax can vary depending on what we want to show.
SELECT 
column_name (s)
CASE condition_field
WHEN condition_field_value_1 THEN result_1
WHEN condition_field_value_2 THEN result_2
.....ELSE END AS FROM table_name; */
-- E.g
-- Here, when the value of a column is M, we'll return Male, when F, we'll return Female.

SELECT emp_no, first_name, last_name, CASE
WHEN gender = 'M' THEN 'Male'
ELSE 'Female'
END AS gender FROM employees;

-- We can obtain the same result by puting the name of the column once after the word CASE,
-- then write the corresponding value after the WHEN keyword without using the equals operator

SELECT emp_no, first_name, last_name, 
CASE gender
WHEN 'M' THEN 'Male'
ELSE 'Female'
END AS gender FROM employees;                        

-- This technique won't work in all cases

SELECT
 e.emp_no,
 e.first_name,
 e.last_name,
 CASE
 WHEN dm.emp_no IS NOT NULL THEN 'Manager'
 ELSE 'Employee'
 END AS is_manager
 FROM
 employee e
 LEFT JOIN
 dept_manager dm ON dm.emp_no = e.emp_no
 WHERE e.emp_no > 109990;
 
-- If we re-write dm.emp_no and place it right after CASE, the query won't return the correct result but employee only. 
 -- As seen bellow. This is bcos, IS NULL and IS NOT NULL are not values that smth can be compared to. So the correct
 -- way of writing this condition is CASE, WHEN, and then putting the condition that contain IS NULL or IS NOT NULL. 
 SELECT
 e.emp_no,
 e.first_name,
 e.last_name,
 CASE dm.emp_no
 WHEN NOT NULL THEN 'Manager'
 ELSE 'Employee'
 END AS is_manager
 FROM
 employee e
 LEFT JOIN
 dept_manager dm ON dm.emp_no = e.emp_no
 WHERE e.emp_no > 109990;
 
 -- Another E.g. Here we use the IF construct. The 1st condition within the parentheses is what we want to be TRUE, If TRUE,
 -- the 2nd expression is returned, if FALSE, the 3rd. The IF stmt has some limitations compared to CASE. With CASE, 
 -- we can have multiple conditional expressions, while IF is just one.
 
  SELECT emp_no, first_name, last_name, IF (gender = 'M', 'Male', 'Female')
 AS gender FROM employees;
 
 -- E.g By executing the query bellow, we can obtain the increase in salaries of all dept managers based on some conditions. 
 -- By using WHEN expression, we can obtain more than 2 values in the salary increase column. This output cannot be 
 -- obtained by a simple IF statement.
 
 SELECT
 dm.emp_no,
 e.first_name,
 e.last_name,
 MAX(s.salary) - MIN(s.salary) AS salary_difference,
 CASE
 WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
 WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20,000 but less than $30,000'
 ELSE 'Salary was raised by less than $20,000'
 END AS salary_increase
 FROM dept_manager dm JOIN employees e
 ON e.emp_no = dm.emp_no
 JOIN salaries s ON s.emp_no = dm.emp_no
 GROUP BY s.emp_no;
 
-- Exercise
/* Task 1:
Similar to the exercises done in the lecture, obtain a result set containing the employee number, 
first name, and last name of all employees with a number higher than 109990. Create a fourth column in the query,
 indicating whether this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee. */ 

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE 
        WHEN dm.emp_no is not Null then 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
    Left Join
    dept_manager dm On dm.emp_no = e.emp_no
    where
    e.emp_no > 109990;
    
-- Task 2:
/* Extract a dataset containing the following information about the managers: employee number, first name, and last name. 
Add two columns at the end one showing the difference between the maximum and minimum salary of that employee, 
and another one saying whether this salary raise was higher than $30,000 or NOT.
If possible, provide more than one solution. */

    SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    Max(s.salary) - Min(s.salary) as salary_difference,
     CASE 
        WHEN Max(s.salary) - Min(s.salary) > 30000 Then 'Salary was raised by more than $30000'
        ELSE 'Salary raise less than $30,000'
    END AS salary_increase
FROM
	dept_manager dm
    Join
    employees e on e.emp_no = dm.emp_no
    Join
    salaries s On s.emp_no = dm.emp_no
    Group by
    s.emp_no;
    
-- another method to do this 
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,'Salary was raised by more than $30000', 'Salary raise less than $30,000') AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

-- Task 3:
/* Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, 
called current_employee saying Is still employed if the employee is still working in the company, 
or Not an employee anymore if they are not.
Hint: You'll need to use data from both the employees and the dept_emp table to solve this exercise. */

    SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    Case
    When Max(de.to_date) > sysdate() then 'is still employed' 
    Else 'not an employee anymore'
    End as current_employee
FROM
    employees e
     Join
    dept_emp de On e.emp_no = de.emp_no
    group by de.emp_no
    Limit 100;
 
 -- ENDS --
 