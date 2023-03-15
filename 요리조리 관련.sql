--#1. 회원 테이블 생성(구조만)
drop table member;

CREATE TABLE member (
    member_id    VARCHAR2(20),
    password     VARCHAR2(20) NOT NULL,
    name         VARCHAR2(30) NOT NULL,
    email        VARCHAR2(30) ,
    age          NUMBER(3)    NOT NULL,
    regdate      DATE DEFAULT SYSDATE
);


--#2. 제약조건 추가
ALTER TABLE member
  ADD ( CONSTRAINT member_id_pk   PRIMARY KEY(member_id),
        CONSTRAINT member_email_uk  UNIQUE (email));

--#3. 개발의 편의성을 위해 제약조건 비활성화
ALTER TABLE member
  DISABLE CONSTRAINT member_id_pk CASCADE
  DISABLE CONSTRAINT member_email_uk;

ALTER TABLE member
  ENABLE CONSTRAINT member_id_pk
  ENABLE CONSTRAINT member_email_uk;     

-- 회원 등록 테스트
INSERT INTO member(member_id, password, name, email, age)
VALUES ('bangry', '1111', '김기정', 'bangry@gmail.com', 30);

INSERT INTO member(member_id, password, name, email, age)
VALUES ('gildong', '1111', '홍길돌', 'gildong@gmail.com', 20);

COMMIT;

-- 전체 회원 조회 테스트
SELECT member_id, name, email, TO_CHAR(regdate, 'yyyy-MM-DD') regdate
FROM member
ORDER BY regdate DESC;

-- 아이디로 회원 조회(상세)
SELECT member_id, name, email, TO_CHAR(regdate, 'yyyy-MM-DD HH24:MI:SS') regdate, age
FROM member
WHERE member_id = 'bangry';

-- 아이디/비밀번호로 회원 조회(로그인)
SELECT member_id, name, email, TO_CHAR(regdate, 'yyyy-MM-DD HH24:MI:SS') regdate, age
FROM member
WHERE member_id = 'bangry' AND password = '1111';

-- 검색값에 따른 회원목록 조회
SELECT member_id, name, email, TO_CHAR(regdate, 'yyyy-MM-DD') regdate
FROM member
WHERE member_id = 'bangry' OR name LIKE '%길%';

        
-- 사용자 선택페이지 및 화면에 보여지는 목록개수 설정에 따른 사용자 목록 반환(페이징 처리)
SELECT member_id, name, password, email, regdate
FROM ( SELECT CEIL(ROWNUM / 10) page, member_id, name, password, email, regdate
       FROM   ( SELECT member_id, name, password, email, TO_CHAR(regdate, 'YYYY-MM-DD DAY') regdate
                FROM member
                ORDER  BY regdate DESC))
WHERE  page = 1;

-- 사용자 선택페이지, 조회 목록개수, 검색값에 따른 사용자 목록 반환(검색값에 따른 페이징 처리)
SELECT member_id, name, password, email, regdate
FROM ( SELECT CEIL(ROWNUM / 10) page, member_id, name, password, email, regdate
       FROM   ( SELECT member_id, name, password, email, TO_CHAR(regdate, 'YYYY-MM-DD DAY') regdate
                FROM member
                WHERE member_id = 'bangry' OR name LIKE '%길%'
                ORDER  BY regdate DESC))
WHERE  page = 1;

-- 전체 회원수 조회
SELECT COUNT(*) count
FROM member;

-- 검색값에 따른 회원수 조회 - 페이징 처리 시 필요
SELECT COUNT(*) count
FROM   member
WHERE member_id = 'bangry' OR name LIKE '%길%';

--------------------------------------------------------------------

--#1. cookbook(요리책) 테이블 생성
CREATE TABLE cookbook (
  book_id     NUMBER(7),
  name        VARCHAR2(30)  NOT NULL,
  describe    VARCHAR2(200),
  author_id   VARCHAR2(20)
);

--#2. recipe(조리법) 테이블 생성
CREATE TABLE recipe (
  recipe_id      NUMBER(7),
  book_id        NUMBER(7),
  name           VARCHAR2(30)  NOT NULL,
  time           NUMBER(3),
  levels         NUMBER(1),
  ingredients    VARCHAR2(300),
  img_file_type  VARCHAR2(30),
  img_file_name  VARCHAR2(30),
  writer_id      VARCHAR2(20)
);


--#3. recipe_procedure(조리법의 조리절차) 테이블 생성
CREATE TABLE recipe_procedure (
  recipe_id      NUMBER(7),
  seq_num        NUMBER(2),
  procedure      VARCHAR2(300) NOT NULL 
);

--#4.제약조건 추가
ALTER TABLE cookbook
  ADD ( CONSTRAINT cookbook_id_pk PRIMARY KEY(book_id),
        CONSTRAINT cookbook_author_id_fk FOREIGN KEY(author_id)  REFERENCES member(member_id));

ALTER TABLE recipe
  ADD ( CONSTRAINT recipe_id_pk          PRIMARY KEY(recipe_id),
        CONSTRAINT recipe_book_id_fk     FOREIGN KEY(book_id)    REFERENCES cookbook(book_id),
        CONSTRAINT recipe_writer_id_fk   FOREIGN KEY(writer_id)  REFERENCES member(member_id) );

ALTER TABLE recipe_procedure
  ADD ( CONSTRAINT recipe_id_fk          FOREIGN KEY(recipe_id)  REFERENCES recipe(recipe_id),
        CONSTRAINT recipe_id_seqnum_pk   PRIMARY KEY(recipe_id, seq_num) );

--#5. cookbook 시퀀스 생성
CREATE SEQUENCE cookbook_seq
START WITH 100
INCREMENT BY 10; 

--#6. 테스트 등록
INSERT INTO cookbook (book_id, name, describe, author_id)
VALUES (cookbook_seq.NEXTVAL, '한식매니아', '한식요리를 맛있게 만드는 방법을 설명합니다',  'bangry');

INSERT INTO cookbook (book_id, name, describe, author_id)
VALUES (cookbook_seq.NEXTVAL, '중식매니아', '중식요리를 맛있게 만드는 방법을 설명합니다',  'gildong');

commit;

-- 요리책 목록 조회(조인)
SELECT c.book_id book_id, c.name book_name, c.describe book_desc, m.name author_name 
FROM cookbook c
    JOIN member m
        ON c.author_id = m.member_id
ORDER BY book_id DESC;

SELECT *
FROM cookbook 
ORDER BY book_id;









