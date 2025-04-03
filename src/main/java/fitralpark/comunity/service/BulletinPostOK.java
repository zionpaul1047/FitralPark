package fitralpark.comunity.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;

@WebServlet("/bulletinPostOK.do")
public class BulletinPostOK extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // PostOK


        String postNoStr = req.getParameter("post_no");
        String type = req.getParameter("type");
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("loginUser"); // 세션에서 userId 가져오기

        StringBuilder jsonBuilder = new StringBuilder(); // JSON 문자열을 직접 생성하기 위한 StringBuilder

        if (userId == null) {
            jsonBuilder.append("{\"success\":false,\"message\":\"로그인이 필요합니다.\"}");
            resp.getWriter().write(jsonBuilder.toString());
            return;
        }

        if (postNoStr == null || type == null) {
            jsonBuilder.append("{\"success\":false,\"message\":\"잘못된 요청입니다.\"}");
            resp.getWriter().write(jsonBuilder.toString());
            return;
        }

        int postNo = Integer.parseInt(postNoStr);
        CommunityDAO dao = new CommunityDAO();

        try {
            //중복 추천/비추천 검사
            boolean alreadyVoted = dao.checkAlreadyVoted(postNo, userId);
            if (alreadyVoted) {
                jsonBuilder.append("{\"success\":false,\"message\":\"이미 추천/비추천 하셨습니다.\"}");
                resp.getWriter().write(jsonBuilder.toString());
                return;
            }

            if ("recommend".equals(type)) {
                dao.incrementRecommend(postNo); // 추천수 증가
            } else if ("decommend".equals(type)) {
                dao.incrementDecommend(postNo); // 비추천수 증가
            } else {
                jsonBuilder.append("{\"success\":false,\"message\":\"잘못된 요청입니다.\"}");
                resp.getWriter().write(jsonBuilder.toString());
                return;
            }

            // 추천/비추천 기록 저장
            dao.insertVoteRecord(postNo, userId, type);

            // 업데이트된 추천/비추천 수 가져오기
            int recommendCount = dao.getRecommendCount(postNo);
            int decommendCount = dao.getDecommendCount(postNo);

            jsonBuilder.append("{\"success\":true,\"recommend\":")
                    .append(recommendCount)
                    .append(",\"decommend\":")
                    .append(decommendCount)
                    .append("}");
        } catch (Exception e) {
            e.printStackTrace();
            jsonBuilder.append("{\"success\":false,\"message\":\"추천/비추천 처리 중 오류가 발생했습니다.\"}");
        } finally {
            dao.close();
        }

        resp.getWriter().write(jsonBuilder.toString());
    }
}