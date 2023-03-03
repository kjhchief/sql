CREATE TABLE member
(
  id VARCHAR2(10) PRIMARY KEY,
  name VARCHAR2(30) NOT NULL,
  age NUMBER(3) NOT NULL,
  address VARCHAR2(60)
);

INSERT INTO member
  (id, name, age, address)
VALUES
('blue', '�̼���', 40, '��õ��');
('sky', '������', 30, '�λ��');
('dragon', '�ڹ���', 40, '�����');

SELECT id, name, age, address
FROM member
WHERE name LIKE '%��%';