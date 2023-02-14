--������ ���� (Old Style)
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e, departments d
WHERE employee_id = 100 AND e.department_id = d.department_id;

--����� ����(ANSI ����)
--INNER JOIN
--EQUI JOIN
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e  JOIN departments d ON e.department_id = d.department_id;
--WHERE employee_id = 100 ;
--��������
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e JOIN departments d USING (department_id);

desc departments; 

--Cross Join
--������
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e, departments d;
--107 * 27
--�����
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e CROSS JOIN departments d;

--INNER JOIN: NON-EQUI JOIN �ǽ��� ���� ���̺� �����ϰ� ���� ������ �Է�
CREATE TABLE salgrade(
 grade NUMBER,
 losal NUMBER,
 hisal NUMBER
);

INSERT INTO salgrade VALUES(1, 2000, 2999);
INSERT INTO salgrade VALUES(2, 3000, 3999);
INSERT INTO salgrade VALUES(3, 4000, 4999);
INSERT INTO salgrade VALUES(4, 5000, 5999);
INSERT INTO salgrade VALUES(5, 6000, 100000);

UPDATE salgrade
SET losal = 6000
WHERE grade = 5;

DELETE FROM salgrade
WHERE grade = 5;

SELECT *
FROM salgrade;

--����� ����
--NON-EQUI JOIN
SELECT e.employee_id, e.last_name, e.salary, s.grade
FROM employees e JOIN salgrade s ON e.salary BETWEEN s.losal AND s.hisal
WHERE e.employee_id=200;

SELECT *
FROM locations;

SELECT *
FROM countries;

SELECT *
FROM regions;

--5���� ���̺� ����
--INNER JOIN, EQUI JOIN
SELECT e.employee_id, e.last_name, d.department_name, l.city, l.postal_code, c.country_name, r.region_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
                 JOIN locations l   ON d.location_id = l.location_id
                 JOIN countries c   ON l.country_id = c.country_id
                 JOIN regions r     ON c.region_id = r.region_id
ORDER BY c.country_name;

-- OUTER JOIN
-- LEFT OUTER JOIN
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id;

-- RIGHT OUTER JOIN
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e RIGHT JOIN departments d ON e.department_id = d.department_id;

-- FULL OUTER JOIN
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e FULL JOIN departments d ON e.department_id = d.department_id;


--SELF JOIN, OUTER JOIN
--��� �� ���(�Ŵ���) �̸� ��ȸ
SELECT e.last_name ���, m.last_name ���
FROM employees e LEFT JOIN employees m ON e.manager_id = m.employee_id;
                 
