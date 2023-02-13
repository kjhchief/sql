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
SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(SYSDATE, 6), 6), 'YYYY-MM-DD HH24:MI:SS')
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
--�� ����. �н�--

--19. 'Landry(last_name)'�� ���� �μ��� �ٹ��ϴ� ����� ��� ��� ������ ��ȸ�϶�(��. Landry�� ����)
SELECT *
FROM employees
WHERE department_id = 50;


--20. 'Lee(last_name)'���� �ʰ� �Ի��� ����� �̸��� �Ի��� ��ȸ�϶�.
SELECT hire_date
FROM employees
WHERE last_name = 'Lee';
SELECT first_name ||' '|| last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE(20080223);