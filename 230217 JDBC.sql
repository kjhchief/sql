SELECT employee_id 
FROM employees;

INSERT INTO departments(department_id, department_name)
VALUES(departments_seq.NEXTVAL, '개발팀');

rollback;

select *
from user_sequences;

SELECT *
FROM departments;

UPDATE departments
SET location_id = 1000
WHERE department_id = 1;

DELETE FROM departments
WHERE department_id = 290;

SELECT department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name LIKE '%A%';

SELECT e.employee_id id, e.last_name lname, e.first_name fname, e.salary salary, e.hire_date hiredate, d.department_name dname
FROM employees e JOIN departments d
 ON e.employee_id = d.department_id
 WHERE e.employee_id = 100;
 
-- 계좌정보 저장을 위한 테이블 생성
CREATE table accounts(
  account_num  VARCHAR2(30) PRIMARY KEY,
  owner_name   VARCHAR2(20) NOT NULL,
  passwd       NUMBER(4) NOT NULL,
  rest_money   NUMBER(10) NOT NULL,
  borrow_money NUMBER(10) NOT NULL
  
);

SELECT COUNT(*)
FROM accounts;

INSERT INTO accounts
VALUES ('1111-2222-3333', '김재훈', 1111, 10000, 0);

SELECT *
FROM accounts;

SELECT account_num, owner_name, passwd, rest_money, borrow_money
FROM accounts
WHERE account_num LIKE '%111%';