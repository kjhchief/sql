SELECT *
FROM user_sequences;
CREATE SEQUENCE emphooni_seq;
CREATE SEQUENCE depthooni_seq
START WITH 100
INCREMENT BY 10;

CREATE TABLE department(
    dept_id NUMBER(4),
    name VARCHAR2(20) NOT NULL,
    leader_id NUMBER(6)
);
ALTER TABLE department
ADD(
--    CONSTRAINT department_dept_id_pk PRIMARY KEY(dept_id)
    CONSTRAINT department_leader_id_fk FOREIGN KEY(leader_id) REFERENCES employee(emp_id)

); 
SELECT *
FROM user_constraints
WHERE table_name = 'DEPARTMENT';
DROP TABLE department CASCADE CONSTRAINTS;
INSERT INTO department(dept_id, name, leader_id)
VALUES(depthooni_seq.nextval, '그런부', 1);

CREATE TABLE employee(
    emp_id NUMBER(6),
    name VARCHAR2(20) NOT NULL,
    hire_date DATE DEFAULT SYSDATE,
    gender CHAR(1),
    position CHAR(13),
    salary NUMBER(8), 
    dept_id NUMBER(4)
);
ALTER TABLE employee
ADD(
    CONSTRAINT employee_emp_id_pk PRIMARY KEY(emp_id),
    CONSTRAINT employee_gender_ck CHECK (gender IN('M', 'F')),
    CONSTRAINT employee_salary_ck CHECK (salary > 0),
    CONSTRAINT employee_dept_id_fk FOREIGN KEY(dept_id) REFERENCES department(dept_id)
    
);
SELECT *
FROM user_constraints
WHERE table_name = 'EMPLOYEE';
DROP TABLE employee CASCADE CONSTRAINTS;
INSERT INTO employee
VALUES(emphooni_seq.nextval, '김바보', '23/02/11','M','good',100000, 100);

CREATE TABLE project(
    proj_id NUMBER(4),
    name VARCHAR2(20) NOT NULL,
    leader_id NUMBER(6),
    start_date DATE,
    end_date DATE
);
ALTER TABLE project
ADD(
    CONSTRAINT project_proj_id_pk PRIMARY KEY(proj_id),
    CONSTRAINT project_leader_id_fk FOREIGN KEY(leader_id) REFERENCES employee(emp_id)
    
);
SELECT *
FROM user_constraints
WHERE table_name = 'PROJECT';
DROP TABLE project CASCADE CONSTRAINTS;

CREATE TABLE works_project(
    emp_id NUMBER(4),
    proj_id NUMBER(4)
);
ALTER TABLE works_project
ADD(
    CONSTRAINT employee_emp_proj_id_pk PRIMARY KEY(emp_id, proj_id),
    CONSTRAINT works_proj_emp_id_fk FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    CONSTRAINT works_proj_proj_id_fk FOREIGN KEY(proj_id) REFERENCES project(proj_id) ON DELETE CASCADE

);
SELECT *
FROM user_constraints
WHERE table_name = 'WORKS_PROJECT';
DESC works_project;
DROP TABLE works_project CASCADE CONSTRAINTS;