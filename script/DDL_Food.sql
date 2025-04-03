DROP TABLE diet_feedback;
DROP TABLE intake_record;
DROP TABLE diet_plan;
DROP TABLE diet_bookmark;
DROP TABLE diet;
DROP TABLE diet_food_list;
DROP TABLE diet_category;
DROP TABLE custom_food_nutrient;
DROP TABLE custom_food;
DROP TABLE nutrient;
DROP TABLE food_bookmark;
DROP TABLE food;
DROP TABLE individual_diet_record_food_nutrient;


-- 개인 식단기록 영양 성분(2025.04.03 이전 기준)
CREATE TABLE individual_diet_record_food_nutrient(
    food_cd VARCHAR2(50),
    food_name VARCHAR2(200),
    foodLv4_name VARCHAR2(50),
    foodLv5_cd VARCHAR2(50),
    foodLv6_cd VARCHAR2(50),
    nut_con_str_qua VARCHAR2(50),
    enerc NUMBER(6, 2),
    water NUMBER(6, 2),
    protein NUMBER(6, 2),
    fatce NUMBER(6, 2),
    ash NUMBER(6, 2),
    chocdf NUMBER(6, 2),
    sugar NUMBER(6, 2),
    fibtg NUMBER(6, 2),
    ca NUMBER(6, 2),
    fe NUMBER(6, 2),
    p NUMBER(6, 2),
    k NUMBER(6, 2),
    na NUMBER(6, 2),
    vataRae NUMBER(6, 2),
    retinol NUMBER(6, 2),
    cartb NUMBER(6, 2),
    thia NUMBER(6, 2),
    ribf NUMBER(6, 2),
    nia NUMBER(6, 2),
    vitac NUMBER(6, 2),
    vitd NUMBER(6, 2),
    fasat NUMBER(6, 2),
    FATRN NUMBER(6, 2),
    chole NUMBER(6, 2),
    rest_name VARCHAR2(50),
    food_size VARCHAR2(50),

    CONSTRAINT PK_individual_diet_record_food_nutrient PRIMARY KEY(food_cd)
);
-- 개인 식단기록 영양 성분(2025.04.03 이후 컬럼명 변경 버전)
CREATE TABLE individual_diet_record_food_nutrient_new (
	food_cd          VARCHAR2(50)  NOT NULL, -- 식품코드
	food_name        VARCHAR2(200)  NULL,     -- 식품명
	foodLv4Nm        VARCHAR2(50) NULL,     -- 대표식품명
	foodLv5Cd        VARCHAR2(50)  NULL,     -- 식품중분류코드
	foodLv6Cd        VARCHAR2(50)  NULL,     -- 식품소분류코드
	nut_con_srtr_qua VARCHAR2(50)  NULL,     -- 영양성분함량기준량
	enerc            NUMBER(6,2)   NULL,     -- 에너지(칼로리)
	water            NUMBER(6,2)   NULL,     -- 수분
	prot             NUMBER(6,2)   NULL,     -- 단백질
	fatce            NUMBER(6,2)   NULL,     -- 지방
	ash              NUMBER(6,2)   NULL,     -- 회분
	chocdf           NUMBER(6,2)   NULL,     -- 탄수화물
	sugar            NUMBER(6,2)   NULL,     -- 당류
	fibtg            NUMBER(6,2)   NULL,     -- 식이섬유
	ca               NUMBER(6,2)   NULL,     -- 칼슘
	fe               NUMBER(6,2)   NULL,     -- 철
	p                NUMBER(6,2)   NULL,     -- 인
	k                NUMBER(6,2)   NULL,     -- 칼륨
	nat              NUMBER(6,2)   NULL,     -- 나트륨
	vitaRae          NUMBER(6,2)   NULL,     -- 비타민 A
	retol            NUMBER(6,2)   NULL,     -- 레티놀
	cartb            NUMBER(6,2)   NULL,     -- 베타카로틴
	thia             NUMBER(6,2)   NULL,     -- 비타민B1(티아민)
	ribf             NUMBER(6,2)   NULL,     -- 비타민B2(리보플라빈)
	nia              NUMBER(6,2)   NULL,     -- 비타민B3(니아신)
	vitc             NUMBER(6,2)   NULL,     -- 비타민C
	vitd             NUMBER(6,2)   NULL,     -- 비타민D
	fasat            NUMBER(6,2)   NULL,     -- 포화지방산
	fatrn            NUMBER(6,2)   NULL,     -- 트랜스지방산
	chole            NUMBER(6,2)   NULL,      -- 콜레스테롤
	rest_name        VARCHAR2(50)  NULL,     -- 업체명
	food_size        VARCHAR2(50)  NULL,     -- 식품중량
    CONSTRAINT PK_individual_diet_record_food_nutrient_new	PRIMARY KEY (food_cd)
);




