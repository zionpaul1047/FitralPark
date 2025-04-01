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
	private String food_cd; //pk
	private String food_name;
	private String foodLv4Nm;
	private String foodLv5Cd;
	private String foodLv6Cd;
	private String nut_con_srtr_qua;
	private String enerc;
	private String water;
	private String prot;
	private String fatce;
	private String ash;
	private String chocdf;
	private String sugar;
	private String fibtg;
	private String ca;
	private String fe;
	private String p;
	private String k;
	private String nat;
	private String vitaRae;
	private String retol;
	private String cartb;
	private String thia;
	private String ribf;
	private String nia;
	private String vitc;
	private String vitd;
	private String food_size;
	private String fasat;
	private String rest_name;
	private String fatrn;
	private String chole;
	
	
//	■■■■■■■■■■ 음식 즐겨찾기 "food_bookmark" ■■■■■■■■■■
	private String fb_food_bookmark_no; //pk
	private String fb_food_no;
	private String fb_regdate;
	private String fb_member_id; //fk (member-member_id)
	
	
	
}
