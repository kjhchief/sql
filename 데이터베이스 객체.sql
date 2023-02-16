-- ������ ����
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
VALUES(emp_seq.NEXTVAL, '�����');

SELECT *
FROM emp5;

SELECT emp_seq.CURRVAL 
FROM dual;

--�� ���� (dba ����)
--���� ������ ���� ����
CREATE VIEW emp_view
    AS SELECT employee_id, last_name, salary
    FROM employees;
--������ ����
SELECT *
FROM emp_view;

SELECT e.employee_id, e.last_name, d.department_name, l.city, l.postal_code, c.country_name, r.region_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
                 JOIN locations l   ON d.location_id = l.location_id
                 JOIN countries c   ON l.country_id = c.country_id
                 JOIN regions r     ON c.region_id = r.region_id
ORDER BY c.country_name;

--������ ���Ǹ� �����ϱ� ���� VIEW
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

-- 10�� �μ��� ��� ������ ��ȸ�� �� �ִ� �� ����
CREATE OR REPLACE VIEW emp_view
    AS SELECT employee_id, last_name, email, phone_number, hire_date, job_id, department_id
    FROM employees
    WHERE department_id = 10
    WITH CHECK OPTION;
INSERT INTO emp_view (employee_id, last_name, email, phone_number, hire_date, job_id, department_id)
VALUES (employees_seq.nextval, '��', 'kdjhchief@ndav.com', '010.2222.1182', TO_DATE('2023/02/12', 'YYYY/MM/DD'), 'IT_PROG', 10);
    
SELECT *
FROM emp_view;

SELECT *
FROM employees;

--�ε���
SELECT *
FROM user_indexes
WHERE table_name = 'EMPLOYEES';

CREATE INDEX emp_dept_id_idx
    ON employee(dept_id);
DROP INDEX emp_dept_id_idx;

-- �ó�� ����
CREATE SYNONYM emps
FOR hr.employees;
SELECT * FROM emps;
-- �ó�� ����
DROP SYNONYM emps;