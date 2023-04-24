
-- 1. ������ �� 3���� ����ϴ� �͸� ����� ����� ����. (���¹� 9���� �����ؼ� ������)
DECLARE
    
BEGIN
    dbms_output.put_line('3 X 1 = 3');
    dbms_output.put_line('3 X 2 = 6');
    dbms_output.put_line('3 X 3 = 9');
    dbms_output.put_line('3 X 4 = 12');
    dbms_output.put_line('3 X 5 = 15');
    dbms_output.put_line('3 X 6 = 18');
    dbms_output.put_line('3 X 7 = 21');
    dbms_output.put_line('3 X 8 = 24');
    dbms_output.put_line('3 X 9 = 27');
END;

-- 2. employees ���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ�
-- �͸����� ����� ����. (������ ��Ƽ� ����ϼ���.)
DECLARE
    v_emps_name employees.first_name%TYPE;
    v_emps_email employees.email%TYPE;
BEGIN
    SELECT first_name, email
    INTO v_emps_name, v_emps_email
    FROM employees
    WHERE employee_id = 201;
    
    dbms_output.put_line('201�� ����� �̸�: ' || v_emps_name);
    dbms_output.put_line('201�� ����� �̸���: ' || v_emps_email);
END;

-- 3. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps ���̺�
-- employee_id, last_name, email, hire_date, job_id�� �ű� �����ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT�� ����� �����մϴ�. (������ �÷��� �ƹ� ���̳� ��������.)
/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
<JOB_ID>: CEO
*/
DECLARE
    v_emps_max_employee_id NUMBER;
BEGIN
    SELECT MAX(employee_id)
    INTO v_emps_max_employee_id
    FROM employees;
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES
        (v_emps_max_employee_id + 1, 'steven', 'stevenjobs', sysdate, 'CEO');
END;