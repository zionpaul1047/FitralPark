package fitralpark.diet.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


//(데이터 전달 DTO 클래스 자리)


@Getter
@Setter
@ToString
public class DietDTO {
    
    //diet
    private int diet_no;
    private String diet_name;
    private String regdate;
    private int diet_total_kcal;
    private String meal_classify;
    private int public_check;
    private int views;
    private int recommend;
    private int disrecommend;
    private String creator_id;
    private int diet_category_no;
    
    //diet_category
    //private int diet_category_no;
    private String diet_category_name;
    
    //diet_food_list
    private int diet_food_list_no;
    //private int diet_no;
    //private int food_no;
    //private int custom_food_no;
    private int food_creation_type;
    private int intake;
    
    //food
    private int food_no;
    //private String food_name;
    //private String food_cd;
    
    //individual_diet_record_food_nutrient
    private String food_cd;
    private String food_name;
    private String foodlv4_name;
    private String foodlv5_Cd;
    private String foodlv6_Cd;
    private String nut_con_str_qua;
    private Double enerc;
    private Double water;
    private Double protein;
    private Double fatce;
    private Double ash;
    private Double chocdf;
    private Double sugar;
    private Double fibtg;
    private Double ca;
    private Double fe;
    private Double p;
    private Double k;
    private Double na;
    private Double vitarae;
    private Double retinol;
    private Double cartb;
    private Double thia;
    private Double ribf;
    private Double nia;
    private Double vitc;
    private Double vitd;
    private int food_size;
    private Double fasat;
    private String rest_name;
    private Double fatrn;
    private Double chole;
    
    //custom_food
    private int custom_food_no;
    private String custom_food_name;
    private int kcal_per_unit;
    //private String creator_id;
    
    //custom_food_nutrient
    private int custom_food_nutrient_no;
    //private int custom_food_no;
    //private String nutrient_cd;
    private int nutrient_content;
    
    //nutrient
    private String nutrient_cd;
    private String  nutrient_name;
    
    //diet_bookmark
    private int diet_bookmark_no;
    private String member_id;
    //regdate;
    //private int diet_no;
    
    //diet_plan
    private int diet_plan_no;
    //regdate;
    //private String creator_id;
    //private int diet_no;
    
    //food_bookmark
    private int food_bookmark_no;
    //food_no;
    
    //diet_feedback
    private int diet_feedback_no;
    private String mentor_id;
    private String feedback_content;
    //regdate;
    //diet_plan_no;
    
    //intake_record
    private int intake_record_no;
    //private String regdate;
    private int intake_kcal;
    //private String meal_classify;
    //private String creator_id;
    //private int food_no;
    //private int custom_food_no;
    //private int diet_no;
    //private int food_creation_type;
    //private int intake;

    
    private String diet_category;
    
 // 음식 상세 정보 리스트 (food_name, enerc, food_size)
    private List<FoodDetail> foodDetails = new ArrayList<>();


    @Getter
    @Setter
    @ToString
    public static class FoodDetail {
        private String food_name;           // 음식 이름
        private int enerc;                  // 열량 (kcal)
        private int food_size;              // 용량 (g)
    }

    

    public void addFoodDetail(String food_name, int enerc, int food_size) {
        FoodDetail detail = new FoodDetail();
        detail.setFood_name(food_name);
        detail.setEnerc(enerc);
        detail.setFood_size(food_size);
        foodDetails.add(detail);
    }
    
    
 // 생성자
    public DietDTO(int diet_no, String diet_name, String regdate, int diet_total_kcal,
                   String meal_classify, String creator_id, int diet_bookmark_no,
                   String food_name, Double enerc, int food_size) {
        this.diet_no = diet_no;
        this.diet_name = diet_name;
        this.regdate = regdate;
        this.diet_total_kcal = diet_total_kcal;
        this.meal_classify = meal_classify;
        this.creator_id = creator_id;
        this.diet_bookmark_no = diet_bookmark_no;
        this.food_name = food_name;
        this.enerc = enerc;
        this.food_size = food_size;
        
    }
    
    
    public DietDTO(int diet_no, String diet_name, String regdate, int diet_total_kcal, String meal_classify,
            String creator_id, int diet_bookmark_no) {
        this.diet_no = diet_no;
        this.diet_name = diet_name;
        this.regdate = regdate;
        this.diet_total_kcal = diet_total_kcal;
        this.meal_classify = meal_classify;
        this.creator_id = creator_id;
        this.diet_bookmark_no = diet_bookmark_no;
    }
    
    public DietDTO(int diet_no, String diet_name, String diet_category_name, String regdate, int diet_total_kcal,
            String meal_classify, String creator_id, int diet_bookmark_no, int views) {
        this.diet_no = diet_no;
        this.diet_name = diet_name;
        this.diet_category_name = diet_category_name;
        this.regdate = regdate;
        this.diet_total_kcal = diet_total_kcal;
        this.meal_classify = meal_classify;
        this.creator_id = creator_id;
        this.diet_bookmark_no = diet_bookmark_no;
        this.views = views;
    }


    public DietDTO() {
        // 기본 생성자
    }

    public DietDTO(int diet_no, String diet_name, String regdate, int diet_total_kcal,
            String mealClassify, String creatorId, String dietCategory,
            int dietBookmarkNo) {
 this.diet_no = diet_no;
 this.diet_name = diet_name;
 this.regdate = regdate;
 this.diet_total_kcal = diet_total_kcal;
 this.meal_classify = mealClassify;
 this.creator_id = creatorId;
 this.diet_category = dietCategory; // 초기화 추가
 this.diet_bookmark_no = dietBookmarkNo;
}





 

    

}

    

