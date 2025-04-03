--회원정보 DML

INSERT INTO member (
    member_no, member_id, pw, member_pic, background_pic, member_nickname, 
    member_name, personalnumber, allergy, tel, email, address, 
    fitness_score, community_score, restrict_check, withdraw_check, 
    mentor_check, admin_check, plan_public_check
) VALUES 
(seqMember.NEXTVAL, 'user1', 'pass123', NULL, NULL, '운동하는사람1', '김철수', '9001011234567', 
 '땅콩', '010-1234-5678', 'user1@naver.com', '서울시 강남구', 
 100, 50, 0, 0, 0, 0, 1);

INSERT INTO member (
    member_no, member_id, pw, member_pic, background_pic, member_nickname, 
    member_name, personalnumber, allergy, tel, email, address, 
    fitness_score, community_score, restrict_check, withdraw_check, 
    mentor_check, admin_check, plan_public_check
) VALUES 
(seqmember.NEXTVAL, 'user2', 'pass456', NULL, NULL, '운동하는사람2', '이영희', '9505052345678', 
 NULL, '010-2345-6789', 'user2@daum.net', '서울시 서초구', 
 80, 30, 0, 0, 0, 0, 1);
 
 INSERT INTO member (
    member_no, member_id, pw, member_pic, background_pic, member_nickname, 
    member_name, personalnumber, allergy, tel, email, address, 
    fitness_score, community_score, restrict_check, withdraw_check, 
    mentor_check, admin_check, plan_public_check
) VALUES 
(seqmember.NEXTVAL, 'user3', 'pass789', NULL, NULL, '무말랭이', '김진혁', '9505051345678', 
 NULL, '010-2345-6789', 'user3@daum.net', '서울시 서초구', 
 80, 30, 0, 0, 0, 0, 1);

INSERT INTO member (
    member_no, member_id, pw, member_pic, background_pic, member_nickname, 
    member_name, personalnumber, allergy, tel, email, address, 
    fitness_score, community_score, restrict_check, withdraw_check, 
    mentor_check, admin_check, plan_public_check
) VALUES 
(seqMember.NEXTVAL, 'mentor1', 'mentor123', NULL, NULL, '운동하는사람3', '박지민', '8808083456789', 
 '우유', '010-3456-7890', 'mentor1@gmail.com', '서울시 마포구', 
 120, 70, 0, 0, 1, 0, 1);

INSERT INTO member (
    member_no, member_id, pw, member_pic, background_pic, member_nickname, 
    member_name, personalnumber, allergy, tel, email, address, 
    fitness_score, community_score, restrict_check, withdraw_check, 
    mentor_check, admin_check, plan_public_check
) VALUES 
(seqmember.NEXTVAL, 'admin1', 'admin123', NULL, NULL, '운동관리자', '최관리', '8505054567890', 
 NULL, '010-4567-8901', 'admin1@fitralpark.com', '서울시 종로구', 
 200, 100, 0, 0, 1, 1, 1);

INSERT INTO member (
    member_no, member_id, pw, member_pic, background_pic, member_nickname, 
    member_name, personalnumber, allergy, tel, email, address, 
    fitness_score, community_score, restrict_check, withdraw_check, 
    mentor_check, admin_check, plan_public_check
) VALUES 
(seqmember.NEXTVAL, 'user4', 'pass012', NULL, NULL, '운동하는사람4', '정수진', '9202025678901', 
 '계란', '010-5678-9012', 'user4@naver.com', '서울시 송파구', 
 60, 20, 0, 0, 0, 0, 0);

commit;

