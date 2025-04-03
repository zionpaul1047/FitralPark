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
import fitralpark.exercise.dto.ExerciseDTO;
import fitralpark.exercise.dto.RoutineDTO;
import fitralpark.exercise.dto.RoutineExerciseDTO;

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

	public ArrayList<RoutineDTO> routineList() {
		
		try {

			ArrayList<RoutineDTO> list = new ArrayList<RoutineDTO>();

			String sql = "SELECT "
	                + "r.routine_no as routine_no, "
	                + "r.routine_name as routine_name, "
	                + "rc.routine_category_name as routine_category_name, "
	                + "TO_CHAR(r.creation_date, 'YYYY-MM-DD') as creation_date, "
	                + "m.member_nickname as member_nickname, "
	                + "r.views as views, "
	                + "LISTAGG(DISTINCT ec.exercise_category_name, ', ') "
	                + "WITHIN GROUP (ORDER BY ec.exercise_category_name) as exercise_categories, "
	                + "LISTAGG(DISTINCT ep.exercise_part_name, ', ') "
	                + "WITHIN GROUP (ORDER BY ep.exercise_part_name) as exercise_parts, "
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
	
	public ArrayList<RoutineExerciseDTO> exerciseList(String routineNo) {
		
		try {
			
			ArrayList<RoutineExerciseDTO> list = new ArrayList<RoutineExerciseDTO>();
			
			String sql = "SELECT "
		            + "e.exercise_name as exercise_name, "
		            + "LISTAGG(DISTINCT ec.exercise_category_name, ', ') "
		            + "    WITHIN GROUP (ORDER BY ec.exercise_category_name) AS exercise_categories, "
		            + "LISTAGG(DISTINCT ep.exercise_part_name, ', ') "
		            + "    WITHIN GROUP (ORDER BY ep.exercise_part_name) AS exercise_parts, "
		            + "e.calories_per_unit as calories_per_unit, "
		            + "re.exercise_time as exercise_time, re.sets, re.reps_per_set, re.weight "
		            + "FROM routine_exercise re "
		            + "JOIN exercise e ON re.exercise_no = e.exercise_no "
		            + "LEFT JOIN exercise_category_group ecg ON e.exercise_no = ecg.exercise_no "
		            + "LEFT JOIN exercise_category ec ON ecg.exercise_category_no = ec.exercise_category_no "
		            + "LEFT JOIN exercise_part_link epl ON e.exercise_no = epl.exercise_no "
		            + "LEFT JOIN exercise_part ep ON epl.exercise_part_no = ep.exercise_part_no "
		            + "WHERE re.routine_no = ? "
		            + "GROUP BY re.routine_exercise_no, e.exercise_name, e.calories_per_unit, "
		            + "re.exercise_time, re.sets, re.reps_per_set, re.weight "
		            + "ORDER BY re.routine_exercise_no ASC";
			
			PreparedStatement pstat = conn.prepareStatement(sql);
			pstat.setString(1, routineNo);
			ResultSet rs = pstat.executeQuery();

			while (rs.next()) {

				RoutineExerciseDTO dto = new RoutineExerciseDTO();

				dto.setExerciseName(rs.getString("exercise_name"));
				dto.setExerciseCategoryNames(rs.getString("exercise_categories"));
				dto.setExercisePartNames(rs.getString("exercise_parts"));
				dto.setCaloriesPerUnit(rs.getString("calories_per_unit"));
				dto.setExerciseTime(rs.getString("exercise_time"));
				dto.setSets(rs.getString("sets"));
				dto.setRepsPerSet(rs.getString("reps_per_set"));
				dto.setWeight(rs.getString("weight"));

				list.add(dto);
			}
			
			return list;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public RoutineDTO getRoutineInfo(String routineNo) {
		
		RoutineDTO dto = null;

		    String sql = "SELECT "
		               + "r.routine_no as routine_no, "
		               + "r.routine_name as routine_name, "
		               + "rc.routine_category_name as routine_category_name, "
		               + "TO_CHAR(r.creation_date, 'YYYY-MM-DD') AS creation_date, "
		               + "m.member_nickname as member_nickname "
		               + "FROM routine r "
		               + "JOIN routine_category rc ON r.routine_category_no = rc.routine_category_no "
		               + "JOIN member m ON r.creator_id = m.member_id "
		               + "WHERE r.routine_no = ?";
		
	    try (PreparedStatement pstat = conn.prepareStatement(sql)) {
	        pstat.setString(1, routineNo);
	        ResultSet rs = pstat.executeQuery();

	        if (rs.next()) {
	            dto = new RoutineDTO();
	            dto.setRoutineNo(rs.getString("routine_no"));
	            dto.setRoutineName(rs.getString("routine_name"));
	            dto.setRoutineCategoryName(rs.getString("routine_category_name"));
	            dto.setCreationDate(rs.getString("creation_date"));
	            dto.setMemberNickname(rs.getString("member_nickname"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return dto;
	}

	public String insertRoutine(String routineName, String category, String visibility) {
		
		String sql = "INSERT INTO routine (routine_name, routine_category, visibility) VALUES (?, ?, ?)";
		
	    try {
	        PreparedStatement pstat = conn.prepareStatement(sql, new String[] { "routine_no" });
	        pstat.setString(1, routineName);
	        pstat.setString(2, category);
	        pstat.setString(3, visibility);
	        pstat.executeUpdate();

	        ResultSet rs = pstat.getGeneratedKeys();
	        if (rs.next()) return rs.getString(1);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return null;
	}

	
}