-- 음식
CREATE TABLE food(
    food_no NUMBER NOT NULL,
    food_name VARCHAR2(50) NOT NULL,
    food_cd VARCHAR2(50) NOT NULL,

    CONSTRAINT PK_food PRIMARY KEY(food_no),
    CONSTRAINT FK_food_food_cd FOREIGN KEY(food_cd) REFERENCES individual_diet_record_food_nutrient
);


-- 음식 즐겨찾기(food + member)
create TABLE food_bookmark(
    food_bookmark_no NUMBER NOT NULL,
    food_no NUMBER NOT NULL,
    regdate DATE NOT NULL,
    member_id VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_food_bookmark PRIMARY KEY(food_bookmark_no),
    CONSTRAINT FK_food_bookmark_food_no FOREIGN KEY(food_no) REFERENCES food(food_no),
    CONSTRAINT FK_food_bookmark_member_id FOREIGN KEY(member_id) REFERENCES member(member_id)
    
);

-- 영양 성분(사용자정의)
CREATE TABLE nutrient(
    nutrient_cd VARCHAR2(50) NOT NULL,
    nutrient_name VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_nutrient PRIMARY KEY(nutrient_cd)
);

-- 사용자 정의 음식
CREATE TABLE custom_food(
    custom_food_no NUMBER NOT NULL,
    custom_food_name VARCHAR2(50) NOT NULL,
    kcal_per_unit NUMBER(6, 2),
    creater_id VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_custom_food PRIMARY KEY(custom_food_no),
    CONSTRAINT FK_custom_food_creater_id FOREIGN KEY(creater_id) REFERENCES member(member_id)

);


-- 사용자 정의 음식 + 영양 성분
CREATE TABLE custom_food_nutrient(
    custom_food_nutrient_no NUMBER NOT NULL,
    custom_food_no NUMBER NOT NULL,
    nutrient_cd VARCHAR2(50) NOT NULL,
    nutrient_content NUMBER(6,2) NOT NULL,
    
    CONSTRAINT PK_custom_food_nutrient PRIMARY KEY(custom_food_nutrient_no),
    CONSTRAINT FK_custom_food_nutrient_custom_food_no FOREIGN KEY(custom_food_no) REFERENCES custom_food(custom_food_no),
    CONSTRAINT FK_custom_food_nutrient_nutrient_cd FOREIGN KEY(nutrient_cd) REFERENCES nutrient(nutrient_cd)
    
);

-- 식단 카테고리
CREATE TABLE diet_category(
    diet_category_no NUMBER NOT NULL,
    diet_category_name VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_diet_category PRIMARY KEY(diet_category_no)
);

-- 식단 음식목록
CREATE TABLE diet_food_list(
    diet_food_list_no NUMBER NOT NULL,
    diet_no NUMBER NOT NULL,
    food_no NUMBER NULL,
    custom_food_no NUMBER NULL,
    public_check NUMBER NOT NULL CHECK (public_check IN (0, 1)),
    food_creation_type NUMBER NOT NULL CHECK (food_creation_type IN (0, 1)),
    intake NUMBER(6, 2) NOT NULL,
    
    CONSTRAINT PK_diet_food_list PRIMARY KEY(diet_food_list_no),
    CONSTRAINT FK_diet_food_list_custom_food_no FOREIGN KEY(custom_food_no) REFERENCES custom_food(custom_food_no),
    CONSTRAINT FK_diet_food_list_food_no FOREIGN KEY(food_no) REFERENCES food(food_no),
    CONSTRAINT FK_diet_food_list_diet_no FOREIGN KEY(diet_no) REFERENCES diet(diet_no)
);

