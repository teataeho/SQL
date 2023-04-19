
-- ����Ŀ�� ���� Ȯ��
SHOW AUTOCOMMIT;
-- ����Ŀ�� ��
SET AUTOCOMMIT ON;
-- ����Ŀ�� ����
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (304, 'park', 'park4321@gmail.com', sysdate, 1800);
    
-- �������� ��� ������ ��������� ���(���)
-- ���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ����� ����
ROLLBACK;

-- ���̺�����Ʈ ����.
-- �ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����.
-- ANSI ǥ�� ������ �ƴϱ� ������ �׷��� ���������� ����.
SAVEPOINT insert_park;

ROLLBACK TO SAVEPOINT insert_park;

-- �������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����
-- Ŀ���� ���Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� �����ϴ�.
COMMIT;