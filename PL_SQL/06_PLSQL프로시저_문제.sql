/*
���ν����� guguProc
������ �� ���޹޾� �ش� �ܼ��� ����ϴ� procedure�� �����ϼ���. 
*/
CREATE OR REPLACE PROCEDURE guguProc
    (p_dan NUMBER)
IS
    
BEGIN
    dbms_output.put_line('������: ' || p_dan || '��');
    FOR i IN 1..9
    LOOP
        dbms_output.put_line(p_dan || 'x' || i || '=' || p_dan*i);
    END LOOP;
    dbms_output.put_line('--------------------------');
END;

EXEC guguProc(3);

/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/
ALTER TABLE depts ADD CONSTRAINT depts_pk PRIMARY KEY(department_id);

CREATE OR REPLACE PROCEDURE depts_proc
    (p_dep_id IN depts.department_id%TYPE,
     p_dep_name IN depts.department_name%TYPE,
     p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_dep_id;
    
    CASE
        WHEN p_flag = 'I' OR p_flag = 'i' THEN
            INSERT INTO depts
                (department_id, department_name)
            VALUES
                (p_dep_id, p_dep_name);
        WHEN p_flag = 'U' OR p_flag = 'u' THEN
            UPDATE depts SET
                department_name = p_dep_name
            WHERE department_id = p_dep_id;
        WHEN p_flag = 'D' OR p_flag = 'd' THEN
            IF v_cnt = 0 THEN
                dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
                RETURN;
            END IF;
            DELETE FROM depts
            WHERE department_id = p_dep_id;
        ELSE
            dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾҽ��ϴ�.');
    END CASE;
    
    COMMIT;
    
EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
    dbms_output.put_line('ERROR MSG: ' || SQLERRM);
    ROLLBACK;
END;

EXEC depts_proc(101, '����', 'd');

/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/
CREATE OR REPLACE PROCEDURE emps_years
    (p_emp_id IN employees.employee_id%TYPE,
     p_result OUT NUMBER)
IS
    v_hire_date DATE;
BEGIN
    SELECT hire_date
    INTO v_hire_date
    FROM employees
    WHERE employee_id = p_emp_id;
    
    p_result := FLOOR((sysdate - v_hire_date) / 365);

END;

DECLARE
    v_year number;
BEGIN
    emps_years(119, v_year);
    dbms_output.put_line('�ټӳ��: ' || year || '��');
EXCEPTION WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('�������� �ʴ� ������̵��Դϴ�.');
END;

/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/
CREATE OR REPLACE PROCEDURE new_emp_proc
    (
     p_emp_id IN employees.employee_id%TYPE,
     p_emp_name IN employees.last_name%TYPE,
     p_emp_email IN employees.email%TYPE,
     p_emp_hire_date IN employees.hire_date%TYPE,
     p_emp_job_id IN employees.job_id%TYPE
    )
IS
    
BEGIN
    MERGE INTO emps a
        USING
            (SELECT p_emp_id AS employee_id
             FROM dual) b
        ON (a.employee_id = b.employee_id)
    WHEN MATCHED THEN
        UPDATE SET
            a.last_name = p_emp_name,
            a.email = p_emp_email,
            a.hire_date = p_emp_hire_date,
            a.job_id = p_emp_job_id
    WHEN NOT MATCHED THEN
        INSERT
            (a.employee_id, a.last_name, a.email, a.hire_date, a.job_id)
        VALUES
            (p_emp_id, p_emp_name, p_emp_email, p_emp_hire_date, p_emp_job_id);
        
END;

EXEC new_emp_proc(208, 'lee', 'lemail', '05/02/03', 'AT_PC');