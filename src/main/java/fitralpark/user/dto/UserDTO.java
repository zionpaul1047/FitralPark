package fitralpark.user.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//사용자 데이터를 담는 객체

@Getter
@Setter
@ToString
public class UserDTO {
	private String memberNo;
	private String memberId;
	private String pw;
	private String memberPic;
	private String backgroundPic;
	private String memberNickname;
	private String memberName;
	private String personalNumber;
	private String allergy;
	private String tel;
	private String email;
	private String address;
	private String fitnessScore;
	private String communityScore;
	private String restrictCheck;
	private String withdrawCheck;
	private String mentorCheck;
	private String adminCheck;
	private String planPublicCheck;
}
