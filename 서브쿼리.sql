--��������

SELECT *
FROM employees
WHERE hire_date < (
                SELECT hire_date
                FROM employees
                WHERE employee_id = 100
);

SELECT salary
FROM employees
WHERE last_name = 'Seo';
SELECT *
FROM employees
WHERE salary = 2700;
--�̰� �� ����
SELECT *
FROM employees
WHERE salary = (
            SELECT salary
            FROM employees
            WHERE last_name = 'Seo'
);

SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE job_id IN (
    SELECT DISTINCT job_id
    FROM employees
    WHERE department_id = 30
);

--������ ��������
SELECT *
FROM employees
WHERE salary > ANY ( --SOME
    SELECT salary
    FROM employees
    WHERE department_id = 30
);
--���� ���� ����� ������ ����������
SELECT *
FROM employees
WHERE salary > (
    SELECT MIN(salary)
    FROM employees
    WHERE department_id = 30
);

--������ ��������
SELECT *
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE department_id = 30
);
--���� ���� ����� ������ ����������
SELECT *
FROM employees
WHERE salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = 30
);

--������ ��������
SELECT *
FROM employees
WHERE EXISTS ( --�����ϴ��� ���δϱ� �÷� �񱳵� �ʿ� ����
    SELECT *   --���������� �����ϸ�(True�̸� ��ü ���� ��.)
    FROM departments
    WHERE department_id = 30
);

-- ���� �÷� ��������
-- �����ȣ�� 147�� ����� ���� �μ�, ���� �Ի������� ������� �����ȣ, �̸�, ����, �μ���ȣ�� ��ȸ
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE (department_id, hire_date) =( --���� �ϳ��ϱ� =������ �� �� ����.
                            SELECT department_id, hire_date -- �� �ΰ��� ������ ���� �ؾ���.
                            FROM employees
                            WHERE employee_id = 147
                            );
                            
-- �μ��� �ּұ޿��� �޴� ��� ���� + �μ� �̸�����(����)
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE (e.department_id, e.salary) IN(
                            SELECT department_id, MIN(salary)
                            FROM employees
                            GROUP BY department_id
                            )
ORDER BY department_id;
-- ���� ������ ���� ����
SELECT *
FROM employees
WHERE (department_id, salary) IN(
                                SELECT department_id, MIN(salary)
                                FROM employees
                                GROUP BY department_id
                                )
ORDER BY department_id;


-- �μ��� �ִ� �޿��� ���� Ȯ��
-- �ζ��κ� ��������
SELECT e.employee_id, e.first_name, e.department_id, e.salary
FROM employees e JOIN (
                        SELECT department_id, MAX(salary) maxsal
                        FROM employees
                        GROUP BY department_id
                        ) i
ON e.department_id = i.department_id
WHERE e.salary = i.maxsal;

-- ��Į�� ��������(�����ϸ� �� ��)
-- ��� ��ȣ, ��� �̸�, �μ��� ��ȸ
SELECT employee_id,
first_name,
(SELECT department_name
FROM departments d
WHERE d.department_id = e.department_id) "department_name"
FROM employees e;


-- �μ��� ��ձ޿����� ���� �޿��� �޴� ��� ���� ��ȸ
SELECT department_id, employee_id, last_name, salary, job_id
FROM employees e1
WHERE salary > (
                SELECT AVG(salary)
                FROM employees e2
                WHERE e2.department_id = e1.department_id
                )
ORDER BY e1.department_id;
-- ������ �ζ��κ��
SELECT e1.department_id, e1.employee_id, e1.last_name, e1.salary, e1.job_id
FROM employees e1 JOIN (
                SELECT department_id, AVG(salary) avgsal
                FROM employees 
                GROUP BY department_id -- �̰� �� ������. (��?? �׷���̴� Ư�� Į�� �����̴ϱ�..)
                ) e2
                ON e1.department_id = e2.department_id
WHERE e1.salary > e2.avgsal
--ORDER BY e1.department_id;


