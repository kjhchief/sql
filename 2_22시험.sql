CREATE TABLE student
(
  student_no NUMBER(4) NOT NULL,
  name VARCHAR2(20),
  age NUMBER(4),
  phone VARCHAR2(20),
  address VARCHAR2(100),
  memo VARCHAR2(200)
);
-- 데이타 추가
INSERT INTO student
  (student_no, name, age, phone, address, memo)
VALUES
  (student_seq.nextval, '홍길동', 30, '010-1111-2222', '한양', '홍길동입니다.');

-- 데이터 검색
select * from student;

CREATE SEQUENCE student_seq;