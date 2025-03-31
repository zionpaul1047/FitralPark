package fitralpark.comunity.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


import fitralpark.comunity.dto.CommunityDTO;

//(DB 접근 DAO 클래스 자리)
public class CommunityDAO {

	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	
	public CommunityDAO() {
		
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
	
	public int Bulletin_add(CommunityDTO dto) {
		
		try {
			
			String sql = "insert into bulletin_post (bulletin_post_no, bulletin_post_subject, bulletin_post_content, private_check, bulletin_post_recommend, bulletin_post_decommend, post_record_cnt, regdate, creator_id, bulletin_post_header_no) values (seq_bulletin_post_no.nextVal, ?, ?, ?, default, default, default, sysdate, ?, ?)";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getPost_subject());
			pstat.setString(2, dto.getPost_content());
			pstat.setString(3, dto.getPrivate_check());
			pstat.setString(4, dto.getCreator_id());
			pstat.setString(5, dto.getHeader_no());
			
			return pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int Announcement_add(CommunityDTO dto) {
		
			try {
				
				String sql = "insert into announcement_post (announcement_post_no, announcement_post_subject, announcement_post_content, private_check, announcement_post_recommend, announcement_post_decommend, post_record_cnt, regdate, creator_id, announcement_post_header_no) values (seq_announcement_post_no.nextVal, ?, ?, ?, default, default, default, sysdate, ?, ?)";
				
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, dto.getPost_subject());
				pstat.setString(2, dto.getPost_content());
				pstat.setString(3, dto.getPrivate_check());
				pstat.setString(4, dto.getCreator_id());
				pstat.setString(5, dto.getHeader_no());
			
			return pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int Qna_add(CommunityDTO dto) {
		
		try {
			
			String sql = "insert into qna_comment (qna_post_no, qna_post_subject, qna_post_content, private_check, qna_post_recommend, qna_post_decommend, post_record_cnt, regdate, creator_id, qna_post_header_no) values (seq_qna_post_no.nextVal, ?, ?, ?, default, default, default, sysdate, ?, ?)";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getPost_subject());
			pstat.setString(2, dto.getPost_content());
			pstat.setString(3, dto.getPrivate_check());
			pstat.setString(4, dto.getCreator_id());
			pstat.setString(5, dto.getHeader_no());
			
			return pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	
public ArrayList<CommunityDTO> Bulletin_list() {
		
		try {
			
			ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
			
			String sql = "SELECT b.bulletin_post_no, b.bulletin_post_subject, "
					+ "m.member_nickname, h.bulletin_post_header_name as post_header_name, "
					+ "b.creator_id, TO_CHAR(b.regdate, 'yyyy-mm-dd') as regdate, "
					+ "b.bulletin_post_recommend, b.post_record_cnt "
					+ "FROM bulletin_post b "
					+ "LEFT JOIN member m ON b.creator_id = m.member_id "
					+ "LEFT JOIN bulletin_post_header h ON b.bulletin_post_header_no = h.bulletin_post_header_no "
					+ "ORDER BY b.bulletin_post_no DESC";
			
			rs = stat.executeQuery(sql);
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				
                dto.setPost_no(rs.getString("bulletin_post_no"));
                dto.setPost_subject(rs.getString("bulletin_post_subject"));
                dto.setNickname(rs.getString("member_nickname"));
                dto.setPost_header_name(rs.getString("post_header_name"));
                dto.setCreator_id(rs.getString("creator_id"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setPost_recommend(rs.getString("bulletin_post_recommend"));
                dto.setPost_record_cnt(rs.getString("post_record_cnt"));
				
				list.add(dto);
			}
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public ArrayList<CommunityDTO> Announcement_list() {
		
		try {
			
			ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
			
			String sql = "select announcement_post_no, announcement_post_subject,"
					+ "        (select member_nickname from member where creator_id = member.member_id) as member_nickname,"
					+ "        creator_id, to_char(regdate, 'yyyy-mm-dd') as regdate,"
					+ "        announcement_post_recommend,"
					+ "        post_record_cnt from announcement_post order by announcement_post_no desc";
			
			rs = stat.executeQuery(sql);
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				
				dto.setPost_subject("announcement_post_subject");
				dto.setNickname("member_nickname");
				dto.setCreator_id("creator_id");
				dto.setRegdate(rs.getString("regdate"));
				dto.setPost_recommend("announcement_post_recommend");
				dto.setPost_record_cnt("post_record_cnt");
				
				list.add(dto);
			}
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public ArrayList<CommunityDTO> Qna_list() {
		
		try {
			
			ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
			
			String sql = "select qna_post_no, qna_post_subject,"
					
					+ "        (select member_nickname from member where creator_id = member.member_id) as member_nickname,"
					+ "        creator_id, to_char(regdate, 'yyyy-mm-dd') as regdate,"
					+ "        qna_post_recommend,"
					+ "        post_record_cnt from qna_post order by qna_post_no desc";
			
			rs = stat.executeQuery(sql);
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				
				dto.setPost_subject("qna_post_subject");
				dto.setNickname("member_nickname");
				dto.setCreator_id("creator_id");
				dto.setRegdate(rs.getString("regdate"));
				dto.setPost_recommend("qna_post_recommend");
				dto.setPost_record_cnt("post_record_cnt");
				
				list.add(dto);
			}
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public void close() {
		
		try {
			
			//DB 연결 해제(X) > DBCP에 반납
			this.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
