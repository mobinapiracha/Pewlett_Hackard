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