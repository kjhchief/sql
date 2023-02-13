--1. employees 테이블에서 급여가 5000이상 15000이하 사이에 포함되지 않는 사원의 사원번호(employee_id), 이름(last_name), 급여(salary), 입사일자(hire_date)를 조회하시오.
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary NOT BETWEEN 5000 AND 15000;

-- 2. 부서번호(department_id) 50, 업무(job_id) 'ST_MAN', 입사일 2004-07-18일인 사원의 사원번호(employee_id), 이름(last_name), 업무번호(job_id), 입사일(hire_date)을 조회하시오.
SELECT department_id, job_id, hire_date 
FROM employees
WHERE hire_date = TO_DATE(20040718) AND job_id = 'ST_MAN';

--3. 2002년 이후에  입사하였고, 업무번호가 'ST_MAN' 또는 'ST_CLERK'인 사원들의 모든 컬럼을 조회하시오.
SELECT *
FROM employees
WHERE (job_id = 'ST_MAN' OR job_id = 'ST_CLERK') AND hire_date > TO_DATE(20020101);

--4. 상사(manager_id)가 없는 사원의 모든 컬럼을 조회하시오.
SELECT *
FROM employees
WHERE manager_id IS NULL;

--5. 사원이름(last_name)이 J, A 또는 M으로 시작하는 모든 사원의 last_name과 salary를 조회하시오.(단, last_name 오름차순 조회)
SELECT last_name, salary
FROM employees
WHERE last_name LIKE 'J%' or last_name LIKE 'A%' or last_name LIKE 'M%'
ORDER BY last_name;

--6. 년도별 입사인원수를 조회하시오.
SELECT first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2002';

--7. 사원번호(employee_id)가 홀수인 사원의 모든 정보를 조회하시오.
SELECT *
FROM employees
WHERE MOD(employee_id , 2)=1;

