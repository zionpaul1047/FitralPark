package fitralpark.user.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 대시보드 중 오늘 계획된 운동 정보을 담을 DTO 클래스
 * @author 한가람
 */
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class DashTodayExerciseDTO {
	private String exerciseName;
	private String ining;
	private String set;
	private String load;
	private String times;
	private String excsCrtType;
	private String excsNo;
}
