package fitralpark.comunity.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/bulletinPostOK.do")
public class BulletinPostOK extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // PostOK
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
    	
		HttpSession session = req.getSession();
		UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
		
        
		CommunityDTO communityDto = new CommunityDTO();
		CommunityDAO dao = new CommunityDAO();
		
		String post_no = req.getParameter("post_no");
		String vote_check = req.getParameter("vote_check");
		
		communityDto.setPost_no(post_no);
		communityDto.setVote_check(vote_check);
		
		if (vote_check != null) {
			
			boolean result = dao.bulletin_Vote_Check(communityDto, userDto);
				if (true == result) {
					return;
				} else {
					dao.bulletin_Vote_Record(communityDto, userDto);
				}
		} 
		
		dao.close();



       
    }
}