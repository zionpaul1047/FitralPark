-- 말머리 DML

-- 자유게시판 말머리
INSERT INTO bulletin_post_header (bulletin_post_header_no, bulletin_post_header_name) VALUES (1, '운동');
INSERT INTO bulletin_post_header (bulletin_post_header_no, bulletin_post_header_name) VALUES (2, '식단');
INSERT INTO bulletin_post_header (bulletin_post_header_no, bulletin_post_header_name) VALUES (3, '헬스장');
INSERT INTO bulletin_post_header (bulletin_post_header_no, bulletin_post_header_name) VALUES (4, '후기');

-- 공지사항 말머리
INSERT INTO announcement_post_header (announcement_post_header_no, announcement_post_header_name) VALUES (1, '공지사항');
INSERT INTO announcement_post_header (announcement_post_header_no, announcement_post_header_name) VALUES (2, '업데이트');
INSERT INTO announcement_post_header (announcement_post_header_no, announcement_post_header_name) VALUES (3, '이벤트');
INSERT INTO announcement_post_header (announcement_post_header_no, announcement_post_header_name) VALUES (4, '점검');

-- Q&A 말머리
INSERT INTO qna_post_header (qna_post_header_no, qna_post_header_name) VALUES (1, '운동');
INSERT INTO qna_post_header (qna_post_header_no, qna_post_header_name) VALUES (2, '식단');
INSERT INTO qna_post_header (qna_post_header_no, qna_post_header_name) VALUES (3, '헬스장');


select * from bulletin_post_header;
select * from announcement_post_header;

select bulletin_post_subject, 
        (select member_nickname from member where creator_id = member.member_id) as member_nickname, 
        creator_id, to_char(regdate, 'yyyy-mm-dd') as regdate, 
        bulletin_post_recommend, 
        post_record_cnt from bulletin_post order by bulletin_post_no desc;

commit;