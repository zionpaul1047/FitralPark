package fitralpark.user.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.DashPhysicalHistDTO;

@WebServlet("/dashphysicalregist.do")
public class DashPhysicalRegist extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DashPhysicalRegist.java
		String id = req.getParameter("id");
		String height = req.getParameter("height");
		String weight = req.getParameter("weight");
		
		DashPhysicalHistDTO histdto = new DashPhysicalHistDTO();
		histdto.setId(id);
		histdto.setHeight(height);
		histdto.setWeight(weight);
		
		UserDAO dao = new UserDAO();
		
		int result = dao.putPhysicalHist(histdto);
		
		dao.close();
		
		PrintWriter writer = resp.getWriter();
		
		writer.print(result);
		
		writer.close();
		

	}

}