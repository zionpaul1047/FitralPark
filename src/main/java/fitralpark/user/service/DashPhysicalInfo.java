package fitralpark.user.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.DashPhysicalHistDTO;

@WebServlet("/dashphysicalinfo.do")
public class DashPhysicalInfo extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DashPhysicalInfo.java
		String id = req.getParameter("id");
		String month = req.getParameter("month");
		
		DashPhysicalHistDTO histdto = new DashPhysicalHistDTO();
		histdto.setId(id);
		histdto.setMonth(month);
		
		UserDAO dao = new UserDAO();
		
		ArrayList<DashPhysicalHistDTO> histList = dao.getPhysicalHist(histdto);
		dao.close();
		
		JSONArray arr = new JSONArray();
		
		for(DashPhysicalHistDTO hist : histList) {
			JSONObject obj = new JSONObject();
			obj.put("regdate", hist.getRegdate());
			obj.put("height", hist.getHeight());
			obj.put("weight", hist.getWeight());
			
			arr.add(obj);
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		PrintWriter writer = resp.getWriter();
		
		writer.print(arr);
		
		writer.close();
		
		

	}

}