--Querys for selecting data
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM dept_emp;
SELECT * FROM salaries;
SELECT * FROM titles;

-- Drop tables to import data
Drop table departments CASCADE;
Drop table employees CASCADE;
Drop table dept_manager CASCADE;
Drop table dept_emp CASCADE;
Drop table salaries CASCADE;
Drop table titles CASCADE;
DROP TABLE retirement_info;

-- Queries for determining retirement group
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
  
-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Creating a new table for exporting data out
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
  
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Check the table
SELECT * FROM retirement_info;

SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
SELECT d.dept_name, 
       dm.emp_no, 
	   dm.from_date,
       dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no, 
       ri.first_name, 
	   ri.last_name,
       de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- creating current employees table
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
    de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Create a new table of numbr of employees by dept retiring
SELECT COUNT(ce.emp_no), de.dept_no
INTO retiring_emp_count_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


-- Creating lists
SELECT * FROM salaries;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no,
       e.first_name,
       e.last_name,
       e.gender,
	   s.salary,
	   de.to_date
INTO emp_info
FROM employees AS e
INNER JOIN salaries AS s
  ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp AS de
  ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
  AND (de.to_date = '9999-01-01');
  
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- creating dept_info table
SELECT ce.emp_no,
       ce.first_name,
       ce.last_name,
       d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
  ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
  ON (de.dept_no = d.dept_no);

-- creating dept_info_sales table
SELECT ce.emp_no,
       ce.first_name,
       ce.last_name,
       d.dept_name
INTO dept_info_sales
FROM current_emp as ce
INNER JOIN dept_emp AS de
  ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
  ON (de.dept_no = d.dept_no)
WHERE (de.dept_no = 'd007');


-- creating dept_info_sales_and_development table
SELECT ce.emp_no,
       ce.first_name,
       ce.last_name,
       d.dept_name
INTO dept_info_sales_and_development
FROM current_emp as ce
INNER JOIN dept_emp AS de
  ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
  ON (de.dept_no = d.dept_no)
WHERE (de.dept_no IN ('d007','d005'));
