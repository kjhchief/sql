-- sql �� �� �ּ�
/* ������ �ּ� */
SELECT *
FROM employees;

-- group by
SELECT department_id
FROM employees
GROUP by department_id;

-- UNION ������ �׽�Ʈ�� ���� ���� ���̺� ����
CREATE TABLE emp AS
 SELECT *
 FROM employees;
 
 SELECT *
 FROM emp;
 
-- UNION ������
SELECT * 
FROM employees
UNION SELECT * 
FROM emp;

-- UNION ALL ������
SELECT * 
FROM employees
UNION ALL
SELECT *
FROM emp; 

-- MINUS ������
SELECT * 
FROM employees
MINUS
SELECT *
FROM emp;

--INTERSECT ������
SELECT * 
FROM employees
INTERSECT
SELECT *
FROM emp;
