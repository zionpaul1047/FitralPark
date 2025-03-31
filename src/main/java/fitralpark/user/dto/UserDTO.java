package fitralpark.user.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserDTO {
	
	//회원 기본정보
    private int memberNo;							//식별번호(PK)
    private String memberId;						//아이디
    private String pw;								//비밀번호
    private String memberNickname;					//닉네임
    private String memberName;						//회원이름
    private String personalNumber;					//주민등록번호
    private String tel;								//전화번호
    private String email;							//이메일
    private String address;							//주소

    //회원 추가정보
    private String memberPic;						//프로필사진
    private String backgroundPic;					//배경사진
    private String allergy;							//알러지 정보

    //기타 정보
    private int fitnessScore;						//운동점수
    private int communityScore;						//커뮤니티점수
    private int restrictCheck;						//정지여부
    private int withdrawCheck;						//탈퇴여부
    private int mentorCheck;						//멘토등급여부
    private int adminCheck;							//권한등급
    private int planPublicCheck;					//계획정보공개여부
    
}
