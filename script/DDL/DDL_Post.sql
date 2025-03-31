DROP TABLE announcement_comment;
DROP TABLE bulletin_comment;
DROP TABLE qna_comment;
DROP TABLE qna_post_header;
DROP TABLE announcement_post;
DROP TABLE bulletin_post;
DROP TABLE qna_post;
DROP TABLE announcement_post_header;
DROP TABLE bulletin_post_header;





-- 시퀀스 생성
CREATE SEQUENCE seq_qna_post_no START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_bulletin_post_no START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_announcement_post_no START WITH 1 INCREMENT BY 1 NOCACHE;







-- Q&A 게시판 말머리
CREATE TABLE qna_post_header(
    qna_post_header_no NUMBER NOT NULL,
    qna_post_header_name VARCHAR2(50) NOT NULL,

    constraint PK_qna_post_header_no primary key (qna_post_header_no)
);

-- 자유 게시판 말머리
CREATE TABLE bulletin_post_header(
    bulletin_post_header_no NUMBER NOT NULL,
    bulletin_post_header_name VARCHAR2(50) NOT NULL,

    constraint PK_bulletin_post_header_no primary key (bulletin_post_header_no)
);

-- 공지사항 말머리
CREATE TABLE announcement_post_header(
    announcement_post_header_no NUMBER NOT NULL,
    announcement_post_header_name VARCHAR2(50) NOT NULL,

    constraint PK_announcement_post_header_no primary key(announcement_post_header_no)
);

-- Q&A 게시글
CREATE TABLE qna_post(
    qna_post_no NUMBER NOT NULL,
    qna_post_subject VARCHAR2(100) NOT NULL,
    qna_post_content VARCHAR2(3000) NOT NULL,
    private_check NUMBER DEFAULT 0 NOT NULL check ( private_check IN (0, 1) ) ,
    qna_post_recommend NUMBER NOT NULL,
    qna_post_decommend NUMBER NOT NULL,
    post_record_cnt NUMBER NOT NULL,
    regdate DATE NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    qna_post_header_no NUMBER NOT NULL,


    CONSTRAINT PK_qna_post_no PRIMARY KEY (qna_post_no),
    CONSTRAINT FK_qna_post_creator_id FOREIGN KEY (creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_qna_post_header_no FOREIGN KEY (qna_post_header_no) REFERENCES qna_post_header(qna_post_header_no)
);

-- 자유게시판 게시글
CREATE TABLE bulletin_post(
    bulletin_post_no NUMBER NOT NULL,
    bulletin_post_subject VARCHAR2(100) NOT NULL,
    bulletin_post_content VARCHAR2(3000) NOT NULL,
    private_check NUMBER DEFAULT 0 NOT NULL check ( private_check IN (0, 1) ) ,
    bulletin_post_recommend NUMBER NOT NULL,
    bulletin_post_decommend NUMBER NOT NULL,
    post_record_cnt NUMBER NOT NULL,
    regdate DATE NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    bulletin_post_header_no NUMBER NOT NULL,
    
    CONSTRAINT PK_bulletin_post_no PRIMARY KEY (bulletin_post_no),
    CONSTRAINT FK_bulletin_post_creator_id FOREIGN KEY (creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_bulletin_post_header_no FOREIGN KEY (bulletin_post_header_no) REFERENCES bulletin_post_header(bulletin_post_header_no)
);

-- 공지사항 게시글
CREATE TABLE announcement_post(
    announcement_post_no NUMBER NOT NULL,
    announcement_post_subject VARCHAR2(100) NOT NULL,
    announcement_post_content VARCHAR2(3000) NOT NULL,
    private_check NUMBER DEFAULT 0 NOT NULL check ( private_check IN (0, 1) ) ,
    announcement_post_recommend NUMBER NOT NULL,
    announcement_post_decommend NUMBER NOT NULL,
    post_record_cnt NUMBER NOT NULL,
    regdate DATE NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    announcement_post_header_no NUMBER NOT NULL,

    CONSTRAINT PK_announcement_post_no PRIMARY KEY (announcement_post_no),
    CONSTRAINT FK_announcement_post_creator_id FOREIGN KEY (creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_announcement_post_header_no FOREIGN KEY (announcement_post_header_no) REFERENCES announcement_post_header(announcement_post_header_no)
);


-- Q&A 댓글
CREATE TABLE qna_comment(
    qna_comment_no NUMBER NOT NULL,
    qna_comment_content VARCHAR2(300) NOT NULL,
    regdate DATE NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    qna_post_no NUMBER NOT NULL,

    CONSTRAINT PK_qna_comment_no PRIMARY KEY (qna_comment_no),
    CONSTRAINT FK_qna_comment_creator_id FOREIGN KEY (creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_qna_comment_qna_post_no FOREIGN KEY (qna_post_no) REFERENCES qna_post(qna_post_no)
);

-- 자유게시판 댓글
CREATE TABLE bulletin_comment(
    bulletin_comment_no NUMBER NOT NULL,
    bulletin_comment_content VARCHAR2(300) NOT NULL,
    regdate DATE NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    bulletin_post_no NUMBER NOT NULL,

    CONSTRAINT PK_bulletin_comment_no PRIMARY KEY (bulletin_comment_no),
    CONSTRAINT FK_bulletin_comment_creator_id FOREIGN KEY (creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_bulletin_comment_bulletin_post_no FOREIGN KEY (bulletin_post_no) REFERENCES bulletin_post(bulletin_post_no)
);

-- 공지사항 댓글
CREATE TABLE announcement_comment(
    announcement_comment_no NUMBER NOT NULL,
    announcement_comment_content VARCHAR2(300) NOT NULL,
    regdate DATE NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    announcement_post_no NUMBER NOT NULL,

    CONSTRAINT PK_announcement_comment_no PRIMARY KEY (announcement_comment_no),
    CONSTRAINT FK_announcement_comment_creator_id FOREIGN KEY (creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_announcement_comment_announcement_post_no FOREIGN KEY (announcement_post_no) REFERENCES announcement_post(announcement_post_no)

);


commit;





-- Q&A 게시글 + 말머리
--CREATE TABLE qna_post_header_group(
--    qna_post_no NUMBER NOT NULL,
--    qna_post_header_no NUMBER NOT NULL,
--
--    CONSTRAINT FK_qna_post_no FOREIGN KEY (qna_post_no) REFERENCES qna_post(qna_post_no),
--    CONSTRAINT FK_qna_post_header_no FOREIGN KEY (qna_post_header_no) REFERENCES qna_post_header(qna_post_header_no)
--);

-- 자유 게시판 + 말머리
--CREATE TABLE bulletin_post_header_group(
--    bulletin_post_no NUMBER NOT NULL,
--    bulletin_post_header_no NUMBER NOT NULL,
--
--    CONSTRAINT FK_bulletin_post_no FOREIGN KEY (bulletin_post_no) REFERENCES bulletin_post(bulletin_post_no),
--    CONSTRAINT FK_bulletin_post_header_no FOREIGN KEY (bulletin_post_header_no) REFERENCES bulletin_post_header(bulletin_post_header_no)
--);

-- 공지사항 게시글 + 말머리
--CREATE TABLE announcement_post_header_group(
--    announcement_post_no NUMBER NOT NULL,
--    announcement_post_header_no NUMBER NOT NULL,
--
--    CONSTRAINT FK_announcement_post_no FOREIGN KEY (announcement_post_no) REFERENCES announcement_post(announcement_post_no),
--    CONSTRAINT FK_announcement_post_header_no FOREIGN KEY (announcement_post_header_no) REFERENCES announcement_post_header(announcement_post_header_no)
--);