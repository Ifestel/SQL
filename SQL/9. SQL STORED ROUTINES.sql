USE employees;

-- STORED ROUTINES
-- Introduction to Stored Routines:

/* A ROUTINE is commonly perceived as a usual, fixed action, or series of actions, repeated periodically.
-- Instead of an SQL query user to repeat a query over and over, a stored routine is used'
-- It is an SQL stmt or a set of SQL stmts, that can be stored on the Database server. Thus, whenever a user
-- needs to run the query in question, they can call, reference, or invoke the routine. 
-- Write the query that encloses the algorithm only once, and then stored in a routine. Then the routine can 
-- bring the desired result multiple times with a simple query. We can have 2 types of stored routines;
-- Stored procedures and Functions. All procedures are stored, so you can simply call them Procedures.
-- Functions can be of various types, they could be programed manually, then they act like stored routines.
-- These are the user defined functions, but there are already defined built in functions inside Mysql eg 
-- Aggregate functions or the datetime functions. Only the context can define what type of function in use.*/


# MySQL syntax for Stored Procedures:
-- SEMI COLON ;
-- They function as a statement terminator
-- Technically, they can also be called delimiters
-- By typing DELIMITER $$, you'll be able to use the dollar symbols as your delimiter, the ; is'nt yr delimiter 
-- anymore because, since every query is terminated by a ; If you call/invoke a Procedure that uses the : as a delimiter,
-- P_query #1 ;
-- P_query #2 ; SQL engine will only run the 1st query with the stmt terminator, and move on to the next query beyond 
-- the procedure. To avoid this problem, you need a temporary delimiter difft from the std ; like the $$ or // 
# Syntax:
DELIMITER $$
CREATE PROCEDURE procedure_name(param_1, param_2)
-- Parameters represent certain values that the procedure will use to complete
-- the calculation it is supposed to execute. 
-- A procedure can be created without parameters too. Nevertheless, the parentheses must 
-- always be attached to its name.
DELIMITER $$
CREATE PROCEDURE procedure_name()
BEGIN
SELECT * FROM employees
LIMIT 1000;
END$$
DELIMITER ;         # from this moment on, $$ will not act as a delimiter
-- The body of the procedure composed of a query, and this query is the reason you are creating
-- the entire procedure. It'll be placed btw the BEGIN and END keywords

# STORED PROCEDURE EXAMPLE Part 1
-- EXAMPLE:
# Return the 1st 1000 rows from the employees table
 # When dropping a nonparameterised procedure, we should not write the parenthesis at the end
 
DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
SELECT * FROM employees
LIMIT 1000;
END$$
DELIMITER ;

# To call/Invoke the Procedure,
CALL employees.select_employees(); 
# OR
CALL select_employees();
# OR 
-- From the Schema section, click on the select_employee and click on the 2nd right icon......

-- Exercise 
-- Create a procedure that will provide the average salary of all employees. Then, call the procedure.

DELIMITER $$
CREATE PROCEDURE AVG_salary()
BEGIN
SELECT  AVG(salary) 
FROM salaries;

END$$
DELIMITER ;

call employees.AVG_salary();
CALL AVG_salary;
DROP PROCEDURE AVG_salary;
DROP PROCEDURE employees.AVG_salaries;

-- ENDS --

-- ANOTHER WAY TO CREATE A PROCEDURE IN SQL
-- The above are non-parametic procedures

-- STORED PROCEDURES WITH AN INPUT PARAMETER
/* A STORED ROUTINE can perform a calculation that transforms an input value in an output value
Stored Procedures can take an input value and then use it in the query, or queries, written in the 
body of the procedure.
This value is represented by the IN parameter
After that calculation is ready, a result will be returned */

-- EG Assuming you want to have a program that returns the name, salary, start date, and to date of the contract of a specific employee*/

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE
e.emp_no = p_emp_no;
END$$
DELIMITER ;

-- Procedures with one input parameter can be used with aggregate functions too
-- consider the average salary of this same employee
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, AVG(s.salary)
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE
e.emp_no = p_emp_no;
END$$
DELIMITER ;

CALL emp_avg_salary (11300);

-- STORED PROCEDURES WITH AN OUTPUT PARAMETER
-- SYNTAX
/* DELIMITER $$
CREATE PROCEDURE procedure_name(in parameter, out parameter)
BEGIN
SELECT * FROM employees
LIMIT 1000;
END$$
DELIMITER ; */
-- The OUT parameter will represent the variable containing the output value of the operation
-- executed by the query of the stored procedure

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
SELECT AVG(s.salary)
INTO p_avg_salary FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE
e.emp_no = p_emp_no;
END$$
DELIMITER ;

-- Everytime you create a procedure containing both an IN and an OUT parameter, you MUST use the SELECT-INTO structure

-- Exercise
-- Create a procedure called "emp_info" that uses as parameters the first and the last name of an individual, and returns their employee number.
 DELIMITER $$
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(255), IN p_last_name VARCHAR(255), OUT p_emp_no INTEGER)
BEGIN
SELECT e.emp_no
INTO p_emp_no FROM employees e
WHERE
e.first_name = p_first_name
AND
e.last_name = p_last_name;
END$$
DELIMITER ;
 
