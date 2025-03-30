package fitralpark.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import fitralpark.user.dto.UserDTO;

//사용자 관련 DB CRUD 담당
public class UserDAO {
	
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	
	public UserDAO() {
		
		try {
			
			Context ctx = new InitialContext();
			Context env = (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/pool");
			
			conn = ds.getConnection();
			stat = conn.createStatement();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void close() {
		try {
			this.conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public UserDTO login(UserDTO dto) {
		
		try {
			
			String sql = "select * from member where member_id = ? and pw = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getMemberId());
			pstat.setString(2, dto.getPw());
			
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				//로그인 성공
				UserDTO result = new UserDTO();
				
				result.setMemberId(rs.getString("member_id"));
				result.setMemberName(rs.getString("member_name"));
				result.setMemberPic(rs.getString("member_pic"));
				
				return result;
				
			} else {
				//로그인 실패
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
}
