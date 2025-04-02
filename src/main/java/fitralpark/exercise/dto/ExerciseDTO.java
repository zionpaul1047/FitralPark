package fitralpark.exercise.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ExerciseDTO {
	private String exerciseNo;
    private String exerciseName;
    private String exerciseCategoryName;
    private String exercisePartName;
    private String caloriesPerUnit;
}
