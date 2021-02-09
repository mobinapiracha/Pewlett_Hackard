-- Determine Retirement Eligibility 
SELECT first_name, last_name 
FROM employees 
WHERE birth_date BETWEEN '1951-01-01' AND '1955-12-31';

-- Only 1952 birth dates
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Only 1953 birth dates
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Only 1954 Birth Dates 
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Only 1955 Birth Dates 
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Determine Eligibility 
SELECT first_name, last_name 
FROM employees 
WHERE (birth_date BETWEEN '1951-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring 
SELECT COUNT (first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create the Retirement Eligibility Table 
SELECT first_name, last_name 
INTO retirement_info
FROM employees 
WHERE (birth_date BETWEEN '1951-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- View new table 
SELECT *
FROM retirement_info;

-- DROP retirement_info table to recreate it 
DROP TABLE retirement_info; 

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table 
SELECT * 
FROM retirement_info

-- Joining departments and dept managers table
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments 
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Some people in retirement_info might have left the company, need refined list
-- dept_emp table has this information
-- Joining retirement info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- JOIN retiring employees with their departments (who still work at PH)
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri 
LEFT JOIN dept_emp as de
On ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Current employee eligible for retirement
SELECT *
FROM current_emp

-- Using COUNT, GROUP BY and ORDER BY
-- Employee count by department number by LEFT JOIN of current_emp and dept_emp
SELECT count(ce.emp_no), de.dept_no
FROM current_emp as ce 
LEFT JOIN dept_emp as de 
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no; 

-- Same code with ORDER BY clause 
SELECT count(ce.emp_no), de.dept_no
INTO emp_retire_per_dept
FROM current_emp as ce 
LEFT JOIN dept_emp as de 
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * 
FROM emp_retire_per_dept;

-- Creating Additional Lists of Employee Info, Management, Department Retirees
-- General Employee Information: first name, last name, em no., salary, gender
-- Only include those retiring
SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender, 
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');


-- Many Employees Retiring are a part of management team
-- Create list to reflect departures 
-- List includes Employee Number, First Name, Last Name, and Start and End Employment Dates 
-- dept_name from departments, first and last name from current emp of those retiring, start and end employment from managers
-- List of Managers per department
SELECT dm.dept_no,
	d.dept_name, 
	dm.emp_no,
	ce.last_name,
	ce.first_name, 
	dm.from_date, 
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments as d 
	ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce 
	ON (dm.emp_no = ce.emp_no);
	
-- View Managers per department 
SELECT * 
FROM manager_info

-- Department Retirees 
SELECT ce.emp_no, 
	ce.first_name, 
	ce.last_name,
	d.dept_name
INTO dept_info 
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no); 

-- View Department Retirees 
SELECT * 
FROM dept_info

-- Only return information relevant to sales team 
-- Employee numbers, first name, last name (retirement info), employee department name (departments), 
SELECT ri.emp_no, 
	ri.first_name,
	ri.last_name, 
	d.dept_name
INTO sales_dept_info
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments as d 
ON (de.dept_no = d.dept_no)
WHERE (dept_name = 'Sales')

-- View sales_dept_info
SELECT * 
FROM sales_dept_info

-- List of employees in both sales and development department 
SELECT ri.emp_no, 
	ri.first_name,
	ri.last_name, 
	d.dept_name
INTO mentorship_program
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments as d 
ON (de.dept_no = d.dept_no)
WHERE dept_name IN ('Sales', 'Development')

-- View mentorship program 
SELECT * 
FROM mentorship_program
	   