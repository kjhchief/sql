DESC departments;
-- INSERT
-- �μ����̺� �� �߰�
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES(7777, '������', 100, 1000);
-- ��� �÷� �Է½� �÷����� ���� ����
INSERT INTO departments
VALUES(7777, '������', 100, 1000);
--Ư�� �÷��� �Է½�
INSERT INTO departments(department_id, department_name)
VALUES(8888, '������');

-- ����Ŭ�� �����ϴ� ������ ��ü�� �̿��� �μ���ȣ �ڵ� ����
INSERT INTO departments(department_id, department_name)
VALUES(departments_seq.nextval, '������');

--��ųʸ����� ������ ��� ��ȸ
SELECT *
FROM user_sequences;

--�������� Ȱ���� ���� ���̺� ������ �����Ͽ� ����
CREATE TABLE emp2 AS
 SELECT *
 FROM employees
 WHERE 1 != 1;

SELECT * FROM emp2;

INSERT INTO emp2
 SELECT * -- ��� ��������
 FROM employees;

SELECT *
FROM departments;

SELECT table_name
FROM user_tables
WHERE table_name = 'EMP';

-- employees ���̺� �������� ����.
SELECT *
FROM user_constraints
WHERE table_name = 'EMPLOYEES';
--��ųʸ� ��ȸ
SELECT *
FROM user_sequences;

-- UPDATE
UPDATE employees
SET department_id = 30
WHERE employee_id = 127;

COMMIT;

SELECT *
FROM employees
WHERE employee_id = 127;

UPDATE employees
SET salary = salary * 1.1
WHERE employee_id = 127;

UPDATE employees;
--SET hire_date = SYSDATE;

-- ���̺� ��� �� ����
DELETE FROM employees ;
-- �����ȣ�� ��ġ�ϴ� �� ����
DELETE FROM employees
WHERE employee_id = 127 ;
-- ���ϵ�ī�� �˻��Ͽ� �� ����
DELETE FROM departments
WHERE department_name LIKE '%��';
-- �������� Ȱ���Ͽ� ����
DELETE FROM emp
WHERE salary > (
        SELECT AVG(salary)
        FROM emp
        );

COMMIT; --����
ROLLBACK; --���� ���

--employee���̺� �ڱ� ������ �Է��ϼ���
DESC employees;

SELECT *
FROM employees;

SELECT *
FROM user_constraints
WHERE table_name = 'EMPLOYEES';

SELECT *
FROM user_sequences;

SELECT *
FROM jobs;

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (employees_seq.nextval, 'Jae hoon', 'Kim', 'kjhchief@naver.com', '010.2000.1111', TO_DATE('2023/02/12', 'YYYY/MM/DD'), 'IT_PROG', 20000, 0.1, NULL, 60);