--서브쿼리

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
--이걸 한 번에
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

--다중행 서브쿼리
SELECT *
FROM employees
WHERE salary > ANY ( --SOME
    SELECT salary
    FROM employees
    WHERE department_id = 30
);
--위와 같은 결과를 단일행 서브쿼리로
SELECT *
FROM employees
WHERE salary > (
    SELECT MIN(salary)
    FROM employees
    WHERE department_id = 30
);

--다중행 서브쿼리
SELECT *
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE department_id = 30
);
--위와 같은 결과를 단일행 서브쿼리로
SELECT *
FROM employees
WHERE salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = 30
);

--다중행 서브쿼리
SELECT *
FROM employees
WHERE EXISTS ( --존재하는지 여부니까 컬럼 비교도 필요 없음
    SELECT *   --서브쿼리가 존재하면(True이면 전체 갖고 옴.)
    FROM departments
    WHERE department_id = 30
);

-- 다중 컬럼 서브쿼리
-- 사원번호가 147인 사원과 같은 부서, 같은 입사일자인 사원들의 사원번호, 이름, 업무, 부서번호를 조회
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE (department_id, hire_date) =( --행은 하나니까 =연산자 쓸 수 있음.
                            SELECT department_id, hire_date -- 이 두개의 조건을 만족 해야함.
                            FROM employees
                            WHERE employee_id = 147
                            );
                            
-- 부서별 최소급여를 받는 사원 정보 + 부서 이름까지(조인)
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE (e.department_id, e.salary) IN(
                            SELECT department_id, MIN(salary)
                            FROM employees
                            GROUP BY department_id
                            )
ORDER BY department_id;
-- 위와 같은데 조인 제외
SELECT *
FROM employees
WHERE (department_id, salary) IN(
                                SELECT department_id, MIN(salary)
                                FROM employees
                                GROUP BY department_id
                                )
ORDER BY department_id;


-- 부서별 최대 급여자 정보 확인
-- 인라인뷰 서브쿼리
SELECT e.employee_id, e.first_name, e.department_id, e.salary
FROM employees e JOIN (
                        SELECT department_id, MAX(salary) maxsal
                        FROM employees
                        GROUP BY department_id
                        ) i
ON e.department_id = i.department_id
WHERE e.salary = i.maxsal;

-- 스칼라 서브쿼리(웬만하면 안 씀)
-- 사원 번호, 사원 이름, 부서명 조회
SELECT employee_id,
first_name,
(SELECT department_name
FROM departments d
WHERE d.department_id = e.department_id) "department_name"
FROM employees e;


-- 부서별 평균급여보다 많은 급여를 받는 사원 정보 조회
SELECT department_id, employee_id, last_name, salary, job_id
FROM employees e1
WHERE salary > (
                SELECT AVG(salary)
                FROM employees e2
                WHERE e2.department_id = e1.department_id
                )
ORDER BY e1.department_id;
-- 위에꺼 인라인뷰로
SELECT e1.department_id, e1.employee_id, e1.last_name, e1.salary, e1.job_id
FROM employees e1 JOIN (
                SELECT department_id, AVG(salary) avgsal
                FROM employees 
                GROUP BY department_id -- 이게 꼭 들어가야함. (왜?? 그룹바이는 특정 칼럼 기준이니까..)
                ) e2
                ON e1.department_id = e2.department_id
WHERE e1.salary > e2.avgsal
--ORDER BY e1.department_id;


