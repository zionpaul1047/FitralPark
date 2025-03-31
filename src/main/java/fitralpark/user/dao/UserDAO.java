package fitralpark.user.dao;

import fitralpark.common.utils.DBUtil;
import fitralpark.user.dto.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAO {

    public int insertMember(UserDTO dto) {
        String sql = "INSERT INTO member (member_no, member_id, pw, member_nickname, member_name, personalnumber, tel, email, address, member_pic, background_pic, allergy, fitness_score, community_score, restrict_check, withdraw_check, mentor_check, admin_check, plan_public_check) "
                   + "VALUES (SEQMEMBER.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0, 0, 0, 0, 0, 0)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

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

            return pstmt.executeUpdate(); // 성공 시 1 반환

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0; // 실패 시 0 반환
    }
}
