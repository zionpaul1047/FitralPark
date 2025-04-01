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

		//BoardController
		CommunityDAO dao = new CommunityDAO();
        
        // 페이지 파라미터 처리
        String pageStr = req.getParameter("page");
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 15; // 한 페이지당 표시할 게시글 수
        
        // 전체 게시글 수 조회
        int totalPosts = dao.getTotalBulletinPosts();
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        
        // 시작 페이지와 끝 페이지 계산
        int startPage = ((page - 1) / 5) * 5 + 1;
        int endPage = Math.min(startPage + 4, totalPages);
        
        // 검색어 파라미터 처리
        String searchWord = req.getParameter("word");
        
        // 현재 페이지의 게시글 목록 조회
        ArrayList<CommunityDTO> list = dao.Bulletin_list(page, searchWord, pageSize);
        
        // request에 데이터 설정
        req.setAttribute("bulletin_list", list);
        req.setAttribute("page", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("startPage", startPage);
        req.setAttribute("endPage", endPage);

        // DAO 연결 해제
        dao.close();

		req.getRequestDispatcher("/WEB-INF/views/community/bulletinList.jsp").forward(req, resp);

		
	}

}