-- 식단
CREATE TABLE diet(
    diet_no NUMBER NOT NULL,
    regdate DATE NOT NULL,
    diet_name VARCHAR2(50) NOT NULL,
    diet_total_kcal NUMBER(6, 2) NOT NULL,
    meal_classify VARCHAR2(10) NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    diet_category_no NUMBER NOT NULL,
    
    CONSTRAINT PK_diet PRIMARY KEY(diet_no),
    CONSTRAINT FK_diet_creator_id FOREIGN KEY(creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_diet_diet_category_no FOREIGN KEY(diet_category_no) REFERENCES diet_category(diet_category_no)
);

-- 식단 즐겨찾기
CREATE TABLE diet_bookmark(
    diet_bookmark_no NUMBER NOT NULL,
    member_id VARCHAR2(50) NOT NULL,
    regdate DATE NOT NULL,
    diet_no NUMBER NOT NULL,
    
    CONSTRAINT PK_diet_bookmark PRIMARY KEY(diet_bookmark_no),
    CONSTRAINT FK_diet_bookmark_member_id FOREIGN KEY(member_id) REFERENCES member(member_id),
    CONSTRAINT FK_diet_bookmark_diet_no FOREIGN KEY(diet_no) REFERENCES diet(diet_no)
);


-- 식단 계획
CREATE TABLE diet_plan(
    diet_plan_no NUMBER NOT NULL,
    regdate DATE NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    diet_no NUMBER NOT NULL,
    
    CONSTRAINT PK_diet_plan PRIMARY KEY(diet_plan_no),
    CONSTRAINT FK_diet_plan_creator_id FOREIGN KEY(creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_diet_plan_diet_no FOREIGN KEY(diet_no) REFERENCES diet(diet_no)
);



-- 섭취 기록(사용자의 입력)
CREATE TABLE intake_record(
    intake_record_no NUMBER NOT NULL,
    regdate DATE NOT NULL,
    intake_kcal NUMBER(6, 2) NOT NULL,
    meal_classify VARCHAR2(10) NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    food_no NUMBER NULL,
    custom_food_no NUMBER NULL,
    diet_no NUMBER NULL,
    food_creation_type NUMBER NOT NULL CHECK (food_creation_type IN (0, 1)),
    intake number(6,2) not null,
	
    CONSTRAINT PK_intake_record PRIMARY KEY(intake_record_no),
    CONSTRAINT FK_intake_record_creator_id FOREIGN KEY(creator_id) REFERENCES member(member_id),
    CONSTRAINT FK_intake_record_food_no FOREIGN KEY(food_no) REFERENCES food(food_no),
    CONSTRAINT FK_intake_record_custom_food_no FOREIGN KEY(custom_food_no) REFERENCES custom_food(custom_food_no),
    CONSTRAINT FK_intake_record_diet_no FOREIGN KEY(diet_no) REFERENCES diet(diet_no)
);

-- 식단 피드백
CREATE TABLE diet_feedback(
    diet_feedback_no NUMBER NOT NULL,
    montor_id VARCHAR2(50) NOT NULL,
    regdate DATE NOT NULL,
    feedback_content VARCHAR2(3000) NOT NULL,
    diet_plan_no NUMBER NOT NULL,
    
    CONSTRAINT PK_diet_feedback PRIMARY KEY(diet_feedback_no),
    CONSTRAINT FK_diet_feedback_montor_id FOREIGN KEY(montor_id) REFERENCES member(member_id),
    CONSTRAINT FK_diet_feedback_diet_plan_no FOREIGN KEY(diet_plan_no) REFERENCES diet_plan(diet_plan_no)
);

--식단 카테고리 시퀀스
create sequence seqDietCategory;
--식단 시퀀스
create sequence seqDiet;
-- 식단 계획 시퀀스
create sequence seqDietPlan;
















