CREATE TABLE student
(
  student_no NUMBER(4) NOT NULL,
  name VARCHAR2(20),
  age NUMBER(4),
  phone VARCHAR2(20),
  address VARCHAR2(100),
  memo VARCHAR2(200)
);
-- ����Ÿ �߰�
INSERT INTO student
  (student_no, name, age, phone, address, memo)
VALUES
  (student_seq.nextval, 'ȫ�浿', 30, '010-1111-2222', '�Ѿ�', 'ȫ�浿�Դϴ�.');

-- ������ �˻�
select * from student;

CREATE SEQUENCE student_seq;