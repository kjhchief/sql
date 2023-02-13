-- sql 한 줄 주석
/* 여러줄 주석 */
SELECT *
FROM employees;

-- group by
SELECT department_id
FROM employees
GROUP by department_id;

-- UNION 연산자 테스트를 위해 기존 테이블 복사
CREATE TABLE emp AS
 SELECT *
 FROM employees;
 
 SELECT *
 FROM emp;
 
-- UNION 연산자
SELECT * 
FROM employees
UNION SELECT * 
FROM emp;

-- UNION ALL 연산자
SELECT * 
FROM employees
UNION ALL
SELECT *
FROM emp; 

-- MINUS 연산자
SELECT * 
FROM employees
MINUS
SELECT *
FROM emp;

--INTERSECT 연산자
SELECT * 
FROM employees
INTERSECT
SELECT *
FROM emp;
