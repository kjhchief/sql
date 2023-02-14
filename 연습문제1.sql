--1. employees ���̺��� �޿��� 5000�̻� 15000���� ���̿� ���Ե��� �ʴ� ����� �����ȣ(employee_id), �̸�(last_name), �޿�(salary), �Ի�����(hire_date)�� ��ȸ�Ͻÿ�.
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary NOT BETWEEN 5000 AND 15000;

-- 2. �μ���ȣ(department_id) 50, ����(job_id) 'ST_MAN', �Ի��� 2004-07-18���� ����� �����ȣ(employee_id), �̸�(last_name), ������ȣ(job_id), �Ի���(hire_date)�� ��ȸ�Ͻÿ�.
SELECT department_id, job_id, hire_date 
FROM employees
WHERE hire_date = TO_DATE(20040718) AND job_id = 'ST_MAN';

--3. 2002�� ���Ŀ�  �Ի��Ͽ���, ������ȣ�� 'ST_MAN' �Ǵ� 'ST_CLERK'�� ������� ��� �÷��� ��ȸ�Ͻÿ�.
SELECT *
FROM employees
WHERE (job_id = 'ST_MAN' OR job_id = 'ST_CLERK') AND hire_date > TO_DATE(20020101);

--4. ���(manager_id)�� ���� ����� ��� �÷��� ��ȸ�Ͻÿ�.
SELECT *
FROM employees
WHERE manager_id IS NULL;

--5. ����̸�(last_name)�� J, A �Ǵ� M���� �����ϴ� ��� ����� last_name�� salary�� ��ȸ�Ͻÿ�.(��, last_name �������� ��ȸ)
SELECT last_name, salary
FROM employees
WHERE last_name LIKE 'J%' or last_name LIKE 'A%' or last_name LIKE 'M%'
ORDER BY last_name;

--6. �⵵�� �Ի��ο����� ��ȸ�Ͻÿ�.
SELECT first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2002';

--7. �����ȣ(employee_id)�� Ȧ���� ����� ��� ������ ��ȸ�Ͻÿ�.
SELECT *
FROM employees
WHERE MOD(employee_id , 2)=1;

--8.���ú��� 6���� �� ���ƿ��� ù��° �ݿ����� ��¥�� ����Ͻÿ�(��¥ �������: 2002-06-05 15:23:10 �ݿ���)
SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(SYSDATE, 6), 6), 'YYYY-MM-DD HH24:MI:SS DAY')
FROM dual;

--9.�����ȣ(employee_id), �����(first_name), ����ȣ(manager_id)�� ��ȸ�ϵ� ��簡 ����(NULL) ��� ����ȣ�� '�뻧'�̶� ����Ͻÿ�.\
SELECT employee_id, first_name, NVL(TO_CHAR(manager_id), '�뻧')
FROM employees;

--10.������� 3���౸������ �з��ϱ� ���� ����� 3���� ������
   --�������� 0�̸� "��ȭ�����"
   --�������� 1�̸� "���׸���"
   --�������� 2�̸� "������" ���� �з��Ͽ� ���̸�, �����ȣ, ������� ����Ͻÿ�.
SELECT employee_id, first_name,
       DECODE(MOD(employee_id,3), MOD(employee_id,3)=0, '��ȭ�����',
       MOD(employee_id,3)=1, '���׸���',
       MOD(employee_id,3)=2, '������')
FROM employees;
--����--

-- 11.����� �޿��׷����� �Ʒ��� ���� ����Ͻÿ�(2�÷����� ���)
--   �̸�            �޿��׷���
   -----------------------------------------------------
--   Steven King     *****($5,000) // $1000�޷��� �� 1���߰�.
--   Neena Kochhar   ***($3,000)--    .........
--   XXXX XXXXX      *****************($17,000)
--����--

--12.2002�� 3������ 2003�� 2�� �Ⱓ ���� �Ի��� ����� ������� �μ��� �ο����� ��ȸ�Ͻÿ�(����� �ο����� ���� ������� �����Ͽ� ���)
SELECT count(*), department_id
FROM employees
WHERE hire_date > TO_DATE(20020301) AND hire_date < TO_DATE(20030228)
GROUP BY department_id
ORDER BY count(*) DESC;

--13.������ ��� �޿��� ����϶�. ��, ��ձ޿��� 10000�� �ʰ��ϴ� ���� �����ϰ� ��� �޿��� ���� ������������ �����Ͻÿ�.
SELECT job_id, AVG(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) < 10000
ORDER BY AVG(salary) DESC;

--14.������ ������� ���� �Ի��� ������� �Ʒ��� ���� ����Ͻÿ�.
--1��  2�� ........................12��
-----------------------------------
--2     1  ........................ 5
SELECT TO_CHAR(hire_date, 'MM') ��
FROM employees;
--����--

--15.'London'���� �ٹ��ϴ� ��� ����� �����ȣ(employee_id), ����̸�(last_name), �����̸�(job_title), �μ��̸�(department_name), �μ���ġ(city)�� ��ȸ�Ͻÿ�.
  --���� ���̺� : employees, jobs, departments, locations
  --���� -����-����-��-
