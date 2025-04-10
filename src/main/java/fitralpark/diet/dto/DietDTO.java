package fitralpark.diet.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * DietDTO 클래스는 식단 및 음식 데이터를 관리하기 위한 데이터 전송 객체입니다.
 * 
 * <p>이 클래스는 다양한 식단 관련 데이터와 음식 영양소 정보를 포함합니다.</p>
 * @author 이지민
 */

@Getter
@Setter
@ToString
public class DietDTO {

    // diet
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
    private String diet_category_name;
    private int diet_food_list_no;
    private int food_creation_type;
    private int intake;
    private int food_no;
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
    private int custom_food_no;
    private String custom_food_name;
    private int kcal_per_unit;
    private int custom_food_nutrient_no;
    private int nutrient_content;
    private String nutrient_cd;
    private String nutrient_name;
    private int diet_bookmark_no;
    private String member_id;
    private int diet_plan_no;
    private int food_bookmark_no;
    private int diet_feedback_no;
    private String mentor_id;
    private String feedback_content;
    private int intake_record_no;
    private int intake_kcal;
    private String diet_category;

    /** 음식 상세 정보 리스트 (food_name, enerc, food_size) */
    private List<FoodDetail> foodDetails = new ArrayList<>();

    /**
     * FoodDetail 클래스는 음식의 상세 정보를 관리하는 내부 클래스입니다.
     *
     * <p>음식 이름, 열량, 용량 등의 정보를 포함합니다.</p>
     */
    @Getter
    @Setter
    @ToString
    public static class FoodDetail {
        private String food_name; // 음식 이름
        private int enerc; // 열량 (kcal)
        private int food_size; // 용량 (g)
    }

