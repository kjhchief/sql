DROP TABLE person;

-- 테이블 생성 시 컬럼레벨에서 제약조건 추가 (비권장)
CREATE TABLE person(
                                  --내가 추가한 제약조건 이름
    ssn        CHAR(13) CONSTRAINT person_ssn_pk PRIMARY KEY,
    name       VARCHAR2(20) NOT NULL,-- 'CONSTRAINT person_ssn_nn' 생략
    age        NUMBER(3) CONSTRAINT person_age_ck CHECK(age BETWEEN 1 AND 150),
    hire_date  DATE DEFAULT SYSDATE,
    manager_id NUMBER(6) CONSTRAINT person_mg_fk REFERENCES employees(employee_id),
    telephone  VARCHAR2(20) CONSTRAINT person_telephone_uk UNIQUE,
    gender     CHAR(1) CONSTRAINT person_gender_ck CHECK(gender IN('M', 'F'))
    );
    
SELECT *
FROM user_tables;

SELECT *
FROM user_constraints
WHERE table_name = 'PERSON';

desc departments;

-- 테이블 생성과 제약조건 분리 (권장)
CREATE TABLE sawon(
               
    ssn        CHAR(13),
    name       VARCHAR2(20) NOT NULL,
    age        NUMBER(3),
    hire_date  DATE DEFAULT SYSDATE,
    telephone  VARCHAR2(20),
    gender     CHAR(1),
    dept_id    NUMBER(4)
    
    );
/* 생성된 테이블에 제약조건 추가 */
ALTER TABLE sawon
ADD ( 
    CONSTRAINT sawon_ssn_pk PRIMARY KEY(ssn),
    CONSTRAINT sawon_age_ck CHECK(age BETWEEN 1 AND 150),
    CONSTRAINT sawon_telephone_uk UNIQUE(telephone),
    CONSTRAINT sawon_gender_ck CHECK (gender IN('M', 'F')),
    CONSTRAINT sawon_dept_id_fk FOREIGN KEY(dept_id) REFERENCES departments(department_id)
    );
    -- ON DELETE CASCADE
    -- PK를 가지고 있는 부모테이블의 행을 삭제하면 FK로 연결된 자식테이블의 행도 삭제하는 옵션

--테스트를 위한 사원정보 입력
desc sawon;

SELECT *
FROM user_constraints
WHERE table_name = 'SAWON';

SELECT *
FROM user_sequences; --sawon 테이블은 딕셔너리가 없다.

INSERT INTO sawon(ssn, name, age, hire_date, telephone, gender, dept_id)
VALUES(1,'김후니', 34, '23/02/15', '010-2222-3243', 'M', 10);

/* #3. 개발자들의 개발 편의를 위한 제약조건 비활성화/활성화 */
ALTER TABLE sawon
    DISABLE CONSTRAINT sawon_ssn_pk CASCADE
    DISABLE CONSTRAINT sawon_age_ck
    DISABLE CONSTRAINT sawon_telephone_uk
    DISABLE CONSTRAINT sawon_gender_ck
    DISABLE CONSTRAINT sawon_dept_id_fk;
    
DELETE FROM sawon;

commit;
    
    ALTER TABLE sawon
    ENABLE CONSTRAINT sawon_ssn_pk 
    ENABLE CONSTRAINT sawon_age_ck
    ENABLE CONSTRAINT sawon_telephone_uk
    ENABLE CONSTRAINT sawon_gender_ck
    ENABLE CONSTRAINT sawon_dept_id_fk;
    
DROP TABLE sawon CASCADE CONSTRAINTS;

RENAME EMP3 TO EMP2;

