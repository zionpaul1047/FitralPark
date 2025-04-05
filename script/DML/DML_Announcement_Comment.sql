-- 공지사항 댓글 시퀀스 생성
CREATE SEQUENCE seq_announcement_comment_no START WITH 1 INCREMENT BY 1 NOCACHE;

-- 공지사항 댓글 더미 데이터 생성
-- 공지사항 1번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '시스템 점검 일정 확인했습니다.', SYSDATE, 'user1', 1);
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '알려주셔서 감사합니다.', SYSDATE, 'user2', 1);

-- 공지사항 2번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '이벤트 참여하고 싶습니다!', SYSDATE, 'user3', 2);
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '좋은 이벤트네요.', SYSDATE, 'user4', 2);

-- 공지사항 3번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '주의사항 잘 읽어보겠습니다.', SYSDATE, 'user1', 3);

-- 공지사항 4번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '변경사항 확인했습니다.', SYSDATE, 'user2', 4);

-- 공지사항 5번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '이용약관 변경 확인했습니다.', SYSDATE, 'user3', 5);

-- 공지사항 6번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '새로운 기능 기대됩니다!', SYSDATE, 'user4', 6);
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '업데이트 감사합니다.', SYSDATE, 'user1', 6);

-- 공지사항 7번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '주의하도록 하겠습니다.', SYSDATE, 'user2', 7);

-- 공지사항 8번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '확인했습니다.', SYSDATE, 'user3', 8);

-- 공지사항 9번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '축하드립니다!', SYSDATE, 'user4', 9);
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '다음에는 저도 당첨되고 싶네요.', SYSDATE, 'user1', 9);

-- 공지사항 10번에 대한 댓글
INSERT INTO announcement_comment (announcement_comment_no, announcement_comment_content, regdate, creator_id, announcement_post_no) 
VALUES (seq_announcement_comment_no.NEXTVAL, '규칙 잘 지키도록 하겠습니다.', SYSDATE, 'user2', 10);

commit; 