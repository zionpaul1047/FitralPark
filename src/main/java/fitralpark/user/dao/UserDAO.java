package fitralpark.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import fitralpark.user.dto.UserDTO;
import fitralpark.common.utils.DBUtil;

//사용자 관련 DB CRUD 담당

public class UserDAO {

    public int insertMember(UserDTO user) {
        int result = 0;

        String sql = "INSERT INTO member (member_no, member_id, pw, member_nickname, member_name, personalnumber, "
                   + "tel, email, address, member_pic, background_pic, allergy, fitness_score, community_score, "
                   + "restrict_check, withdraw_check, mentor_check, admin_check, plan_public_check) "
                   + "VALUES (SEQMEMBER.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0, 0, 0, 0, 0, 0)";

        try (
            Connection conn = DBUtil.getConnection(); // DB 연결
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setString(1, user.getMemberId());
            pstmt.setString(2, user.getPw());
            pstmt.setString(3, user.getMemberNickname());
            pstmt.setString(4, user.getMemberName());
            pstmt.setString(5, user.getPersonalNumber());
            pstmt.setString(6, user.getTel());
            pstmt.setString(7, user.getEmail());
            pstmt.setString(8, user.getAddress());
            pstmt.setString(9, user.getMemberPic());
            pstmt.setString(10, user.getBackgroundPic());
            pstmt.setString(11, user.getAllergy());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result; // 성공 시 1, 실패 시 0
    }
}
