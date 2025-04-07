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
    private String exerciseId;
    private String exerciseNo;
    private String customExerciseNo;
    
    public String getExerciseId() {
        if (exerciseNo != null) {
            return "ex_" + exerciseNo;
        } else if (customExerciseNo != null) {
            return "cus_" + customExerciseNo;
        }
        return null;
    }
    
    public void setExerciseId(String exerciseId) {
        if (exerciseId != null) {
            if (exerciseId.startsWith("ex_")) {
                this.exerciseNo = exerciseId.substring(3);
            } else if (exerciseId.startsWith("cus_")) {
                this.customExerciseNo = exerciseId.substring(4);
            }
        }
    }
    
    public String getExerciseNo() {
        return exerciseNo;
    }
    
    public void setExerciseNo(String exerciseNo) {
        this.exerciseNo = exerciseNo;
    }
    
    public String getCustomExerciseNo() {
        return customExerciseNo;
    }
    
    public void setCustomExerciseNo(String customExerciseNo) {
        this.customExerciseNo = customExerciseNo;
    }
}
