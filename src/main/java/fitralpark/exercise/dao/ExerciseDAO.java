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
import fitralpark.user.dto.UserDTO;

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
	
	public List<ExerciseDTO> getExerciseList(String keyword, String category) {
	    List<ExerciseDTO> list = new ArrayList<>();

	    StringBuilder sql = new StringBuilder();
	    sql.append("SELECT e.exercise_no, e.exercise_name, ");
	    sql.append("ec.exercise_category_name, ep.exercise_part_name, e.calories_per_unit ");
	    sql.append("FROM exercise e ");
	    sql.append("LEFT JOIN exercise_category_group ecg ON e.exercise_no = ecg.exercise_no ");
	    sql.append("LEFT JOIN exercise_category ec ON ecg.exercise_category_no = ec.exercise_category_no ");
	    sql.append("LEFT JOIN exercise_part_link epl ON e.exercise_no = epl.exercise_no ");
	    sql.append("LEFT JOIN exercise_part ep ON epl.exercise_part_no = ep.exercise_part_no ");
	    sql.append("WHERE 1=1 "); // 기본 조건

	    if (keyword != null && !keyword.isEmpty()) {
	        sql.append("AND e.exercise_name LIKE ? ");
	    }
	    if (category != null && !category.isEmpty()) {
	        sql.append("AND ec.exercise_category_no = ? ");
	    }

	    try {
	        PreparedStatement pstat = conn.prepareStatement(sql.toString());

	        int idx = 1;
	        if (keyword != null && !keyword.isEmpty()) {
	            pstat.setString(idx++, "%" + keyword + "%");
	        }
	        if (category != null && !category.isEmpty()) {
	            pstat.setString(idx++, category);
	        }

	        ResultSet rs = pstat.executeQuery();

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
	
	public List<ExerciseDTO> getCustomExerciseList(String memberId, String keyword, String category) {
	    List<ExerciseDTO> list = new ArrayList<>();

	    StringBuilder sql = new StringBuilder();
	    sql.append("SELECT ce.custom_exercise_no, ");
	    sql.append("ce.custom_exercise_name, ");
	    sql.append("ce.calories_per_unit, ");
	    sql.append("ec.exercise_category_name, ");
	    sql.append("ep.exercise_part_name ");
	    sql.append("FROM custom_exercise ce ");
	    sql.append("LEFT JOIN custom_exercise_category_group ceg ON ce.custom_exercise_no = ceg.custom_exercise_no ");
	    sql.append("LEFT JOIN exercise_category ec ON ceg.exercise_category_no = ec.exercise_category_no ");
	    sql.append("LEFT JOIN custom_exercise_part_link cepl ON ce.custom_exercise_no = cepl.custom_exercise_no ");
	    sql.append("LEFT JOIN exercise_part ep ON cepl.exercise_part_no = ep.exercise_part_no ");
	    sql.append("WHERE ce.creator_id = ? ");

	    if (keyword != null && !keyword.isEmpty()) {
	        sql.append("AND ce.custom_exercise_name LIKE ? ");
	    }
	    if (category != null && !category.isEmpty()) {
	        sql.append("AND ec.exercise_category_no = ? ");
	    }
	    
	    sql.append("ORDER BY ce.custom_exercise_no DESC");

	    try {
	        PreparedStatement pstat = conn.prepareStatement(sql.toString());

	        int idx = 1;
	        pstat.setString(idx++, memberId);
	        if (keyword != null && !keyword.isEmpty()) {
	            pstat.setString(idx++, "%" + keyword + "%");
	        }
	        if (category != null && !category.isEmpty()) {
	            pstat.setString(idx++, category);
	        }

	        ResultSet rs = pstat.executeQuery();

	        while (rs.next()) {
	            ExerciseDTO dto = new ExerciseDTO();
	            dto.setCustomExerciseNo(rs.getString("custom_exercise_no"));
	            dto.setCustomExerciseName(rs.getString("custom_exercise_name"));
	            dto.setCustomCaloriesPerUnit(rs.getString("calories_per_unit"));
	            dto.setCustomExerciseCategoryName(rs.getString("exercise_category_name"));
	            dto.setCustomExercisePartName(rs.getString("exercise_part_name"));
	            list.add(dto);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	public String insertCustomExercise(String name, String kcal, String creatorId) {
		String customExerciseNo = null;
		
		try {
			// 시퀀스 값을 먼저 가져옴
			String seqSql = "SELECT seq_custom_exercise.NEXTVAL FROM DUAL";
			PreparedStatement seqPstat = conn.prepareStatement(seqSql);
			ResultSet seqRs = seqPstat.executeQuery();
			
			if (seqRs.next()) {
				customExerciseNo = seqRs.getString(1);
				
				// 실제 INSERT 실행
				String sql = "INSERT INTO custom_exercise (custom_exercise_no, custom_exercise_name, calories_per_unit, creator_id, weight_unit_no) VALUES (?, ?, ?, ?, 1)";
				PreparedStatement pstat = conn.prepareStatement(sql);
				pstat.setString(1, customExerciseNo);
				pstat.setString(2, name);
				pstat.setString(3, kcal);
				pstat.setString(4, creatorId);
				
				int result = pstat.executeUpdate();
				if (result <= 0) {
					customExerciseNo = null;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			customExerciseNo = null;
		}
		
		return customExerciseNo;
	}

	public void insertCustomExercisePartLink(String customExerciseNo, String partNo) {
		
		String sql = "INSERT INTO custom_exercise_part_link (custom_exercise_part_link_no, custom_exercise_no, exercise_part_no) " +
                "VALUES (seq_custom_exercise_part_link.NEXTVAL, ?, ?)";
		
	   try {
	       PreparedStatement pstat = conn.prepareStatement(sql);
	       pstat.setString(1, customExerciseNo);
	       pstat.setString(2, partNo);
	       pstat.executeUpdate();
	       
	   } catch (Exception e) {
	       e.printStackTrace();
	   }
		
	}

	public void insertCustomExerciseCategoryGroup(String customExerciseNo, String categoryNo) {
		
		String sql = "INSERT INTO custom_exercise_category_group (custom_exercise_category_no, custom_exercise_no, exercise_category_no) " +
                "VALUES (seq_custom_exercise_category_group.NEXTVAL, ?, ?)";
		
	   try {
	       PreparedStatement pstat = conn.prepareStatement(sql);
	       pstat.setString(1, customExerciseNo);
	       pstat.setString(2, categoryNo);
	       pstat.executeUpdate();
	       
	   } catch (Exception e) {
	       e.printStackTrace();
	   }
		
	}
	
	public ExerciseDTO getCustomExercise(String customExerciseNo) {
		ExerciseDTO dto = null;
		String sql = "SELECT ce.custom_exercise_no, ce.custom_exercise_name, " +
				"ce.calories_per_unit, ceg.exercise_category_no, cepl.exercise_part_no " +
				"FROM custom_exercise ce " +
				"LEFT JOIN custom_exercise_category_group ceg ON ce.custom_exercise_no = ceg.custom_exercise_no " +
				"LEFT JOIN custom_exercise_part_link cepl ON ce.custom_exercise_no = cepl.custom_exercise_no " +
				"WHERE ce.custom_exercise_no = ?";
		
		try {
			PreparedStatement pstat = conn.prepareStatement(sql);
			pstat.setString(1, customExerciseNo);
			ResultSet rs = pstat.executeQuery();
			
			if (rs.next()) {
				dto = new ExerciseDTO();
				dto.setCustomExerciseNo(rs.getString("custom_exercise_no"));
				dto.setCustomExerciseName(rs.getString("custom_exercise_name"));
				dto.setCustomCaloriesPerUnit(rs.getString("calories_per_unit"));
				dto.setCustomExerciseCategoryNo(rs.getString("exercise_category_no"));
				dto.setCustomExercisePartNo(rs.getString("exercise_part_no"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public void updateCustomExercise(String customExerciseNo, String exerciseName, String caloriesPerUnit) {
		String sql = "UPDATE custom_exercise SET custom_exercise_name = ?, calories_per_unit = ? WHERE custom_exercise_no = ?";
		
		try {
			PreparedStatement pstat = conn.prepareStatement(sql);
			pstat.setString(1, exerciseName);
			pstat.setString(2, caloriesPerUnit);
			pstat.setString(3, customExerciseNo);
			pstat.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateCustomExerciseCategory(String customExerciseNo, String categoryNo) {
		String sql = "UPDATE custom_exercise_category_group SET exercise_category_no = ? WHERE custom_exercise_no = ?";
		
		try {
			PreparedStatement pstat = conn.prepareStatement(sql);
			pstat.setString(1, categoryNo);
			pstat.setString(2, customExerciseNo);
			pstat.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateCustomExercisePart(String customExerciseNo, String partNo) {
		String sql = "UPDATE custom_exercise_part_link SET exercise_part_no = ? WHERE custom_exercise_no = ?";
		
		try {
			PreparedStatement pstat = conn.prepareStatement(sql);
			pstat.setString(1, partNo);
			pstat.setString(2, customExerciseNo);
			pstat.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
