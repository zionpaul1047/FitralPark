
DROP TABLE forbidden_words;
DROP TABLE association_company;
DROP TABLE cheerup_message;
DROP TABLE public_holiday;
DROP TABLE event;
DROP TABLE supplement;
DROP TABLE map_marker;

CREATE TABLE map_marker (
    map_marker_no NUMBER PRIMARY KEY,
    map_marker_name VARCHAR2(50),
    lat NUMBER NOT NULL,
    lng NUMBER NOT NULL
);

CREATE TABLE supplement (
    supplement_no NUMBER PRIMARY KEY,
    supplement_name VARCHAR2(50) NOT NULL,
    ingredient VARCHAR2(50) NOT NULL,
    ingredient_content VARCHAR2(3000)
);

CREATE TABLE event (
    event_no NUMBER PRIMARY KEY,
    event_name VARCHAR2(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    discount NUMBER NOT NULL
);

CREATE TABLE public_holiday (
    public_holiday_no NUMBER PRIMARY KEY,
    public_holiday_date DATE NOT NULL,
    public_holiday_name VARCHAR2(50) NOT NULL
);

CREATE TABLE cheerup_message (
    cheerup_message_no NUMBER PRIMARY KEY,
    content VARCHAR2(600) NOT NULL
);

CREATE TABLE association_company (
    association_company_no NUMBER PRIMARY KEY,
    association_company_name VARCHAR2(50) NOT NULL,
    content VARCHAR2(600) NOT NULL
);

CREATE TABLE forbidden_words (
    forbidden_words_no NUMBER PRIMARY KEY,
    forbidden_words_content VARCHAR2(100) NOT NULL
);


commit;