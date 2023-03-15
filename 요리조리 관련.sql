--#1. ȸ�� ���̺� ����(������)
drop table member;

CREATE TABLE member (
    member_id    VARCHAR2(20),
    password     VARCHAR2(20) NOT NULL,
    name         VARCHAR2(30) NOT NULL,
    email        VARCHAR2(30) ,
    age          NUMBER(3)    NOT NULL,
    regdate      DATE DEFAULT SYSDATE
);


--#2. �������� �߰�
ALTER TABLE member
  ADD ( CONSTRAINT member_id_pk   PRIMARY KEY(member_id),
        CONSTRAINT member_email_uk  UNIQUE (email));

--#3. ������ ���Ǽ��� ���� �������� ��Ȱ��ȭ
ALTER TABLE member
  DISABLE CONSTRAINT member_id_pk CASCADE
  DISABLE CONSTRAINT member_email_uk;

ALTER TABLE member
  ENABLE CONSTRAINT member_id_pk
  ENABLE CONSTRAINT member_email_uk;     

-- ȸ�� ��� �׽�Ʈ
INSERT INTO member(member_id, password, name, email, age)
VALUES ('bangry', '1111', '�����', 'bangry@gmail.com', 30);

INSERT INTO member(member_id, password, name, email, age)
VALUES ('gildong', '1111', 'ȫ�浹', 'gildong@gmail.com', 20);

COMMIT;

-- ��ü ȸ�� ��ȸ �׽�Ʈ
SELECT member_id, name, email, TO_CHAR(regdate, 'yyyy-MM-DD') regdate
FROM member
ORDER BY regdate DESC;

-- ���̵�� ȸ�� ��ȸ(��)
SELECT member_id, name, email, TO_CHAR(regdate, 'yyyy-MM-DD HH24:MI:SS') regdate, age
FROM member
WHERE member_id = 'bangry';

-- ���̵�/��й�ȣ�� ȸ�� ��ȸ(�α���)
SELECT member_id, name, email, TO_CHAR(regdate, 'yyyy-MM-DD HH24:MI:SS') regdate, age
FROM member
WHERE member_id = 'bangry' AND password = '1111';

-- �˻����� ���� ȸ����� ��ȸ
SELECT member_id, name, email, TO_CHAR(regdate, 'yyyy-MM-DD') regdate
FROM member
WHERE member_id = 'bangry' OR name LIKE '%��%';

        
-- ����� ���������� �� ȭ�鿡 �������� ��ϰ��� ������ ���� ����� ��� ��ȯ(����¡ ó��)
SELECT member_id, name, password, email, regdate
FROM ( SELECT CEIL(ROWNUM / 10) page, member_id, name, password, email, regdate
       FROM   ( SELECT member_id, name, password, email, TO_CHAR(regdate, 'YYYY-MM-DD DAY') regdate
                FROM member
                ORDER  BY regdate DESC))
WHERE  page = 1;

-- ����� ����������, ��ȸ ��ϰ���, �˻����� ���� ����� ��� ��ȯ(�˻����� ���� ����¡ ó��)
SELECT member_id, name, password, email, regdate
FROM ( SELECT CEIL(ROWNUM / 10) page, member_id, name, password, email, regdate
       FROM   ( SELECT member_id, name, password, email, TO_CHAR(regdate, 'YYYY-MM-DD DAY') regdate
                FROM member
                WHERE member_id = 'bangry' OR name LIKE '%��%'
                ORDER  BY regdate DESC))
WHERE  page = 1;

-- ��ü ȸ���� ��ȸ
SELECT COUNT(*) count
FROM member;

-- �˻����� ���� ȸ���� ��ȸ - ����¡ ó�� �� �ʿ�
SELECT COUNT(*) count
FROM   member
WHERE member_id = 'bangry' OR name LIKE '%��%';

--------------------------------------------------------------------

--#1. cookbook(�丮å) ���̺� ����
CREATE TABLE cookbook (
  book_id     NUMBER(7),
  name        VARCHAR2(30)  NOT NULL,
  describe    VARCHAR2(200),
  author_id   VARCHAR2(20)
);

--#2. recipe(������) ���̺� ����
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


--#3. recipe_procedure(�������� ��������) ���̺� ����
CREATE TABLE recipe_procedure (
  recipe_id      NUMBER(7),
  seq_num        NUMBER(2),
  procedure      VARCHAR2(300) NOT NULL 
);

--#4.�������� �߰�
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

--#5. cookbook ������ ����
CREATE SEQUENCE cookbook_seq
START WITH 100
INCREMENT BY 10; 

--#6. �׽�Ʈ ���
INSERT INTO cookbook (book_id, name, describe, author_id)
VALUES (cookbook_seq.NEXTVAL, '�ѽĸŴϾ�', '�ѽĿ丮�� ���ְ� ����� ����� �����մϴ�',  'bangry');

INSERT INTO cookbook (book_id, name, describe, author_id)
VALUES (cookbook_seq.NEXTVAL, '�߽ĸŴϾ�', '�߽Ŀ丮�� ���ְ� ����� ����� �����մϴ�',  'gildong');

commit;

-- �丮å ��� ��ȸ(����)
SELECT c.book_id book_id, c.name book_name, c.describe book_desc, m.name author_name 
FROM cookbook c
    JOIN member m
        ON c.author_id = m.member_id
ORDER BY book_id DESC;

SELECT *
FROM cookbook 
ORDER BY book_id;









