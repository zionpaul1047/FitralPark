package fitralpark.user.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserDTO {

    // 회원 기본정보
    private int memberNo;                  // 식별번호(PK)
    private String memberId;               // 아이디
    private String pw;                     // 비밀번호
    private String memberNickname;         // 닉네임
    private String memberName;             // 이름
    private String personalNumber;         // 주민등록번호
    private String tel;                    // 전화번호
    private String email;                  // 이메일
    private String address;                // 주소

    // 프로필 관련
    private String memberPic;              // 프로필 사진 경로
    private String backgroundPic;          // 배경 사진 경로

    // 건강 정보
    private String allergy;                // 알러지 정보

    // 시스템 관리 정보
    private int fitnessScore;              // 운동점수
    private int communityScore;            // 커뮤니티점수
    private int restrictCheck;             // 계정 정지 여부 (0:정상, 1:정지)
    private int withdrawCheck;             // 탈퇴 여부 (0:가입중, 1:탈퇴)
    private int mentorCheck;               // 멘토 여부
    private int adminCheck;                // 관리자 여부
    private int planPublicCheck;           // 운동계획 공개 여부 (0:비공개, 1:공개)
}
