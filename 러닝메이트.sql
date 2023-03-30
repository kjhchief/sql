SELECT *
FROM members;

DROP TABLE members;

--제약조건 조회
SELECT * 
FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'members';

--제약조건 비활성화
ALTER TABLE members
  DISABLE CONSTRAINT members_id_pk CASCADE
  DISABLE CONSTRAINT members_phonenum_uk;
  
ALTER TABLE members
  ENABLE CONSTRAINT members_id_pk 
  ENABLE CONSTRAINT members_phonenum_uk;

INSERT INTO members
VALUES ('kjh', '김재훈', '0000', 'M', SYSDATE,'010-0000-1111', '서울', '일반회원', '일반계정', 36, 10, 10, 10);

CREATE TABLE members (
	member_id	VARCHAR2(20)		NOT NULL,
	name	VARCHAR2(30)		NOT NULL,
	password	VARCHAR2(20)		NOT NULL,
	gender	VARCHAR2(10)		NOT NULL,
	birthdate	DATE	DEFAULT SYSDATE	NOT NULL,
	phone_number	VARCHAR2(20)		NOT NULL,
	myarea	VARCHAR2(20)		NOT NULL,
	member_class	VARCHAR2(20)		NOT NULL,
	kakaoacc_yn	VARCHAR2(20)		NOT NULL,
	rating_temp	NUMBER(7)		NOT NULL,
	comment_count	NUMBER(7)		NULL,
	join_count	NUMBER(7)		NULL,
	host_count	NUMBER(7)		NULL
);

-- 제약조건 추가
ALTER TABLE members
  ADD ( CONSTRAINT members_id_pk   PRIMARY KEY(member_id),
        CONSTRAINT members_phonenum_uk  UNIQUE (phone_number));



DROP TABLE crew;

CREATE TABLE crew (
	crew_id	VARCHAR2(20)		NOT NULL,
	title	VARCHAR2(30)		NOT NULL,
	crewdate	VARCHAR2(20)		NOT NULL,
	member_count	NUMBER(7)		NOT NULL,
	crew_location	VARCHAR2(20)		NOT NULL,
	level	CHAR(2)		NOT NULL,
	course_leng	NUMBER(7)		NOT NULL,
	course_intro	VARCHAR2(50)		NULL,
	weather_intro	VARCHAR2(50)		NULL,
	etc_intro	VARCHAR2(50)		NULL,
	description	VARCHAR2(4000)		NOT NULL,
	awaiter_count	NUMBER(7)		NOT NULL
);

DROP TABLE faq;

CREATE TABLE faq (
	faq_id	VARCHAR2(20)		NOT NULL,
	category	VARCHAR2(20)		NULL,
	faq_title	VARCHAR2(30)		NOT NULL,
	faq_content	VARCHAR2(300)		NOT NULL,
	faq_date	DATE		NOT NULL,
	member_id	VARCHAR2(20)		NOT NULL
);

DROP TABLE notice;

CREATE TABLE notice (
	notice_id	VARCHAR2(20)		NOT NULL,
	title	VARCHAR2(30)		NOT NULL,
	content	VARCHAR2(4000)		NOT NULL,
	notice_date	DATE		NOT NULL,
	Field	NUMBER(7)		NULL,
	member_id	VARCHAR2(20)		NOT NULL
);

DROP TABLE location;

CREATE TABLE location (
	location_id	VARCHAR2(20)		NOT NULL,
	adress	VARCHAR2(20)		NOT NULL,
	longitude	VARCHAR2(20)		NOT NULL,
	latitude	VARCHAR2(20)		NOT NULL,
	crew_id	VARCHAR2(20)		NOT NULL
);

DROP TABLE review;

CREATE TABLE review (
	review_id	VARCHAR2(20)		NOT NULL,
	author	VARCHAR2(20)		NOT NULL,
	content	VARCHAR2(4000)		NOT NULL,
	writedate	DATE		NOT NULL,
	member_id	VARCHAR2(20)		NOT NULL
);

DROP TABLE comment;

CREATE TABLE comment (
	comment_id	VARCHAR2(20)		NOT NULL,
	content	VARCHAR2(4000)		NOT NULL,
	notice_id	VARCHAR2(20)		NOT NULL,
	member_id	VARCHAR2(20)		NOT NULL
);

DROP TABLE crewlist;

CREATE TABLE crewlist (
	crewlist_id	VARCHAR2(20)		NOT NULL,
	types	VARCHAR2(10)		NOT NULL,
	member_id	VARCHAR2(20)		NOT NULL,
	crew_id	VARCHAR2(20)		NOT NULL
);

DROP TABLE photo;

CREATE TABLE photo (
	photo_id	VARCHAR2(20)		NOT NULL,
	name	VARCHAR2(20)		NOT NULL,
	type	VARCHAR2(20)		NOT NULL,
	crew_id	VARCHAR2(20)		NOT NULL
);
