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
public class DashCurrentExcsDTO {
	String regdate;
	String totalPlanCnt;
	String completePlanCnt;
	String incompletePlanCnt;
	String unplanCnt;
	String processivity;
}
