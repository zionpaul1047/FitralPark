package fitralpark.nutrition.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//(데이터 전달 DTO 클래스 자리)

@Getter
@Setter
@ToString
public class NutritionDTO {
//	■■■■■■■■■■ API 식품정보 "individual_diet_record_food_nutrient" ■■■■■■■■■■

	private String food_img_croll; //크롤링 이미지
	private String food_cd;        //식품코드(PK)
    private String food_name;        //식품명
    private String foodLv4Nm;        //대표식품명
    private String foodLv5Cd;        //식품중분류코드
    private String foodLv6Cd;        //식품소분류코드
    private String nut_con_str_qua;        //영양성분함량기준량
    private String enerc;        //에너지(칼로리)
    private String water;        //수분
    private String protein;        //단백질
    private String fatce;        //지방
    private String ash;        //회분
    private String chocdf;        //탄수화물
    private String sugar;        //당류
    private String fibtg;        //식이섬유
    private String ca;        //칼슘
    private String fe;        //철
    private String p;        //인
    private String k;        //칼륨
    private String na;        //나트륨
    private String vataRae;        //비타민A
    private String retol;        //레티놀
    private String cartb;        //베타카로틴
    private String thia;        //비타민B1(티아민)
    private String ribf;        //비타민B2(리보플라빈)
    private String nia;        //비타민B3(니아신)
    private String vitac;        //비타민C
    private String vitd;        //비타민D
    private String food_size;        //식품중량
    private String fasat;        //포화지방산
    private String rest_name;        //업체명
    private String fatrn;        //트랜스지방산
    private String chole;        //콜레스테롤
	
	
//	■■■■■■■■■■ 음식 즐겨찾기 "food_bookmark" ■■■■■■■■■■
	private String fb_food_bookmark_no; //pk
	private String fb_food_no;
	private String fb_regdate;
	private String fb_member_id; //fk (member-member_id)
	
	
	
}
/*

food_name
nut_con_str_qua
enerc
protein
chocdf
fatce
sugar
na
ca
fe
p
k
chole
fasat
fatrn
vataRae
cartb
thia
ribf
nia
vitac
vitd
food_size




*/