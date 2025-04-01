package fitralpark.exercise.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoutineExerciseDTO {
	private String exerciseName;
    private String exerciseCategoryNames;
    private String exercisePartNames;
    private String caloriesPerUnit;
    private String exerciseTime;
    private String sets;
    private String repsPerSet;
    private String weight;
}
