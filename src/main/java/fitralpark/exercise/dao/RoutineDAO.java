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

import fitralpark.exercise.dto.ExerciseRecordDTO;
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

	public ArrayList<RoutineDTO> list() {
		
		try {

			ArrayList<RoutineDTO> list = new ArrayList<>();

			String sql = "SELECT "
	                + "r.routine_no as routine_no, "
	                + "r.routine_name as routine_name, "
	                + "rc.routine_category_name as routine_category_name, "
	                + "TO_CHAR(r.creation_date, 'YYYY-MM-DD') as creation_date, "
	                + "m.member_nickname as member_nickname, "
	                + "m.member_id as member_id, "
	                + "r.views as views, "
	                + "LISTAGG(DISTINCT ec.exercise_category_name, ', ') "
	                + "   WITHIN GROUP (ORDER BY ec.exercise_category_name) as exercise_categories, "
	                + "LISTAGG(DISTINCT ep.exercise_part_name, ', ') "
	                + "   WITHIN GROUP (ORDER BY ep.exercise_part_name) as exercise_parts, "
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
		            + "re.exercise_time as exercise_time, re.sets, re.reps_per_set, re.weight "
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
	
	public boolean insertRoutineExercises(String routineNo, List<ExerciseRecordDTO> exercises) {
		try {
			String sql = "INSERT INTO routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, exercise_creation_type, sets, reps_per_set, exercise_time, weight) " +
						 "VALUES (seq_routine_exercise.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			PreparedStatement pstat = conn.prepareStatement(sql);
			
			for (ExerciseRecordDTO exercise : exercises) {
				try {
					pstat.setInt(1, Integer.parseInt(routineNo));
					
					if (exercise.getExerciseCreationType().equals("0")) {
						pstat.setInt(2, Integer.parseInt(exercise.getExerciseNo()));
						pstat.setNull(3, java.sql.Types.INTEGER);
					} else {
						pstat.setNull(2, java.sql.Types.INTEGER);
						pstat.setInt(3, Integer.parseInt(exercise.getCustomExerciseNo()));
					}
					
					pstat.setInt(4, Integer.parseInt(exercise.getExerciseCreationType()));
					pstat.setInt(5, Integer.parseInt(exercise.getSets()));
					pstat.setInt(6, Integer.parseInt(exercise.getRepsPerSet()));
					pstat.setInt(7, Integer.parseInt(exercise.getExerciseTime()));
					pstat.setFloat(8, Float.parseFloat(exercise.getWeight()));
					
					System.out.println("Executing insert for exercise: " + 
						(exercise.getExerciseCreationType().equals("0") ? 
						"exercise_no=" + exercise.getExerciseNo() : 
						"custom_exercise_no=" + exercise.getCustomExerciseNo()));
					
					pstat.addBatch();
				} catch (Exception e) {
					System.out.println("Error processing exercise: " + e.getMessage());
					e.printStackTrace();
				}
			}
			
			int[] results = pstat.executeBatch();
			boolean success = true;
			for (int result : results) {
				if (result <= 0) {
					success = false;
					break;
				}
			}
			return success;
			
		} catch (Exception e) {
			System.out.println("Error in insertRoutineExercises: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}

	public List<String> getAllRoutineNos() {
		List<String> routineNos = new ArrayList<>();
		PreparedStatement pstat = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT routine_no FROM routine ORDER BY routine_no";
			pstat = conn.prepareStatement(sql);
			rs = pstat.executeQuery();
			
			while (rs.next()) {
				routineNos.add(rs.getString("routine_no"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("루틴 목록 조회 중 오류가 발생했습니다.", e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstat != null) pstat.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return routineNos;
	}

	public boolean isFavoriteRoutine(String memberId, String routineNo) {
		
		String sql = "SELECT COUNT(*) FROM exercise_routine_favorite WHERE member_id = ? AND routine_no = ?";
	    
		try {
	        PreparedStatement pstat = conn.prepareStatement(sql);
	        pstat.setString(1, memberId);
	        pstat.setString(2, routineNo);
	        ResultSet rs = pstat.executeQuery();
	        
	        if (rs.next()) {
	            return rs.getInt(1) > 0;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	    
	}
	
	public boolean addFavoriteRoutine(String memberId, String routineNo) {
	    String sql = "INSERT INTO exercise_routine_favorite (exercise_routine_favorite_no, regdate, member_id, routine_no) "
	               + "VALUES (seq_exercise_routine_favorite.NEXTVAL, SYSDATE, ?, ?)";
	    System.out.println("routineNo = " + routineNo);
	    
	    try (PreparedStatement pstat = conn.prepareStatement(sql)) {
	        pstat.setString(1, memberId);
	        pstat.setString(2, routineNo);
	        return pstat.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return false;
	}
	
	public boolean removeFavoriteRoutine(String memberId, String routineNo) {
	    String sql = "DELETE FROM exercise_routine_favorite WHERE member_id = ? AND routine_no = ?";
	    
	    try (PreparedStatement pstat = conn.prepareStatement(sql)) {
	        pstat.setString(1, memberId);
	        pstat.setString(2, routineNo);
	        return pstat.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return false;
	}
	
	public List<RoutineDTO> getRoutineList(String memberId) {
		List<RoutineDTO> list = new ArrayList<>();
	    String sql = "SELECT r.routine_no, r.routine_name, r.creation_date, r.public_check, " +
	                 "r.creator_id, r.routine_category_no, r.views, r.recommend, r.disrecommend, " +
	                 "m.member_nickname, rc.routine_category_name, " +
	                 "CASE WHEN f.member_id IS NOT NULL THEN 1 ELSE 0 END AS favorite_check " +
	                 "FROM routine r " +
	                 "JOIN member m ON r.creator_id = m.member_id " +
	                 "JOIN routine_category rc ON r.routine_category_no = rc.routine_category_no " +
	                 "LEFT JOIN exercise_routine_favorite f ON r.routine_no = f.routine_no AND f.member_id = ? " +
	                 "ORDER BY r.creation_date DESC";
	    
	    try {
	        PreparedStatement pstat = conn.prepareStatement(sql);
	        pstat.setString(1, memberId);
	        ResultSet rs = pstat.executeQuery();
	        
	        while (rs.next()) {
	            RoutineDTO dto = new RoutineDTO();
	            dto.setRoutineNo(rs.getString("routine_no"));
	            dto.setRoutineName(rs.getString("routine_name"));
	            dto.setCreationDate(rs.getString("creation_date"));
	            dto.setPublicCheck(rs.getString("public_check"));
	            dto.setCreatorId(rs.getString("creator_id"));
	            dto.setRoutineCategoryNo(rs.getString("routine_category_no"));
	            dto.setViews(rs.getString("views"));
	            dto.setRecommend(rs.getString("recommend"));
	            dto.setDisrecommend(rs.getString("disrecommend"));
	            dto.setMemberNickname(rs.getString("member_nickname"));
	            dto.setRoutineCategoryName(rs.getString("routine_category_name"));
	            dto.setFavoriteCheck(rs.getString("favorite_check")); // 여기에 즐겨찾기 여부
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

}
