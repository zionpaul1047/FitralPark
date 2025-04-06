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
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

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
	                + "m.member_id as member_id, "
	                + "r.views as views, "
	                + "LISTAGG(DISTINCT ec.exercise_category_name, ', ') "
	                + "WITHIN GROUP (ORDER BY ec.exercise_category_name) as exercise_categories, "
	                + "LISTAGG(DISTINCT ep.exercise_part_name, ', ') "
	                + "WITHIN GROUP (ORDER BY ep.exercise_part_name) as exercise_parts, "
	                + "SUM(e.calories_per_unit) as total_calories "
	                + "FROM routine r "
	                + "INNER JOIN routine_category rc ON r.routine_category_no = rc.routine_category_no "
	                + "INNER JOIN member m ON r.creator_id = m.member_id "
	                + "INNER JOIN routine_exercise re ON r.routine_no = re.routine_no "
	                + "INNER JOIN ("
	                + "    SELECT exercise_no, exercise_name, calories_per_unit FROM exercise "
	                + "    UNION ALL "
	                + "    SELECT custom_exercise_no, custom_exercise_name, calories_per_unit FROM custom_exercise"
	                + ") e ON (re.exercise_no = e.exercise_no OR re.custom_exercise_no = e.exercise_no) "
	                + "INNER JOIN exercise_category_group ecg ON e.exercise_no = ecg.exercise_no "
	                + "INNER JOIN exercise_category ec ON ecg.exercise_category_no = ec.exercise_category_no "
	                + "INNER JOIN exercise_part_link epl ON e.exercise_no = epl.exercise_no "
	                + "INNER JOIN exercise_part ep ON epl.exercise_part_no = ep.exercise_part_no "
	                + "GROUP BY r.routine_no, r.routine_name, rc.routine_category_name, "
	                + "r.creation_date, m.member_nickname, m.member_id, r.views "
	                + "ORDER BY r.routine_no DESC";

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
	            dto.setMemberId(rs.getString("member_id"));
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
		            + "re.exercise_time as exercise_time, re.sets, re.reps_per_set, re.weight, "
		            + "re.exercise_no as exercise_no, "
		            + "re.custom_exercise_no as custom_exercise_no, "
		            + "CASE WHEN re.custom_exercise_no IS NOT NULL THEN 1 ELSE 0 END as is_custom "
		            + "FROM routine_exercise re "
		            + "INNER JOIN ("
		            + "    SELECT exercise_no, exercise_name, calories_per_unit FROM exercise "
		            + "    UNION ALL "
		            + "    SELECT custom_exercise_no, custom_exercise_name, calories_per_unit FROM custom_exercise"
		            + ") e ON (re.exercise_no = e.exercise_no OR re.custom_exercise_no = e.exercise_no) "
		            + "INNER JOIN exercise_category_group ecg ON e.exercise_no = ecg.exercise_no "
		            + "INNER JOIN exercise_category ec ON ecg.exercise_category_no = ec.exercise_category_no "
		            + "INNER JOIN exercise_part_link epl ON e.exercise_no = epl.exercise_no "
		            + "INNER JOIN exercise_part ep ON epl.exercise_part_no = ep.exercise_part_no "
		            + "WHERE re.routine_no = ? "
		            + "GROUP BY re.routine_exercise_no, e.exercise_name, e.calories_per_unit, "
		            + "re.exercise_time, re.sets, re.reps_per_set, re.weight, re.exercise_no, re.custom_exercise_no "
		            + "ORDER BY is_custom ASC, re.routine_exercise_no ASC";
			
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
				dto.setExerciseNo(rs.getString("exercise_no"));
				dto.setCustomExerciseNo(rs.getString("custom_exercise_no"));

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
		               + "r.routine_category_no as routine_category_no, "
		               + "r.public_check as public_check, "
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
	            dto.setRoutineCategoryNo(rs.getString("routine_category_no"));
	            dto.setPublicCheck(rs.getString("public_check"));
	            dto.setCreationDate(rs.getString("creation_date"));
	            dto.setMemberNickname(rs.getString("member_nickname"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return dto;
	}

	public String insertRoutine(String routineName, String routineCategoryNo, String publicCheck, String creatorId) {
		String routineNo = null;
		try {
			String sql = "INSERT INTO routine (routine_no, routine_name, routine_category_no, public_check, creator_id) "
					  + "VALUES (seq_routine.NEXTVAL, ?, TO_NUMBER(?), TO_NUMBER(?), ?)";
			
			PreparedStatement pstat = conn.prepareStatement(sql, new String[] {"routine_no"});
			pstat.setString(1, routineName);
			pstat.setString(2, routineCategoryNo);
			pstat.setString(3, publicCheck);
			pstat.setString(4, creatorId);
			
			int result = pstat.executeUpdate();
			
			if (result > 0) {
				ResultSet rs = pstat.getGeneratedKeys();
				if (rs.next()) {
					routineNo = rs.getString(1);
				}
				rs.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return routineNo;
	}

	public void insertRoutineExercise(String routineNo, String exerciseNo, 
									String sets, String repsPerSet, String exerciseTime, String weight) {
		try {
			// exerciseNo에서 숫자만 추출
			String cleanExerciseNo = exerciseNo.replaceAll("[^0-9]", "");
			
			// exerciseNo가 ex_로 시작하는지 확인
			boolean isExercise = exerciseNo.startsWith("ex_");
			
			String sql;
			if (isExercise) {
				sql = "INSERT INTO routine_exercise "
					+ "(routine_exercise_no, routine_no, exercise_no, sets, reps_per_set, exercise_time, weight) "
					+ "VALUES (seq_routine_exercise.NEXTVAL, TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?))";
			} else {
				sql = "INSERT INTO routine_exercise "
					+ "(routine_exercise_no, routine_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight) "
					+ "VALUES (seq_routine_exercise.NEXTVAL, TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?))";
			}
			
			PreparedStatement pstat = conn.prepareStatement(sql);
			pstat.setString(1, routineNo);
			pstat.setString(2, cleanExerciseNo);
			pstat.setString(3, sets);
			pstat.setString(4, repsPerSet);
			pstat.setString(5, exerciseTime);
			pstat.setString(6, weight);
			
			System.out.println("Executing query: " + sql);
			System.out.println("Parameters: routineNo=" + routineNo + ", exerciseNo=" + cleanExerciseNo 
						   + ", sets=" + sets + ", repsPerSet=" + repsPerSet 
						   + ", exerciseTime=" + exerciseTime + ", weight=" + weight);
			
			pstat.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("Error in insertRoutineExercise: " + e.getMessage());
			e.printStackTrace();
		}
	}

	public boolean updateRoutine(String routineNo, String routineName, String routineCategoryNo, String publicCheck) {
		try {
			String sql = "UPDATE routine SET "
					+ "routine_name = ?, "
					+ "routine_category_no = TO_NUMBER(?), "
					+ "public_check = TO_NUMBER(?) "
					+ "WHERE routine_no = TO_NUMBER(?)";
			
			PreparedStatement pstat = conn.prepareStatement(sql);
			pstat.setString(1, routineName);
			pstat.setString(2, routineCategoryNo);
			pstat.setString(3, publicCheck);
			pstat.setString(4, routineNo);
			
			int result = pstat.executeUpdate();
			return result > 0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public void deleteRoutineExercises(String routineNo) {
		try {
			String sql = "DELETE FROM routine_exercise WHERE routine_no = TO_NUMBER(?)";
			
			PreparedStatement pstat = conn.prepareStatement(sql);
			pstat.setString(1, routineNo);
			
			pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean insertRoutineExercises(String routineNo, JsonArray exercises) {
		try {
			String sql = "INSERT INTO routine_exercise "
					+ "(routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight) "
					+ "VALUES (seq_routine_exercise.NEXTVAL, TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?), TO_NUMBER(?))";
			
			PreparedStatement pstat = conn.prepareStatement(sql);
			
			for (int i = 0; i < exercises.size(); i++) {
				JsonObject exercise = exercises.get(i).getAsJsonObject();
				String exerciseId = exercise.get("exerciseId").getAsString();
				
				// exerciseId가 ex_로 시작하는지 확인
				boolean isExercise = exerciseId.startsWith("ex_");
				String cleanExerciseId = exerciseId.replaceAll("[^0-9]", "");
				
				pstat.setString(1, routineNo);
				if (isExercise) {
					pstat.setString(2, cleanExerciseId);
					pstat.setString(3, null);
				} else {
					pstat.setString(2, null);
					pstat.setString(3, cleanExerciseId);
				}
				pstat.setString(4, exercise.get("sets").getAsString());
				pstat.setString(5, exercise.get("repsPerSet").getAsString());
				pstat.setString(6, exercise.get("exerciseTime").getAsString());
				pstat.setString(7, exercise.get("weight").getAsString());
				
				pstat.addBatch();
			}
			
			int[] results = pstat.executeBatch();
			return results.length == exercises.size();
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
