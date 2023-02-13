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

