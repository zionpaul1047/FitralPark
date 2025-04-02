package fitralpark.exercise.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ExerciseRecordDTO {
	private String exerciseRecordNo;
	private String recordDate;
	private String sets;
	private String repsPerSet;
	private String weight;
	private String exerciseTime;
	private String creatorId;
	private String exerciseNo;
	private String customExerciseNo;
	private String exerciseCreationType;
	
}
