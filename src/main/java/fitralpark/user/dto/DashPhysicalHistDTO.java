package fitralpark.user.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 대시보드에서 신체기록 정보를 담을 DTO 클래스
 * @author 한가람
 */
@Getter
@Setter
@ToString
public class DashPhysicalHistDTO {
	private String id;
	private String month;
	private String regdate;
	private String height;
	private String weight;
	
}
