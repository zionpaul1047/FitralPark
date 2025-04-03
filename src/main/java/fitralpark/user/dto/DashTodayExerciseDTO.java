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
	private String exerciseName;
	private String ining;
	private String set;
	private String load;
	private String times;
	private String excsCrtType;
	private String excsNo;
}
