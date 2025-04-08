package fitralpark.user.dto;

import java.util.ArrayList;
import java.util.HashMap;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 대시보드 중 오늘 계획된 식단 정보을 담을 DTO 클래스
 * @author 한가람
 */
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class DashTodayDietDTO {
	private String mealClassify;
	private String dietNo;
	private ArrayList<DashFoodDTO> foodList;
} 
