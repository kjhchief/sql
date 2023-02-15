DROP TABLE person;

CREATE TABLE person(
                            --���� �߰��� �������� �̸�
    ssn CHAR(13) CONSTRAINT person_ssn_pk PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,-- 'CONSTRAINT person_ssn_nn' ����
    age NUMBER(3) CONSTRAINT person_age_ck CHECK(age BETWEEN 1 AND 150),
    hire_date DATE DEFAULT SYSDATE,
    manager_id NUMBER(6) CONSTRAINT person_mg_fk REFERENCES employees(employee_id),
    telephone VARCHAR2(20) CONSTRAINT person_telephone_uk UNIQUE,
    gender CHAR(1) CONSTRAINT person_gender_ck CHECK(gender IN('M', 'F'))
    );
    
SELECT *
FROM user_tables;

SELECT *
FROM user_constraints
WHERE table_name = 'PERSON';