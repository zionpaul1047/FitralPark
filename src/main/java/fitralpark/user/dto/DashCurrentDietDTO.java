package fitralpark.user.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 대시보드 중 일주일간의 식사 집계 정보을 담을 DTO 클래스
 * @author 한가람
 */
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
