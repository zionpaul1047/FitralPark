package fitralpark.user.dto;

import java.util.ArrayList;
import java.util.HashMap;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


/**
 * 대시보드 정보를 담을 DTO 클래스
 * @author 한가람
 */
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class DashDTO {
	private String userName;
	private String backgroundPic;
	private String height;
	private String gender;
	private String weight;
	private String age;
	
	private ArrayList<DashTodayExerciseDTO> tdyExcsList;
	private ArrayList<DashTodayDietDTO> tdyDietList;
	private ArrayList<DashCurrentExcsDTO> crtExcsList;
	private ArrayList<DashCurrentDietDTO> crtdietList;
	private DashTodayIntakeDTO tdyintake;
	
}
