package fitralpark.user.dto;

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
public class DashTodayExerciseDTO {
	String exerciseName;
	String ining;
	String set;
	String load;
	String times;
	String excsCrtType;
	String excsNo;
}
