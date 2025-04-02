package fitralpark.user.dto;

import java.util.ArrayList;
import java.util.HashMap;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class DashTodayDietDTO {
	String mealClassify;
	ArrayList<DashFoodDTO> foodList;
} 
