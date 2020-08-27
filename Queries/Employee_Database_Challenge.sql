-- Creating deliverable 1 tables
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
	   t.from_date,
	   t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
  ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--  AND (t.to_date = '9999-01-01')
-- ORDER BY e.emp_no;

SELECT DISTINCT ON (emp_no) emp_no,
       first_name,
       last_name,
       title,
	   from_date,
	   to_date
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;
-- Use Dictinct with Orderby to remove duplicate rows
-- SELECT DISTINCT ON (______) _____,
-- ______,
-- ______,
-- ______
-- 
-- INTO nameyourtable
-- FROM _______
-- ORDER BY _____, _____ DESC;

SELECT COUNT(title)
FROM unique_titles;

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count desc;


-- Creating deliverable 2 table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
       e.first_name,
       e.last_name,
	   e.birth_date,
       de.from_date,
	   de.to_date,
	   t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
  ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
  ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
  AND (t.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC; 
  
