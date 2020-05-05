-- 1) details of each employee: employee number, last name, first name, 
--    sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
LEFT JOIN salaries AS s
	ON e.emp_no = s.emp_no;
	
-- 2) first name, last name, and hire date for employees who were 
--    hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees AS e
WHERE hire_date LIKE '%/86';

-- 3) manager of each department: department number, department name, 
-- the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM dept_manager AS m
INNER JOIN departments AS d
	ON m.dept_no = d.dept_no
INNER JOIN employees AS e
	ON m.emp_no = e.emp_no;
	
-- 4) department of each employee: employee number, last name, 
-- first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp 
	ON e.emp_no = dept_emp.emp_no
INNER JOIN departments AS d
	ON dept_emp.dept_no = d.dept_no;

-- 5) first name, last name, and sex for employees whose first name 
-- is "Hercules" and last names begin with "B."
SELECT e.first_name, e.last_name, e.sex
FROM employees AS e
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6) All employees in the Sales department, including their employee 
-- number, last name, first name, and department name.
--using JOINS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp
	ON e.emp_no = dept_emp.emp_no
INNER JOIN departments AS d
	ON dept_emp.dept_no = d.dept_no
WHERE dept_name = 'Sales';

-- using SUBQUERIES
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e, departments AS d
WHERE (e.emp_no, d.dept_no) IN (
	SELECT emp_no, dept_no FROM dept_emp
	WHERE dept_no IN (
		SELECT dept_no FROM departments
		WHERE dept_name = 'Sales'));

-- 7) employees in the Sales and Development departments, including 
-- their employee number, last name, first name, and department name.
-- using JOINS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp
	ON e.emp_no = dept_emp.emp_no
INNER JOIN departments AS d
	ON dept_emp.dept_no = d.dept_no
WHERE dept_name IN ('Sales','Development');

-- using SUBQUERIES
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e, departments AS d
WHERE (e.emp_no, d.dept_no) IN (
	SELECT emp_no, dept_no FROM dept_emp
	WHERE dept_no IN (
		SELECT dept_no FROM departments
		WHERE dept_name IN('Sales', 'Development')));
		
-- 8) In descending order, list the frequency count of employee 
-- last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(first_name) AS "last name counts"
FROM employees
GROUP BY last_name
ORDER BY "last name counts" DESC;