call employees.emp_info('Aruna', 'Journel', @p_emp_no);      -- Aruna Journel emp_no = 10789 

/* What is IN Parameter in SQL. 
A parameter in SQL helps to exchange data among stored procedures and functions. 
With the help of input parameters, the caller can pass a data value to the stored procedure or function. 
While, with the help of output parameters, the stored procedure can pass a data value back to the caller*/

# VARIABLES
/* When you are defining a program, such as a stored procedure for instance, you can say you are using 'Parameters'
Parameters are a more abstract term
DELIMITER $$
CREATE PROCEDURE procedure_name (in parameter, out parameter)
Once the structure has been solidified, then it'll be applied to the database. The input value you insert is typically
refered to as the 'argument', while the obtained output value is stored in a 'variable'.
CREATE PROCEDURE INPUT(ARGUMENT) OUTPUT (VARIABLE)
The Procedure is
- create a variable using SET @
- Extract a value that will be assigned to the newly created variable(Call the Procedure) 
- Ask the software to display the output of the procedure by selecting the variable just created*/

SELECT * FROM employees;

delimiter $$
use employees $$
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10, 2)) -- precision of 10 and scale of 2 -- specifiying the name of the column we want to use as our in parameter
begin
select avg(s.salary)
into p_avg_salary
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end $$
delimeeter;

SET @v_avg_salary = 0;
CALL emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

/* The parameter and varible outputs are identical bcos the process of implementing stored procedures 
in SQL is unique. 
IN-OUT parameter exist as well. They are used whenever you are working with stored procedures and 
tries to override the content of a data point that has been used as an input with the output value 
obtained after running the calculation
CREATE PROCEDURE ... out parameter 
This means you have the same variable as IN and OUT parameter*/


/* Assignment
Create a variable, called "v_emp_no", where you will store the output of the procedure you created in the last exercise.
Call the same procedure, inserting the values "Aruna" and "Journel" as a first and last name respectively.
Finally, select the obtained output.*/

DELIMITER $$

CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)

BEGIN

SELECT
e.emp_no
INTO p_emp_no FROM
employees e
WHERE
e.first_name = p_first_name
AND e.last_name = p_last_name;

END$$
#emp_info
DELIMITER ;

SET @p_emp_no = 0;
CALL employees.emp_info('Aruna', 'Journel', @p_emp_no);
SELECT @p_emp_no;
 
--  USER-DEFINED FUNCTIONS IN MySQL

/* Stored procedures are not the only types of stored routines. Some cases, it will be preferable to use FUNCTIONS. 
What's the diff btw the 2?*/
/* DELIMITER $$
CREATE FUNCTION function_name(parameter data_type) RETURNS data_type
DECLARE variable_name data_type
BEGIN
SELECT
RETURN variable_name
END$$
DELIMITER ; */
 
 # EG
 
DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
BEGIN
DECLARE v_avg_salary DECIMAL(10,2);
SELECT AVG(s.salary)
INTO v_avg_salary 
FROM employees e
JOIN
salaries s ON e.emp_no = s.emp_no
WHERE 
e.emp_no = p_emp_no; 
RETURN v_avg_salary;
END$$
DELIMITER ;

-- We can't call a funtion
-- We can select it
  SELECT f_emp_avg_salary(11300);
 -- OR from the Schema section through FUNCTIONS
  
-- Exercise
/* Create a function called "emp_info" that takes for parameters the first and last name of an employee, 
and returns the salary from the newest contract of that employee.
Hint: In the BEGIN-END block of this program, you need to declare and use two variables - v_max_from_date 
that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.
Finally, select this function.*/

DELIMITER $$
CREATE FUNCTION f_emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS DECIMAL(10,2)
BEGIN
DECLARE v_max_from_date DATE;
DECLARE v_salary DECIMAL (10,2);

SELECT
max(s.salary) INTO v_salary
 FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE
e.first_name = p_first_name and e.last_name = p_last_name;
RETURN v_salary;

END$$
DELIMITER ;

SELECT f_emp_info ('Aruna', 'Journel');   

-- ENDS --           

/* STORED ROUTINES - CONCLUSION
Technical Differences;
- Stored Procedures do not return a value
- You CALL the procedure
- Can have multiple OUT parameters
If you need to obtain more than one value as a result of a calculation, you are better off with a Procedure 

- User Defined Functions Return a value
- They use SELECT Functions
- Can return a single value only
If you need just one value to be returned, you can use a function
- You can easily include a function as one of the columns inside a SELECT statement

How about Involving an INSERT, UPDATE, and DELETE statement?
In those cases, the operation performed will apply changes to the data in your database
There will be no value or values to be returned and displayed to the user
A FUNCTION should not be used incase we perform update, insert, and delete only as it must
always return a value. Using a PROCEDURE without an out parameter is the right choice*/
# EG
SET @v_emp_no = 11300;
SELECT
emp_no,
first_name, 
last_name,
f_emp_avg_salary(@v_emp_no) AS avg_salary
FROM
employees
WHERE
emp_no = @v_emp_no;

/* Including a procedure in a SELECT statement is impossible
- Once you become an advanced SQL user, and have gained a lot of practice, You'll appreciate
the advantages and disadvantages of both types of programs.
- You will encounter many cases where you should choose between procedures and functions.