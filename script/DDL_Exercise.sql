


--DROP TABLE online_pt;
--DROP TABLE exercise_plan_routine;
--DROP TABLE exercise_plan;
--DROP TABLE routine_exercise;
--DROP TABLE routine;
--DROP TABLE exercise_favorite;
--DROP TABLE exercise_record;
--DROP TABLE exercise_part_link;
--DROP TABLE custom_exercise_category_group;
--DROP TABLE exercise_category_group;
--DROP TABLE custom_exercise;
--DROP TABLE exercise;
--DROP TABLE routine_category;
--DROP TABLE weight_unit;
--DROP TABLE exercise_part;
--DROP TABLE exercise_category;

CREATE TABLE exercise_routine_favorite (
	exercise_routine_favorite_no NUMBER PRIMARY KEY,
	regdate DATE DEFAULT SYSDATE,
	member_id VARCHAR2(50) NOT NULL,
	routine_no NUMBER NOT NULL,
	CONSTRAINT fk_routinefav_routine FOREIGN KEY (routine_no) REFERENCES routine(routine_no),
    CONSTRAINT fk_routinefav_member FOREIGN KEY (member_id) REFERENCES member(member_id)
);



CREATE TABLE weight_unit (
    weight_unit_no NUMBER PRIMARY KEY,
    weight_unit_name VARCHAR2(50) NOT NULL
);

CREATE TABLE exercise_part (
    exercise_part_no NUMBER PRIMARY KEY,
    exercise_part_name VARCHAR2(50) NOT NULL
);

CREATE TABLE exercise_category (
    exercise_category_no NUMBER PRIMARY KEY,
    exercise_category_name VARCHAR2(50) NOT NULL
);

CREATE TABLE routine_category (
    routine_category_no NUMBER PRIMARY KEY,
    routine_category_name VARCHAR2(50) NOT NULL
);

CREATE TABLE exercise (
    exercise_no NUMBER PRIMARY KEY,
    exercise_name VARCHAR2(50) NOT NULL,
    calories_per_unit NUMBER(6,2) DEFAULT 0,
    weight_unit_no NUMBER NOT NULL,
    CONSTRAINT fk_exercise_weight_unit FOREIGN KEY (weight_unit_no) REFERENCES weight_unit(weight_unit_no)
);

CREATE TABLE custom_exercise (
    custom_exercise_no NUMBER PRIMARY KEY,
    custom_exercise_name VARCHAR2(50) NOT NULL,
    calories_per_unit NUMBER(6,2) DEFAULT 0,
    creator_id VARCHAR2(50) NOT NULL,
    weight_unit_no NUMBER NOT NULL,
    CONSTRAINT fk_custom_weight_unit FOREIGN KEY (weight_unit_no) REFERENCES weight_unit(weight_unit_no),
    CONSTRAINT fk_custom_member FOREIGN KEY (creator_id) REFERENCES member(member_id)
);

CREATE TABLE exercise_category_group (
    exercise_category_group_no NUMBER PRIMARY KEY,
    exercise_category_no NUMBER NOT NULL,
    exercise_no NUMBER NOT NULL,
    CONSTRAINT fk_group_category FOREIGN KEY (exercise_category_no) REFERENCES exercise_category(exercise_category_no),
    CONSTRAINT fk_group_exercise FOREIGN KEY (exercise_no) REFERENCES exercise(exercise_no)
);

CREATE TABLE custom_exercise_category_group (
    custom_exercise_category_no NUMBER PRIMARY KEY,
    exercise_category_no NUMBER NOT NULL,
    custom_exercise_no NUMBER NOT NULL,
    CONSTRAINT fk_custom_group_category FOREIGN KEY (exercise_category_no) REFERENCES exercise_category(exercise_category_no),
    CONSTRAINT fk_custom_group_exercise FOREIGN KEY (custom_exercise_no) REFERENCES custom_exercise(custom_exercise_no)
);

CREATE TABLE exercise_part_link (
    exercise_part_link_no NUMBER PRIMARY KEY,
    exercise_part_no NUMBER,
    exercise_no NUMBER,
    CONSTRAINT fk_link_part FOREIGN KEY (exercise_part_no) REFERENCES exercise_part(exercise_part_no),
    CONSTRAINT fk_link_exercise FOREIGN KEY (exercise_no) REFERENCES exercise(exercise_no)
);

