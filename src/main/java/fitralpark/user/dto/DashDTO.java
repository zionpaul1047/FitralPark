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
