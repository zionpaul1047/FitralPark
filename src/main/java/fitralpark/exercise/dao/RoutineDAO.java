package fitralpark.exercise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import fitralpark.common.utils.DBUtil;
import fitralpark.exercise.dto.RoutineDTO;

public class RoutineDAO {
	
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	
	public RoutineDAO() {
		
		try {
			
			Context ctx = new InitialContext();
			Context env = (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/pool");
			
			conn = ds.getConnection();
			stat = conn.createStatement();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void close() {
		try {
			this.conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<RoutineDTO> list() {
		
		try {

			ArrayList<RoutineDTO> list = new ArrayList<>();

			String sql = "SELECT "
	                + "r.routine_no as routine_no, "
	                + "r.routine_name as routine_name, "
	                + "rc.routine_category_name as routine_category_name, "
	                + "TO_CHAR(r.creation_date, 'YYYY-MM-DD') as creation_date, "
	                + "m.member_nickname as member_nickname, "
	                + "r.views as views, "
	                + "LISTAGG(DISTINCT ec.exercise_category_name, ', ') "
	                + "   WITHIN GROUP (ORDER BY ec.exercise_category_name) as exercise_categories, "
	                + "LISTAGG(DISTINCT ep.exercise_part_name, ', ') "
	                + "   WITHIN GROUP (ORDER BY ep.exercise_part_name) as exercise_parts, "
	                + "SUM(e.calories_per_unit) as total_calories "
	                + "FROM routine r "
	                + "JOIN routine_category rc ON r.routine_category_no = rc.routine_category_no "
	                + "JOIN member m ON r.creator_id = m.member_id "
	                + "JOIN routine_exercise re ON r.routine_no = re.routine_no "
	                + "JOIN exercise e ON re.exercise_no = e.exercise_no "
	                + "LEFT JOIN exercise_category_group ecg ON e.exercise_no = ecg.exercise_no "
	                + "LEFT JOIN exercise_category ec ON ecg.exercise_category_no = ec.exercise_category_no "
	                + "LEFT JOIN exercise_part_link epl ON e.exercise_no = epl.exercise_no "
	                + "LEFT JOIN exercise_part ep ON epl.exercise_part_no = ep.exercise_part_no "
	                + "GROUP BY r.routine_no, r.routine_name, rc.routine_category_name, "
	                + "r.creation_date, m.member_nickname, r.views "
	                + "ORDER BY r.creation_date DESC";

			rs = stat.executeQuery(sql);

			while (rs.next()) {
				RoutineDTO dto = new RoutineDTO();
	            dto.setRoutineNo(rs.getString("routine_no"));
	            dto.setRoutineName(rs.getString("routine_name"));
	            dto.setRoutineCategoryName(rs.getString("routine_category_name"));
	            dto.setExerciseCategories(rs.getString("exercise_categories"));
	            dto.setExerciseParts(rs.getString("exercise_parts"));
	            dto.setTotalCalories(rs.getString("total_calories"));
	            dto.setCreationDate(rs.getString("creation_date"));
	            dto.setMemberNickname(rs.getString("member_nickname"));
	            dto.setViews(rs.getString("views"));
	            list.add(dto);
			}
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}
	
	
	
}
