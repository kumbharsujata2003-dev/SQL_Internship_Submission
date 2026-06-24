  Internship SQL Task
-- Date: 23-06-2026


-- Create Database
CREATE DATABASE IF NOT EXISTS company_db;

USE company_db;


-- Create Department Table
CREATE TABLE IF NOT EXISTS Department
(
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);


-- Create Employee Table
CREATE TABLE IF NOT EXISTS Employee
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    hire_date DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);


-- Insert Department Data
INSERT INTO Department VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance');


-- Insert Employee Data
INSERT INTO Employee VALUES
(101,'Amit',50000,'2025-01-10',1),
(102,'Priya',70000,'2025-03-15',2),
(103,'Rahul',60000,'2024-12-20',2),
(104,'Sneha',80000,'2025-04-01',3),
(105,'Kiran',55000,'2025-02-10',1),
(106,'Pooja',90000,'2025-05-01',3);



-- Q1: Find top 5 highest salary employees

SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 5;



-- Q2: Find department wise employee count

SELECT dept_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY dept_id;



-- Q3: Find second highest salary

SELECT MAX(salary) AS second_highest
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);



-- Q4: Find employees whose salary is greater than department average salary

SELECT *
FROM Employee e
WHERE e.salary >
(
SELECT AVG(e2.salary)
FROM Employee e2
WHERE e2.dept_id = e.dept_id
);



-- Q5: Display employee name with department name using Inner Join

SELECT e.emp_name, d.dept_name
FROM Employee e
INNER JOIN Department d
ON e.dept_id=d.dept_id;



-- Q6: Display employee name with department name using Left Join

SELECT e.emp_name, d.dept_name
FROM Employee e
LEFT JOIN Department d
ON e.dept_id=d.dept_id;



-- Q7: Find departments having more than 1 employee

SELECT dept_id, COUNT(*) AS total_emp
FROM Employee
GROUP BY dept_id
HAVING COUNT(*) > 1;



-- Q8: Find employees hired in last 6 months

SELECT *
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);



-- Q9: Find duplicate employee records

SELECT emp_name, COUNT(*)
FROM Employee
GROUP BY emp_name
HAVING COUNT(*) > 1;



-- Q10: Remove duplicate employee records

SET SQL_SAFE_UPDATES = 0

DELETE e1
FROM Employee e1
JOIN Employee e2
ON e1.emp_name = e2.emp_name
AND e1.emp_id > e2.emp_id;

DELETE e1
FROM Employee e1
JOIN Employee e2
ON e1.emp_name=e2.emp_name
AND e1.emp_id>e2.emp_id