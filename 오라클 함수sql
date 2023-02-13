-- 단일행 함수
SELECT employee_id, CONCAT('김기정','선생님')
from employees;
-- 문자열 관련 함수
SELECT CONCAT('Oracle', 'Java Developer')
FROM dual;

SELECT *
from dual;

desc dual;

SELECT INITCAP('kim ki jung')
FROM dual;

SELECT first_name, last_name
FROM employees
--WHERE first_name = 'James';
WHERE LOWER(first_name) = 'james';

SELECT UPPER('bangry')
FROM dual;

SELECT LPAD('DataBase', 20, '*')
FROM dual;

--게시판 제목 줄여서 보여주기
SELECT RPAD(SUBSTR('오늘은 즐거운 월요일은 화요일과 수요르레이히.', 1, 15), 30, '.')
FROM dual;

SELECT SUBSTR('Java Developer', 6, 9)
FROM dual;

SELECT SUBSTR('서울시가산동', 4)
FROM dual;

------------------------

SELECT first_name, LENGTH(first_name)
FROM employees;

SELECT REPLACE('기정바보', '바보', '최고')
FROM dual;

SELECT REPLACE('서울 시', ' ', '')
FROM dual;

--SELECT INSTR('DataBase', 'B')
SELECT INSTR('DataBase', 'a', 1, 2)
FROM dual;

--SELECT LTRIM(' JavaDeveloper')
SELECT LTRIM(' JavaDeveloper', ' ')
--SELECT LTRIM('JavaDeveloper', 'Java')
FROM dual;

--SELECT RTRIM('JavaDeveloper ')
--SELECT RTRIM('JavaDeveloper ', ' ')
SELECT RTRIM('JavaDeveloper', 'Developer')
FROM dual;

SELECT TRIM(' Java Developer ')
FROM dual;

-- 숫자 함수
SELECT ROUND(45.923), ROUND(45.923, 0), ROUND(45.923, 2), ROUND(45.923, -1)
FROM dual;

SELECT TRUNC(45.923), TRUNC(45.923, 0), TRUNC(45.923, 2), TRUNC(45.923, -1)
FROM dual;

SELECT CEIL(123.123)
FROM dual;

SELECT FLOOR(123.123)
FROM dual;

SELECT ABS(-500)
FROM dual;

SELECT POWER(5, 2), SQRT(5), SIN(30), COS(30), TAN(30)
FROM dual;

-- 최소값 반환
SELECT LEAST(10, 20, 30, 40)
FROM dual;

-- 최대값 반환
SELECT GREATEST(10, 20, 30, 40)
FROM dual;

---- 날짜 함수 ----
SELECT SYSDATE 
FROM dual;

-- DATE 타입에 연산 가능
SELECT SYSDATE - 1 "어제" , SYSDATE "오늘", SYSDATE + 1 "내일"
FROM dual;

-- 사원별 근무 일수 검색
SELECT first_name, hire_date, SYSDATE, CEIL(SYSDATE - hire_date) "근무일수"
FROM employees;

-- 사원별 근무 개월수 검색
SELECT first_name, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) "근무개월수"
FROM employees;

-- 특정개월수를 더한 날짜 반환
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 2) "오늘부터 2개월 후"
FROM dual;

-- 이번주 토요일 날짜
SELECT SYSDATE "오늘", NEXT_DAY(SYSDATE, 7) "이번주 토요일"
FROM dual;

-- 이번달 마지막 날짜
SELECT SYSDATE, LAST_DAY(SYSDATE) "이번달 마지막날"
FROM dual;

-- 형변환 함수
SELECT TO_CHAR(12345), TO_CHAR(12345.67)
FROM dual;

SELECT TO_CHAR(12345, '999,999'), TO_CHAR(12345.677, '999,999.99')
FROM dual;

SELECT TO_CHAR(12345, '000,000'), TO_CHAR(12345.677, '000,000.00')
FROM dual;

SELECT TO_CHAR(150, '$9999'), TO_CHAR(150, '$0000')
FROM dual;

SELECT TO_CHAR(150, 'S9999'), TO_CHAR(150, 'S0000')
FROM dual;

SELECT TO_CHAR(150, '9999MI'), TO_CHAR(-150, '9999MI')
FROM dual;

SELECT TO_CHAR(150, '9999EEEE'), TO_CHAR(150, '99999B')
FROM dual;

-------

SELECT TO_CHAR(150, 'RN'), TO_CHAR(150, 'rn')
FROM dual;

SELECT TO_CHAR(10, 'X'), TO_CHAR(10, 'x'), TO_CHAR(15, 'X')
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS DAY')
FROM dual;