CREATE TABLE exercise_record (
    exercise_record_no NUMBER PRIMARY KEY,
    record_date DATE DEFAULT SYSDATE NOT NULL,
    sets NUMBER DEFAULT 0,
    reps_per_set NUMBER DEFAULT 0,
    weight NUMBER(5,1) DEFAULT 0,
    exercise_time NUMBER DEFAULT 0,
    creator_id VARCHAR2(50),
    exercise_no NUMBER NULL,
    custom_exercise_no NUMBER NULL,
    exercise_creation_type NUMBER NOT NULL,
    CONSTRAINT fk_record_exercise FOREIGN KEY (exercise_no) REFERENCES exercise(exercise_no),
    CONSTRAINT fk_record_custom_exercise FOREIGN KEY (custom_exercise_no) REFERENCES custom_exercise(custom_exercise_no),
    CONSTRAINT fk_record_member FOREIGN KEY (creator_id) REFERENCES member(member_id)
);

CREATE TABLE exercise_favorite (
    exercise_favorite_no NUMBER PRIMARY KEY,
    exercise_no NUMBER NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_fav_exercise FOREIGN KEY (exercise_no) REFERENCES exercise(exercise_no),
    CONSTRAINT fk_fav_member FOREIGN KEY (creator_id) REFERENCES member(member_id)
);

CREATE TABLE routine (
    routine_no NUMBER PRIMARY KEY,
    routine_name VARCHAR2(50) NOT NULL,
    creation_date DATE DEFAULT SYSDATE NOT NULL,
    public_check NUMBER DEFAULT 0 NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    routine_category_no NUMBER NOT NULL,
<<<<<<< HEAD:script/DDL/DDL_Exercise.sql
    views NUMBER Default 1,											
    recommend NUMBER Default 0,
    disrecommend NUMBER Default 0,
=======
>>>>>>> origin/HN2:script/DDL_Exercise.sql
    CONSTRAINT fk_routine_category FOREIGN KEY (routine_category_no) REFERENCES routine_category(routine_category_no),
    CONSTRAINT fk_routine_member FOREIGN KEY (creator_id) REFERENCES member(member_id)
);

CREATE TABLE routine_exercise (
    routine_exercise_no NUMBER PRIMARY KEY,
    routine_no NUMBER NOT NULL,
    exercise_no NUMBER NULL,
    custom_exercise_no NUMBER NULL,
    exercise_creation_type NUMBER,
    sets NUMBER DEFAULT 0,
    reps_per_set NUMBER DEFAULT 0,
    exercise_time NUMBER DEFAULT 0,
    weight NUMBER(5,1) DEFAULT 0,
    CONSTRAINT fk_routine_exercise_routine FOREIGN KEY (routine_no) REFERENCES routine(routine_no),
    CONSTRAINT fk_routine_exercise_exercise FOREIGN KEY (exercise_no) REFERENCES exercise(exercise_no),
    CONSTRAINT fk_routine_exercise_custom_exercise FOREIGN KEY (custom_exercise_no) REFERENCES custom_exercise(custom_exercise_no)
);


CREATE TABLE exercise_plan (
    exercise_plan_no NUMBER PRIMARY KEY,
    regdate DATE DEFAULT SYSDATE NOT NULL,
    creator_id VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_exercise_plan_member FOREIGN KEY (creator_id) REFERENCES member(member_id)
);

CREATE TABLE exercise_plan_routine (
    exercise_plan_routine_no NUMBER PRIMARY KEY,
    exercise_plan_no NUMBER NOT NULL,
    routine_no NUMBER NOT NULL,
    CONSTRAINT fk_plan_routine_plan FOREIGN KEY (exercise_plan_no) REFERENCES exercise_plan(exercise_plan_no),
    CONSTRAINT fk_plan_routine_routine FOREIGN KEY (routine_no) REFERENCES routine(routine_no)
);

CREATE TABLE online_pt (
    online_pt_no NUMBER PRIMARY KEY,
    mentor_id VARCHAR2(50) NOT NULL,
    content VARCHAR2(3000),
    regdate DATE DEFAULT SYSDATE NOT NULL,
    exercise_plan_no NUMBER NOT NULL,
    CONSTRAINT fk_pt_plan FOREIGN KEY (exercise_plan_no) REFERENCES exercise_plan(exercise_plan_no),
    CONSTRAINT fk_pt_member FOREIGN KEY (mentor_id) REFERENCES member(member_id)
);


commit;




-- 운동계획 시퀀스
create sequence seqExercisePlan;
--운동 + 루틴 시퀀스
create sequence seqRoutineExercise;
--운동 기록 시퀀스
create sequence seqExerciseRecord;
--회원 신체 정보 시퀀스
create sequence seqMemberPhysical;
--운동계획 + 루틴 시퀀스
create sequence seqExercisePlanRoutineNo;








