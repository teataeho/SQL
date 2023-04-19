/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���
*/
SELECT *
FROM employees
WHERE salary >
    (
        SELECT AVG(salary)
        FROM employees
    );
    
SELECT COUNT(*)
FROM employees
WHERE salary >
    (
        SELECT AVG(salary)
        FROM employees
    );

SELECT *
FROM employees
WHERE salary >
    (
        SELECT AVG(salary)
        FROM employees
        WHERE job_id = 'IT_PROG'
    );

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
*/
SELECT *
FROM employees e
WHERE e.department_id = 
    (
        SELECT d.department_id
        FROM departments d
        where d.manager_id = 100
    );

/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/
SELECT *
FROM employees
WHERE manager_id >
    (
        SELECT manager_id
        FROM employees
        WHERE first_name = 'Pat'
    );
    
SELECT *
FROM employees
WHERE manager_id = ANY
    (
        SELECT manager_id
        FROM employees
        WHERE first_name = 'James'
    );

/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
*/
SELECT *
FROM
    (
        SELECT ROWNUM AS rn, first_name
        FROM 
            (
                SELECT *
                FROM employees
                ORDER BY first_name DESC
            )
    )
WHERE rn >= 41 AND rn <= 50;

/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
�Ի����� ����ϼ���.
*/
SELECT *
FROM 
    (
        SELECT ROWNUM AS rn, employee_id, first_name, phone_number, hire_date
        FROM 
            (
                SELECT *
                FROM employees
                ORDER BY hire_date ASC
            )
    )
WHERE rn >= 31 AND rn <= 40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/
SELECT e.employee_id,
    CONCAT(e.first_name, e.last_name) AS name,
    e.department_id, 
    d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id;

/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT e.employee_id,
    CONCAT(e.first_name, e.last_name) AS name,
    e.department_id,
    (
        SELECT d.department_name
        FROM departments d
        WHERE e.department_id = d.department_id
    ) AS department_name
FROM employees e
ORDER BY employee_id;

/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
SELECT d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    loc.street_address,
    loc.postal_code,
    loc.city
FROM departments d LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    (
        SELECT loc.street_address
        FROM locations loc
        WHERE d.location_id = loc.location_id
    ) AS street_address,
    (
        SELECT loc.postal_code
        FROM locations loc
        WHERE d.location_id = loc.location_id
    ) AS postal_code,
    (
        SELECT loc.city
        FROM locations loc
        WHERE d.location_id = loc.location_id
    ) AS city
FROM departments d
ORDER BY d.department_id;

/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
SELECT loc.location_id,
    loc.street_address,
    loc.city,
    loc.country_id,
    c.country_name
FROM locations loc LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_name;

/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT loc.location_id,
    loc.street_address,
    loc.city,
    loc.country_id,
    (
        SELECT c.country_name
        FROM countries c
        WHERE loc.country_id = c.country_id
    ) AS country_name
FROM locations loc
ORDER BY country_name;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/
SELECT *
FROM
    (
        SELECT ROWNUM AS rn, info.*
        FROM
            (
                SELECT e.employee_id, e.first_name, e.phone_number,
                e.hire_date, d.department_id, d.department_name
                FROM employees e LEFT JOIN departments d
                ON e.department_id = d.department_id
                ORDER BY hire_date
            ) info        
    )
WHERE rn <= 10;

/*���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE job_id = 'SA_MAN';

/*���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
*/
SELECT *
FROM
    (
        SELECT
            department_id, department_name, manager_id,
            (
                SELECT COUNT(department_id)
                FROM employees e
                WHERE d.department_id = e.department_id
            ) AS total
        FROM departments d
    )
WHERE total > 0
ORDER BY total DESC;

SELECT
    d.department_id, d.department_name, d.manager_id, a.total
FROM departments d
JOIN
    (
        SELECT department_id, COUNT(*) AS total
        FROM employees
        GROUP By department_id
    ) a
ON d.department_id = a.department_id
ORDER BY a.total DESC;

/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/
SELECT d.*, loc.street_address, loc.postal_code,
    (
        SELECT NVL(AVG(e.salary), 0)
        FROM employees e
        WHERE d.department_id = e.department_id
    ) AS average_salary
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id;

SELECT d.*,
    loc.street_address, loc.postal_code,
    NVL(tbl.result, 0) AS �μ�����ձ޿�
FROM departments d JOIN locations loc
ON d.location_id = loc.location_id
LEFT JOIN
    (
        SELECT
            department_id, TRUNC(AVG(salary)) AS result
        FROM employees
        GROUP BY department_id
    ) tbl
ON d. department_id = tbl.department_id;

/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
����ϼ���.
*/
SELECT *
FROM
    (   
        SELECT ROWNUM AS rn, info.*
        FROM
            (
                SELECT d.*, loc.street_address, loc.postal_code,
                (
                    SELECT NVL(AVG(e.salary), 0)
                    FROM employees e
                    WHERE d.department_id = e.department_id
                ) AS average_salary
                FROM departments d
                LEFT JOIN locations loc
                ON d.location_id = loc.location_id
                ORDER BY department_id DESC
            ) info
    )
WHERE rn <= 10;

SELECT *
FROM
    (
    SELECT ROWNUM AS rn, info.*
    FROM
        (
        SELECT d.*,
            loc.street_address, loc.postal_code,
            NVL(tbl.result, 0) AS �μ�����ձ޿�
        FROM departments d JOIN locations loc
        ON d.location_id = loc.location_id
        LEFT JOIN
            (
                SELECT
                    department_id, TRUNC(AVG(salary)) AS result
                FROM employees
                GROUP BY department_id
            ) tbl
        ON d.department_id = tbl.department_id
        ORDER BY d.department_id DESC
        ) info
    )
WHERE rn <= 10;