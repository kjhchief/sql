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
('blue', '이순신', 40, '인천시');
('sky', '김윤신', 30, '부산시');
('dragon', '박문수', 40, '서울시');

SELECT id, name, age, address
FROM member
WHERE name LIKE '%신%';