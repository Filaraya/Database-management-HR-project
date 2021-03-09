
USE MyProjectHR;
-- To view all tables in the database
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
test

--TO CREATE VIEW FROM EACH TABLES
/*To create a view from employees table to view only emp_no,first_name, last_name, hire_date
AS employee information */
CREATE VIEW [employee information] AS
SELECT emp_no,first_name, last_name, hire_date
FROM employees;

SELECT * FROM [employee information];

/*To create a view from dept_emp table to view only emp_no and dept_no
AS employee number with dept code */
CREATE VIEW [employee number with dept code] AS
SELECT emp_no,dept_no
FROM dept_emp;

--to view the created employee number with dept code
SELECT * FROM [employee number with dept code];

-- to delete the above view
DROP VIEW [employee number with dept code];

/* to create a new view that deleted from dept_emp table to view employee number
and department number AS employees departments codes */
CREATE VIEW [employees departments codes] AS
SELECT emp_no,dept_no
FROM dept_emp;


/*To create a view from departments table to view only dept_no and dept_name
AS department with its code */
CREATE VIEW [departments code] AS
SELECT dept_no, dept_name
FROM departments;

/*To create a view from dept_manager table to view only employee number and deparments number
AS managers  */
CREATE VIEW [managers code] AS
SELECT emp_no,dept_no
FROM dept_manager;

/*To create a view from salaries table to view only employee number and salary
AS employees salaries  */
CREATE VIEW [employees salaries] AS
SELECT emp_no,salary
FROM salaries;

/*To create a view from titles table to view only employee number and title
AS employees titles  */
CREATE VIEW [employees titles] AS
SELECT emp_no,title
FROM titles;

--to view the created employee infromation


SELECT * FROM [departments code];
SELECT * FROM [managers code];
SELECT * FROM [employees salaries];
SELECT * FROM [employees titles];


-- To view every employees title from employees table and titles table

CREATE VIEW employee_title AS
SELECT e.emp_no,e.first_name,e.last_name,t.title
FROM employees e INNER JOIN titles t
	ON e.emp_no=t.emp_no
--To view the above view (employee_title) view
SELECT * FROM employee_title


--To create a view for every employees department from three tables - employees, dept_emp and departments table
CREATE VIEW employee_department AS
SELECT e.emp_no,e.first_name,e.last_name,d.dept_name,de.dept_no
FROM employees e INNER JOIN	dept_emp de
	ON e.emp_no=de.emp_no
	INNER JOIN departments d
	ON de.dept_no=d.dept_no
--To view the above View (employee_department)
SELECT * FROM employee_department


--To view list of managers name for every departments from three tables - employees,dept_manager and departments tables 
CREATE VIEW departments_managers AS
SELECT e.emp_no, e.first_name,e.last_name,d.dept_name,dm.dept_no
FROM employees e INNER JOIN dept_manager dm
	ON e.emp_no=dm.emp_no
	INNER JOIN departments d
	ON dm.dept_no = d.dept_no

--To view the above deparmants_managers
SELECT * FROM departments_managers


--To create a view from dept_emp table by lates dates and arranged by employee number
CREATE OR ALTER VIEW dept_emp_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;

--To view dept_emp_latest_date
SELECT * FROM dept_emp_latest_date;

--shows only the current department for each employee
CREATE OR ALTER VIEW current_dept_emp AS
    SELECT l.emp_no, dept_no, l.from_date, l.to_date
    FROM dept_emp d
        INNER JOIN dept_emp_latest_date l
        ON d.emp_no=l.emp_no AND d.from_date=l.from_date AND l.to_date = d.to_date;

--To view current_dept_emp
SELECT * FROM current_dept_emp;

-- To view the total salary received every employee while in the company
SELECT emp_no, SUM (salary) AS Total_salary
FROM salaries
GROUP BY emp_no

-- whose employees HAVING lessthan 150,000 while he is in the company
SELECT emp_no, SUM (salary) AS Total_salary
FROM salaries
GROUP BY emp_no
HAVING SUM (salary) < 150000
	
-- To use Functions buit-in function
SELECT emp_no,first_name,last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
ORDER BY full_name

--To know any employee hire data, user defined fuction
CREATE FUNCTION employeeHireDate (
    @emo_no INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        emp_no,
        first_name,
        last_name,
	 hire_date
    FROM
       employees
    WHERE
        emp_no = @emo_no;

--To run the above function
SELECT  * FROM employeeHireDate (10005)
SELECT  * FROM employeeHireDate (10009)
SELECT  * FROM employeeHireDate (10008)


--To Create PROCEDURE to select all employees
CREATE PROCEDURE SelectAllEmployees
AS
SELECT * FROM employees;
GO

EXEC SelectAllEmployees;

----To Create PROCEDURE to select ANY employees
CREATE PROCEDURE SelectAnyEmployee @last_name varchar(60)
AS
SELECT * FROM employees WHERE last_name = @last_name
GO

--To run, use any employees last name, example Simmel, Koblick, Preusig
Select * FROM employees
EXEC SelectAnyEmployee @last_name = 'Simmel'
--or
EXEC SelectAnyEmployee @last_name = 'Koblick'





--working with XML

SELECT e.emp_no,e.first_name,e.last_name,d.dept_name,de.dept_no
FROM employees e INNER JOIN	dept_emp de
	ON e.emp_no=de.emp_no
	INNER JOIN departments d
	ON de.dept_no=d.dept_no
ORDER BY emp_no
FOR XML AUTO;





SELECT e.emp_no AS EmployeeID,e.first_name AS First_Name,e.last_name AS Last_Name,t.title AS Title
FROM employees e INNER JOIN titles t
	ON e.emp_no=t.emp_no
ORDER BY first_name
FOR XML RAW ('Employee'), ROOT ('Title'), ELEMENTS







--working with JSON FUNCTION
SELECT emp_no,
	RTrim (first_name) AS [info. First_Name],
	RTrim (last_name) AS [info.Last_Name], 
	CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
FOR JSON PATH









--To add memebers to update and to insert into employees table
USE master
USE MyProjectHR;
CREATE ROLE EmployeeEntry;
GRANT UPDATE, INSERT  ON employees   TO EmployeeEntry;
ALTER ROLE db_datareader   ADD MEMBER EmployeeEntry;



DROP ROLE EmployeeEntry;









