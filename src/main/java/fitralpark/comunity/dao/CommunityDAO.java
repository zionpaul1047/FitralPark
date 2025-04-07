package fitralpark.comunity.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

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
	
	public int Bulletin_post_add(CommunityDTO communityDto, UserDTO userDto) {
		
		try {
			
			String sql = "insert into bulletin_post (bulletin_post_no, bulletin_post_subject, bulletin_post_content, private_check, bulletin_post_recommend, bulletin_post_decommend, post_record_cnt, regdate, creator_id, bulletin_post_header_no) values (SEQ_BULLETIN_POST_NO.nextVal, ?, ?, default, default, default, default, sysdate, ?, ?)";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, communityDto.getPost_subject());
			pstat.setString(2, communityDto.getPost_content());
			pstat.setString(3, userDto.getMemberId());
			pstat.setString(4, communityDto.getHeader_no());
			
			return pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int Announcement_post_add(CommunityDTO dto, UserDTO userDto) {
		try {
			// admin 체크
			String checkSql = "SELECT admin_check FROM member WHERE member_id = ?";
			pstat = conn.prepareStatement(checkSql);
			pstat.setString(1, userDto.getMemberId());
			rs = pstat.executeQuery();
			
			if (rs.next() && "1".equals(rs.getString("admin_check"))) {
				String sql = "INSERT INTO announcement_post (announcement_post_no, announcement_post_subject, announcement_post_content, private_check, announcement_post_recommend, announcement_post_decommend, post_record_cnt, regdate, creator_id, announcement_post_header_no) VALUES (seq_announcement_post_no.nextVal, ?, ?, ?, default, default, default, sysdate, ?, ?)";
				
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, dto.getPost_subject());
				pstat.setString(2, dto.getPost_content());
				pstat.setString(3, dto.getPrivate_check());
				pstat.setString(4, userDto.getMemberId());
				pstat.setString(5, dto.getHeader_no());
				
				return pstat.executeUpdate();
			}
			
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
	
	
	//자유 게시판 불러오기
	public ArrayList<CommunityDTO> Bulletin_list(int page, String word, int pageSize, String searchSel, String searchCategory) {
		ArrayList<CommunityDTO> list = new ArrayList<>();
		

		try {
			
			String sql = "SELECT * FROM (" +
					"SELECT a.*, ROWNUM rnum FROM (" +
					"SELECT bp.*, m.member_nickname as nickname, " +
					"bph.bulletin_post_header_name as post_header_name " +
					"FROM bulletin_post bp " +
					"LEFT JOIN member m ON bp.creator_id = m.member_id " +
					"LEFT JOIN bulletin_post_header bph ON bp.bulletin_post_header_no = bph.bulletin_post_header_no " +
					"WHERE 1=1 ";
			
			// 검색어가 있는 경우
			if (word != null && !word.trim().isEmpty()) {
				// 검색어가 있고 searchSel이 입력 돼 있는 경우
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject": //범위: 제목
							sql += "AND bp.bulletin_post_subject LIKE ? ";
							break;
						case "post_subject&post_content": //범위: 제목 + 내용
							sql += "AND (bp.bulletin_post_subject LIKE ? OR bp.bulletin_post_content LIKE ?) ";
							break;
						case "creator_id": //범위: 작성자
							sql += "AND m.member_id LIKE ? OR m.member_nickname LIKE ? ";
							break;
						case "regdate": //범위: 날짜
							sql += "AND TO_CHAR(bp.regdate, 'YYYY-MM-DD') LIKE ? ";
							break;
						default: //범위: 전체
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
						case "post_subject": //범위: 제목
							pstat.setString(paramIndex++, "%" + word + "%");
							break; 
						case "post_subject&post_content": //범위: 제목 + 내용
							pstat.setString(paramIndex++, "%" + word + "%");
							pstat.setString(paramIndex++, "%" + word + "%");
							break; 
						case "creator_id": //범위: 작성자
							pstat.setString(paramIndex++, "%" + word + "%");
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						case "regdate": //범위: 날짜
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						default: // 전체
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
				dto.setViews(rs.getString("views"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//공지사항 불러오기
	public ArrayList<CommunityDTO> Announcement_list(int page, String word, int pageSize, String searchSel, String searchCategory) {
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		
		try {
			String sql = "SELECT * FROM (" +
					"SELECT a.*, ROWNUM rnum FROM (" +
					"SELECT ap.announcement_post_no, ap.announcement_post_subject, ap.announcement_post_content, " +
					"ap.creator_id, ap.regdate, ap.views, ap.announcement_post_recommend, ap.announcement_post_decommend, " +
					"m.member_nickname as nickname, " +
					"aph.announcement_post_header_name as post_header_name " +
					"FROM announcement_post ap " +
					"LEFT JOIN member m ON ap.creator_id = m.member_id " +
					"LEFT JOIN announcement_post_header aph ON ap.announcement_post_header_no = aph.announcement_post_header_no " +
					"WHERE 1=1 ";

			// 검색어가 있는 경우
			if (word != null && !word.trim().isEmpty()) {
				// 검색어가 있고 searchSel이 입력된 경우
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject": //범위: 제목
							sql += "AND ap.announcement_post_subject LIKE ? ";
							break;
						case "post_subject&post_content": //범위: 제목 + 내용
							sql += "AND (ap.announcement_post_subject LIKE ? OR ap.announcement_post_content LIKE ?) ";
							break;
						case "creator_id": //범위: 작성자
							sql += "AND m.member_id LIKE ? OR m.member_nickname LIKE ? ";
							break;
						case "regdate": //범위: 날짜
							sql += "AND TO_CHAR(ap.regdate, 'YYYY-MM-DD') LIKE ? ";
							break;
						default: //범위: 전체
							sql += "AND (ap.announcement_post_subject LIKE ? OR m.member_id LIKE ? OR aph.announcement_post_header_name LIKE ?) ";
					}
				} else {
					sql += "AND (ap.announcement_post_subject LIKE ? OR m.member_id LIKE ? OR aph.announcement_post_header_name LIKE ?) ";
				}
			}

			sql += "ORDER BY ap.announcement_post_no DESC" +
				   ") a WHERE ROWNUM <= ?" +
				   ") WHERE rnum > ?";

			pstat = conn.prepareStatement(sql);
			int paramIndex = 1;

			// 검색어가 있는 경우
			if (word != null && !word.trim().isEmpty()) {
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject": //범위: 제목
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						case "post_subject&post_content": //범위: 제목 + 내용
							pstat.setString(paramIndex++, "%" + word + "%");
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						case "creator_id": //범위: 작성자
							pstat.setString(paramIndex++, "%" + word + "%");
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						case "regdate": //범위: 날짜
							pstat.setString(paramIndex++, "%" + word + "%");
							break;
						default: //범위: 전체
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
				dto.setPost_no(rs.getString("announcement_post_no"));
				dto.setPost_subject(rs.getString("announcement_post_subject"));
				dto.setPost_content(rs.getString("announcement_post_content"));
				dto.setNickname(rs.getString("nickname"));
				dto.setHeader_name(rs.getString("post_header_name"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPost_recommend(rs.getString("announcement_post_recommend"));
				dto.setPost_decommend(rs.getString("announcement_post_decommend"));
				dto.setViews(rs.getString("views"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("Announcement_list 오류: " + e.getMessage());
			e.printStackTrace();
		}
		
		return list;
	}
	
	//Q&A 불러오기
	public ArrayList<CommunityDTO> Qna_list() {
		
		try {
			
			ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
			
			String sql = "select qna_post_no, qna_post_subject,"
					
					+ "        (select member_nickname from member where creator_id = member.member_id) as member_nickname,"
					+ "        creator_id, to_char(regdate, 'yyyy-mm-dd') as regdate,"
					+ "        qna_post_recommend,"
					+ "        views from qna_post order by qna_post_no desc";
			
			
			rs = stat.executeQuery(sql);
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				
				dto.setPost_subject("qna_post_subject");
				dto.setNickname("member_nickname");
				dto.setCreator_id("creator_id");
				dto.setRegdate(rs.getString("regdate"));
				dto.setPost_recommend("qna_post_recommend");
				dto.setViews("views");
				
				list.add(dto);
				
			}
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//갯수 세기
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

	
	public int getTotalPosts(String searchWord, String searchSel, String searchCategory) {
		int total = 0;
		

		try {
			String sql = "SELECT COUNT(*) as total FROM bulletin_post bp " +
					"LEFT JOIN member m ON bp.creator_id = m.member_id " +
					"LEFT JOIN bulletin_post_header bph ON bp.bulletin_post_header_no = bph.bulletin_post_header_no " +
					"WHERE 1=1 ";
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

	//공지사항 게시글 불러오기
	public CommunityDTO getAnnouncementPost(String post_no, HttpSession session) {
		PreparedStatement pstat1 = null;
		PreparedStatement pstat2 = null;
		CommunityDTO dto = null;
		
		try {
			//session으로 체크
			String visitedKey = "visited_announcement_" + post_no;
			Boolean visited = (Boolean) session.getAttribute(visitedKey);
			
			if (visited == null) {
				String sql1 = "UPDATE announcement_post SET views = views + 1 WHERE announcement_post_no = ?";
				pstat1 = conn.prepareStatement(sql1);
				pstat1.setString(1, post_no);
				int updateResult = pstat1.executeUpdate();
				
				session.setAttribute(visitedKey, true);
			}
			
			String sql2 = "SELECT ap.*, m.member_nickname as nickname, aph.announcement_post_header_name as header_name " +
					"FROM announcement_post ap " +
					"LEFT JOIN member m ON ap.creator_id = m.member_id " +
					"LEFT JOIN announcement_post_header aph ON ap.announcement_post_header_no = aph.announcement_post_header_no " +
					"WHERE ap.announcement_post_no = ?";

			pstat2 = conn.prepareStatement(sql2);
			pstat2.setString(1, post_no);
			rs = pstat2.executeQuery();
			
			if(rs.next()) {
				dto = new CommunityDTO();
				dto.setPost_no(rs.getString("announcement_post_no"));
				dto.setPost_subject(rs.getString("announcement_post_subject"));
				dto.setPost_content(rs.getString("announcement_post_content"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViews(rs.getString("views"));
				dto.setPost_recommend(rs.getString("announcement_post_recommend"));
				dto.setPost_decommend(rs.getString("announcement_post_decommend"));
				dto.setHeader_name(rs.getString("header_name"));
				dto.setHeader_no(rs.getString("announcement_post_header_no"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	//게시글 불러오기
	public CommunityDTO getPost(String post_no, HttpSession session) {
		PreparedStatement pstat1 = null;
		PreparedStatement pstat2 = null;
		CommunityDTO dto = null;
		
		try {
			//session으로 체크
			String visitedKey = "visited_" + post_no;
			Boolean visited = (Boolean) session.getAttribute(visitedKey);
			
			if (visited == null) {
				String sql1 = "UPDATE bulletin_post SET views = views + 1 WHERE bulletin_post_no = ?";
				pstat1 = conn.prepareStatement(sql1);
				pstat1.setString(1, post_no);
				int updateResult = pstat1.executeUpdate();
				
				session.setAttribute(visitedKey, true);
			}
			
			String sql2 = "SELECT bp.*, m.member_nickname as nickname, bph.bulletin_post_header_name as header_name " +
					"FROM bulletin_post bp " +
					"LEFT JOIN member m ON bp.creator_id = m.member_id " +
					"LEFT JOIN bulletin_post_header bph ON bp.bulletin_post_header_no = bph.bulletin_post_header_no " +
					"WHERE bp.bulletin_post_no = ?";

			pstat2 = conn.prepareStatement(sql2);
			pstat2.setString(1, post_no);
			rs = pstat2.executeQuery();
			
			if(rs.next()) {
				dto = new CommunityDTO();
				dto.setPost_no(rs.getString("bulletin_post_no"));
				dto.setPost_subject(rs.getString("bulletin_post_subject"));
				dto.setPost_content(rs.getString("bulletin_post_content"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViews(rs.getString("views"));
				dto.setPost_recommend(rs.getString("bulletin_post_recommend"));
				dto.setPost_decommend(rs.getString("bulletin_post_decommend"));
				dto.setHeader_name(rs.getString("header_name"));
				dto.setHeader_no(rs.getString("bulletin_post_header_no"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	//댓글 불러오기
	public ArrayList<CommunityDTO> Bulletin_Comment_list(String post_no) {
		try {
			String sql = "SELECT "
						+ "bc.bulletin_comment_no AS comment_no, "
						+ "bc.bulletin_comment_content AS comment_content, " 
						+ "bc.creator_id AS creator_id, " 
						+ "m.member_nickname AS nickname, " 
						+ "TO_CHAR(bc.regdate, 'YYYY-MM-DD HH24:MI:SS') AS regdate "
						+ "FROM bulletin_comment bc "
						+ "LEFT JOIN member m ON m.member_id = bc.creator_id "
						+ "WHERE bc.bulletin_post_no = ? "
						+ "ORDER BY bc.bulletin_comment_no DESC ";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			rs = pstat.executeQuery();
			
			ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setComment_no(rs.getString("comment_no"));
				dto.setComment_content(rs.getString("comment_content"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
    public int Bulletin_edit(CommunityDTO dto) {
		
		try {
			
			String sql = "UPDATE bulletin_post SET bulletin_post_subject = ?, bulletin_post_content = ?, bulletin_post_header_no = ? where bulletin_post_no = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getPost_subject());
			pstat.setString(2, dto.getPost_content());
			pstat.setString(3, dto.getHeader_no());
			pstat.setString(4, dto.getPost_no());

			return pstat.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
    
    
    
    
	public void close() {
		
		try {
			
			//DB 연결 해제(X) > DBCP에 반납
			if(rs != null) rs.close();
			if(pstat != null) pstat.close();
			if(stat != null) stat.close();
			if(conn != null) conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	//게시글 삭제 메서드
	public boolean bulletin_Del_Post(String post_no) {
		
		PreparedStatement pstat1 = null;
	    PreparedStatement pstat2 = null;
	    boolean success = false;
	    
		try {
			conn.setAutoCommit(false);
			
			//댓글 삭제
			conn.setAutoCommit(false);
            String sql1 = "DELETE FROM bulletin_comment WHERE bulletin_post_no = ?";
            pstat1 = conn.prepareStatement(sql1);
            pstat1.setString(1, post_no);
            
            pstat1.executeUpdate();
            
			//게시글 삭제
            String sql2 = "DELETE FROM bulletin_post WHERE bulletin_post_no = ?";
            pstat2 = conn.prepareStatement(sql2);
            pstat2.setString(1, post_no);
            
            pstat2.executeUpdate();
              
            conn.commit();  // 트랜잭션 커밋
            success = true;  // 성공 표시
            
        } catch (Exception e) {
        	try {
				conn.rollback();
			} catch (SQLException rollbackEx) { 
	            rollbackEx.printStackTrace();
			}
            e.printStackTrace();
            
        } finally {
            // 자원 정리
            try {
                if (pstat1 != null) pstat1.close();
                if (pstat2 != null) pstat2.close();
				conn.setAutoCommit(true);
            } catch (Exception closeEx) {
                closeEx.printStackTrace();
            }
        }
		
		return success;
	}

	
	
	
	
	
	//추천 비추천 추가 메서드
	public int bulletin_Vote_Record(CommunityDTO communityDto, UserDTO userDto) {
		PreparedStatement pstat1 = null;
	    PreparedStatement pstat2 = null;
		int result = 0;
		
		try {
			conn.setAutoCommit(false); 
			//추천, 비추천 기록
			String sql = "INSERT INTO bulletin_vote_record (bulletin_vote_record_no, bulletin_post_no, regdate, vote_check, member_id) values (seq_bulletin_vote_record_no.nextVal, ?, sysdate, ?, ?)";
			
			pstat = conn.prepareStatement(sql);
	        pstat.setString(1, communityDto.getPost_no());
	        pstat.setString(2, communityDto.getVote_check());
	        pstat.setString(3, userDto.getMemberId());
	        result = pstat.executeUpdate();
			
			//추천, 비추천 업데이트
	        if(communityDto.getVote_check().equals("0")) {
	        	String sql1 = "UPDATE bulletin_post SET bulletin_post_recommend = bulletin_post_recommend + 1 WHERE bulletin_post_no = ?";

				pstat1 = conn.prepareStatement(sql1);
				pstat1.setString(1, communityDto.getPost_no());
				pstat1.executeUpdate();


	        } else if(communityDto.getVote_check().equals("1")) {
	        	String sql2 = "UPDATE bulletin_post SET bulletin_post_decommend = bulletin_post_decommend + 1 WHERE bulletin_post_no = ?";

				pstat2 = conn.prepareStatement(sql2);
				pstat2.setString(1, communityDto.getPost_no());
				pstat2.executeUpdate();
	        }
	    
			conn.commit();  // 트랜잭션 커밋
	        
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstat1 != null) pstat1.close();
				if (pstat2 != null) pstat2.close();
				conn.setAutoCommit(true);  // 자동 커밋 모드 복원
			} catch (Exception closeEx) {
				closeEx.printStackTrace();
			}
		}
		
		return result;
		
	}

	//추천, 비추천 눌렀을 경우 체크 -> 있으면 삭제 및 업데이트
	public boolean bulletin_Vote_Check(CommunityDTO communityDto, UserDTO userDto) {
		
		PreparedStatement pstat1 = null;
		PreparedStatement pstat2 = null;
		PreparedStatement pstat3 = null;
		boolean success = false;

		try {
			conn.setAutoCommit(false);

			//추천, 비추천 기록 조회
			 String checkSql = "SELECT vote_check FROM bulletin_vote_record WHERE bulletin_post_no = ? AND member_id = ?";
	        pstat = conn.prepareStatement(checkSql);
	        pstat.setString(1, communityDto.getPost_no());
	        pstat.setString(2, userDto.getMemberId());
	        rs = pstat.executeQuery();
			
	        
	        
	        	
				if(rs.next()) {
				       
		        	String vote_check = rs.getString("vote_check");
		            // vote_check 값에 따른 처리
		        	if(vote_check.equals("0")) {
						
						String sql1 = "UPDATE bulletin_post SET bulletin_post_recommend = bulletin_post_recommend - 1 WHERE bulletin_post_no = ?";
						pstat1 = conn.prepareStatement(sql1);
						pstat1.setString(1, communityDto.getPost_no());
						pstat1.executeUpdate();

					} else if(vote_check.equals("1")) {

						String sql2 = "UPDATE bulletin_post SET bulletin_post_decommend = bulletin_post_decommend - 1 WHERE bulletin_post_no = ?";
						pstat2 = conn.prepareStatement(sql2);
						pstat2.setString(1, communityDto.getPost_no());
						pstat2.executeUpdate();

					} 

					//추천, 비추천 기록 삭제
					String sql3 = "DELETE FROM bulletin_vote_record WHERE bulletin_post_no = ? AND member_id = ?";
					pstat3 = conn.prepareStatement(sql3);
					pstat3.setString(1, communityDto.getPost_no());
					pstat3.setString(2, userDto.getMemberId());
					int deleteResult = pstat3.executeUpdate();

					if(deleteResult > 0) {
						conn.commit();
						success = true;
					}	
				        
				        
				}
				
		} catch (Exception e) {
			try {
            conn.rollback(); 
        } catch (Exception rollbackEx) {
            rollbackEx.printStackTrace();
        }
        e.printStackTrace();
		} finally {
	        try {
	            if (pstat1 != null) pstat1.close(); 
	            if (pstat2 != null) pstat2.close();
	            if (pstat3 != null) pstat3.close();
	            conn.setAutoCommit(true);
	        } catch (Exception closeEx) {
	            closeEx.printStackTrace();
	        }
    	}
   
    return success;
    
	}


	//댓글 삭제
	public boolean bulletin_Del_Comment(String comment_no) {
		try {
			String sql = "DELETE FROM bulletin_comment WHERE bulletin_comment_no = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, comment_no);
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	//댓글 쓰기
	public boolean bulletin_Write_Comment(String post_no, String comment_content, String creator_id) {
		try {
			String sql = "INSERT INTO bulletin_comment (bulletin_comment_no, bulletin_post_no, bulletin_comment_content, creator_id, regdate) VALUES (seq_bulletin_comment_no.nextVal, ?, ?, ?, sysdate)";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			pstat.setString(2, comment_content);
			pstat.setString(3, creator_id);
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	//댓글 수정
	public boolean bulletin_Edit_Comment(String comment_no, String comment_content) {
		try {
			String sql = "UPDATE bulletin_comment SET bulletin_comment_content = ? WHERE bulletin_comment_no = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, comment_content);
			pstat.setString(2, comment_no);
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// 공지사항 댓글 삭제
	public boolean announcement_Del_Comment(CommunityDTO communityDto) {
		try {
			String sql = "DELETE FROM announcement_comment WHERE announcement_comment_no = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, communityDto.getComment_no());
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 공지사항 댓글 수정
	public boolean announcement_Edit_Comment(CommunityDTO communityDto) {
		try {
			String sql = "UPDATE announcement_comment SET announcement_comment_content = ? WHERE announcement_comment_no = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, communityDto.getComment_content());
			pstat.setString(2, communityDto.getComment_no());
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 공지사항 댓글 작성
	public boolean announcement_Write_Comment(CommunityDTO communityDto) {
		try {
			String sql = "INSERT INTO announcement_comment (announcement_comment_no, announcement_post_no, announcement_comment_content, creator_id, regdate) VALUES (seq_announcement_comment_no.nextVal, ?, ?, ?, sysdate)";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, communityDto.getPost_no());
			pstat.setString(2, communityDto.getComment_content());
			pstat.setString(3, communityDto.getCreator_id());
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// 공지사항 추천/비추천 기록 추가
	public int announcement_Vote_Record(CommunityDTO communityDto, UserDTO userDto) {
		PreparedStatement pstat1 = null;
		int result = 0;
		
		try {
			conn.setAutoCommit(false); 
			//추천, 비추천 기록
			String sql = "INSERT INTO announcement_vote_record (announcement_vote_record_no, announcement_post_no, regdate, vote_check, member_id) VALUES (seq_announcement_vote_record_no.nextVal, ?, sysdate, ?, ?)";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, communityDto.getPost_no());
			pstat.setString(2, communityDto.getVote_check());
			pstat.setString(3, userDto.getMemberId());
			result = pstat.executeUpdate();
			
			//추천, 비추천 업데이트
			if(communityDto.getVote_check().equals("0")) {
				String sql1 = "UPDATE announcement_post SET announcement_post_recommend = announcement_post_recommend + 1 WHERE announcement_post_no = ?";

				pstat1 = conn.prepareStatement(sql1);
				pstat1.setString(1, communityDto.getPost_no());
				pstat1.executeUpdate();

			} else if(communityDto.getVote_check().equals("1")) {
				String sql2 = "UPDATE announcement_post SET announcement_post_decommend = announcement_post_decommend + 1 WHERE announcement_post_no = ?";

				pstat1 = conn.prepareStatement(sql2);
				pstat1.setString(1, communityDto.getPost_no());
				pstat1.executeUpdate();
			}
		
			conn.commit();  // 트랜잭션 커밋
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (pstat1 != null) pstat1.close();
				conn.setAutoCommit(true);
			} catch (Exception closeEx) {
				closeEx.printStackTrace();
			}
		}
		
		return result;
	}

	//공지사항 추천, 비추천 눌렀을 경우 체크 -> 있으면 삭제 및 업데이트
	public boolean announcement_Vote_Check(CommunityDTO communityDto, UserDTO userDto) {
		PreparedStatement pstat1 = null;
		PreparedStatement pstat2 = null;
		PreparedStatement pstat3 = null;
		boolean success = false;

		try {
			conn.setAutoCommit(false);

			//추천, 비추천 기록 조회
			String checkSql = "SELECT vote_check FROM announcement_vote_record WHERE announcement_post_no = ? AND member_id = ?";
			pstat = conn.prepareStatement(checkSql);
			pstat.setString(1, communityDto.getPost_no());
			pstat.setString(2, userDto.getMemberId());
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				String vote_check = rs.getString("vote_check");
				// vote_check 값에 따른 처리
				if ("0".equals(vote_check)) {
					String sql1 = "UPDATE announcement_post SET announcement_post_recommend = announcement_post_recommend - 1 WHERE announcement_post_no = ?";
					pstat1 = conn.prepareStatement(sql1);
					pstat1.setString(1, communityDto.getPost_no());
					pstat1.executeUpdate();
				} else {
					String sql2 = "UPDATE announcement_post SET announcement_post_decommend = announcement_post_decommend - 1 WHERE announcement_post_no = ?";
					pstat2 = conn.prepareStatement(sql2);
					pstat2.setString(1, communityDto.getPost_no());
					pstat2.executeUpdate();
				}
				
				// 추천, 비추천 기록 삭제
				String sql3 = "DELETE FROM announcement_vote_record WHERE announcement_post_no = ? AND member_id = ?";
				pstat3 = conn.prepareStatement(sql3);
				pstat3.setString(1, communityDto.getPost_no());
				pstat3.setString(2, userDto.getMemberId());
				int deleteResult = pstat3.executeUpdate();
				
				if (deleteResult > 0) {
					conn.commit();
					success = true;
				}
			}
			
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception rollbackEx) {
				rollbackEx.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (pstat1 != null) pstat1.close();
				if (pstat2 != null) pstat2.close();
				if (pstat3 != null) pstat3.close();
				conn.setAutoCommit(true);
			} catch (Exception closeEx) {
				closeEx.printStackTrace();
			}
		}
		
		return success;
	}

	// 공지사항 댓글 목록 조회
	public ArrayList<CommunityDTO> Announcement_Comment_list(String post_no) {
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		
		try {
			String sql = "SELECT ac.*, m.member_nickname "
					  + "FROM announcement_comment ac "
					  + "LEFT JOIN member m ON ac.creator_id = m.member_id "
					  + "WHERE ac.announcement_post_no = ? "
					  + "ORDER BY ac.announcement_comment_no ASC";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			rs = pstat.executeQuery();
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setComment_no(rs.getString("announcement_comment_no"));
				dto.setPost_no(rs.getString("announcement_post_no"));
				dto.setComment_content(rs.getString("announcement_comment_content"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("member_nickname"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	// 공지사항 총 게시물 수 조회
	public int getTotalAnnouncementPosts(String word, String searchSel, String searchCategory) {
		try {
			String sql = "SELECT COUNT(*) as total FROM announcement_post ap "
					  + "LEFT JOIN member m ON ap.creator_id = m.member_id " +
					  "LEFT JOIN announcement_post_header aph ON ap.announcement_post_header_no = aph.announcement_post_header_no " +
					  "WHERE 1=1 ";
			
			// 검색어가 있는 경우
			if (word != null && !word.trim().isEmpty()) {
				// 검색어가 있고 searchSel이 입력된 경우
				if (searchSel != null && !searchSel.isEmpty() && searchCategory == null && searchCategory.isEmpty()) {
					switch (searchSel) {
						case "post_subject": //범위: 제목
							sql += "AND ap.announcement_post_subject LIKE ? ";
							break;
						case "post_subject&post_content": //범위: 제목 + 내용
							sql += "AND (ap.announcement_post_subject LIKE ? OR ap.announcement_post_content LIKE ?) ";
							break;
						case "creator_id": //범위: 작성자
							sql += "AND (m.member_id LIKE ? OR m.member_nickname LIKE ?) ";
							break;
						case "regdate": //범위: 날짜
							sql += "AND TO_CHAR(ap.regdate, 'YYYY-MM-DD') LIKE ? ";
							break;
						default: //범위: 전체
							sql += "AND (ap.announcement_post_subject LIKE ? OR m.member_id LIKE ? OR aph.announcement_post_header_name LIKE ?) ";
					}
				} else {
					sql += "AND (ap.announcement_post_subject LIKE ? OR m.member_id LIKE ? OR aph.announcement_post_header_name LIKE ?) ";
				}
			}
			
			pstat = conn.prepareStatement(sql);
			int paramIndex = 1;
			
			// 검색어가 있는 경우 파라미터 설정
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
			
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				return rs.getInt("total");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	// 공지사항 헤더 이름 조회
	public ArrayList<CommunityDTO> getAnnouncementHeaderList() {
	    ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
	    try {
	        String sql = "SELECT announcement_post_header_no, announcement_post_header_name FROM announcement_post_header ORDER BY announcement_post_header_no ASC";
	        stat = conn.createStatement();
	        rs = stat.executeQuery(sql);
	        
	        while (rs.next()) {
	            CommunityDTO dto = new CommunityDTO();
	            dto.setHeader_no(rs.getString("announcement_post_header_no"));
	            dto.setHeader_name(rs.getString("announcement_post_header_name"));
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stat != null) stat.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return list;
	}

	//공지사항 게시글 삭제 메서드
	public boolean announcement_Del_Post(String post_no, UserDTO userDto) {
		PreparedStatement pstat1 = null;
		PreparedStatement pstat2 = null;
		boolean success = false;
		
		try {
			// admin 체크
			String checkSql = "SELECT admin_check FROM member WHERE member_id = ?";
			pstat = conn.prepareStatement(checkSql);
			pstat.setString(1, userDto.getMemberId());
			rs = pstat.executeQuery();
			
			if (rs.next() && "1".equals(rs.getString("admin_check"))) {
				conn.setAutoCommit(false);
				//댓글 삭제
				String sql1 = "DELETE FROM announcement_comment WHERE announcement_post_no = ?";
				pstat1 = conn.prepareStatement(sql1);
				pstat1.setString(1, post_no);
				
				pstat1.executeUpdate();
				
				//게시글 삭제
				String sql2 = "DELETE FROM announcement_post WHERE announcement_post_no = ?";
				pstat2 = conn.prepareStatement(sql2);
				pstat2.setString(1, post_no);
				
				pstat2.executeUpdate();
				  
				conn.commit();  // 트랜잭션 커밋
				success = true;  // 성공 표시
			}
			
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException rollbackEx) { 
				rollbackEx.printStackTrace();
			}
			e.printStackTrace();
			
		} finally {
			// 자원 정리
			try {
				if (pstat1 != null) pstat1.close();
				if (pstat2 != null) pstat2.close();
				conn.setAutoCommit(true);
			} catch (Exception closeEx) {
				closeEx.printStackTrace();
			}
		}
		
		return success;
	}

	// 공지사항 수정 (admin 체크 추가)
	public int announcement_Edit(CommunityDTO dto, UserDTO userDto) {
		try {
			// admin 체크
			String checkSql = "SELECT admin_check FROM member WHERE member_id = ?";
			pstat = conn.prepareStatement(checkSql);
			pstat.setString(1, userDto.getMemberId());
			rs = pstat.executeQuery();
			
			if (rs.next() && "1".equals(rs.getString("admin_check"))) {
				String sql = "UPDATE announcement_post SET announcement_post_subject = ?, announcement_post_content = ?, announcement_post_header_no = ? WHERE announcement_post_no = ?";
				
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, dto.getPost_subject());
				pstat.setString(2, dto.getPost_content());
				pstat.setString(3, dto.getHeader_no());
				pstat.setString(4, dto.getPost_no());
				
				return pstat.executeUpdate();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	//공지사항 게시글 수정
	public int announcement_Edit_Post(CommunityDTO dto, UserDTO userDto) {
		try {
			// admin 체크
			if (userDto.getAdminCheck() == 1) {
				String sql = "UPDATE announcement_post SET announcement_post_subject = ?, announcement_post_content = ?, announcement_post_header_no = ? WHERE announcement_post_no = ?";
				
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, dto.getPost_subject());
				pstat.setString(2, dto.getPost_content());
				pstat.setString(3, dto.getHeader_no());
				pstat.setString(4, dto.getPost_no());
				
				return pstat.executeUpdate();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	// QNA 게시글 목록 조회
	public ArrayList<CommunityDTO> Qna_list(int page, String word, int pageSize, String searchSel, String searchCategory) {
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		
		try {
			String sql = "SELECT * FROM (" +
					"SELECT a.*, ROWNUM rnum FROM (" +
					"SELECT qp.qna_post_no, qp.qna_post_subject, qp.qna_post_content, " +
					"qp.creator_id, qp.regdate, qp.views, qp.qna_post_recommend, qp.qna_post_decommend, " +
					"m.member_nickname as nickname, " +
					"qph.qna_post_header_name as post_header_name " +
					"FROM qna_post qp " +
					"LEFT JOIN member m ON qp.creator_id = m.member_id " +
					"LEFT JOIN qna_post_header qph ON qp.qna_post_header_no = qph.qna_post_header_no " +
					"WHERE 1=1 ";

			// 검색어가 있는 경우
			if (word != null && !word.trim().isEmpty()) {
				// 검색어가 있고 searchSel이 입력된 경우
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject": //범위: 제목
							sql += "AND qp.qna_post_subject LIKE ? ";
							break;
						case "post_subject&post_content": //범위: 제목 + 내용
							sql += "AND (qp.qna_post_subject LIKE ? OR qp.qna_post_content LIKE ?) ";
							break;
						case "creator_id": //범위: 작성자
							sql += "AND m.member_id LIKE ? OR m.member_nickname LIKE ? ";
							break;
						case "regdate": //범위: 날짜
							sql += "AND TO_CHAR(qp.regdate, 'YYYY-MM-DD') LIKE ? ";
							break;
						default: //범위: 전체
							sql += "AND (qp.qna_post_subject LIKE ? OR m.member_id LIKE ? OR qph.qna_post_header_name LIKE ?) ";
					}
				} else {
					sql += "AND (qp.qna_post_subject LIKE ? OR m.member_id LIKE ? OR qph.qna_post_header_name LIKE ?) ";
				}
			}

			// 말머리 검색
			if (searchCategory != null && !searchCategory.isEmpty()) {
				sql += "AND qp.qna_post_header_no = ? ";
			}

			sql += "ORDER BY qp.qna_post_no DESC" +
				   ") a WHERE ROWNUM <= ?) " +
				   "WHERE rnum > ?";

			pstat = conn.prepareStatement(sql);

			int parameterIndex = 1;

			// 검색어 파라미터 설정
			if (word != null && !word.trim().isEmpty()) {
				String searchWord = "%" + word + "%";
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject":
							pstat.setString(parameterIndex++, searchWord);
							break;
						case "post_subject&post_content":
							pstat.setString(parameterIndex++, searchWord);
							pstat.setString(parameterIndex++, searchWord);
							break;
						case "creator_id":
							pstat.setString(parameterIndex++, searchWord);
							pstat.setString(parameterIndex++, searchWord);
							break;
						case "regdate":
							pstat.setString(parameterIndex++, searchWord);
							break;
						default:
							pstat.setString(parameterIndex++, searchWord);
							pstat.setString(parameterIndex++, searchWord);
							pstat.setString(parameterIndex++, searchWord);
					}
				} else {
					pstat.setString(parameterIndex++, searchWord);
					pstat.setString(parameterIndex++, searchWord);
					pstat.setString(parameterIndex++, searchWord);
				}
			}

			// 말머리 검색 파라미터 설정
			if (searchCategory != null && !searchCategory.isEmpty()) {
				pstat.setString(parameterIndex++, searchCategory);
			}

			// 페이징 파라미터 설정
			pstat.setInt(parameterIndex++, page * pageSize);
			pstat.setInt(parameterIndex++, (page - 1) * pageSize);

			rs = pstat.executeQuery();

			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setPost_no(rs.getString("qna_post_no"));
				dto.setPost_subject(rs.getString("qna_post_subject"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViews(rs.getString("views"));
				dto.setPost_recommend(rs.getString("qna_post_recommend"));
				dto.setPost_decommend(rs.getString("qna_post_decommend"));
				dto.setHeader_name(rs.getString("post_header_name"));
				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// QNA 게시글 총 개수 조회
	public int getQnaTotalPosts(String word, String searchSel, String searchCategory) {
		try {
			String sql = "SELECT COUNT(*) as total FROM qna_post qp " +
					"LEFT JOIN member m ON qp.creator_id = m.member_id " +
					"LEFT JOIN qna_post_header qph ON qp.qna_post_header_no = qph.qna_post_header_no " +
					"WHERE 1=1 ";

			if (word != null && !word.trim().isEmpty()) {
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject":
							sql += "AND qp.qna_post_subject LIKE ? ";
							break;
						case "post_subject&post_content":
							sql += "AND (qp.qna_post_subject LIKE ? OR qp.qna_post_content LIKE ?) ";
							break;
						case "creator_id":
							sql += "AND m.member_id LIKE ? OR m.member_nickname LIKE ? ";
							break;
						case "regdate":
							sql += "AND TO_CHAR(qp.regdate, 'YYYY-MM-DD') LIKE ? ";
							break;
						default:
							sql += "AND (qp.qna_post_subject LIKE ? OR m.member_id LIKE ? OR qph.qna_post_header_name LIKE ?) ";
					}
				} else {
					sql += "AND (qp.qna_post_subject LIKE ? OR m.member_id LIKE ? OR qph.qna_post_header_name LIKE ?) ";
				}
			}

			if (searchCategory != null && !searchCategory.isEmpty()) {
				sql += "AND qp.qna_post_header_no = ? ";
			}

			pstat = conn.prepareStatement(sql);

			int parameterIndex = 1;

			if (word != null && !word.trim().isEmpty()) {
				String searchWord = "%" + word + "%";
				if (searchSel != null && !searchSel.isEmpty()) {
					switch (searchSel) {
						case "post_subject":
							pstat.setString(parameterIndex++, searchWord);
							break;
						case "post_subject&post_content":
							pstat.setString(parameterIndex++, searchWord);
							pstat.setString(parameterIndex++, searchWord);
							break;
						case "creator_id":
							pstat.setString(parameterIndex++, searchWord);
							pstat.setString(parameterIndex++, searchWord);
							break;
						case "regdate":
							pstat.setString(parameterIndex++, searchWord);
							break;
						default:
							pstat.setString(parameterIndex++, searchWord);
							pstat.setString(parameterIndex++, searchWord);
							pstat.setString(parameterIndex++, searchWord);
					}
				} else {
					pstat.setString(parameterIndex++, searchWord);
					pstat.setString(parameterIndex++, searchWord);
					pstat.setString(parameterIndex++, searchWord);
				}
			}

			if (searchCategory != null && !searchCategory.isEmpty()) {
				pstat.setString(parameterIndex++, searchCategory);
			}

			rs = pstat.executeQuery();
			
			if (rs.next()) {
				return rs.getInt("total");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	// QNA 헤더 목록 조회
	public ArrayList<CommunityDTO> getQnaHeaderList() {
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		try {
			String sql = "SELECT qna_post_header_no, qna_post_header_name FROM qna_post_header ORDER BY qna_post_header_no ASC";
			stat = conn.createStatement();
			rs = stat.executeQuery(sql);
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setHeader_no(rs.getString("qna_post_header_no"));
				dto.setHeader_name(rs.getString("qna_post_header_name"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stat != null) stat.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// QNA 게시글 추가
	public int Qna_post_add(CommunityDTO dto, UserDTO userDto) {
		try {
			String sql = "INSERT INTO qna_post (qna_post_no, qna_post_subject, qna_post_content, creator_id, regdate, views, qna_post_recommend, qna_post_decommend, qna_post_header_no) " +
					"VALUES (seq_qna_post_no.nextval, ?, ?, ?, default, default, default, default, ?)";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getPost_subject());
			pstat.setString(2, dto.getPost_content());
			pstat.setString(3, dto.getCreator_id());
			pstat.setString(4, dto.getHeader_no());
			
			return pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	public boolean Qna_post_delete(String post_no) {
		String sql = "DELETE FROM qna_post WHERE qna_post_no = ?";
		
		try {
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			
			int result = pstat.executeUpdate();
			return result > 0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean Qna_post_edit(CommunityDTO dto) {
		String sql = "UPDATE qna_post SET qna_post_subject = ?, qna_post_content = ?, qna_post_header_no = ? WHERE qna_post_no = ?";
		
		try {
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getPost_subject());
			pstat.setString(2, dto.getPost_content());
			pstat.setString(3, dto.getHeader_no());
			pstat.setString(4, dto.getPost_no());
			
			int result = pstat.executeUpdate();
			return result > 0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Q&A 댓글 조회
	public CommunityDTO getQnaComment(String comment_no) {
		try {
			String sql = "SELECT qc.*, m.member_nickname " +
						"FROM qna_comment qc " +
						"LEFT JOIN member m ON qc.creator_id = m.member_id " +
						"WHERE qc.qna_comment_no = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, comment_no);
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setComment_no(rs.getString("qna_comment_no"));
				dto.setPost_no(rs.getString("qna_post_no"));
				dto.setComment_content(rs.getString("qna_comment_content"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("member_nickname"));
				dto.setRegdate(rs.getString("regdate"));
				return dto;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// Q&A 댓글 삭제
	public boolean Qna_comment_delete(String comment_no) {
		try {
			String sql = "DELETE FROM qna_comment WHERE qna_comment_no = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, comment_no);
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Q&A 댓글 수정
	public boolean Qna_comment_edit(CommunityDTO dto) {
		try {
			String sql = "UPDATE qna_comment SET qna_comment_content = ? WHERE qna_comment_no = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getComment_content());
			pstat.setString(2, dto.getComment_no());
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Q&A 댓글 목록 조회
	public ArrayList<CommunityDTO> Qna_Comment_list(String post_no) {
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		try {
			String sql = "SELECT qc.*, m.member_nickname " +
						"FROM qna_comment qc " +
						"LEFT JOIN member m ON qc.creator_id = m.member_id " +
						"WHERE qc.qna_post_no = ? " +
						"ORDER BY qc.qna_comment_no ASC";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			rs = pstat.executeQuery();
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setComment_no(rs.getString("qna_comment_no"));
				dto.setPost_no(rs.getString("qna_post_no"));
				dto.setComment_content(rs.getString("qna_comment_content"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("member_nickname"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Q&A 댓글 작성
	public boolean Qna_comment_add(CommunityDTO dto) {
		try {
			String sql = "INSERT INTO qna_comment (qna_comment_no, qna_post_no, qna_comment_content, creator_id, regdate) " +
						"VALUES (seq_qna_comment_no.nextval, ?, ?, ?, default)";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getPost_no());
			pstat.setString(2, dto.getComment_content());
			pstat.setString(3, dto.getCreator_id());
			
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public CommunityDTO getQnaPost(String post_no, HttpSession session) {
		CommunityDTO dto = null;
		String sql = "SELECT q.qna_post_no, q.qna_post_subject, q.qna_post_content, q.private_check, " +
					"q.qna_post_recommend, q.qna_post_decommend, q.post_record_cnt, q.regdate, q.views, " +
					"q.creator_id, m.member_nickname, q.qna_post_header_no, h.qna_post_header_name " +
					"FROM qna_post q " +
					"JOIN member m ON q.creator_id = m.member_id " +
					"JOIN qna_post_header h ON q.qna_post_header_no = h.qna_post_header_no " +
					"WHERE q.qna_post_no = ?";
		
		try {
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				dto = new CommunityDTO();
				dto.setPost_no(rs.getString("qna_post_no"));
				dto.setPost_subject(rs.getString("qna_post_subject"));
				dto.setPost_content(rs.getString("qna_post_content"));
				dto.setPrivate_check(rs.getString("private_check"));
				dto.setPost_recommend(rs.getString("qna_post_recommend"));
				dto.setPost_decommend(rs.getString("qna_post_decommend"));
				dto.setPost_record_cnt(rs.getString("post_record_cnt"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("member_nickname"));
				dto.setHeader_no(rs.getString("qna_post_header_no"));
				dto.setHeader_name(rs.getString("qna_post_header_name"));
				dto.setViews(rs.getString("views"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstat != null) pstat.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dto;
	}

	public ArrayList<CommunityDTO> getQnaCommentList(String post_no) {
		ArrayList<CommunityDTO> list = new ArrayList<>();
		String sql = "SELECT qc.qna_comment_no, qc.qna_comment_content, qc.regdate, " +
					"qc.creator_id, m.member_nickname " +
					"FROM qna_comment qc " +
					"JOIN member m ON qc.creator_id = m.member_id " +
					"WHERE qc.qna_post_no = ? " +
					"ORDER BY qc.qna_comment_no ASC";
		
		try {
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			rs = pstat.executeQuery();
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setComment_no(rs.getString("qna_comment_no"));
				dto.setComment_content(rs.getString("qna_comment_content"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setCreator_id(rs.getString("creator_id"));
				dto.setNickname(rs.getString("member_nickname"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstat != null) pstat.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// Q&A 추천/비추천 기록 추가
	public int Qna_Vote_Record(CommunityDTO dto, UserDTO userDto) {
		PreparedStatement pstat1 = null;
		int result = 0;
		
		try {
			conn.setAutoCommit(false);
			// 추천, 비추천 기록
			String sql = "INSERT INTO qna_vote_record (qna_vote_record_no, qna_post_no, regdate, vote_check, member_id) " +
						"VALUES (seq_qna_vote_record_no.nextval, ?, sysdate, ?, ?)";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getPost_no());
			pstat.setString(2, dto.getVote_check());
			pstat.setString(3, userDto.getMemberId());
			result = pstat.executeUpdate();
			
			// 추천, 비추천 업데이트
			if (dto.getVote_check().equals("0")) {
				String sql1 = "UPDATE qna_post SET qna_post_recommend = qna_post_recommend + 1 WHERE qna_post_no = ?";
				pstat1 = conn.prepareStatement(sql1);
				pstat1.setString(1, dto.getPost_no());
				pstat1.executeUpdate();
			} else if (dto.getVote_check().equals("1")) {
				String sql2 = "UPDATE qna_post SET qna_post_decommend = qna_post_decommend + 1 WHERE qna_post_no = ?";
				pstat1 = conn.prepareStatement(sql2);
				pstat1.setString(1, dto.getPost_no());
				pstat1.executeUpdate();
			}
			
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (pstat1 != null) pstat1.close();
				conn.setAutoCommit(true);
			} catch (Exception closeEx) {
				closeEx.printStackTrace();
			}
		}
		
		return result;
	}

	// Q&A 추천, 비추천 눌렀을 경우 체크 -> 있으면 삭제 및 업데이트
	public boolean Qna_Vote_Check(CommunityDTO dto, UserDTO userDto) {
		PreparedStatement pstat1 = null;
		PreparedStatement pstat2 = null;
		PreparedStatement pstat3 = null;
		boolean success = false;

		try {
			conn.setAutoCommit(false);

			// 추천, 비추천 기록 조회
			String checkSql = "SELECT vote_check FROM qna_vote_record WHERE qna_post_no = ? AND member_id = ?";
			pstat = conn.prepareStatement(checkSql);
			pstat.setString(1, dto.getPost_no());
			pstat.setString(2, userDto.getMemberId());
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				String vote_check = rs.getString("vote_check");
				// vote_check 값에 따른 처리
				if (vote_check.equals("0")) {
					String sql1 = "UPDATE qna_post SET qna_post_recommend = qna_post_recommend - 1 WHERE qna_post_no = ?";
					pstat1 = conn.prepareStatement(sql1);
					pstat1.setString(1, dto.getPost_no());
					pstat1.executeUpdate();
				} else if (vote_check.equals("1")) {
					String sql2 = "UPDATE qna_post SET qna_post_decommend = qna_post_decommend - 1 WHERE qna_post_no = ?";
					pstat2 = conn.prepareStatement(sql2);
					pstat2.setString(1, dto.getPost_no());
					pstat2.executeUpdate();
				}
				
				// 추천, 비추천 기록 삭제
				String sql3 = "DELETE FROM qna_vote_record WHERE qna_post_no = ? AND member_id = ?";
				pstat3 = conn.prepareStatement(sql3);
				pstat3.setString(1, dto.getPost_no());
				pstat3.setString(2, userDto.getMemberId());
				int deleteResult = pstat3.executeUpdate();
				
				if (deleteResult > 0) {
					conn.commit();
					success = true;
				}
			}
			
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception rollbackEx) {
				rollbackEx.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (pstat1 != null) pstat1.close();
				if (pstat2 != null) pstat2.close();
				if (pstat3 != null) pstat3.close();
				conn.setAutoCommit(true);
			} catch (Exception closeEx) {
				closeEx.printStackTrace();
			}
		}
		
		return success;
	}

	// Q&A 댓글 수정
	public boolean qna_Edit_Comment(String comment_no, String comment_content) {
		try {
			String sql = "UPDATE qna_comment SET qna_comment_content = ? WHERE qna_comment_no = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, comment_content);
			pstat.setString(2, comment_no);
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (pstat != null) pstat.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// Q&A 댓글 작성
	public boolean qna_Write_Comment(String post_no, String comment_content, String creator_id) {
		try {
			String sql = "INSERT INTO qna_comment (qna_comment_no, qna_post_no, qna_comment_content, creator_id, regdate) " +
						"VALUES (seq_qna_comment_no.nextval, ?, ?, ?, sysdate)";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			pstat.setString(2, comment_content);
			pstat.setString(3, creator_id);
			
			int result = pstat.executeUpdate();
			return result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstat != null) pstat.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	// 게시글 신고 처리
	public boolean addReport(String post_no, String reporter_id, String target_type) {
		try {
			conn.setAutoCommit(false);
			
			String tableName = "";
			String postNoColumn = "";
			String reportCountColumn = "";
			String boardType = "";
			
			// 게시판 타입에 따라 테이블명과 컬럼명 설정
			switch(target_type) {
				case "bulletin_post":
					tableName = "bulletin_post";
					postNoColumn = "bulletin_post_no";
					reportCountColumn = "post_record_cnt";
					boardType = "bulletin";
					break;
				case "bulletin_comment":
					tableName = "bulletin_comment";
					postNoColumn = "bulletin_comment_no";
					reportCountColumn = "comment_record_cnt";
					boardType = "bulletin";
					break;
				case "announcement_post":
					tableName = "announcement_post";
					postNoColumn = "announcement_post_no";
					reportCountColumn = "post_record_cnt";
					boardType = "announcement";
					break;
				case "announcement_comment":
					tableName = "announcement_comment";
					postNoColumn = "announcement_comment_no";
					reportCountColumn = "comment_record_cnt";
					boardType = "announcement";
					break;
				case "qna_post":
					tableName = "qna_post";
					postNoColumn = "qna_post_no";
					reportCountColumn = "post_record_cnt";
					boardType = "qna";
					break;
				case "qna_comment":
					tableName = "qna_comment";
					postNoColumn = "qna_comment_no";
					reportCountColumn = "comment_record_cnt";
					boardType = "qna";
					break;
				default:
					return false;
			}
			
			// 게시글/댓글의 신고 횟수 증가
			String updatePostSql = "UPDATE " + tableName + " SET " + reportCountColumn + " = NVL(" + reportCountColumn + ", 0) + 1 WHERE " + postNoColumn + " = ?";
			pstat = conn.prepareStatement(updatePostSql);
			pstat.setString(1, post_no);
			int postResult = pstat.executeUpdate();
			
			// 신고된 사용자의 누적 신고 횟수 증가
			String updateMemberSql = "UPDATE member SET report_cnt = NVL(report_cnt, 0) + 1 " +
								   "WHERE member_id = (SELECT creator_id FROM " + tableName + " WHERE " + postNoColumn + " = ?)";
			pstat = conn.prepareStatement(updateMemberSql);
			pstat.setString(1, post_no);
			int memberResult = pstat.executeUpdate();
			
			if (postResult > 0 && memberResult > 0) {
				conn.commit();
				return true;
			} else {
				conn.rollback();
				return false;
			}
			
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			e.printStackTrace();
			return false;
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 게시글 신고 횟수 조회
	public int getPostReportCount(String post_no) {
		try {
			String sql = "SELECT post_record_cnt FROM qna_post WHERE qna_post_no = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, post_no);
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				return rs.getInt("post_record_cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	// 사용자의 누적 신고 횟수 조회
	public int getUserReportCount(String member_id) {
		try {
			String sql = "SELECT report_cnt FROM member WHERE member_id = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, member_id);
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				return rs.getInt("report_cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

}