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
	
	
	public ArrayList<CommunityDTO> Bulletin_list(int page, String word, int pageSize, String searchSel) {
		ArrayList<CommunityDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM (" +
					"SELECT a.*, ROWNUM rnum FROM (" +
					"SELECT bp.*, m.member_nickname as nickname, " +
					"bph.bulletin_post_header_name as post_header_name " +
					"FROM bulletin_post bp " +
					"LEFT JOIN member m ON bp.creator_id = m.member_id " +
					"LEFT JOIN bulletin_post_header bph ON bp.bulletin_post_header_no = bph.bulletin_post_header_no " +
					"WHERE 1=1 ";

		try {
			// 검색어가 있는 경우
			if (word != null && !word.trim().isEmpty()) {
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject":
							sql += "AND bp.bulletin_post_subject LIKE ? ";
							break;
						case "post_subject&post_content":
							sql += "AND (bp.bulletin_post_subject LIKE ? OR bp.bulletin_post_content LIKE ?) ";
							break;
						case "creator_id":
							sql += "AND m.member_id LIKE ? OR m.member_nickname LIKE ?";
							break;
						case "regdate":
							sql += "AND TO_CHAR(bp.regdate, 'YYYY-MM-DD') LIKE ? ";
							break;
						default:
							sql += "AND (bp.bulletin_post_subject LIKE ? OR m.member_id LIKE ? OR bph.bulletin_post_header_name LIKE ?) ";
					}
				} else {
					sql += "AND (bp.bulletin_post_subject LIKE ? OR m.member_id LIKE ? OR bph.bulletin_post_header_name LIKE ?) ";
				}
			}

			sql += "ORDER BY bp.bulletin_post_no DESC" +
				   ") a WHERE ROWNUM <= ?" +
				   ") WHERE rnum > ?";

			pstat = conn.prepareStatement(sql);
			int paramIndex = 1;

			// 검색어가 있는 경우
			if (word != null && !word.trim().isEmpty()) {
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject":
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						case "post_subject&post_content":
							pstat.setString(paramIndex++, "%" + word + "%");
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						case "creator_id":
							pstat.setString(paramIndex++, "%" + word + "%");
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						case "regdate":
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						default:
							pstat.setString(paramIndex++, "%" + word + "%");
							pstat.setString(paramIndex++, "%" + word + "%");
							pstat.setString(paramIndex++, "%" + word + "%");
					}
				} else {
					pstat.setString(paramIndex++, "%" + word + "%");
					pstat.setString(paramIndex++, "%" + word + "%");
					pstat.setString(paramIndex++, "%" + word + "%");
				}
			}

			// 페이지네이션 파라미터
			pstat.setInt(paramIndex++, page * pageSize);  // ROWNUM <= ?
			pstat.setInt(paramIndex, (page - 1) * pageSize);  // rnum > ?

			rs = pstat.executeQuery();
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setPost_no(rs.getString("bulletin_post_no"));
				dto.setPost_subject(rs.getString("bulletin_post_subject"));
				dto.setNickname(rs.getString("nickname"));
				dto.setHeader_name(rs.getString("post_header_name"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPost_recommend(rs.getString("bulletin_post_recommend"));
				dto.setPost_record_cnt(rs.getString("post_record_cnt"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
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
	
	public int getTotalBulletinPosts() {
		try {
			//게시판 게시글 갯수 카운트
			String sql = "SELECT COUNT(*) as total FROM bulletin_post";
			rs = stat.executeQuery(sql);
			if (rs.next()) {
				return rs.getInt("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public void close() {
		
		try {
			
			//DB 연결 해제(X) > DBCP에 반납
			this.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	// 게시판 헤더 이름 조회
	public ArrayList<CommunityDTO> getHeaderList() {
	    try {
	        String sql = "SELECT bulletin_post_header_no as header_no, bulletin_post_header_name as header_name FROM bulletin_post_header";
	        rs = stat.executeQuery(sql);
	        
	        ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
	        while (rs.next()) {
	            CommunityDTO dto = new CommunityDTO();
	            dto.setHeader_no(rs.getString("header_no"));
	            dto.setHeader_name(rs.getString("header_name"));
	            list.add(dto);
	        }
	        
	        return list;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	public int getTotalPosts(String searchWord, String searchSel) {
		int total = 0;
		String sql = "SELECT COUNT(*) as total FROM bulletin_post bp " +
					"LEFT JOIN member m ON bp.creator_id = m.member_id " +
					"LEFT JOIN bulletin_post_header bph ON bp.bulletin_post_header_no = bph.bulletin_post_header_no " +
					"WHERE 1=1 ";

		try {
			// 검색어가 있는 경우
			if (searchWord != null && !searchWord.trim().isEmpty()) {
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject":
							sql += "AND bp.bulletin_post_subject LIKE ? ";
							break;
						case "post_subject&post_content":
							sql += "AND (bp.bulletin_post_subject LIKE ? OR bp.bulletin_post_content LIKE ?) ";
							break;
						case "creator_id":
							sql += "AND m.member_id LIKE ? OR m.member_nickname LIKE ?";
							break;
						case "regdate":
							sql += "AND TO_CHAR(bp.regdate, 'YYYY-MM-DD') LIKE ? ";
							break;
						default:
							sql += "AND (bp.bulletin_post_subject LIKE ? OR m.member_id LIKE ? OR bph.bulletin_post_header_name LIKE ?) ";
					}
				} else {
					sql += "AND (bp.bulletin_post_subject LIKE ? OR m.member_id LIKE ? OR bph.bulletin_post_header_name LIKE ?) ";
				}
			}

			pstat = conn.prepareStatement(sql);
			if (searchWord != null && !searchWord.trim().isEmpty()) {
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject":
							pstat.setString(1, "%" + searchWord + "%");
							break;
						case "post_subject&post_content":
							pstat.setString(1, "%" + searchWord + "%");
							pstat.setString(2, "%" + searchWord + "%");
							break;
						case "creator_id":
							pstat.setString(1, "%" + searchWord + "%");
							pstat.setString(2, "%" + searchWord + "%");
							break;
						case "regdate":
							pstat.setString(1, "%" + searchWord + "%");
							break;
						default:
							pstat.setString(1, "%" + searchWord + "%");
							pstat.setString(2, "%" + searchWord + "%");
							pstat.setString(3, "%" + searchWord + "%");
					}
				} else {
					pstat.setString(1, "%" + searchWord + "%");
					pstat.setString(2, "%" + searchWord + "%");
					pstat.setString(3, "%" + searchWord + "%");
				}
			}
			
			rs = pstat.executeQuery();
			if (rs.next()) {
				total = rs.getInt("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}

}