SELECT e.employee_id, e.last_name, d.department_name, l.city, j.job_title
FROM employees e JOIN departments d ON e.department_id = d.department_id
                 JOIN locations l ON d.location_id = l.location_id
                 JOIN jobs j ON e.job_id = j.job_id
WHERE l.city LIKE 'London'
ORDER BY e.employee_id;
-- 1�� ����. ����?

SELECT e.employee_id, e.first_name, e.last_name, d.department_name, l.city, j.job_title
FROM employees e, departments d, locations l, jobs j
WHERE l.city LIKE 'London'
ORDER BY e.employee_id;

--16.����̸�(last_name)�� 'A'�� ���Ե� ����� �̸�(last_name)�� �μ���(department_name)�� ��ȸ�Ͻÿ�.
SELECT e.last_name, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE e.last_name LIKE 'A%';

--17. �޿�(salary)�� 3000���� 5000 ������ ����� ��ȣ, �̸�, �޿�, �μ����� ��ȸ�϶�.
SELECT e.employee_id, e.last_name, e.salary, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE e.salary BETWEEN 3000 AND 5000;

--18. 'Accounting' �μ��� �ٹ��ϴ� ����� �̸��� �Ի����� ��ȸ�϶�.
   -- �Ի��� ��� ���� - 2007�� 05�� 21��(������)
SELECT e.last_name, TO_CHAR(hire_date, 'YYYY"��" MM"��" DD"��" "("DAY")"'), d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name LIKE 'Accounting';
--��ī���� department_id = 110

--19. 'Landry(last_name)'�� ���� �μ��� �ٹ��ϴ� ����� ��� ��� ������ ��ȸ�϶�(��. Landry�� ����)
SELECT *
FROM employees
WHERE department_id = (
                    SELECT department_id
                    FROM employees
                    WHERE last_name LIKE 'Landry'
);

--20. 'Lee(last_name)'���� �ʰ� �Ի��� ����� �̸��� �Ի��� ��ȸ�϶�.
SELECT first_name ||' '|| last_name, hire_date
FROM employees
WHERE hire_date > (
                SELECT hire_date
                FROM employees
                WHERE last_name = 'Lee'
);

--21. 'Lee(last_name)'���� ���� �޿��� �޴� ����� �̸��� �޿��� ��ȸ�϶�.
SELECT first_name ||' '|| last_name, salary
FROM employees
WHERE salary > (
            SELECT salary
            FROM employees
            WHERE last_name = 'Lee'
);

--22. 50�� �μ��� ������ ���� �޿��� �޴� ����� �̸��� �޿��� ��ȸ�϶�.
SELECT first_name ||' '|| last_name, salary
FROM employees
WHERE salary IN (
            SELECT salary
            FROM employees
            WHERE department_id = 50
);

--23. ��� ����� ��ձ޿����� ���� �޿��� �޴� ������� ���, �̸�, �޿��� ��ȸ�϶�.
SELECT job_id, last_name, salary
FROM employees
WHERE salary > (
            SELECT AVG(salary)
            FROM employees
);

--24.�̸�(last_name)��  'T'�� ���ԵǾ� �ִ� ����� ������ �μ��� �ٹ��ϴ� ����� ��ȣ, �̸��� ��ȸ�϶�.
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (
                    SELECT department_id
                    FROM employees
                    WHERE last_name LIKE 'T%'
);

--25.10�� �μ� �ִ�޿��ڿ� ������ �޿��� �޴� ����� ��ȣ, �̸�, �޿��� ��ȸ�϶�.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary = (
            SELECT MAX(salary)
            FROM employees
            WHERE department_id = 50
);

--26. 'IT_PROG' ������ �ִ� �޿��ں��� ���� �޿��� �޴� ��� ����(�μ���ȣ, �����ȣ, �̸�, �޿�)�� ����϶�.
SELECT department_id, employee_id, last_name, salary
FROM employees
WHERE salary > (
            SELECT MAX(salary)
            FROM employees
            WHERE job_id LIKE 'IT_PROG'
);

--27. ��� �޿����� ���� �޿��� �ް� �̸��� u�� ���Ե� ����� ���� �μ��� �ٹ��ϴ� ��� ����� ��� ����(�����ȣ, �̸�, �޿�)�� ��ȸ�϶�.
SELECT employee_id, last_name, first_name, salary
FROM employees
WHERE first_name || last_name LIKE '%u%'
    AND salary >(SELECT AVG(salary)
                FROM employees)
;

--28. ��ձ޿��� ���� ���� ������ȣ(job_id)�� ��ձ޿��� ����϶�
--    ��) ������ȣ  ��ձ޿�
       -----------------
--        CLERK      2300   
SELECT AVG(salary)
FROM employees
WHERE job_id LIKE 'IT_PROG';
SELECT AVG(salary)
FROM employees
WHERE job_id LIKE 'IT_PROG';

SELECT job_id, (SELECT AVG(salary) FROM employees WHERE job_id LIKE 'IT_PROG')
FROM employees