    /**
     * 모든 필드를 초기화하는 생성자.
     *
     * @param diet_no 식단 번호
     * @param diet_name 식단 이름
     * @param regdate 등록 날짜
     * @param diet_total_kcal 총 칼로리
     * @param meal_classify 식사 분류 (아침, 점심, 저녁 등)
     * @param creator_id 생성자 ID
     * @param diet_bookmark_no 즐겨찾기 번호
     * @param food_name 음식 이름
     * @param enerc 열량 (kcal)
     * @param food_size 용량 (g)
     */
    public DietDTO(int diet_no, String diet_name, String regdate, int diet_total_kcal, String meal_classify,
            String creator_id, int diet_bookmark_no, String food_name, Double enerc, int food_size) {
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
    
    /* 추가 생성자 및 getter/setter*/

    public int getDiet_no() {
        return diet_no;
    }

    public void setDiet_no(int diet_no) {
        this.diet_no = diet_no;
    }

    public String getDiet_name() {
        return diet_name;
    }

    public void setDiet_name(String diet_name) {
        this.diet_name = diet_name;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public int getDiet_total_kcal() {
        return diet_total_kcal;
    }

    public void setDiet_total_kcal(int diet_total_kcal) {
        this.diet_total_kcal = diet_total_kcal;
    }

    public String getMeal_classify() {
        return meal_classify;
    }

    public void setMeal_classify(String meal_classify) {
        this.meal_classify = meal_classify;
    }

    public int getPublic_check() {
        return public_check;
    }

    public void setPublic_check(int public_check) {
        this.public_check = public_check;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public int getRecommend() {
        return recommend;
    }

    public void setRecommend(int recommend) {
        this.recommend = recommend;
    }

    public int getDisrecommend() {
        return disrecommend;
    }

    public void setDisrecommend(int disrecommend) {
        this.disrecommend = disrecommend;
    }

    public String getCreator_id() {
        return creator_id;
    }

    public void setCreator_id(String creator_id) {
        this.creator_id = creator_id;
    }

    public int getDiet_category_no() {
        return diet_category_no;
    }

    public void setDiet_category_no(int diet_category_no) {
        this.diet_category_no = diet_category_no;
    }

    public String getDiet_category_name() {
        return diet_category_name;
    }

    public void setDiet_category_name(String diet_category_name) {
        this.diet_category_name = diet_category_name;
    }

    public int getDiet_food_list_no() {
        return diet_food_list_no;
    }

    public void setDiet_food_list_no(int diet_food_list_no) {
        this.diet_food_list_no = diet_food_list_no;
    }

    public int getFood_creation_type() {
        return food_creation_type;
    }

    public void setFood_creation_type(int food_creation_type) {
        this.food_creation_type = food_creation_type;
    }

    public int getIntake() {
        return intake;
    }

    public void setIntake(int intake) {
        this.intake = intake;
    }

    public int getFood_no() {
        return food_no;
    }

    public void setFood_no(int food_no) {
        this.food_no = food_no;
    }

    public String getFood_cd() {
        return food_cd;
    }

    public void setFood_cd(String food_cd) {
        this.food_cd = food_cd;
    }

    public String getFood_name() {
        return food_name;
    }

    public void setFood_name(String food_name) {
        this.food_name = food_name;
    }

    public String getFoodlv4_name() {
        return foodlv4_name;
    }

    public void setFoodlv4_name(String foodlv4_name) {
        this.foodlv4_name = foodlv4_name;
    }

    public String getFoodlv5_Cd() {
        return foodlv5_Cd;
    }

    public void setFoodlv5_Cd(String foodlv5_Cd) {
        this.foodlv5_Cd = foodlv5_Cd;
    }

    public String getFoodlv6_Cd() {
        return foodlv6_Cd;
    }

    public void setFoodlv6_Cd(String foodlv6_Cd) {
        this.foodlv6_Cd = foodlv6_Cd;
    }

    public String getNut_con_str_qua() {
        return nut_con_str_qua;
    }

    public void setNut_con_str_qua(String nut_con_str_qua) {
        this.nut_con_str_qua = nut_con_str_qua;
    }

    public Double getEnerc() {
        return enerc;
    }

    public void setEnerc(Double enerc) {
        this.enerc = enerc;
    }

    public Double getWater() {
        return water;
    }

    public void setWater(Double water) {
        this.water = water;
    }

    public Double getProtein() {
        return protein;
    }

    public void setProtein(Double protein) {
        this.protein = protein;
    }

    public Double getFatce() {
        return fatce;
    }

    public void setFatce(Double fatce) {
        this.fatce = fatce;
    }

    public Double getAsh() {
        return ash;
    }

    public void setAsh(Double ash) {
        this.ash = ash;
    }

    public Double getChocdf() {
        return chocdf;
    }

    public void setChocdf(Double chocdf) {
        this.chocdf = chocdf;
    }

    public Double getSugar() {
        return sugar;
    }

    public void setSugar(Double sugar) {
        this.sugar = sugar;
    }

    public Double getFibtg() {
        return fibtg;
    }

    public void setFibtg(Double fibtg) {
        this.fibtg = fibtg;
    }

    public Double getCa() {
        return ca;
    }

    public void setCa(Double ca) {
        this.ca = ca;
    }

    public Double getFe() {
        return fe;
    }

    public void setFe(Double fe) {
        this.fe = fe;
    }

    public Double getP() {
        return p;
    }

    public void setP(Double p) {
        this.p = p;
    }

    public Double getK() {
        return k;
    }

    public void setK(Double k) {
        this.k = k;
    }

    public Double getNa() {
        return na;
    }

    public void setNa(Double na) {
        this.na = na;
    }

    public Double getVitarae() {
        return vitarae;
    }

    public void setVitarae(Double vitarae) {
        this.vitarae = vitarae;
    }

    public Double getRetinol() {
        return retinol;
    }

    public void setRetinol(Double retinol) {
        this.retinol = retinol;
    }

    public Double getCartb() {
        return cartb;
    }

    public void setCartb(Double cartb) {
        this.cartb = cartb;
    }

    public Double getThia() {
        return thia;
    }

    public void setThia(Double thia) {
        this.thia = thia;
    }

    public Double getRibf() {
        return ribf;
    }

    public void setRibf(Double ribf) {
        this.ribf = ribf;
    }

    public Double getNia() {
        return nia;
    }

    public void setNia(Double nia) {
        this.nia = nia;
    }

    public Double getVitc() {
        return vitc;
    }

    public void setVitc(Double vitc) {
        this.vitc = vitc;
    }

    public Double getVitd() {
        return vitd;
    }

    public void setVitd(Double vitd) {
        this.vitd = vitd;
    }

    public int getFood_size() {
        return food_size;
    }

    public void setFood_size(int food_size) {
        this.food_size = food_size;
    }

    public Double getFasat() {
        return fasat;
    }

    public void setFasat(Double fasat) {
        this.fasat = fasat;
    }

    public String getRest_name() {
        return rest_name;
    }

    public void setRest_name(String rest_name) {
        this.rest_name = rest_name;
    }

    public Double getFatrn() {
        return fatrn;
    }

    public void setFatrn(Double fatrn) {
        this.fatrn = fatrn;
    }

    public Double getChole() {
        return chole;
    }

    public void setChole(Double chole) {
        this.chole = chole;
    }

    public int getCustom_food_no() {
        return custom_food_no;
    }

    public void setCustom_food_no(int custom_food_no) {
        this.custom_food_no = custom_food_no;
    }

    public String getCustom_food_name() {
        return custom_food_name;
    }

    public void setCustom_food_name(String custom_food_name) {
        this.custom_food_name = custom_food_name;
    }

    public int getKcal_per_unit() {
        return kcal_per_unit;
    }

    public void setKcal_per_unit(int kcal_per_unit) {
        this.kcal_per_unit = kcal_per_unit;
    }

    public int getCustom_food_nutrient_no() {
        return custom_food_nutrient_no;
    }

    public void setCustom_food_nutrient_no(int custom_food_nutrient_no) {
        this.custom_food_nutrient_no = custom_food_nutrient_no;
    }

    public int getNutrient_content() {
        return nutrient_content;
    }

    public void setNutrient_content(int nutrient_content) {
        this.nutrient_content = nutrient_content;
    }

    public String getNutrient_cd() {
        return nutrient_cd;
    }

    public void setNutrient_cd(String nutrient_cd) {
        this.nutrient_cd = nutrient_cd;
    }

    public String getNutrient_name() {
        return nutrient_name;
    }

    public void setNutrient_name(String nutrient_name) {
        this.nutrient_name = nutrient_name;
    }

    public int getDiet_bookmark_no() {
        return diet_bookmark_no;
    }

    public void setDiet_bookmark_no(int diet_bookmark_no) {
        this.diet_bookmark_no = diet_bookmark_no;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public int getDiet_plan_no() {
        return diet_plan_no;
    }

    public void setDiet_plan_no(int diet_plan_no) {
        this.diet_plan_no = diet_plan_no;
    }

    public int getFood_bookmark_no() {
        return food_bookmark_no;
    }

    public void setFood_bookmark_no(int food_bookmark_no) {
        this.food_bookmark_no = food_bookmark_no;
    }

    public int getDiet_feedback_no() {
        return diet_feedback_no;
    }

    public void setDiet_feedback_no(int diet_feedback_no) {
        this.diet_feedback_no = diet_feedback_no;
    }

    public String getMentor_id() {
        return mentor_id;
    }

    public void setMentor_id(String mentor_id) {
        this.mentor_id = mentor_id;
    }

    public String getFeedback_content() {
        return feedback_content;
    }

    public void setFeedback_content(String feedback_content) {
        this.feedback_content = feedback_content;
    }

    public int getIntake_record_no() {
        return intake_record_no;
    }

    public void setIntake_record_no(int intake_record_no) {
        this.intake_record_no = intake_record_no;
    }

    public int getIntake_kcal() {
        return intake_kcal;
    }

    public void setIntake_kcal(int intake_kcal) {
        this.intake_kcal = intake_kcal;
    }

    public String getDiet_category() {
        return diet_category;
    }

    public void setDiet_category(String diet_category) {
        this.diet_category = diet_category;
    }

    public List<FoodDetail> getFoodDetails() {
        return foodDetails;
    }

    public void setFoodDetails(List<FoodDetail> foodDetails) {
        this.foodDetails = foodDetails;
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

    /**
     * 기본 생성자.
     */
    public DietDTO() {
    }

    public DietDTO(int diet_no, String diet_name, String regdate, int diet_total_kcal, String mealClassify,
            String creatorId, String dietCategory, int dietBookmarkNo) {
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
