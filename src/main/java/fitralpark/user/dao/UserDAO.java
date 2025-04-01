package fitralpark.user.dao;

import fitralpark.common.utils.DBUtil;
import fitralpark.user.dto.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	// 회원 가입 (INSERT)
	public int insertMember(UserDTO dto) {
		String sql = "INSERT INTO member (member_no, member_id, pw, member_nickname, member_name, personalnumber, tel, email, address, member_pic, background_pic, allergy, fitness_score, community_score, restrict_check, withdraw_check, mentor_check, admin_check, plan_public_check) "
				+ "VALUES (SEQMEMBER.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, dto.getMemberId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getMemberNickname());
			pstmt.setString(4, dto.getMemberName());
			pstmt.setString(5, dto.getPersonalNumber());
			pstmt.setString(6, dto.getTel());
			pstmt.setString(7, dto.getEmail());
			pstmt.setString(8, dto.getAddress());
			pstmt.setString(9, dto.getMemberPic());
			pstmt.setString(10, dto.getBackgroundPic());
			pstmt.setString(11, dto.getAllergy());
			pstmt.setInt(12, dto.getFitnessScore());
			pstmt.setInt(13, dto.getCommunityScore());
			pstmt.setInt(14, dto.getRestrictCheck());
			pstmt.setInt(15, dto.getWithdrawCheck());
			pstmt.setInt(16, dto.getMentorCheck());
			pstmt.setInt(17, dto.getAdminCheck());
			pstmt.setInt(18, dto.getPlanPublicCheck());

			System.out.println("[DEBUG] 회원가입 시도: " + dto);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			System.err.println("[회원가입 실패 - 예외 발생]");
			e.printStackTrace();
		}

		return 0;
	}

	// 회원 정보 수정 (UPDATE)
	public int updateMember(UserDTO dto) {
		String sql = "UPDATE member SET "
				+ "pw = ?, member_pic = ?, background_pic = ?, member_nickname = ?, member_name = ?, "
				+ "personalnumber = ?, allergy = ?, tel = ?, email = ?, address = ?, "
				+ "fitness_score = ?, community_score = ?, restrict_check = ?, withdraw_check = ?, "
				+ "mentor_check = ?, admin_check = ?, plan_public_check = ? " + "WHERE member_no = ?";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getMemberPic());
			pstmt.setString(3, dto.getBackgroundPic());
			pstmt.setString(4, dto.getMemberNickname());
			pstmt.setString(5, dto.getMemberName());
			pstmt.setString(6, dto.getPersonalNumber());
			pstmt.setString(7, dto.getAllergy());
			pstmt.setString(8, dto.getTel());
			pstmt.setString(9, dto.getEmail());
			pstmt.setString(10, dto.getAddress());
			pstmt.setInt(11, dto.getFitnessScore());
			pstmt.setInt(12, dto.getCommunityScore());
			pstmt.setInt(13, dto.getRestrictCheck());
			pstmt.setInt(14, dto.getWithdrawCheck());
			pstmt.setInt(15, dto.getMentorCheck());
			pstmt.setInt(16, dto.getAdminCheck());
			pstmt.setInt(17, dto.getPlanPublicCheck());
			pstmt.setInt(18, dto.getMemberNo());

			System.out.println("[DEBUG] 회원가입 시도: " + dto);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			System.err.println("[회원정보 수정 실패 - 예외 발생]");
			e.printStackTrace();
		}

		return 0;
	}

	// 아이디 중복 확인
	public boolean isDuplicateId(String id) {
		String sql = "SELECT COUNT(*) FROM member WHERE member_id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				int count = rs.getInt(1);
				return count > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
