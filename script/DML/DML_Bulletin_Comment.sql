-- 자유게시판 댓글 시퀀스 생성
CREATE SEQUENCE seq_bulletin_comment_no START WITH 1 INCREMENT BY 1 NOCACHE;

-- 자유게시판 댓글 더미 데이터 생성
-- 게시글 20번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '저도 이 운동 시작한지 얼마 안됐는데 효과가 정말 좋더라구요!', SYSDATE, 'user1', 20);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '꾸준히 하는게 중요한 것 같아요. 화이팅하세요!', SYSDATE, 'user2', 20);

-- 게시글 21번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '운동 파트너 구하시나요? 저도 관심있습니다!', SYSDATE, 'user3', 21);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '저도 같이하고 싶네요. 연락주세요~', SYSDATE, 'user4', 21);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '혹시 아직 자리 있나요?', SYSDATE, 'user1', 21);

-- 게시글 22번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '이 운동복 저도 써봤는데 정말 좋아요!', SYSDATE, 'user2', 22);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '가격대비 만족도가 높네요.', SYSDATE, 'user3', 22);

-- 게시글 23번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '운동 루틴 공유 감사합니다! 많은 도움이 되네요.', SYSDATE, 'user4', 23);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '저도 이 방법으로 해볼게요!', SYSDATE, 'user1', 23);

-- 게시글 24번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '식단 관리가 정말 중요한 것 같아요.', SYSDATE, 'user2', 24);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '좋은 정보 감사합니다!', SYSDATE, 'user3', 24);

-- 게시글 25번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '이 헬스장 저도 다니는데 시설 정말 좋아요!', SYSDATE, 'user4', 25);

-- 게시글 26번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '운동하면서 힘들었던 점 공감됩니다.', SYSDATE, 'user1', 26);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '포기하지 마세요! 함께 힘내봐요~', SYSDATE, 'user2', 26);

-- 게시글 27번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '운동 영상 추천 감사합니다!', SYSDATE, 'user3', 27);

-- 게시글 28번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '목표 달성하셨다니 축하드려요!', SYSDATE, 'user4', 28);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '정말 대단하십니다. 저도 열심히 해야겠어요.', SYSDATE, 'user1', 28);

-- 게시글 29번에 대한 댓글
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '운동 초보자에게 좋은 조언이네요!', SYSDATE, 'user2', 29);
INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_comment_content, regdate, creator_id, bulletin_post_no) 
VALUES (seq_bulletin_comment_no.NEXTVAL, '저도 처음에 이런 실수 많이 했었어요.', SYSDATE, 'user3', 29);

commit; 