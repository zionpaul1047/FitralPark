package fitralpark.comunity.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//(데이터 전달 DTO 클래스 자리)

@Getter
@Setter
@ToString
public class CommunityDTO {
	
	private String post_no;
	private String post_subject;
	private String post_content;
	private String private_check;
	private String post_recommend;
	private String post_decommend;
	private String post_record_cnt;
	private String regdate;
	private String creator_id;
	private String header_no;
	private String comment_no;
	private String header_name;
	
	private String nickname;
	private String post_header_name;
}
