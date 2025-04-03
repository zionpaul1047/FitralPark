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
public class DashCurrentDietDTO {
	private String regdate;
	private String totalPlanCnt;
	private String completePlanCnt;
	private String incompletePlanCnt;
	private String unplanCnt;
	private String processivity;

}
