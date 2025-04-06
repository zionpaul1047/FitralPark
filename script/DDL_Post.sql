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

CREATE TABLE bulletin_vote_record (
    bulletin_vote_record_no NUMBER,
    member_id VARCHAR2(50) NOT NULL,
    vote_check NUMBER NOT NULL check ( vote_check IN (0, 1) ),
    regdate DATE NOT NULL,
    bulletin_post_no NUMBER NOT NULL,

    CONSTRAINT PK_bulletin_vote_record_no PRIMARY KEY (bulletin_vote_record_no),
    CONSTRAINT FK_vote_record_bulletin_post_no FOREIGN KEY (bulletin_post_no) REFERENCES bulletin_post(bulletin_post_no),
    CONSTRAINT FK_vote_record_member_id FOREIGN KEY (member_id) REFERENCES member(member_id)
);

CREATE TABLE announcement_vote_record (
    announcement_vote_record_no NUMBER,
    member_id VARCHAR2(50) NOT NULL,
    vote_check NUMBER NOT NULL check ( vote_check IN (0, 1) ),
    regdate DATE NOT NULL,
    announcement_post_no NUMBER NOT NULL,

    CONSTRAINT PK_announcement_vote_record_no PRIMARY KEY (announcement_vote_record_no),
    CONSTRAINT FK_vote_record_announcement_post_no FOREIGN KEY (announcement_post_no) REFERENCES announcement_post(announcement_post_no),
    CONSTRAINT FK_vote_record_announcement_member_id FOREIGN KEY (member_id) REFERENCES member(member_id)
);

