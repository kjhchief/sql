-- 게시판 db만들기

drop table board;

CREATE TABLE board(
board_idx number (4) primary key,
board_name varchar2(20),
board_title varchar2(100),
board_content varchar2(300),
board_date date default sysdate,
board_hit number (4) default 0
);

drop sequence board_seq;
create sequence board_seq;

insert into board (board_idx, board_name, board_title, board_content, board_date)
values (board_seq. nextval, '홍길동', '글 제목1', '글 내용1', sysdate);
insert into board (board_idx, board_name, board_title, board_content, board_date)
values (board_seq.nextval,'변사또','글 제목2', '글내용2', sysdate);
insert into board (board_idx, board_name, board_title, board_content, board_date)
values (board_seq.nextval,' 사임당', '글 제목3',  '글 내용3', sysdate);

SELECT *
FROM board;