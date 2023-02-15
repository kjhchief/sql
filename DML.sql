DESC departments;
-- INSERT
-- 부서테이블에 행 추가
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES(7777, '교육부', 100, 1000);
-- 모든 컬럼 입력시 컬럼명은 생략 가능
INSERT INTO departments
VALUES(7777, '교육부', 100, 1000);
--특정 컬럼만 입력시
INSERT INTO departments(department_id, department_name)
VALUES(8888, '영업부');

-- 오라클이 지원하는 시퀸스 객체를 이용한 부서번호 자동 생성
INSERT INTO departments(department_id, department_name)
VALUES(departments_seq.nextval, '개발팀');

--딕셔너리에서 시퀸스 목록 조회
SELECT *
FROM user_sequences;

--서브쿼리 활용을 위해 테이블 구조만 복사하여 생성
CREATE TABLE emp2 AS
 SELECT *
 FROM employees
 WHERE 1 != 1;

SELECT * FROM emp2;

INSERT INTO emp2
 SELECT * -- 요게 서브쿼리
 FROM employees;

SELECT *
FROM departments;

SELECT table_name
FROM user_tables
WHERE table_name = 'EMP';

-- employees 테이블에 제약조건 보기.
SELECT *
FROM user_constraints
WHERE table_name = 'EMPLOYEES';
--딕셔너리 조회
SELECT *
FROM user_sequences;

-- UPDATE
UPDATE employees
SET department_id = 30
WHERE employee_id = 127;

COMMIT;

SELECT *
FROM employees
WHERE employee_id = 127;

UPDATE employees
SET salary = salary * 1.1
WHERE employee_id = 127;

UPDATE employees;
--SET hire_date = SYSDATE;

-- 테이블 모든 행 삭제
DELETE FROM employees ;
-- 사원번호에 일치하는 행 삭제
DELETE FROM employees
WHERE employee_id = 127 ;
-- 와일드카드 검색하여 행 삭제
DELETE FROM departments
WHERE department_name LIKE '%부';
-- 서브퀄리 활용하여 삭제
DELETE FROM emp
WHERE salary > (
        SELECT AVG(salary)
        FROM emp
        );

COMMIT; --저장
ROLLBACK; --저장 취소

--employee테이블에 자기 정보를 입력하세요
DESC employees;

SELECT *
FROM employees;

SELECT *
FROM user_constraints
WHERE table_name = 'EMPLOYEES';

SELECT *
FROM user_sequences;

SELECT *
FROM jobs;

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (employees_seq.nextval, 'Jae hoon', 'Kim', 'kjhchief@naver.com', '010.2000.1111', TO_DATE('2023/02/12', 'YYYY/MM/DD'), 'IT_PROG', 20000, 0.1, NULL, 60);