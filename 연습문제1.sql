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

--8.오늘부터 6개월 후 돌아오는 첫번째 금요일의 날짜를 출력하시오(날짜 출력형식: 2002-06-05 15:23:10 금요일)
SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(SYSDATE, 6), 6), 'YYYY-MM-DD HH24:MI:SS DAY')
FROM dual;

--9.사원번호(employee_id), 사원명(first_name), 상사번호(manager_id)를 조회하되 상사가 없는(NULL) 경우 상사번호를 '대빵'이라 출력하시오.\
SELECT employee_id, first_name, NVL(TO_CHAR(manager_id), '대빵')
FROM employees;

--10.사원들을 3개축구팀으로 분류하기 위해 사번을 3으로 나누어
   --나머지가 0이면 "영화배우팀"
   --나머지가 1이면 "개그맨팀"
   --나머지가 2이면 "가수팀" 으로 분류하여 팀이름, 사원번호, 사원명을 출력하시오.
SELECT employee_id, first_name,
       DECODE(MOD(employee_id,3), MOD(employee_id,3)=0, '영화배우팀',
       MOD(employee_id,3)=1, '개그맨팀',
       MOD(employee_id,3)=2, '가수팀')
FROM employees;
--보류--

-- 11.사원별 급여그래프를 아래와 같이 출력하시오(2컬럼으로 출력)
--   이름            급여그래프
   -----------------------------------------------------
--   Steven King     *****($5,000) // $1000달러당 별 1개추가.
--   Neena Kochhar   ***($3,000)--    .........
--   XXXX XXXXX      *****************($17,000)
--보류--

--12.2002년 3월부터 2003년 2월 기간 동안 입사한 사원을 대상으로 부서별 인원수를 조회하시오(결과는 인원수가 많은 순서대로 정렬하여 출력)
SELECT count(*), department_id
FROM employees
WHERE hire_date > TO_DATE(20020301) AND hire_date < TO_DATE(20030228)
GROUP BY department_id
ORDER BY count(*) DESC;

--13.업무별 평균 급여를 계산하라. 단, 평균급여가 10000을 초과하는 경우는 제외하고 평균 급여에 대해 내림차순으로 정렬하시오.
SELECT job_id, AVG(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) < 10000
ORDER BY AVG(salary) DESC;

--14.연도에 상관없이 월별 입사한 사원수를 아래와 같이 출력하시오.
--1월  2월 ........................12월
-----------------------------------
--2     1  ........................ 5
SELECT TO_CHAR(hire_date, 'MM') 월
FROM employees;
--보류--

--15.'London'에서 근무하는 모든 사원의 사원번호(employee_id), 사원이름(last_name), 업무이름(job_title), 부서이름(department_name), 부서위치(city)를 조회하시오.
  --관련 테이블 : employees, jobs, departments, locations
  --로케 -디파-임플-잡-
SELECT e.employee_id, e.last_name, d.department_name, l.city, j.job_title
FROM employees e JOIN departments d ON e.department_id = d.department_id
                 JOIN locations l ON d.location_id = l.location_id
                 JOIN jobs j ON e.job_id = j.job_id
WHERE l.city LIKE 'London'
ORDER BY e.employee_id;
-- 1명만 나옴. 왜지?

SELECT e.employee_id, e.first_name, e.last_name, d.department_name, l.city, j.job_title
FROM employees e, departments d, locations l, jobs j
WHERE l.city LIKE 'London'
ORDER BY e.employee_id;

--16.사원이름(last_name)에 'A'가 포함된 사원의 이름(last_name)과 부서명(department_name)을 조회하시오.
SELECT e.last_name, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE e.last_name LIKE 'A%';

--17. 급여(salary)가 3000에서 5000 사이인 사원의 번호, 이름, 급여, 부서명을 조회하라.
SELECT e.employee_id, e.last_name, e.salary, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE e.salary BETWEEN 3000 AND 5000;

--18. 'Accounting' 부서에 근무하는 사원의 이름과 입사일을 조회하라.
   -- 입사일 출력 형식 - 2007년 05월 21일(월요일)
SELECT e.last_name, TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일" "("DAY")"'), d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name LIKE 'Accounting';
--어카운팅 department_id = 110

--19. 'Landry(last_name)'와 동일 부서에 근무하는 사원의 모든 모든 정보를 조회하라(단. Landry은 제외)
SELECT *
FROM employees
WHERE department_id = (
                    SELECT department_id
                    FROM employees
                    WHERE last_name LIKE 'Landry'
);

--20. 'Lee(last_name)'보다 늦게 입사한 사원의 이름과 입사일 조회하라.
SELECT first_name ||' '|| last_name, hire_date
FROM employees
WHERE hire_date > (
                SELECT hire_date
                FROM employees
                WHERE last_name = 'Lee'
);

--21. 'Lee(last_name)'보다 많은 급여를 받는 사원의 이름과 급여을 조회하라.
SELECT first_name ||' '|| last_name, salary
FROM employees
WHERE salary > (
            SELECT salary
            FROM employees
            WHERE last_name = 'Lee'
);

--22. 50번 부서의 사원들과 같은 급여를 받는 사원의 이름과 급여를 조회하라.
SELECT first_name ||' '|| last_name, salary
FROM employees
WHERE salary IN (
            SELECT salary
            FROM employees
            WHERE department_id = 50
);

--23. 모든 사원의 평균급여보다 많은 급여를 받는 사원들의 사번, 이름, 급여를 조회하라.
SELECT job_id, last_name, salary
FROM employees
WHERE salary > (
            SELECT AVG(salary)
            FROM employees
);

--24.이름(last_name)에  'T'가 포함되어 있는 사원과 동일한 부서에 근무하는 사원의 번호, 이름을 조회하라.
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (
                    SELECT department_id
                    FROM employees
                    WHERE last_name LIKE 'T%'
);

--25.10번 부서 최대급여자와 동일한 급여를 받는 사원의 번호, 이름, 급여를 조회하라.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary = (
            SELECT MAX(salary)
            FROM employees
            WHERE department_id = 50
);

--26. 'IT_PROG' 업무의 최대 급여자보다 많은 급여를 받는 사원 정보(부서번호, 사원번호, 이름, 급여)를 출력하라.
SELECT department_id, employee_id, last_name, salary
FROM employees
WHERE salary > (
            SELECT MAX(salary)
            FROM employees
            WHERE job_id LIKE 'IT_PROG'
);

--27. 평균 급여보다 많은 급여를 받고 이름에 u가 포함된 사원과 같은 부서에 근무하는 모든 사원의 사원 정보(사원번호, 이름, 급여)를 조회하라.
SELECT employee_id, last_name, first_name, salary
FROM employees
WHERE first_name || last_name LIKE '%u%'
    AND salary >(SELECT AVG(salary)
                FROM employees)
;

--28. 평균급여가 가장 적은 업무번호(job_id)와 평균급여를 출력하라
--    예) 업무번호  평균급여
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