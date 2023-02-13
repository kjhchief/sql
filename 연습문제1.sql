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
SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(SYSDATE, 6), 6), 'YYYY-MM-DD HH24:MI:SS')
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
--안 배운듯. 패스--

--19. 'Landry(last_name)'와 동일 부서에 근무하는 사원의 모든 모든 정보를 조회하라(단. Landry은 제외)
SELECT *
FROM employees
WHERE department_id = 50;


--20. 'Lee(last_name)'보다 늦게 입사한 사원의 이름과 입사일 조회하라.
SELECT hire_date
FROM employees
WHERE last_name = 'Lee';
SELECT first_name ||' '|| last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE(20080223);