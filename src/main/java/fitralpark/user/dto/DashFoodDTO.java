package fitralpark.user.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 대시보드 중 오늘의 식단정보의 음식 정보을 담을 DTO 클래스
 * @author 한가람
 */
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class DashFoodDTO {
	private String foodName;
	private String intake;
	private String foodCreationType;
	private String foodNo;

}
