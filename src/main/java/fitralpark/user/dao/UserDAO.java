package fitralpark.user.dao;

import fitralpark.common.utils.DBUtil;
import fitralpark.user.dto.DashCurrentDietDTO;
import fitralpark.user.dto.DashCurrentExcsDTO;
import fitralpark.user.dto.DashDTO;
import fitralpark.user.dto.DashFoodDTO;
import fitralpark.user.dto.DashTodayDietDTO;
import fitralpark.user.dto.DashTodayExerciseDTO;
import fitralpark.user.dto.UserDTO;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class UserDAO {
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	
	public UserDAO() {
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
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	// 회원 가입 (INSERT)
	public int insertMember(UserDTO dto) {
		String sql = "INSERT INTO member (member_no, member_id, pw, member_nickname, member_name, personalnumber, tel, email, address, member_pic, background_pic, allergy, fitness_score, community_score, restrict_check, withdraw_check, mentor_check, admin_check, plan_public_check) "
				+ "VALUES (SEQMEMBER.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, dto.getMemberId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getMemberNickname());
			pstmt.setString(4, dto.getMemberName());
			pstmt.setString(5, dto.getPersonalNumber());
			pstmt.setString(6, dto.getTel());
			pstmt.setString(7, dto.getEmail());
			pstmt.setString(8, dto.getAddress());
			pstmt.setString(9, dto.getMemberPic());
			pstmt.setString(10, dto.getBackgroundPic());
			pstmt.setString(11, dto.getAllergy());
			pstmt.setInt(12, dto.getFitnessScore());
			pstmt.setInt(13, dto.getCommunityScore());
			pstmt.setInt(14, dto.getRestrictCheck());
			pstmt.setInt(15, dto.getWithdrawCheck());
			pstmt.setInt(16, dto.getMentorCheck());
			pstmt.setInt(17, dto.getAdminCheck());
			pstmt.setInt(18, dto.getPlanPublicCheck());

			System.out.println("[DEBUG] 회원가입 시도: " + dto);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			System.err.println("[회원가입 실패 - 예외 발생]");
			e.printStackTrace();
		}

		return 0;
	}

	// 회원 정보 수정 (UPDATE)
	public int updateMember(UserDTO dto) {
		String sql = "UPDATE member SET "
				+ "pw = ?, member_pic = ?, background_pic = ?, member_nickname = ?, member_name = ?, "
				+ "personalnumber = ?, allergy = ?, tel = ?, email = ?, address = ?, "
				+ "fitness_score = ?, community_score = ?, restrict_check = ?, withdraw_check = ?, "
				+ "mentor_check = ?, admin_check = ?, plan_public_check = ? " + "WHERE member_no = ?";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getMemberPic());
			pstmt.setString(3, dto.getBackgroundPic());
			pstmt.setString(4, dto.getMemberNickname());
			pstmt.setString(5, dto.getMemberName());
			pstmt.setString(6, dto.getPersonalNumber());
			pstmt.setString(7, dto.getAllergy());
			pstmt.setString(8, dto.getTel());
			pstmt.setString(9, dto.getEmail());
			pstmt.setString(10, dto.getAddress());
			pstmt.setInt(11, dto.getFitnessScore());
			pstmt.setInt(12, dto.getCommunityScore());
			pstmt.setInt(13, dto.getRestrictCheck());
			pstmt.setInt(14, dto.getWithdrawCheck());
			pstmt.setInt(15, dto.getMentorCheck());
			pstmt.setInt(16, dto.getAdminCheck());
			pstmt.setInt(17, dto.getPlanPublicCheck());
			pstmt.setInt(18, dto.getMemberNo());

			System.out.println("[DEBUG] 회원가입 시도: " + dto);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			System.err.println("[회원정보 수정 실패 - 예외 발생]");
			e.printStackTrace();
		}

		return 0;
	}

	public DashDTO getDashInfo(String id) {
		try {
			DashDTO dto = new DashDTO();
			
			//개인정보
			String sql = """
					select member_id    --id    
					     , background_pic --배경사진
					     , member_name
					     , case
					            when substr(personalnumber, 7,1) in (1,3) then 'm'
					            when substr(personalnumber, 7,1) in (2,4) then 'f'
					        end as gender
					     , case
					            when substr(personalnumber, 7,1) in (1,2,5,6)  then to_number(to_char(sysdate,'yyyy')) - to_number('19' || substr(personalnumber, 1,2))
					            when substr(personalnumber, 7,1) in (3,4,7,8) then to_number(to_char(sysdate,'yyyy')) - to_number('20' || substr(personalnumber, 1,2))
					        end as age
					     , (select height from (select height from member_physical where member_id = m.member_id order by regdate desc) where rownum <= 1) as height
					     , (select weight from (select weight from member_physical where member_id = m.member_id order by regdate desc) where rownum <= 1) as weight
					  from member m
					 where member_id = ?
					""";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			rs = pstat.executeQuery();
						
			while(rs.next()) {
				dto.setUserName(rs.getString("member_name"));
				dto.setBackgroundPic(rs.getString("background_pic"));
				dto.setHeight(rs.getString("height"));
				dto.setWeight(rs.getString("weight"));
				dto.setAge(rs.getString("age"));
				dto.setGender(rs.getString("gender"));
			}
			
			//오늘의 운동
			ArrayList<DashTodayExerciseDTO> tdyExcsList = new ArrayList<DashTodayExerciseDTO>();
			sql = """
					select ep.creator_id as creator_id 
					     , ep.regdate as plandate
					     , ex.exercise_name as exerciseName
					     , ex.sets as sets
					     , ex.reps_per_set as ining
					     , ex.exercise_time as times
					     , ex.weight as load
					  from exercise_plan ep
					 inner join exercise_plan_routine epr
					   on ep.exercise_plan_no = epr.exercise_plan_no
					 inner join routine r
					  on r.routine_no  = epr.routine_no
					 inner join (
					                select re.routine_no as routine_no
					                     , e.exercise_name as exercise_name
					                     , re.sets as sets
					                     , reps_per_set as reps_per_set
					                     , exercise_time as exercise_time
					                     , weight as weight
					                  from routine_exercise re
					                  inner join exercise e
					                    on re.exercise_no = e.exercise_no
					                   and re.exercise_creation_type = 0
					                union all
					                select re.routine_no
					                     , ce.custom_exercise_name
					                     , re.sets
					                     , reps_per_set
					                     , exercise_time
					                     , weight
					                  from routine_exercise re
					                  inner join custom_exercise ce
					                    on re.custom_exercise_no = ce.custom_exercise_no
					                   and re.exercise_creation_type = 1
					             ) ex
					  on r.routine_no = ex.routine_no
					 where to_char(ep.regdate, 'yyyymmdd') = to_char(sysdate - 1, 'yyyymmdd')
					   and ep.creator_id = ?
					""";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			
			rs = pstat.executeQuery();
			
			while (rs.next()) {
				DashTodayExerciseDTO item = new DashTodayExerciseDTO();
				item.setExerciseName(rs.getString("exerciseName"));
				item.setIning(rs.getString("ining"));
				item.setSet(rs.getString("sets"));
				item.setLoad(rs.getString("load"));
				item.setTimes(rs.getString("times"));
				
				tdyExcsList.add(item);
				
			}
			dto.setTdyExcsList(tdyExcsList);
			
			//오늘의 식단
			
			ArrayList<DashTodayDietDTO> tdyDietList = new ArrayList<DashTodayDietDTO>();
			
			sql = """
					select dp.creator_id as creator_id
					     , dp.regdate as plandate
					     , d.meal_classify as meal_classify
					     , f.food_name as food_name
					     , f.intake as intake
					  from diet_plan dp
					 inner join diet d
					   on dp.diet_no = d.diet_no
					 inner join (
					                select dfl0.diet_no as diet_no
					                      , food_name as food_name
					                      , dfl0.intake as intake
					                  from diet_food_list dfl0
					                 inner join food f
					                    on dfl0.food_no = f.food_no
					                   and dfl0.food_creation_type = 0
					                union all
					                select dfl1.diet_no
					                      , custom_food_name
					                      , dfl1.intake as intake
					                  from diet_food_list dfl1
					                 inner join custom_food cf
					                    on dfl1.custom_food_no = cf.custom_food_no
					                   and dfl1.food_creation_type = 1
					             ) f
					    on d.diet_no = f.diet_no
					 where to_char(dp.regdate, 'yyyymmdd') = to_char(sysdate - 1, 'yyyymmdd')
					   and dp.creator_id = ?
					 order by plandate, meal_classify
					""";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			
			rs = pstat.executeQuery();
			
			ArrayList<DashFoodDTO> foodList = new ArrayList<DashFoodDTO>();
			
			DashTodayDietDTO currentDTO = null;
			
			while(rs.next()) {
				String meal_classify = rs.getString("meal_classify");
				String food_name = rs.getString("food_name");
				String intake = rs.getString("intake");
				
				if (currentDTO == null || !currentDTO.getMealClassify().equals(meal_classify)) {
					currentDTO = new DashTodayDietDTO();
					currentDTO.setMealClassify(meal_classify);
					currentDTO.setFoodList(new ArrayList<DashFoodDTO>());
					
					tdyDietList.add(currentDTO);
					
				} 
				
				currentDTO.getFoodList().add(new DashFoodDTO(food_name, intake));
				
			}
			dto.setTdyDietList(tdyDietList);
			
			
			//최근 운동 기록
			ArrayList<DashCurrentExcsDTO> crtExcsList = new ArrayList<DashCurrentExcsDTO>();
			
			sql = """
					select to_char(to_date(regdate, 'yyyymmdd'), 'yyyy.mm.dd.(dy)') as regdate
					     , nvl(sum(total_plan),0) as total_plan
					     , nvl(sum(not_plan_exercise),0) as not_plan_exercise
					     , nvl(sum(complete_exercise),0) as complete_exercise
					     , nvl(sum(incomplete_exercise),0) as incomplete_exercise
					     , case when nvl(sum(total_plan),0) != 0 then round(nvl(sum(complete_exercise),0) / nvl(sum(total_plan),0) * 100, 1)
					            else null
					        end as processivity
					  from (
					            select nvl(ep.regdate, er.regdate) as regdate
					                 , case when ep.creator_id is not null then 1 end as total_plan
					                 , case when ep.creator_id is null then 1 end as not_plan_exercise
					                 , case when ep.creator_id is not null and er.creator_id is not null then 1 end as complete_exercise
					                 , case when er.creator_id is null then 1 end as incomplete_exercise
					              from (
					                        select ep.CREATOR_ID
					                             , to_char(ep.regdate, 'yyyymmdd') as regdate
					                             , re.EXERCISE_CREATION_TYPE
					                             , nvl(re.EXERCISE_NO, 0) as EXERCISE_NO
					                             , nvl(re.CUSTOM_EXERCISE_NO, 0) as CUSTOM_EXERCISE_NO
					                             , re.SETS
					                             , re.REPS_PER_SET
					                             , re.WEIGHT
					                             , re.EXERCISE_TIME
					                          from exercise_plan ep
					                         inner join exercise_plan_routine epr
					                            on ep.EXERCISE_PLAN_NO = epr.EXERCISE_PLAN_NO
					                         inner join routine r
					                            on epr.ROUTINE_NO = r.ROUTINE_NO
					                         inner join routine_exercise re
					                            on r.ROUTINE_NO = re.ROUTINE_NO
					                         where ep.CREATOR_ID = ?
					                           and ep.regdate between (sysdate - 7) and sysdate
					                    ) ep
					              full outer join (
					                                    select CREATOR_ID
					                                          , to_char(RECORD_DATE, 'yyyymmdd') as regdate
					                                          , EXERCISE_CREATION_TYPE
					                                          , nvl(EXERCISE_NO, 0) as EXERCISE_NO
					                                          , nvl(CUSTOM_EXERCISE_NO, 0) as CUSTOM_EXERCISE_NO
					                                          , SETS
					                                          , REPS_PER_SET
					                                          , WEIGHT
					                                          , EXERCISE_TIME
					                                      from exercise_record
					                                     where CREATOR_ID = ?
					                                       and RECORD_DATE between (sysdate - 7) and sysdate
					                                ) er
					                on ep.CREATOR_ID = er.CREATOR_ID
					               and ep.regdate = er.regdate
					               and ep.EXERCISE_CREATION_TYPE = er.EXERCISE_CREATION_TYPE
					               and ep.EXERCISE_NO = er.EXERCISE_NO
					               and ep.CUSTOM_EXERCISE_NO = er.CUSTOM_EXERCISE_NO
					               and ep.SETS = er.SETS
					               and ep.REPS_PER_SET = er.REPS_PER_SET
					               and ep.WEIGHT = er.WEIGHT
					               and ep.EXERCISE_TIME = er.EXERCISE_TIME
					        )
					 group by regdate
					""";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			pstat.setString(2, id);
			
			rs = pstat.executeQuery();
			
			while(rs.next()) {
				DashCurrentExcsDTO item = new DashCurrentExcsDTO();
				item.setRegdate(rs.getString("regdate"));
				item.setTotalPlanCnt(rs.getString("total_plan"));
				item.setUnplanCnt(rs.getString("not_plan_exercise"));
				item.setCompletePlanCnt(rs.getString("complete_exercise"));
				item.setIncompletePlanCnt(rs.getString("incomplete_exercise"));
				item.setProcessivity(rs.getString("processivity"));
				
				crtExcsList.add(item);
			}
			dto.setCrtExcsList(crtExcsList);
			
			//최근 식사 기록
			ArrayList<DashCurrentDietDTO> crtdietList = new ArrayList<DashCurrentDietDTO>();
			sql = """
					select to_char(to_date(regdate, 'yyyymmdd'), 'yyyy.mm.dd.(dy)') as regdate
					     , nvl(sum(total_plan),0) as total_plan
					     , nvl(sum(not_plan_diet),0) as not_plan_diet
					     , nvl(sum(complete_diet),0) as complete_diet
					     , nvl(sum(incomplete_diet),0) as incomplete_diet
					     , case when nvl(sum(total_plan),0) != 0 then round(nvl(sum(complete_diet),0) / nvl(sum(total_plan),0) * 100, 1)
					            else null
					        end as processivity
					  from (
					            select nvl(dp.regdate, ir.REGDATE) as regdate
					                 , case when dp.creator_id is not null then 1 end as total_plan
					                 , case when dp.creator_id is null then 1 end as not_plan_diet
					                 , case when dp.creator_id is not null and ir.creator_id is not null then 1 end as complete_diet
					                 , case when ir.creator_id is null then 1 end as incomplete_diet
					              from (
					                        select dp.creator_id
					                              , to_char(dp.regdate, 'yyyymmdd') as regdate
					                              , d.meal_classify
					                              , d.diet_no
					                              , nvl(dfl.food_no, 0) as food_no
					                              , nvl(dfl.custom_food_no, 0) as custom_food_no
					                              , dfl.food_creation_type
					                              , dfl.intake
					                          from diet_plan dp
					                         inner join diet d
					                           on dp.diet_no = d.diet_no
					                         inner join diet_food_list dfl
					                           on d.diet_no = dfl.diet_no
					                         where dp.creator_id = ?
					                           and dp.regdate between (sysdate - 7) and sysdate
					                   ) dp
					              full join (
					                            select CREATOR_ID
					                                 , to_char(REGDATE, 'yyyymmdd') as regdate
					                                 , MEAL_CLASSIFY
					                                 , DIET_NO
					                                 , nvl(FOOD_NO, 0) as FOOD_NO
					                                 , nvl(CUSTOM_FOOD_NO, 0) as CUSTOM_FOOD_NO
					                                 , FOOD_CREATION_TYPE
					                                 , INTAKE
					                              from intake_record
					                             where creator_id = ?
					                               and regdate between (sysdate - 7) and sysdate
					                         ) ir
					                on dp.creator_id = ir.creator_id
					               and dp.regdate = ir.regdate
					               and dp.meal_classify = ir.meal_classify
					               and dp.diet_no = ir.diet_no
					               and dp.food_creation_type = ir.food_creation_type
					               and dp.food_no = ir.food_no
					               and dp.custom_food_no = ir.custom_food_no
					               and dp.intake = ir.intake
					        )
					   group by regdate
					""";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			pstat.setString(2, id);
			
			rs = pstat.executeQuery();
			
			while(rs.next()) {
				DashCurrentDietDTO item = new DashCurrentDietDTO();
				item.setCompletePlanCnt(rs.getString("complete_diet"));
				item.setIncompletePlanCnt(rs.getString("incomplete_diet"));
				item.setProcessivity(rs.getString("processivity"));
				item.setRegdate(rs.getString("regdate"));
				item.setTotalPlanCnt(rs.getString("total_plan"));
				item.setUnplanCnt(rs.getString("not_plan_diet"));
				
				crtdietList.add(item);
			}
			
			dto.setCrtdietList(crtdietList);

			
			
			return dto;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	// 아이디 중복 확인
	public boolean isDuplicateId(String id) {
		String sql = "SELECT COUNT(*) FROM member WHERE member_id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				int count = rs.getInt(1);
				return count > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
