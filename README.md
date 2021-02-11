# Pewlett_Hackard

## Overview of the Analysis
Pewlett Hackard is a large company that has been around for a very long time. As baby boomers retire from the company, the company is planning retirement packages and also planning for the future as upcoming retirement will leave thousands of job openings. Planning for this large departure is very important as unfilled vacancies would mean a large gap in the workforce which would put a lot of burden on Human Resources and current employee and could affect company performance. Therefore, we want to use SQL databases through Postgres SQL to find out how many employees will be retiring in the next few years and also how many vacancies will need to be filled. This analysis will help us determine which employees are eligible for retirement, which of the ones retiring are part of the management team, which vacancies will be empty and also allow us to create a mentorship program to train current employees to fill the roles of employees retiring. Pewlett Hackard was previously using Excel and VBA but now they want to transition into SQL. Using relational database is a huge upgrade as it allows us to link different tables in order to filter data and create new tables, and make our analysis much easier. 

## Results 
* We joined the employees and titles table and filtered it for birth days between 1952 and end of 1955 to find out employees who are retiring and their title
* We found the employees most recent title and finally we counted all people retiring by title to find number of people retiring in each title
* For the mentorship program, we created an eligibility table by getting employee information from employees, titles, and dept_employee 
* Lastly for the mentorship program we choose current employees who were born in 1965, in order to help mentor the upcoming employees for the retiring titles

