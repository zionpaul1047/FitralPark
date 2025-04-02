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
	String userName;
	String backgroundPic;
	String height;
	String gender;
	String weight;
	String age;
	
	ArrayList<DashTodayExerciseDTO> tdyExcsList;
	ArrayList<DashTodayDietDTO> tdyDietList;
	ArrayList<DashCurrentExcsDTO> crtExcsList;
	ArrayList<DashCurrentDietDTO> crtdietList;
	DashTodayIntakeDTO tdyintake;
	
}
