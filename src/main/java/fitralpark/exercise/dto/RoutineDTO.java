package fitralpark.exercise.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoutineDTO {
	private String routineNo;
    private String routineName;
    private String routineCategoryName;
    private String exerciseCategories;
    private String exerciseParts;
    private String totalCalories;
    private String creationDate;
    private String memberNickname;
    private String views;
}
