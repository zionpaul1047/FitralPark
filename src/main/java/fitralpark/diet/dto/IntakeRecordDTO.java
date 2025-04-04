package fitralpark.diet.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class IntakeRecordDTO {
	private String intakeRecordNo;
	private String regdate;
	private String intakeKcal;
	private String mealClassify;
	private String creatorId;
	private String foodNo;
	private String customFoodNo;
	private String dietNo;
	private String foodCreationType;
	private String intake;
}
