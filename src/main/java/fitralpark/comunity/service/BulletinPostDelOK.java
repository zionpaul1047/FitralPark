package fitralpark.comunity.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;

@WebServlet("/bulletinPostDelOK.do")
public class BulletinPostDelOK extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//BulletinPostDelOK
		req.setCharacterEncoding("UTF-8");
        
        String post_no = req.getParameter("post_no");  // 요청에서 post_no 가져오기
        
        CommunityDAO dao = new CommunityDAO();  // DAO 객체 생성
        CommunityDTO result = dao.delPost(post_no);  // 삭제 실행
        
        resp.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        if (result != null) {
            out.print("success");
        } else {
            out.print("fail");
        }
        
        dao.close();
		
		

	}

}
