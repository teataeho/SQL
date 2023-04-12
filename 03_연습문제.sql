-- 1
SELECT employee_id,
    first_name,
    last_name,
    hire_date,
    salary
FROM employees;

-- 2
SELECT first_name || last_name AS name
FROM employees;

-- 3
SELECT *
FROM employees
WHERE department_id = 50;

-- 4
SELECT first_name || last_name AS name,
    department_id,
    job_id
FROM employees
WHERE department_id = 50;

-- 5
SELECT first_name || last_name AS name,
    salary,
    salary + 300
FROM employees;

-- 6
SELECT first_name || last_name AS name,
    salary
FROM employees
WHERE salary > 10000;

-- 7
SELECT first_name || last_name AS name,
    job_id,
    commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- 8
SELECT first_name || last_name AS name,
    hire_date,
    salary
FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

-- 9
SELECT first_name || last_name AS name,
    hire_date,
    salary
FROM employees
WHERE hire_date LIKE '03%';

-- 10
SELECT first_name || last_name AS name,
    salary
FROM employees
ORDER BY salary DESC;

-- 11
SELECT first_name || last_name AS name,
    salary
FROM employees
WHERE department_id = 60
ORDER BY salary DESC;

-- 12
SELECT first_name || last_name AS name,
    job_id
FROM employees
WHERE job_id = 'IT_PROG' OR job_id = 'SA_MAN';

SELECT first_name || last_name AS name,
    job_id
FROM employees
WHERE job_id IN ('IT_PROG', 'SA_MAN');

-- 13
SELECT
    first_name || ' ' || last_name || ' 사원의 급여는 ' || salary || '달러 입니다'
FROM employees
WHERE first_name = 'Steven' AND last_name = 'King';

-- 14
SELECT first_name || last_name AS name,
    job_id
FROM employees
WHERE job_id LIKE '%MAN';

-- 15
SELECT first_name || last_name AS name,
    job_id
FROM employees
WHERE job_id LIKE '%MAN'
ORDER BY job_id ASC;