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
        ArrayList<CommunityDTO> list = dao.Bulletin_list();
        req.setAttribute("bulletin_list", list);

		req.getRequestDispatcher("/WEB-INF/views/community/bulletinList.jsp").forward(req, resp);
	}

}