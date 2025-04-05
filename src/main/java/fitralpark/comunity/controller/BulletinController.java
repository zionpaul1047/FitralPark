package fitralpark.comunity.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;

//커뮤니티 자유게시판 관련 컨트롤러
@WebServlet("/bulletinList.do")
public class BulletinController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 페이지 파라미터 처리
		String pageStr = req.getParameter("page");
		int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
		
		// 검색 파라미터 처리
		String searchWord = req.getParameter("searchWord");
		String searchCategory = req.getParameter("search_category");
		String searchSel = req.getParameter("search_sel");
		
		// 페이지 크기 설정
		int pageSize = 15;
		
		// DAO에서 게시글 목록 조회
		CommunityDAO dao = new CommunityDAO();
		ArrayList<CommunityDTO> list = dao.Bulletin_list(page, searchWord, pageSize, searchSel, searchCategory);
		
		// 전체 게시글 수 조회 (검색 조건 포함)
		int totalPosts = dao.getTotalPosts(searchWord, searchSel, searchCategory);
		int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
		
		// 시작 페이지와 끝 페이지 계산
		int startPage = ((page - 1) / 5) * 5 + 1;
		int endPage = Math.min(startPage + 4, totalPages);
		
		// 말머리 목록 조회
		ArrayList<CommunityDTO> headerList = dao.getHeaderList();

		// 요청 속성에 데이터 설정
		req.setAttribute("bulletin_list", list);
		req.setAttribute("page", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("headerList", headerList);
		req.setAttribute("searchWord", searchWord);
		req.setAttribute("searchCategory", searchCategory);
		req.setAttribute("searchSel", searchSel);
		
		// DAO 연결 해제
		dao.close();
		
		
		// JSP로 포워딩
		req.getRequestDispatcher("/WEB-INF/views/community/bulletinList.jsp").forward(req, resp);
	}

}