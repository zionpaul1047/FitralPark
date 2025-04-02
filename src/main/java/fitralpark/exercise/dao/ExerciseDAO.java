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

import fitralpark.exercise.dto.ExerciseDTO;

//(DB 접근 DAO 클래스 자리)
public class ExerciseDAO {
	
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	
	public ExerciseDAO() {
		
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
	
	public List<ExerciseDTO> getExerciseList() {
	    List<ExerciseDTO> list = new ArrayList<>();
	    
	    String sql = "SELECT e.exercise_no as exercise_no, e.exercise_name as exercise_name, "
	               + "ec.exercise_category_name as exercise_category_name, ep.exercise_part_name as exercise_part_name, e.calories_per_unit as calories_per_unit "
	               + "FROM exercise e "
	               + "LEFT JOIN exercise_category_group ecg ON e.exercise_no = ecg.exercise_no "
	               + "LEFT JOIN exercise_category ec ON ecg.exercise_category_no = ec.exercise_category_no "
	               + "LEFT JOIN exercise_part_link epl ON e.exercise_no = epl.exercise_no "
	               + "LEFT JOIN exercise_part ep ON epl.exercise_part_no = ep.exercise_part_no";

	    try (Statement stmt = conn.createStatement();
	         ResultSet rs = stmt.executeQuery(sql)) {

	        while (rs.next()) {
	            ExerciseDTO dto = new ExerciseDTO();
	            dto.setExerciseNo(rs.getString("exercise_no"));
	            dto.setExerciseName(rs.getString("exercise_name"));
	            dto.setExerciseCategoryName(rs.getString("exercise_category_name"));
	            dto.setExercisePartName(rs.getString("exercise_part_name"));
	            dto.setCaloriesPerUnit(rs.getString("calories_per_unit"));
	            list.add(dto);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	
	public List<ExerciseDTO> getCustomExerciseList(String memberId) {
	    List<ExerciseDTO> list = new ArrayList<>();
	    
	    String sql = """
	            SELECT ce.custom_exercise_no AS exercise_no,
	                   ce.custom_exercise_name AS exercise_name,
	                   ce.calories_per_unit as calories_per_unit,
	                   LISTAGG(ec.exercise_category_name, ', ') WITHIN GROUP (ORDER BY ec.exercise_category_name) AS exercise_category_name,
	                   LISTAGG(ep.exercise_part_name, ', ') WITHIN GROUP (ORDER BY ep.exercise_part_name) AS exercise_part_name
	            FROM custom_exercise ce
	            LEFT JOIN custom_exercise_category_group cecg ON ce.custom_exercise_no = cecg.custom_exercise_no
	            LEFT JOIN exercise_category ec ON cecg.exercise_category_no = ec.exercise_category_no
	            LEFT JOIN exercise_part_link epl ON ce.custom_exercise_no = epl.exercise_no
	            LEFT JOIN exercise_part ep ON epl.exercise_part_no = ep.exercise_part_no
	            WHERE ce.creator_id = ?
	            GROUP BY ce.custom_exercise_no, ce.custom_exercise_name, ce.calories_per_unit
	            ORDER BY ce.custom_exercise_no DESC
	        """;

	    try (PreparedStatement pstat = conn.prepareStatement(sql)) {
	        pstat.setString(1, memberId);
	        ResultSet rs = pstat.executeQuery();

	        while (rs.next()) {
	            ExerciseDTO dto = new ExerciseDTO();
	            dto.setExerciseNo(rs.getString("exercise_no"));
	            dto.setExerciseName(rs.getString("exercise_name"));
	            dto.setCaloriesPerUnit(rs.getString("calories_per_unit"));
	            dto.setExerciseCategoryName(rs.getString("exercise_category_name"));
	            dto.setExercisePartName(rs.getString("exercise_part_name"));
	            list.add(dto);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	
}
