
-- 1. 구구단 중 3단을 출력하는 익명 블록을 만들어 보자. (츨력문 9개를 복사해서 쓰세요)
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

-- 2. employees 테이블에서 201번 사원의 이름과 이메일 주소를 출력하는
-- 익명블록을 만들어 보자. (변수에 담아서 출력하세요.)
DECLARE
    v_emps_name employees.first_name%TYPE;
    v_emps_email employees.email%TYPE;
BEGIN
    SELECT first_name, email
    INTO v_emps_name, v_emps_email
    FROM employees
    WHERE employee_id = 201;
    
    dbms_output.put_line('201번 사원의 이름: ' || v_emps_name);
    dbms_output.put_line('201번 사원의 이메일: ' || v_emps_email);
END;

-- 3. employees 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤 (MAX 함수 사용)
-- 이 번호 + 1번으로 아래의 사원을 emps 테이블에
-- employee_id, last_name, email, hire_date, job_id를 신규 삽입하는 익명 블록을 만드세요.
-- SELECT절 이후에 INSERT문 사용이 가능합니다. (나머지 컬럼은 아무 값이나 넣으세요.)
/*
<사원명>: steven
<이메일>: stevenjobs
<입사일자>: 오늘날짜
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