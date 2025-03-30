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
    private String categoryName;
    private String creationDate;
    private String nickname;
    private String views;
}
