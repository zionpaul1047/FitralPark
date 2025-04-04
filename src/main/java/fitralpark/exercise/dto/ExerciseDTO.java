package fitralpark.exercise.dto;
//(데이터 전달 DTO 클래스 자리)

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
    
    private String customExerciseNo;
    private String customExerciseName;
    private String customExerciseCategoryName;
    private String customExercisePartName;
    private String customCaloriesPerUnit;
    
    private String customExerciseCategoryNo;
    private String customExercisePartNo;
    
}
