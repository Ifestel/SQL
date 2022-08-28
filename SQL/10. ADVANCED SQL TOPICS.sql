USE employees;

-- ADVANCED SQL TOPICS

/* TYPES OF MySQL VARIABLES - LOCAL VARIABLES

SCOPE - A region of a computer program where a phenomenon, such as variable is considered valid
A variable could be relevant for a specific SQL stmt only or it could be important for all the connections on a server
These are 2 diff scopes where a variable could be applied. Alternatively, a programmer can use the term VISIBILiTY
 as a more advanced term to scope.
 There are 3 types of MySQL variables - LOCAL, SESSION, AND GLOBAL
 
 LOCAL VARIABLE - A variable that is visible only in the BEGIN - END block in which it was created
 DECLARE is the keyword that can be used when creating local variables only. You can't declare variable
 of some other types like Session and global variables. */
 
 DROP FUNCTION If EXISTS f_emp_avg_salary;
 
 DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
BEGIN
DECLARE v_avg_salary DECIMAL(10,2);  # Let's proove that the v_avg_salary cannot be accessed from outside this block
SELECT AVG(s.salary)				# ie it was visible at this part of the code only		
INTO v_avg_salary FROM
employees e
JOIN
salaries s ON e.emp_no = s.emp_no
WHERE 
e.emp_no = p_emp_no; 
RETURN v_avg_salary;
END$$
DELIMITER ;

SELECT v_avg_salary;
# This statement is unknown to this variable at this stage. 
# It Is beyond the scope of the local variable in question.  

/* SESSION VARIABLES:
A SESSION is a series of info exchange interactions, or a dialogue, between a computer and a user.
EG a dialogue btw the MySQL server and a client application like MySQL workbench. A Session begins 
at a certain point in time and terminates at another later point.
To start a MySQL session, you connect to the MySQL server and establish a connection with your password
The workbench interface will open immediately.This marks the beginning of your MySQL session. D4,
A Session comes out because of a connection that has been made successfuly. Once you close the connection
tab, you close the MySQL session. There are certain SQL objects that are valid for a specific session only
IE, if you are using an SQL object during a specific connection for a period of time, and then you end that connection,
you'll loose all the data contained/created by these SQL objects. 
Therefore, a session variable is one that exists only for the session in which you are operating
- It is defined on our server, and it lives there.
- It is visible to the connection being used only, meaning that if there are 100 connected USERS, 
there'll be 100 connections,  and 100 sessions. Only you'll see the variable you created in your session.*/

-- For session we use SET and @
SET @s_var1 = 3;
SELECT @s_var1;

# GLOBAL VARIABLES:
/* Global variables apply to all connections related to a specific server
To Indicate you are setting a global variable; */
 
SET GLOBAL var_name = value;
-- OR
SET @@GLOBAL.var_name = value;

-- You can't just set any variable as global. 
-- A specific group of pre-defined variables in MySQL is suitable for this job.
-- They're called 'SYSTEM VARIABLES' Examples
-- 1.  .max_connections() - Indicates the maximum number of connections to a server that can be 
-- established at a certain point in time. 
-- 2. .max_join_size() - Sets the maximum memory space allocated for the joins created by a certain connection
-- Eg

SET GLOBAL max_connections = 1000;
-- Here, not more than 1000 sessions can be started on our server

SET @@global.max_connections = 1;
-- Here, only our session will be the one to be connected to the server at the moment

# USER-DEFINED VS SYSTEM VARIABLES:
/* Varaibles in MySQL can be characterised according to the way they have been created
USER- DEFINED VARIABLES - Can be set by the user manually. 
SYSTEM VARIABLES - Are pre-defined on our system - The MySQL server

- LOCAL VARIABLES - Can be user-defined only
- Only SYSTEM VARIABLES can be set as global
- SESSION VARIABLES - Both User-Defined and System variables can be set as session variables but 
there are limitations to this rule. 
-1.  Some of the system variables can be defined as global only, they cannot be session variables
(e.g .max_connections())
-2. .sql_mode() can help you adjust workbench settings
SET SESSION sql_mode = 
SET SESSION var_name = value; 
SET SESSION sql_mode = changing SESSION to GLOBAL here will allow us to apply the same SQL MODE
to all sessions connected to our server
Finally;
- A user can define a local variable or a session variable - e.g
SET @s_var1 = 3;
SYSTEM Variables can be set as SESSION Variables or as GLOBAL Variables

Not all System Variables can be set as Session
There are 2 types of System Variables
- The ones like sql_mode - Which could be set either as a session or a global variable and 
- The ones like max_connections that can be set as global only. 



