desc departments;
desc employees;

-- #1. 테이블 생성
-- 부서
CREATE TABLE department (
     dept_id      NUMBER(4),
     name         VARCHAR2(30)    NOT NULL,
     leader_id    NUMBER(6) 
  );

-- 임직원
CREATE TABLE employee (
     emp_id       NUMBER(6),
     name         VARCHAR2(30)   NOT NULL,
     hire_date    DATE                   DEFAULT   SYSDATE,
     gender       CHAR(1),
     position    VARCHAR2(10)     NOT NULL,
     salary         NUMBER(10,2)     NOT NULL,
     dept_id       NUMBER(4)
 );
 
 -- 프로젝트
CREATE TABLE project (
     proj_id       NUMBER(6),
     name         VARCHAR2(50)   NOT NULL,
     leader_id    NUMBER(6), 
     start_date   DATE                  NOT NULL,
     end_date   DATE                   NOT NULL
);

-- 사원별 프로젝트 참여 히스토리
CREATE TABLE works_project (
     emp_id       NUMBER(6),
     proj_id        NUMBER(6)
);

-- #2. 테이블 제약조건 추가
-- 부서 제약조건
 ALTER TABLE department
    ADD CONSTRAINT department_id_pk              PRIMARY KEY(dept_id);

ALTER TABLE department
    ADD   CONSTRAINT dept_leader_id_fk    FOREIGN KEY(leader_id)  REFERENCES employee(emp_id);

-- 사원 제약조건
ALTER TABLE employee
    ADD ( CONSTRAINT emp_id_pk              PRIMARY KEY(emp_id),
              CONSTRAINT emp_gender_ck      CHECK (gender IN('M', 'F')),
              CONSTRAINT emp_position_ck     CHECK (position IN('PM', 'PL', 'PE', 'QA')),
              CONSTRAINT emp_dept_id_fk      FOREIGN KEY(dept_id)  REFERENCES department(dept_id));

-- 프로젝트 제약조건
ALTER TABLE project
    ADD ( CONSTRAINT proj_id_pk              PRIMARY KEY(proj_id),
              CONSTRAINT proj_leader_id_fk    FOREIGN KEY(leader_id)  REFERENCES employee(emp_id));

-- 사원별 프로젝트 제약조건
ALTER TABLE works_project
    ADD ( CONSTRAINT works_proj_id_pk            PRIMARY KEY(emp_id, proj_id),
              CONSTRAINT works_proj_emp_id_fk     FOREIGN KEY(emp_id)  REFERENCES employee(emp_id) ON DELETE CASCADE,
              CONSTRAINT works_proj_proj_id_fk      FOREIGN KEY(proj_id)   REFERENCES project(proj_id) ON DELETE CASCADE);

select * from employees;

-- #3. 테이블 별 시퀀스 생성
CREATE SEQUENCE department_seq
    START WITH 10
    INCREMENT BY 10;

CREATE SEQUENCE employee_seq
    START WITH 1000
    INCREMENT BY 1;    
    
CREATE SEQUENCE project_seq
    START WITH 100
    INCREMENT BY 1;  

-- #4. 테이블 별 가상 데이터 입력
INSERT INTO employee (emp_id, name, hire_date, gender, position, salary)
VALUES (employee_seq.NEXTVAL, '김기정', TO_DATE('1987-03-13', 'YYYY-MM-DD'), 'M', 'PM', 10000000);

INSERT INTO employee (emp_id, name, hire_date, gender, position, salary)
VALUES (employee_seq.NEXTVAL, '김재훈', TO_DATE('2022-10-22', 'YYYY-MM-DD'), 'M', 'PL', 7000000);

INSERT INTO employee (emp_id, name, hire_date, gender, position, salary)
VALUES (employee_seq.NEXTVAL, '송진호', TO_DATE('2022-10-22', 'YYYY-MM-DD'), 'M', 'PE', 5000000);

INSERT INTO employee (emp_id, name, hire_date, gender, position, salary)
VALUES  (employee_seq.NEXTVAL, '김성욱', TO_DATE('2022-10-22', 'YYYY-MM-DD'), 'M', 'QA', 5000000);

INSERT INTO employee (emp_id, name, hire_date, gender, position, salary)
VALUES (employee_seq.NEXTVAL, '김현아', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'F', 'PM', 10000000);

SELECT * FROM employee;

INSERT INTO department (dept_id, name, leader_id)
VALUES (department_seq.NEXTVAL, 'Development', 1000);

INSERT INTO department (dept_id, name, leader_id)
VALUES (department_seq.NEXTVAL, 'Design', 1004);

SELECT * FROM department;

INSERT INTO project (proj_id, name, leader_id, start_date, end_date)
VALUES (project_seq.NEXTVAL, '쥑이는 서버 프로젝트', 1000, TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2001-12-31', 'YYYY-MM-DD'));

INSERT INTO project (proj_id, name, leader_id, start_date, end_date)
VALUES (project_seq.NEXTVAL, '더 쥑이는 서버 프로젝트', 1000, TO_DATE('2005-01-01', 'YYYY-MM-DD'), TO_DATE('2005-12-31', 'YYYY-MM-DD'));

INSERT INTO project (proj_id, name, leader_id, start_date, end_date)
VALUES (project_seq.NEXTVAL, '더더 쥑이는 서버 프로젝트', 1000, TO_DATE('2007-01-01', 'YYYY-MM-DD'), TO_DATE('2007-12-31', 'YYYY-MM-DD'));

SELECT * FROM project;

INSERT INTO works_project (emp_id, proj_id)
VALUES (1000, 100);

INSERT INTO works_project (emp_id, proj_id)
VALUES (1000, 102);

INSERT INTO works_project (emp_id, proj_id)
VALUES (1001, 100);

INSERT INTO works_project (emp_id, proj_id)
VALUES (1001, 101);

-- 사원번호가 100인 임직원이 참여한 프로젝트 정보를 조회하고 싶다.
SELECT p.proj_id, p.name, p.start_date, p.end_date
FROM project p
WHERE p.proj_id IN(
                    SELECT w.proj_id
                    FROM works_project w
                    WHERE w.emp_id = 1000
                    --WHERE w.emp_id IN (1000, 1001)
                );
                
-- 이름이 김기정인 임직원이 참여한 프로젝트 정보를 조회하고 싶다.
SELECT p.proj_id, p.name, p.start_date, p.end_date
FROM project p
WHERE p.proj_id IN(
                    SELECT w.proj_id
                    FROM works_project w
                    WHERE w.emp_id = (
                                        SELECT e.emp_id
                                        FROM employee e
                                        WHERE e.name = '김기정'
                                )
                );




  