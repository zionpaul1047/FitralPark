-- 초기화 버튼 조심해서 사용
-- DROP TABLE member CASCADE CONSTRAINTS;
----------------------------------------------

DROP TABLE menu_bookmark;
DROP TABLE menu;
DROP TABLE setting;
DROP TABLE member_goal;
DROP TABLE member_physical;
DROP TABLE member_class;
DROP TABLE member;
DROP TABLE score_record;
DROP TABLE class;





-- 회원 > notnull 유무 erd 반영 필요
CREATE TABLE member (
	member_no       NUMBER        NOT NULL, -- 회원번호
	member_id              VARCHAR2(50)  NOT NULL, -- 회원 id
	pw              VARCHAR2(20)   NOT NULL,     -- pw
	member_pic      VARCHAR2(3000) NULL,     -- 프로필 사진
    background_pic  VARCHAR2(3000) NULL,    -- 배경 사진
	member_nickname VARCHAR2(50)   NOT NULL,     -- 닉네임
	member_name     VARCHAR2(50)  NOT NULL,     -- 이름
	personalnumber  VARCHAR2(13)   NOT NULL,     -- 주민등록번호
	allergy         VARCHAR2(50)  NULL,     -- 알레르기 성분
	tel             VARCHAR2(30)   NOT NULL,     -- 연락처
	email           VARCHAR2(40)   NOT NULL,     -- email
	address         VARCHAR2(200)  NULL,     -- 주소
	fitness_score   NUMBER        default 0     NOT NULL,     -- 운동 점수
	community_score NUMBER        default 0     NOT NULL,     -- 커뮤니티 점수
	restrict_check  NUMBER        default 0     NOT NULL check ( restrict_check IN (0, 1) ),     -- 활동제한여부
	withdraw_check  NUMBER        default 0     NOT NULL check ( withdraw_check IN (0, 1) ),     -- 탈퇴 유무
	mentor_check    NUMBER        default 0     NOT NULL check ( mentor_check IN (0, 1) ),     -- 멘토 유무
	admin_check     NUMBER        default 0     NOT NULL check ( admin_check IN (0, 1) ),      -- 관리자 유무
    plan_public_check NUMBER      DEFAULT 0     NOT NULL check ( plan_public_check IN (0, 1) ), -- 계획 공개 여부
   
    constraint PK_member primary key (member_no),
    constraint UK_member_id unique(member_id)
);

-- 회원 등급 테이블
create table class (
    class_no NUMBER NOT NULL,
    class_name VARCHAR2(50) NOT NULL,
    
    constraint PK_class primary key(class_no)
);


-- 회원 + 등급 관계 테이블
create table member_class (
    class_no NUMBER NOT NULL,
    member_id VARCHAR2(50) NOT NULL,
    
    constraint FK_class_no FOREIGN KEY (class_no) REFERENCES class(class_no),
    constraint FK_member_class_id FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- 점수 기록 테이블
CREATE TABLE score_record(
    score_record_no NUMBER NOT NULL,
    regdate DATE NOT NULL,
    operation_check NUMBER NOT NULL check ( operation_check IN (0, 1) ),
    type_check NUMBER NOT NULL check ( type_check IN (0, 1) ),
    score NUMBER DEFAULT 0 NOT NULL,
    member_id VARCHAR2(50) NOT NULL,
    
    constraint FK_score_record_id FOREIGN KEY (member_id) REFERENCES member(member_id)
);


-- 회원신체정보
CREATE TABLE member_physical(
    member_physical_no NUMBER NOT NULL,
    regdate DATE NOT NULL,
    height NUMBER(4, 1) NOT NULL,
    weight NUMBER(4, 1) NOT NULL,
    member_id VARCHAR2(50) NOT NULL,
    
    constraint PK_member_physical primary key (member_physical_no),
    constraint FK_member_physical_id FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- 나의 목표 정보
CREATE TABLE member_goal(
    member_goal_no NUMBER NOT NULL,
    goal_weight NUMBER(4, 1) NOT NULL,
    goal_fitness_cnt NUMBER NOT NULL,
    regdate DATE NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    member_id VARCHAR2(50) NOT NULL,

    constraint PK_member_goal primary key (member_goal_no),
    constraint FK_member_goal_id FOREIGN KEY (member_id) REFERENCES member(member_id)
);


-- 설정 세팅
CREATE TABLE setting(
    setting_no NUMBER NOT NULL,
    setting_name VARCHAR2(50) NOT NULL,
    setting_check NUMBER NOT NULL,
    member_id VARCHAR2(50) NOT NULL,

    constraint PK_setting_no primary key (setting_no),
    constraint FK_setting_id FOREIGN KEY (member_id) REFERENCES member(member_id)

);


drop table menu;


-- 메뉴
CREATE TABLE menu(
    menu_no NUMBER NOT NULL,
    menu_name VARCHAR2(50) NOT NULL,
    menu_level NUMBER NOT NULL,

    constraint PK_menu_no primary key (menu_no)
);



-- 자주찾는 서비스(메뉴 + 회원)
CREATE TABLE menu_bookmark(
    menu_bookmark_no NUMBER NOT NULL,
    menu_no NUMBER NOT NULL,
    member_id VARCHAR2(50) NOT NULL,

    constraint PK_menu_bookmark_no primary key (menu_bookmark_no),
    constraint FK_menu_bookmark_menu_no FOREIGN KEY (menu_no) REFERENCES menu(menu_no),
    constraint FK_menu_bookmark_id FOREIGN KEY (member_id) REFERENCES member(member_id)
);

commit;

ALTER TABLE routine_exercise modify exercise_creation_type NUMBER DEFAULT 1;
ALTER TABLE routine add views number default 1;
ALTER TABLE qna_post add views number default 1;
ALTER TABLE announcement_post add views number default 1;
ALTER TABLE bulletin_post add views number default 1;
ALTER TABLE diet add views number default 1;
ALTER TABLE routine_exercise modify custom_exercise_no NUMBER NULL;
ALTER TABLE routine_exercise modify exercise_no NUMBER NULL;
ALTER TABLE routine add recommend NUMBER DEFAULT 0;
ALTER TABLE routine add disrecommend NUMBER DEFAULT 0;
ALTER TABLE diet add recommend NUMBER DEFAULT 0;
ALTER TABLE diet add disrecommend NUMBER DEFAULT 0;
ALTER TABLE qna_post add recommend NUMBER DEFAULT 0;
ALTER TABLE qna_post add disrecommend NUMBER DEFAULT 0;
ALTER TABLE announcement_post add recommend NUMBER DEFAULT 0;
ALTER TABLE announcement_post add disrecommend NUMBER DEFAULT 0;
ALTER TABLE bulletin_post add recommend NUMBER DEFAULT 0;
ALTER TABLE bulletin_post add disrecommend NUMBER DEFAULT 0;

create sequence seq_weight_unit;
create sequence seq_routine;
create sequence seq_excercise_part;
create sequence seq_excercise_category;
create sequence seq_routine_category;
create sequence seq_exercise;
create sequence seq_exercise_category_group;
create sequence seq_member;
CREATE SEQUENCE seq_exercise_part_link;
CREATE SEQUENCE seq_routine_exercise;
create sequence seq_custom_exercise;
