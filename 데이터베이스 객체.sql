-- 시퀸스 생성
CREATE SEQUENCE emp_seq
  START WITH 100
  INCREMENT BY 10
  NOMAXVALUE
  NOCYCLE
  CACHE 20;
  
SELECT *
FROM user_sequences;

CREATE TABLE emp5 (
    emp_id NUMBER(5),
    name VARCHAR2(20)
    
);

INSERT INTO emp5
VALUES(emp_seq.NEXTVAL, '김기정');

SELECT *
FROM emp5;

SELECT emp_seq.CURRVAL 
FROM dual;

--뷰 생성 (dba 역할)
--보안 때문에 만든 예제
CREATE VIEW emp_view
    AS SELECT employee_id, last_name, salary
    FROM employees;
--개발자 역할
SELECT *
FROM emp_view;

SELECT e.employee_id, e.last_name, d.department_name, l.city, l.postal_code, c.country_name, r.region_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
                 JOIN locations l   ON d.location_id = l.location_id
                 JOIN countries c   ON l.country_id = c.country_id
                 JOIN regions r     ON c.region_id = r.region_id
ORDER BY c.country_name;

--복잡한 질의를 저장하기 위한 VIEW
CREATE VIEW emp_detail
    AS SELECT e.employee_id, e.last_name, d.department_name, l.city, l.postal_code, c.country_name, r.region_name
     FROM employees e JOIN departments d ON e.department_id = d.department_id
                 JOIN locations l   ON d.location_id = l.location_id
                 JOIN countries c   ON l.country_id = c.country_id
                 JOIN regions r     ON c.region_id = r.region_id
     ORDER BY c.country_name;
     
SELECT *
FROM emp_detail;

SELECT *
FROM user_views;

SELECT *
FROM emp_details_view;

-- 10번 부서의 사원 정보만 조회할 수 있는 뷰 생성
CREATE OR REPLACE VIEW emp_view
    AS SELECT employee_id, last_name, email, phone_number, hire_date, job_id, department_id
    FROM employees
    WHERE department_id = 10
    WITH CHECK OPTION;
INSERT INTO emp_view (employee_id, last_name, email, phone_number, hire_date, job_id, department_id)
VALUES (employees_seq.nextval, '강', 'kdjhchief@ndav.com', '010.2222.1182', TO_DATE('2023/02/12', 'YYYY/MM/DD'), 'IT_PROG', 10);
    
SELECT *
FROM emp_view;

SELECT *
FROM employees;

--인덱스
SELECT *
FROM user_indexes
WHERE table_name = 'EMPLOYEES';

CREATE INDEX emp_dept_id_idx
    ON employee(dept_id);
DROP INDEX emp_dept_id_idx;

-- 시노님 생성
CREATE SYNONYM emps
FOR hr.employees;
SELECT * FROM emps;
-- 시노님 삭제
DROP SYNONYM emps;