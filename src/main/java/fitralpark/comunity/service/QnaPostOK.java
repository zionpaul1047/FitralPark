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
import fitralpark.user.dto.UserDTO;

@WebServlet("/qnaPostOK.do")
public class QnaPostOK extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
    	
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        
        CommunityDTO communityDto = new CommunityDTO();
        CommunityDAO dao = new CommunityDAO();
        
        try {
            String post_no = req.getParameter("post_no");
            String vote_check = req.getParameter("vote_check");
            String comment_content = req.getParameter("comment_content");
            String action = req.getParameter("action");
            String comment_no = req.getParameter("comment_no");
            String comment_creator_id = req.getParameter("comment_creator_id");

            if ("edit".equals(action)) {
                // 권한 확인
                if (!userDto.getMemberId().equals(comment_creator_id)) {
                    resp.setContentType("text/plain");
                    resp.getWriter().write("unauthorized");
                    return;
                }
                // 댓글 수정 처리
                boolean success = dao.qna_Edit_Comment(comment_no, comment_content);
                resp.setContentType("text/plain");
                resp.getWriter().write(success ? "success" : "fail");
                return;
            } else if (vote_check != null) {
                // 추천/비추천 처리
                communityDto.setPost_no(post_no);
                communityDto.setVote_check(vote_check);
                
                boolean result = dao.Qna_Vote_Check(communityDto, userDto);
                if (true == result) {
                    return;
                } else {
                    dao.Qna_Vote_Record(communityDto, userDto);
                }
            } else if (comment_content != null && !comment_content.trim().isEmpty()) {
            	
                // 댓글 작성 처리
                if (userDto.getMentorCheck() != 1) {
        	        req.setCharacterEncoding("UTF-8");
        	        resp.setContentType("text/html; charset=UTF-8");
        	        PrintWriter out = resp.getWriter();
        	        out.println("<script>");
        	        out.println("alert('Q&A 답변은 멘토만 가능합니다.');");
        	        out.println("history.back();");
        	        out.println("</script>");
        	        out.close();
        	        return;
                }
            	
                boolean success = dao.qna_Write_Comment(post_no, comment_content, userDto.getMemberId());
                if (success) {
                    resp.sendRedirect("/fitralpark/qnaPost.do?post_no=" + post_no);
                } else {
                    PrintWriter out = resp.getWriter();
                    out.println("<script>");
                    out.println("alert('댓글 작성에 실패했습니다.');");
                    out.println("history.back();");
                    out.println("</script>");
                    out.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('처리 중 오류가 발생했습니다.');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
        } finally {
            dao.close();
        }
    }
}