SELECT first_name, hire_date, TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI')
FROM employees;

-- 입사년도가 2002년도인 사원들
SELECT first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'MM') = '03';

-- 숫자

SELECT TO_NUMBER('12345') + 1
FROM dual;

SELECT TO_NUMBER('12,345', '00,000') + 1
FROM dual;

SELECT TO_NUMBER('1000') + TO_NUMBER('2,000', '0,000') + 1
FROM dual;

-- 

SELECT TO_DATE('2021/12/31 18:45:23', 'YYYY/MM/DD HH24:MI:SS')
FROM dual;

SELECT first_name, hire_date
FROM employees
WHERE hire_date = TO_DATE('2003-06-17', 'YYYY-MM-DD');

SELECT first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY-MM-DD') = '2003-06-17';

SELECT first_name, hire_date
FROM employees
WHERE hire_date = TO_DATE(20030617, 'YYYY-MM-DD');

-- 일반함수(자주 쓰이는?)
-- NULL을 내가 원하는 값으로 변환해서 반환
SELECT NVL(NULL, 10) 
FROM dual;

SELECT 10 * NULL, 10*NVL(NULL, 1)
FROM dual;

SELECT first_name, salary, NVL(commission_pct, 0)
FROM employees;

SELECT first_name, 
       salary, 
       commission_pct, 
       ( salary + ( salary * commission_pct ) ) * 12 "연봉"
FROM employees;

SELECT first_name, salary, commission_pct, ( salary + ( salary * NVL(commission_pct, 0) ) ) * 12 "연봉"
FROM employees;

SELECT first_name, salary, NVL2(commission_pct, commission_pct, 0)
FROM employees;

SELECT first_name, salary, NVL2(TO_CHAR(commission_pct), TO_CHAR(commission_pct), '신입사원') "인센티브"
FROM employees;

--DECODE 함수
SELECT first_name, job_id,
DECODE(job_id, 'IT_PROG', '개발자',
'AC_MRG', '관리자',
'FI_ACCOUNT', '회계사',
'직원')
FROM employees;

-- 회사 직종별 급여 인상
SELECT first_name, job_id, salary,
       DECODE(job_id, 'IT_PROG', salary * 1.5,
       'AC_MRG', salary * 1.3,
       'AC_ASST', salary * 1.1, 
       salary) "인상급여"
FROM employees;

---- 그룹함수 ----
-- 전체 사원수(NULL은 포함 안됨)
SELECT COUNT(employee_id) FROM employees;

-- 전체 사원수(NULL 포함)
SELECT COUNT(*) FROM employees;

-- 커미션 받는 사원의 수
SELECT COUNT(commission_pct)
FROM employees;

SELECT COUNT(*) "전체사원수", COUNT(commission_pct) "커미션사원수"
FROM employees;

-- 급여 총액(NULL은 무시)
SELECT SUM(salary)
FROM employees;

-- 급여 평균(NULL은 무시)
SELECT AVG(salary)
FROM employees;

-- 커미션 평균
-- 35명에 대한 평균(107에 대한 평균이어야 함)
SELECT AVG(commission_pct)
FROM employees;

-- 커미션 평균
SELECT AVG(commission_pct), AVG(NVL(commission_pct, 0))
FROM employees;

-- 최대값, 최소값
SELECT MAX(salary), MIN(salary), MAX(commission_pct), MIN(NVL(commission_pct, 0))
FROM employees;

SELECT MAX(hire_date), MIN(hire_date), MAX(hire_date) - MIN(hire_date) "짬밥차"
FROM employees;

-- GROUP BY 절(특정 컬럼을 기준으로 그룹핑)
SELECT department_id
FROM employees
GROUP BY department_id;

-- 부서별 급여총액, 평균
SELECT department_id, SUM(salary), AVG(salary)
FROM employees
GROUP BY department_id;

-- HAVING 절(그룹에 대한 조건)
SELECT department_id, SUM(salary) sum, AVG(salary) avg
FROM employees
GROUP BY department_id
HAVING department_id IS NOT NULL
--HAVING department_id = 10
--ORDER BY department_id ;
ORDER BY avg ;

-- 
SELECT department_id, SUM(salary) sum, AVG(salary) avg
FROM employees
GROUP BY department_id
HAVING AVG(salary) >= 3000;

SELECT department_id, MAX(salary), MIN(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 20000;

SELECT hire_date, COUNT(*)
FROM employees
GROUP BY hire_date
ORDER BY hire_date;
--ORDER BY COUNT(*);