CREATE TABLE qna_vote_record (
    qna_vote_record_no NUMBER,
    member_id VARCHAR2(50) NOT NULL,
    vote_check NUMBER NOT NULL check ( vote_check IN (0, 1) ),
    regdate DATE NOT NULL,
    qna_post_no NUMBER NOT NULL,

    CONSTRAINT PK_qna_vote_record_no PRIMARY KEY (qna_vote_record_no),
    CONSTRAINT FK_vote_record_qna_post_no FOREIGN KEY (qna_post_no) REFERENCES qna_post(qna_post_no),
    CONSTRAINT FK_vote_record_qna_member_id FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- 자유게시판 게시글 작성 시 커뮤니티 점수 증가 트리거
CREATE OR REPLACE TRIGGER trg_bulletin_post_score
AFTER INSERT ON bulletin_post
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score + 2
    WHERE member_id = :NEW.creator_id;
END;
/

-- Q&A 게시글 작성 시 커뮤니티 점수 증가 트리거
CREATE OR REPLACE TRIGGER trg_qna_post_score
AFTER INSERT ON qna_post
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score + 2
    WHERE member_id = :NEW.creator_id;
END;
/

-- 공지사항 게시글 작성 시 커뮤니티 점수 증가 트리거
CREATE OR REPLACE TRIGGER trg_announcement_post_score
AFTER INSERT ON announcement_post
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score + 2
    WHERE member_id = :NEW.creator_id;
END;
/

-- 자유게시판 댓글 작성 시 커뮤니티 점수 증가 트리거
CREATE OR REPLACE TRIGGER trg_bulletin_comment_score
AFTER INSERT ON bulletin_comment
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score + 1
    WHERE member_id = :NEW.creator_id;
END;
/

-- Q&A 댓글 작성 시 커뮤니티 점수 증가 트리거
CREATE OR REPLACE TRIGGER trg_qna_comment_score
AFTER INSERT ON qna_comment
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score + 1
    WHERE member_id = :NEW.creator_id;
END;
/

-- 공지사항 댓글 작성 시 커뮤니티 점수 증가 트리거
CREATE OR REPLACE TRIGGER trg_announcement_comment_score
AFTER INSERT ON announcement_comment
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score + 1
    WHERE member_id = :NEW.creator_id;
END;
/

-- 자유게시판 게시글 삭제 시 커뮤니티 점수 감소 트리거
CREATE OR REPLACE TRIGGER trg_bulletin_post_delete_score
AFTER DELETE ON bulletin_post
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score - 2
    WHERE member_id = :OLD.creator_id;
END;
/

-- Q&A 게시글 삭제 시 커뮤니티 점수 감소 트리거
CREATE OR REPLACE TRIGGER trg_qna_post_delete_score
AFTER DELETE ON qna_post
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score - 2
    WHERE member_id = :OLD.creator_id;
END;
/

-- 공지사항 게시글 삭제 시 커뮤니티 점수 감소 트리거
CREATE OR REPLACE TRIGGER trg_announcement_post_delete_score
AFTER DELETE ON announcement_post
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score - 2
    WHERE member_id = :OLD.creator_id;
END;
/

-- 자유게시판 댓글 삭제 시 커뮤니티 점수 감소 트리거
CREATE OR REPLACE TRIGGER trg_bulletin_comment_delete_score
AFTER DELETE ON bulletin_comment
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score - 1
    WHERE member_id = :OLD.creator_id;
END;
/

-- Q&A 댓글 삭제 시 커뮤니티 점수 감소 트리거
CREATE OR REPLACE TRIGGER trg_qna_comment_delete_score
AFTER DELETE ON qna_comment
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score - 1
    WHERE member_id = :OLD.creator_id;
END;
/

-- 공지사항 댓글 삭제 시 커뮤니티 점수 감소 트리거
CREATE OR REPLACE TRIGGER trg_announcement_comment_delete_score
AFTER DELETE ON announcement_comment
FOR EACH ROW
BEGIN
    UPDATE member
    SET community_score = community_score - 1
    WHERE member_id = :OLD.creator_id;
END;
/

-- 자유게시판 트리거 신고 5회 이상 시 삭제
CREATE OR REPLACE TRIGGER delete_free_post_on_report
AFTER UPDATE OF post_record_cnt ON bulletin_post
FOR EACH ROW
WHEN (NEW.post_record_cnt >= 5)
BEGIN
    -- 먼저 관련 댓글 삭제
    DELETE FROM bulletin_comment WHERE bulletin_post_no = :NEW.bulletin_post_no;
    -- 그 다음 게시글 삭제
    DELETE FROM bulletin_post WHERE bulletin_post_no = :NEW.bulletin_post_no;
END;
/

-- Q&A 게시판 트리거 신고 5회 이상 시 삭제
CREATE OR REPLACE TRIGGER delete_qna_post_on_report
AFTER UPDATE OF post_record_cnt ON qna_post
FOR EACH ROW
WHEN (NEW.post_record_cnt >= 5)
BEGIN
    -- 먼저 관련 댓글 삭제
    DELETE FROM qna_comment WHERE qna_post_no = :NEW.qna_post_no;
    -- 그 다음 게시글 삭제
    DELETE FROM qna_post WHERE qna_post_no = :NEW.qna_post_no;
END;
/

CREATE OR REPLACE TRIGGER reset_scores_on_report
AFTER UPDATE OF report_cnt ON member
FOR EACH ROW
WHEN (NEW.report_cnt >= 10)
BEGIN
    -- 해당 회원의 모든 점수를 0으로 초기화
    UPDATE member 
    SET community_score = 0,
        fitness_score = 0
    WHERE member_id = :NEW.member_id;
END;
/


commit;

ALTER TABLE member ADD report_cnt NUMBER DEFAULT 0 NOT NULL;

UPDATE bulletin_post SET post_record_cnt = 0; 
UPDATE qna_post SET post_record_cnt = 0; 
UPDATE announcement_post SET post_record_cnt = 0; 



ALTER TABLE bulletin_post modify views default 0 NOT NULL; 
alter table bulletin_post modify bulletin_post_recommend default 0;
alter table bulletin_post modify bulletin_post_decommend default 0;
alter table bulletin_post modify POST_RECORD_CNT default 0;




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

