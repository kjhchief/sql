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
WHERE e1.salary > e2.avgsal;
--ORDER BY e1.department_id;

--2007년 이후에 입사한 사원이 있는 부서번호와 부서이름 주회
--다중행 서브쿼리 EXIST연산자 활용
SELECT d.department_id, d.department_name
FROM departments d
WHERE EXISTS(
            SELECT *
            FROM employees e
            WHERE e.hire_date >= '07/01/01' AND e.department_id = d.department_id
);
--위와 같음
SELECT d.department_id, d.department_name
FROM departments d
WHERE d.department_id IN(
            SELECT e.department_id
            FROM employees e
            WHERE e.hire_date >= '07/01/01'
);

-- 가상컬럼 (ROWID)
SELECT ROWID, employee_id, last_name
FROM employees;

-- 부서번호 중복 제거 후 조회(에러)
SELECT employee_id, DISTINCT department_id --임플 아디랑 이파 아디가 일치하지 않아서.
FROM employees;
-- 서브쿼리와 rowid 활용
SELECT employee_id, department_id
FROM employees
WHERE rowid IN (
                SELECT MIN(ROWID)
                FROM employees
                GROUP BY department_id
                -- 부서별 최초 등록한 사원의 ROWID만 출력
                );
                
-- ROWNUM
SELECT ROWNUM, employee_id, first_name
FROM employees;
-- 테이블의 같은 행이라도 서로 다른 ROWNUM을 가질 수 있다
SELECT ROWNUM, employee_id
FROM employees;

SELECT ROWNUM, employee_id
FROM employees
ORDER BY employee_id DESC;

-- 사원 3명만 조회
SELECT ROWNUM, employee_id, first_name
FROM employees
WHERE ROWNUM <= 3;

-- 주의
-- 첫번째 행의 rownum이 1이므로
-- 1 > 1은 false가 되어 rownum은 더이상 증가하지 않으며, 하나의 행도 반환되지 않음
SELECT ROWNUM, employee_id, first_name
FROM employees
WHERE ROWNUM > 1;

/* 특정 컬럼을 기준으로 정렬하여 상위 5개(범위)를 조회하고자 한다면 */
-- 예)전체 사원의 급여순으로 5명 조회하기
SELECT first_name, salary
FROM employees
WHERE ROWNUM <=5
ORDER BY salary DESC;
-- 잘못된 query : 전체 급여 순위가 아닌 처음 5명안에서의 급여 순위 정렬됨. 왜? 실행 순서가 FROM 다음에 WHERE이기에
-- 문제 해결) FROM절에서 서브쿼리(Inline View)를 사용해야 한다
SELECT *
FROM (
    SELECT *
    FROM employees
    ORDER BY salary DESC
    )
WHERE ROWNUM <= 5;

-- 급여순으로 페이징 처리 ( 10개씩 잘라서 조회하기)
SELECT page, employee_id, first_name, salary
FROM (
    SELECT CEIL(ROWNUM / 10) page,
    employee_id,
    first_name,
    salary
        FROM (
              SELECT ROWNUM,
              employee_id,
              first_name,
              salary
                FROM employees
                ORDER BY salary DESC)
                )
WHERE page = 2;
--참고로 mySQL, MariaDB인 경우
--위와 같음
SELECT page, employee_id, first_name, salary
FROM employees
LIMIT 1, 10;