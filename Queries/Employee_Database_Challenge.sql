
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
	   t.from_date,
	   t.to_date
--INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
  ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--  AND (t.to_date = '9999-01-01')
-- ORDER BY e.emp_no;

SELECT DISTINCT(emp_no),
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
