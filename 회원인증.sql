drop table member;

CREATE TABLE member (
    member_id    VARCHAR2(10),
    password     VARCHAR2(10) NOT NULL,
    name         VARCHAR2(30) NOT NULL,
    email        VARCHAR2(30) ,
    age          NUMBER(3)    NOT NULL,
    regdate      DATE DEFAULT SYSDATE
);

ALTER TABLE member
    ADD ( CONSTRAINT member_id_pk    PRIMARY KEY(member_id),
          CONSTRAINT member_email_uk UNIQUE(email));
          

commit;

-- 테스트를 위한 가상 데이터 입력
insert into member
values('kjh', '1111', '김재훈', 'kjh@gmail.com', 34, SYSDATE); 

insert into member
values('park', '1121', '박지성', 'jisung@gmail.com', 32, SYSDATE);

insert into member
values('son', '2111', '손흥민', 'son@gmail.com', 29, SYSDATE);

select *
FROM member;

-- 회원 인증 쿼리
SELECT member_id, name, email, age, regdate
FROM member
WHERE member_id='kjh' AND password ='1111';

-- 회원 전체 목록
SELECT member_id, name, email, age, regdate
FROM member
ORDER BY regdate DESC;

SELECT member_id, name, email, age, regdate
FROM member
WHERE member_id ='kjh';