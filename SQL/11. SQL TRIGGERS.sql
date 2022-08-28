USE employees;

COMMIT;
-- We will ROLLBACK after this triggers exercise.

# MySQL TRIGGERS

# Is a type of stored program, associated with a table, 
# that will be activated automatically once a specific event related to the table of association occurs. 

# This event must be related to one of the following three DML statements: INSERT, UPDATE, or DELETE. 
# Therefore, triggers are a powerful and handy tool that professionals love to use where database consistency 
# and integrity are concerned.

-- BEFORE INSERT TRIGGER
DELIMITER $$
CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN
IF NEW.salary < 0 THEN
SET NEW.salary = 0;
END IF;
END $$

DELIMITER ;

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
    INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');
    
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
    # BEFORE UPDATE TRIGGER:
    
    DELIMITER $$
    CREATE TRIGGER before_salaries_update
    BEFORE UPDATE ON salaries
    FOR EACH ROW
    BEGIN
    IF NEW.salary < 0 THEN
    SET NEW.salary = OLD.salary;
    END IF;
    END $$
    DELIMITER ;
    
    UPDATE salaries
    SET
    salary = 98765
    WHERE
    emp_no = '10001'
    AND from_date = '2010-06-22';

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
    UPDATE salaries 
SET 
    salary = -50000
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
        SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001' 
    AND from_date = '2010-06-22'; 
    -- The salary did not change.
    
    -- There are system variables known as system functions. System Functions = Built-In Functions
    -- Often applied in practice, they provide data about the moment of the execution of a certain query.
    
    SELECT SYSDATE();  # delivers the system date and time
    
    SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') as today;  # delivers today's date according to the format
    
    # Illustration
    /* A new employee has been promoted to a manager
    Annual salary should immediately become 20000 dollars higher than the highest
    annual salary they'd ever earned until that moment. A new record in the 'department manager' table
    Create a trigger that will apply several modifications to the 'salaries' table once the relevant
    record in the 'department manager' table has been inserted. 
		Make sure that the end date of the previously highest salary contract of that employee is 
        the one from the execution of the insert stmt. 
        Insert a new record in the 'salaries' table about the same employee that reflects their next
        contract as a manager. 
        - A start date the same as the new 'from date' from the newly inserted record in 'department manager'
        - A salary equal to 20000 dollars higher than their highest ever salary
        - Let that be a contract of indefinite duration. You can display that as a contract ending on the 1st of 
        January in the year 9999.*/
        
    
    DELIMITER $$
    CREATE TRIGGER trig_ins_dept_mng
    AFTER INSERT ON dept_manager
    FOR EACH ROW
    BEGIN
    DECLARE v_curr_salary int;
    
    SELECT 
    MAX(salary)
    INTO v_curr_salary FROM salaries
    WHERE emp_no = NEW.emp_no;
    
    IF v_curr_salary IS NOT NULL THEN
    UPDATE salaries
    SET to_date = SYSDATE()
    WHERE
    emp_no = NEW.emp_no and to_date = NEW.to_date;
    INSERT INTO salaries
    VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
    END $$
    DELIMITER ;
    
    INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');
    
    SELECT * FROM dept_manager WHERE emp_no = 111534;
    
    SELECT * FROM salaries WHERE emp_no = 111534;
           
    ROLLBACK
    
-- Assignment
-- Create a trigger that checks if the hire date of an employee is higher than the current date. 
-- If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).

DELIMITER $$
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
IF NEW.hire_date > sysdate()
THEN SET NEW.hire_date = date_format(sysdate(), '%y-%m-%d');
END IF;
END$$
DELIMITER ;

INSERT INTO employees
VALUES('999999', '1999-01-01', 'Ify', 'Bello', 'F', '2022-08-04');

SELECT * FROM employees WHERE emp_no = 999999;