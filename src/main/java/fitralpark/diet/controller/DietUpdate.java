package fitralpark.diet.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.diet.dao.DietDAO;

/**
 * DietUpdate 서블릿 클래스는 식단의 추천, 비추천, 조회수를 업데이트하는 역할을 합니다.
 * 
 * <p>클라이언트로부터 요청을 받아 데이터베이스의 식단 데이터를 수정하고,
 * JSON 형식으로 응답을 반환합니다.</p>
 * @author 이지민
 */
@WebServlet("/dietupdate.do")
public class DietUpdate extends HttpServlet {
    
    
    /**
     * POST 요청을 처리하는 메서드입니다.
     *
     * <p>클라이언트로부터 식단 번호와 업데이트 유형(추천, 비추천, 조회수)을 받아
     * 해당 데이터를 수정합니다. 수정된 값은 JSON 형식으로 클라이언트에게 반환됩니다.</p>
     *
     * @param req  HttpServletRequest 객체 (클라이언트 요청 정보 포함)
     * @param resp HttpServletResponse 객체 (클라이언트 응답 정보 포함)
     * @throws ServletException 서블릿 처리 중 오류 발생 시
     * @throws IOException 입출력 처리 중 오류 발생 시
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        /**
         * 요청 파라미터에서 식단 번호와 업데이트 유형(type)을 추출합니다.
         */
        int dietNo = Integer.parseInt(req.getParameter("dietNo"));
        String type = req.getParameter("type");
        
        // DAO 인스턴스 생성
        DietDAO dietDAO = new DietDAO();
        
       
        
        int count = 0;
        
        if (type.equals("recommend")) {
            /*추천수 업데이트*/
            count = dietDAO.incrementRecommend(dietNo);
        } else if (type.equals("disrecommend")) {        
            /*비추천수 업데이트*/
            count = dietDAO.incrementDisrecommend(dietNo);
        } else if(type.equals("views")) {
            /* 조회수 업데이트*/
            count = dietDAO.incrementViews(dietNo);
        }
        
        /* JSON 응답 생성*/
        PrintWriter out = resp.getWriter();
        out.print("""
                {
                    "success": true,
                    "count": %d
                }
                """.formatted(count));
        out.flush();
        
        
    }
}

