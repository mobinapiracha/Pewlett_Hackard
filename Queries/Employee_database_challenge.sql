-- Employee Database Challenge SQL
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles 
FROM employees AS e 
JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (birth_date between '1952-01-01' AND '1955-12-31')
ORDER BY emp_no; 

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Employees by most recent title who are about to retire
SELECT COUNT (ut.title) AS "Count", ut.title
INTO retiring_titles
FROM unique_titles AS ut 
GROUP BY title
ORDER BY "Count" DESC;

-- Create a mentorship eligibility table 
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility 
FROM employees as e
JOIN dept_emp as de
ON e.emp_no = de.emp_no
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (birth_date between '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no; 

-- How many roles will need to be filled
SELECT COUNT(unique_titles.title) AS "total count of people retiring"
FROM unique_titles 

-- Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
SELECT COUNT (mentorship_eligibility.emp_no) AS "total count of available mentors"
FROM mentorship_eligibility; 