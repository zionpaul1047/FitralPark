package fitralpark.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import fitralpark.common.utils.DBUtil;
import fitralpark.diet.dto.IntakeRecordDTO;
import fitralpark.exercise.dto.ExerciseRecordDTO;
import fitralpark.user.dto.DashCurrentDietDTO;
import fitralpark.user.dto.DashCurrentExcsDTO;
import fitralpark.user.dto.DashDTO;
import fitralpark.user.dto.DashFoodDTO;
import fitralpark.user.dto.DashPhysicalHistDTO;
import fitralpark.user.dto.DashTodayDietDTO;
import fitralpark.user.dto.DashTodayExerciseDTO;
import fitralpark.user.dto.DashTodayIntakeDTO;
import fitralpark.user.dto.UserDTO;

/***
 * User서비스의 DB처리를 위한 DAO 클래스 
 * @author 한가람, 이지온
 */
public class UserDAO {
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	
	/**
	 * UserDAO 생성자로, 커넥션풀에서 Connection 객체와 Statement 객체를 얻는다.
	 * @author 한가람
	 */
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
	/**
	 * 얻어온 Connection 객체를 반환한다. 
	 * @author 한가람
	 */
	public void close() {
		try {
			this.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	/**
	 * 신규 회원 정보를 데이터베이스에 등록합니다.
	 * <p>
	 * 입력된 {@link UserDTO} 객체의 필드 값을 바탕으로 INSERT 쿼리를 실행하여
	 * MEMBER 테이블에 회원 데이터를 저장합니다.
	 * </p>
	 * 
	 * @author 이지온
	 * @param dto 회원 정보가 담긴 UserDTO 객체
	 * @return 삽입 성공 시 1, 실패 시 0 반환
	 * throws SQLException 데이터베이스 연결 또는 쿼리 실행 중 예외가 발생할 수 있음
	 */
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
			
			return pstmt.executeUpdate();
			

		} catch (Exception e) {
			System.err.println("[회원가입 실패 - 예외 발생]");
			e.printStackTrace();
		}

		return 0;
	}

	// 회원 정보 수정 (UPDATE)
	/**
	 * 얻어온 파라미터 객체안의 회원정보로 데이터를 수정한다.
	 * @author 한가람
	 * @param dto 회원의 id와 수정할(to-be) 패스워드, 닉네임, 연락처, 이메일, 주소 정보가 담긴 UserDTO 객체 
	 * @return 데이터 수정 후 실행 결과값을 반환. 성공 시 1, 실패 시 0을 반환한다.
	 */
	public int updateMember(UserDTO dto) {
		
		try {
			String sql = """
					update member 
					   set pw = ?
					     , member_nickname = ?
					     , tel = ?
					     , email = ?
					     , address = ?
					 where member_id = ?
					""";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getPw());
			pstat.setString(2, dto.getMemberNickname());
			pstat.setString(3, dto.getTel());
			pstat.setString(4, dto.getEmail());
			pstat.setString(5, dto.getAddress());
			pstat.setString(6, dto.getMemberId());
			
			return pstat.executeUpdate();
			
			
		} catch (Exception e) {
			System.err.println("[회원정보 수정 실패 - 예외 발생]");
			e.printStackTrace();
		}
		

		return 0;
	}
	/**
	 * 대시보드에서 보여줄 회원의 정보를 조회한다.
	 * @author 한가람
	 * @param userdto 회원의 id가 담긴 UserDTO 객체 
	 * @return 개인정보(사용자이름, 배경사진 파일명, 키, 몸무게, 나이, 성별), 오늘의 운동정보(운동명, 세트당 횟수, 세트, 중량, 운동시간, 운동생성구분, 운동번호) 리스트, 오늘의 식단정보(끼니구분, 식단번호, 식단의 음식리스트(음식명, 섭취량, 음식생성구분, 음식번호)), 일주일간의 운동 집계 정보(기록일, 총계획수, 계획되지않은 운동기록수, 완료한 운동기록수, 미완료한 운동기록수, 달성률), 일주일간의 식사 집계 정보(기록일, 총계획수, 계획되지 않은 식사기록 수, 완료한 식사기록 수, 미완료한 식사기록 수, 달성률) 을 반환한다. 
	 */
	public DashDTO getDashInfo(UserDTO userdto) {
		try {
			String id = userdto.getMemberId();
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
                         , ex.exercise_creation_type as exercise_creation_type
                         , ex.exercise_no as exercise_no
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
                                         , 0 as exercise_creation_type
                                         , e.exercise_no as exercise_no
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
                                         , 1 as exercise_creation_type
                                         , ce.custom_exercise_no as exercise_no
					                  from routine_exercise re
					                  inner join custom_exercise ce
					                    on re.custom_exercise_no = ce.custom_exercise_no
					                   and re.exercise_creation_type = 1
					             ) ex
					  on r.routine_no = ex.routine_no
					 where to_char(ep.regdate, 'yyyymmdd') = to_char(sysdate, 'yyyymmdd')
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
				item.setExcsCrtType(rs.getString("exercise_creation_type"));
				item.setExcsNo(rs.getString("exercise_no"));
				
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
                         , f.food_creation_type
                         , f. food_no
                         , d.diet_no
					  from diet_plan dp
					 inner join diet d
					   on dp.diet_no = d.diet_no
					 inner join (
					                select dfl0.diet_no as diet_no
					                      , food_name as food_name
					                      , dfl0.intake as intake
                                          , 0 as food_creation_type
                                          , f.food_no as food_no
					                  from diet_food_list dfl0
					                 inner join food f
					                    on dfl0.food_no = f.food_no
					                   and dfl0.food_creation_type = 0
					                union all
					                select dfl1.diet_no
					                      , custom_food_name
					                      , dfl1.intake as intake
                                          , 1 as food_creation_type
                                          , cf.custom_food_no as food_no
					                  from diet_food_list dfl1
					                 inner join custom_food cf
					                    on dfl1.custom_food_no = cf.custom_food_no
					                   and dfl1.food_creation_type = 1
					             ) f
					    on d.diet_no = f.diet_no
					 where to_char(dp.regdate, 'yyyymmdd') = to_char(sysdate, 'yyyymmdd')
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
				String diet_no = rs.getString("diet_no");
				String food_name = rs.getString("food_name");
				String intake = rs.getString("intake");
				String foodCreationType = rs.getString("food_creation_type");
				String foodNo = rs.getString("food_no");
				
				if (currentDTO == null || !currentDTO.getMealClassify().equals(meal_classify)) {
					currentDTO = new DashTodayDietDTO();
					currentDTO.setMealClassify(meal_classify);
					currentDTO.setDietNo(diet_no);
					currentDTO.setFoodList(new ArrayList<DashFoodDTO>());
					
					tdyDietList.add(currentDTO);
					
				} 
				
				currentDTO.getFoodList().add(new DashFoodDTO(food_name, intake, foodCreationType, foodNo));
				
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
			
			//하루 영양소 섭취량
			DashTodayIntakeDTO tdyIntakeNtr = new DashTodayIntakeDTO();
			
			sql = """
					select nvl(sum(enerc),0) as enerc
					     , nvl(sum(water),0) as water
					     , nvl(sum(prot),0) as prot
					     , nvl(sum(fatce),0) as fatce
					     , nvl(sum(ash),0) as ash
					     , nvl(sum(chocdf),0) as chocdf
					     , nvl(sum(sugar),0) as sugar
					     , nvl(sum(fibtg),0) as fibtg
					     , nvl(sum(ca),0) as ca
					     , nvl(sum(fe),0) as fe
					     , nvl(sum(p),0) as p
					     , nvl(sum(k),0) as k
					     , nvl(sum(nat),0) as nat
					     , nvl(sum(vitaRae),0) as vitaRae
					     , nvl(sum(retol),0) as retol
					     , nvl(sum(cartb),0) as cartb
					     , nvl(sum(thia),0) as thia
					     , nvl(sum(ribf),0) as ribf
					     , nvl(sum(nia),0) as nia
					     , nvl(sum(vitc),0) as vitc
					     , nvl(sum(vitd),0) as vitd
					     , nvl(sum(fasat),0) as fasat
					     , nvl(sum(fatrn),0) as fatrn
					     , nvl(sum(chole),0) as chole
					  from (
					        select NUTRIENT_CD
					             , nutrient_content
					             , case when NUTRIENT_CD = 'enerc' then nutrient_content else 0 end as enerc
					             , case when NUTRIENT_CD = 'water' then nutrient_content else 0 end as water
					             , case when NUTRIENT_CD = 'prot' then nutrient_content else 0 end as prot
					             , case when NUTRIENT_CD = 'fatce' then nutrient_content else 0 end as fatce
					             , case when NUTRIENT_CD = 'ash' then nutrient_content else 0 end as ash
					             , case when NUTRIENT_CD = 'chocdf' then nutrient_content else 0 end as chocdf
					             , case when NUTRIENT_CD = 'sugar' then nutrient_content else 0 end as sugar
					             , case when NUTRIENT_CD = 'fibtg' then nutrient_content else 0 end as fibtg
					             , case when NUTRIENT_CD = 'ca' then nutrient_content else 0 end as ca
					             , case when NUTRIENT_CD = 'fe' then nutrient_content else 0 end as fe
					             , case when NUTRIENT_CD = 'p' then nutrient_content else 0 end as p
					             , case when NUTRIENT_CD = 'k' then nutrient_content else 0 end as k
					             , case when NUTRIENT_CD = 'nat' then nutrient_content else 0 end as nat
					             , case when NUTRIENT_CD = 'vitaRae' then nutrient_content else 0 end as vitaRae
					             , case when NUTRIENT_CD = 'retol' then nutrient_content else 0 end as retol
					             , case when NUTRIENT_CD = 'cartb' then nutrient_content else 0 end as cartb
					             , case when NUTRIENT_CD = 'thia' then nutrient_content else 0 end as thia
					             , case when NUTRIENT_CD = 'ribf' then nutrient_content else 0 end as ribf
					             , case when NUTRIENT_CD = 'nia' then nutrient_content else 0 end as nia
					             , case when NUTRIENT_CD = 'vitc' then nutrient_content else 0 end as vitc
					             , case when NUTRIENT_CD = 'vitd' then nutrient_content else 0 end as vitd
					             , case when NUTRIENT_CD = 'fasat' then nutrient_content else 0 end as fasat
					             , case when NUTRIENT_CD = 'fatrn' then nutrient_content else 0 end as fatrn
					             , case when NUTRIENT_CD = 'chole' then nutrient_content else 0 end as chole
					          from (
					                select NUTRIENT_CD as nutrient_cd
					                     , sum(nutrient_content) as nutrient_content
					                  from (
					                        select ir.food_no as food_no
					                             , f.nutrient_cd
					                             , f.nutrient_content
					                          from intake_record ir
					                         inner join (
					                                         select * 
					                                          from (
					                                                    select f.food_no, enerc, water, prot, fatce, ash, chocdf, sugar, fibtg, ca, fe, p, k, nat, vitaRae, retol, cartb, thia, ribf, nia, vitc, vitd, fasat, fatrn, chole
					                                                      from food f
					                                                     inner join individual_diet_record_food_nutrient_new ifn
					                                                        on f.food_cd = ifn.food_cd
					                                                )
					                                        unpivot (nutrient_content for nutrient_cd in (enerc, water, prot, fatce, ash, chocdf, sugar, fibtg, ca, fe, p, k, nat, vitaRae, retol, cartb, thia, ribf, nia, vitc, vitd, fasat, fatrn, chole))
					                                     ) f
					                            on ir.food_no = f.food_no
					                         where ir.creator_id = ?
					                           and ir.regdate between to_date(to_char(sysdate, 'yyyymmdd'), 'yyyymmdd') and to_date(to_char(sysdate + 1, 'yyyymmdd'), 'yyyymmdd') - (interval '1' second)
					                        union all
					                        select ir.custom_food_no as food_no
					                             , cf.nutrient_cd
					                             , cf.nutrient_content
					                          from intake_record ir
					                         inner join (
					                                     select cf.CUSTOM_FOOD_NO, cf.CUSTOM_FOOD_NAME, cfn.NUTRIENT_CD, sum(cfn.NUTRIENT_CONTENT) as NUTRIENT_CONTENT
					                                              from custom_food cf
					                                             inner join custom_food_nutrient cfn
					                                                on cf.custom_food_no = cfn.custom_food_no
					                                             group by cf.CUSTOM_FOOD_NO, cf.CUSTOM_FOOD_NAME, cfn.NUTRIENT_CD
					                                     union all
					                                     select cf.CUSTOM_FOOD_NO, cf.CUSTOM_FOOD_NAME, 'enerc',kcal_per_unit
					                                              from custom_food cf
					                                     ) cf
					                           on ir.CUSTOM_FOOD_NO = cf.CUSTOM_FOOD_NO
					                         where ir.creator_id = ?
					                           and ir.regdate between to_date(to_char(sysdate, 'yyyymmdd'), 'yyyymmdd') and to_date(to_char(sysdate + 1, 'yyyymmdd'), 'yyyymmdd') - (interval '1' second)
					                        )
					                 group by NUTRIENT_CD
					                )
					        ) x
					""";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			pstat.setString(2, id);
			
			rs = pstat.executeQuery();
			
			if(rs.next()) {
				tdyIntakeNtr.setNtrt_calorie(rs.getString("enerc"));
				tdyIntakeNtr.setNtrt_water(rs.getString("water"));
				tdyIntakeNtr.setNtrt_prot(rs.getString("prot"));
				tdyIntakeNtr.setNtrt_fatce(rs.getString("fatce"));
				tdyIntakeNtr.setNtrt_ash(rs.getString("ash"));
				tdyIntakeNtr.setNtrt_chocdf(rs.getString("chocdf"));
				tdyIntakeNtr.setNtrt_sugar(rs.getString("sugar"));
				tdyIntakeNtr.setNtrt_fibtg(rs.getString("fibtg"));
				tdyIntakeNtr.setNtrt_ca(rs.getString("ca"));
				tdyIntakeNtr.setNtrt_fe(rs.getString("fe"));
				tdyIntakeNtr.setNtrt_p(rs.getString("p"));
				tdyIntakeNtr.setNtrt_k(rs.getString("k"));
				tdyIntakeNtr.setNtrt_nat(rs.getString("nat"));
				tdyIntakeNtr.setNtrt_vitaRae(rs.getString("vitaRae"));
				tdyIntakeNtr.setNtrt_retol(rs.getString("retol"));
				tdyIntakeNtr.setNtrt_cartb(rs.getString("cartb"));
				tdyIntakeNtr.setNtrt_thia(rs.getString("thia"));
				tdyIntakeNtr.setNtrt_ribf(rs.getString("ribf"));
				tdyIntakeNtr.setNtrt_nia(rs.getString("nia"));
				tdyIntakeNtr.setNtrt_vitc(rs.getString("vitc"));
				tdyIntakeNtr.setNtrt_vitd(rs.getString("vitd"));
				tdyIntakeNtr.setNtrt_fasat(rs.getString("fasat"));
				tdyIntakeNtr.setNtrt_fatrn(rs.getString("fatrn"));
				tdyIntakeNtr.setNtrt_chole(rs.getString("chole"));
				
			}
			
			dto.setTdyintake(tdyIntakeNtr);
			
			
			return dto;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	// 아이디 중복 확인
	/**
	 * 입력된 아이디가 이미 회원 테이블에 존재하는지 확인합니다.
	 * <p>
	 * member 테이블에서 주어진 아이디의 개수를 조회하여
	 * 중복 여부를 반환합니다.
	 * </p>
	 * 
	 * @author 이지온
	 * @param id 중복 여부를 확인할 회원 아이디
	 * @return 아이디가 이미 존재하면 {@code true}, 존재하지 않으면 {@code false}
	 * throws SQLException 쿼리 실행 중 예외가 발생할 수 있음
	 */
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
	/***
	 * 사용자의 조회할 달의 기록된 신체기록을 조회한다.
	 * @author 한가람
	 * @param inputDto 회원의 id와 조회할 달의 정보가 담긴 DashPhysicalHistDTO 객체 
	 * @return 해당 달의 등록일, 키, 몸무게 정보를 반환한다.
	 */
	//신체기록 조회
	public ArrayList<DashPhysicalHistDTO> getPhysicalHist(DashPhysicalHistDTO inputDto) {
		String id = inputDto.getId();
		String month = inputDto.getMonth();
		
		try {
			String sql = """
					select to_char(regdate, 'yyyy.mm.dd.(dy)') as regdate
				     , height
				     , weight
				  from member_physical
				 where regdate between to_date(?, 'yyyymm') and add_months(to_date(?, 'yyyymm'), 1) - (interval '1' second)
				   and member_id = ?
				 order by regdate asc
					""";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, month);
			pstat.setString(2, month);
			pstat.setString(3, id);
			
			rs = pstat.executeQuery();
			
			ArrayList<DashPhysicalHistDTO> list = new ArrayList<DashPhysicalHistDTO>(); 
			
			
			while(rs.next()) {
				DashPhysicalHistDTO item = new DashPhysicalHistDTO();
				item.setRegdate(rs.getString("regdate"));
				item.setHeight(rs.getString("height"));
				item.setWeight(rs.getString("weight"));
				
				list.add(item);
			}
			
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	/***
	 * 자신의 신체기록(키, 몸무게)을 기록한다.
	 * @author 한가람
	 * @param inputDto 회원의 아이디와 수정할(to-be) 키, 몸무게 정보가 담긴 DashPhysicalHistDTO 객체 
	 * @return 데이터 입력 후 실행 결과값을 반환. 성공 시 1, 실패 시 0을 반환한다.
	 */
	
	public int putPhysicalHist(DashPhysicalHistDTO inputDto) {
		String id = inputDto.getId();
		String height = inputDto.getHeight();
		String weight = inputDto.getWeight();
		
		
		try {
			String sql = """
					insert into member_physical(MEMBER_PHYSICAL_NO, REGDATE, HEIGHT, WEIGHT, MEMBER_ID)
						values(SEQMEMBERPHYSICAL.nextVal, sysdate, ?, ?, ?)
					""";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, height);
			pstat.setString(2, weight);
			pstat.setString(3, id);
			
			return pstat.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
		
	}
	/**
	 * 사용자가 계획한 해당 운동을 수행했음을 기록한다.
	 * @author 한가람
	 * @param dto 회원의 id와 기록할 운동의 운동생성구분, 운동번호, 세트, 세트당 횟수, 중량, 운동시간 정보가 담긴 ExerciseRecordDTO 객체 
	 * @return 데이터 기록 후 실행 결과값을 반환. 성공 시 1, 실패 시 0, 이미 데이터가 있으면 -1을 반환한다.
	 */
	//오늘의 운동 완료
	public int tdyRecordExcs(ExerciseRecordDTO dto) {
		
		String id = dto.getCreatorId();
		String exercise_creation_type = dto.getExerciseCreationType();
		String exercise_no = dto.getExerciseNo();
		String sets = dto.getSets();
		String reps_per_set = dto.getRepsPerSet();
		String weight = dto.getWeight();
		String exercise_time = dto.getExerciseTime();
		
				
		//반환 값: 성공: 1, 실패:0, 이미 데이터 있음: -1
		try {
			String sql;
			//기존에 처리된 값이 있는지 확인
			int validNumber = -1;  //초기값 -1
			if(exercise_creation_type.equals("0")) {
				sql = """
						select count(*) as cnt
						  from exercise_record
						 where 1=1
						   and creator_id = ?
						   and RECORD_DATE between to_date(to_char(sysdate, 'yyyymmdd'), 'yyyymmdd') and to_date(to_char(sysdate + 1, 'yyyymmdd'), 'yyyymmdd') - (interval '1' second)
						   and sets = ?
						   and reps_per_set = ?
						   and weight = ?
						   and exercise_time = ?
						   and exercise_no = ?
						   and exercise_creation_type = 0
						""";
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, id);
				pstat.setString(2, sets);
				pstat.setString(3, reps_per_set);
				pstat.setString(4, weight);
				pstat.setString(5, exercise_time);
				pstat.setString(6, exercise_no);
				
				rs = pstat.executeQuery();
				
				if(rs.next()) {
					validNumber = rs.getInt("cnt");
				}
				
				
			} else if (exercise_creation_type.equals("1")) {
				sql = """
						select count(*) as cnt
						  from exercise_record
						 where 1=1
						   and creator_id = ?
						   and RECORD_DATE between to_date(to_char(sysdate, 'yyyymmdd'), 'yyyymmdd') and to_date(to_char(sysdate + 1, 'yyyymmdd'), 'yyyymmdd') - (interval '1' second)
						   and sets = ?
						   and reps_per_set = ?
						   and weight = ?
						   and exercise_time = ?
						   and custom_exercise_no = ?
						   and exercise_creation_type = 1
						""";
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, id);
				pstat.setString(2, sets);
				pstat.setString(3, reps_per_set);
				pstat.setString(4, weight);
				pstat.setString(5, exercise_time);
				pstat.setString(6, exercise_no);
			}
			
			if (validNumber >= 1) {
				return -1;
			}
			
			
			//운동기록 데이터 입력
			if(exercise_creation_type.equals("0")) {
				sql = """
						insert into exercise_record(EXERCISE_RECORD_NO, CREATOR_ID, RECORD_DATE, EXERCISE_NO, SETS, REPS_PER_SET, WEIGHT, EXERCISE_TIME, CUSTOM_EXERCISE_NO, EXERCISE_CREATION_TYPE)
  values (seqExerciseRecord.nextVal, ?, sysdate, ?, ?, ?, ?, ?, null, 0)
						""";
				
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, id);
				pstat.setString(2, exercise_no);
				pstat.setString(3, sets);
				pstat.setString(4, reps_per_set);
				pstat.setString(5, weight);
				pstat.setString(6, exercise_time);
				
				
				return pstat.executeUpdate();
				
				
			} else if (exercise_creation_type.equals("1")) {
				sql = """
						insert into exercise_record(EXERCISE_RECORD_NO, CREATOR_ID, RECORD_DATE, EXERCISE_NO, SETS, REPS_PER_SET, WEIGHT, EXERCISE_TIME, CUSTOM_EXERCISE_NO, EXERCISE_CREATION_TYPE)
  values (seqExerciseRecord.nextVal, ?, sysdate, null, ?, ?, ?, ?, ?, 1)
						""";
				
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, id);
				pstat.setString(2, sets);
				pstat.setString(3, reps_per_set);
				pstat.setString(4, weight);
				pstat.setString(5, exercise_time);
				pstat.setString(6, exercise_no);

				
				return pstat.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * 사용자가 계획한 해당 식사를 수행했음을 기록한다.
	 * @author 한가람
	 * @param dtoList 회원의 id와 기록할 식사의 끼니구분, 식단번호, 음식리스트(음식생성구분, 음식번호, 섭취량) 정보가 담긴 IntakeRecordDTO list 객체 
	 * @return 데이터 기록 후 실행 결과값을 반환. 성공 시 1, 실패 시 0, 이미 데이터가 있으면 -1을 반환한다.
	 */
	//오늘의 운동 완료
	public int tdyRecordIntake(ArrayList<IntakeRecordDTO> dtoList) {
		//반환 값: 성공: 1, 실패:0, 이미 데이터 있음: -1
		try {
			String sql;
			int validNumber = -1;  //초기값 -1
			int successCnt = 0;
			
			//데이터 확인
			for(IntakeRecordDTO dto : dtoList) {
				String creator_id = dto.getCreatorId();
				String diet_no = dto.getDietNo();
				String meal_classify = dto.getMealClassify();
				String food_creation_type = dto.getFoodCreationType();
				String food_no = dto.getFoodNo();
				String intake = dto.getIntake();
				
				if(food_creation_type.equals("0")) {
					
					sql = """
							select count(*) as cnt 
							  from intake_record
							 where 1=1 
							   and regdate between to_date(to_char(sysdate, 'yyyymmdd'), 'yyyymmdd') and to_date(to_char(sysdate + 1, 'yyyymmdd'), 'yyyymmdd') - (interval '1' second)
							   and meal_classify = ?
							   and creator_id = ?
							   and food_no = ?
							   and diet_no = ?
							   and food_creation_type = 0
							   and intake = ?
							""";
					pstat = conn.prepareStatement(sql);
					pstat.setString(1, meal_classify);
					pstat.setString(2, creator_id);
					pstat.setString(3, food_no);
					pstat.setString(4, diet_no);
					pstat.setString(5, intake);
					
					rs = pstat.executeQuery();
					
					if(rs.next()) {
						validNumber = rs.getInt("cnt");
					}
					
					
				} else if (food_creation_type.equals("1")) {
					sql = """
							select count(*) as cnt 
							  from intake_record
							 where 1=1 
							   and regdate between to_date(to_char(sysdate, 'yyyymmdd'), 'yyyymmdd') and to_date(to_char(sysdate + 1, 'yyyymmdd'), 'yyyymmdd') - (interval '1' second)
							   and meal_classify = ?
							   and creator_id = ?
							   and custom_food_no = ?
							   and diet_no = ?
							   and food_creation_type = 1
							   and intake = ?
							""";
					pstat = conn.prepareStatement(sql);
					pstat.setString(1, meal_classify);
					pstat.setString(2, creator_id);
					pstat.setString(3, food_no);
					pstat.setString(4, diet_no);
					pstat.setString(5, intake);
					
					rs = pstat.executeQuery();
					
					if(rs.next()) {
						validNumber = rs.getInt("cnt");
					}
				}
				
				if (validNumber >= 1) {
					System.out.println(validNumber);
					return -1;
				}
			}
			
			
			//데이터 입력
			for(IntakeRecordDTO dto : dtoList) {
				String creator_id = dto.getCreatorId();
				String diet_no = dto.getDietNo();
				String meal_classify = dto.getMealClassify();
				String food_creation_type = dto.getFoodCreationType();
				String food_no = dto.getFoodNo();
				String intake = dto.getIntake();
				
				if(food_creation_type.equals("0")) {
					
					sql  = """
							insert into intake_record(intake_record_no, regdate, intake_kcal, meal_classify, creator_id, food_no, custom_food_no, diet_no, food_creation_type, intake)
		  values(seqIntakeRecord.nextVal, sysdate, (select (300/100) * irn.enerc as real_intake from food f inner join individual_diet_record_food_nutrient irn on f.food_cd = irn.food_cd where food_no = ?)
		            , ?, ?, ?, null, ?, 0, ?)
							""";
					pstat = conn.prepareStatement(sql);
					pstat.setString(1, food_no);
					pstat.setString(2, meal_classify);
					pstat.setString(3, creator_id);
					pstat.setString(4, food_no);
					pstat.setString(5, diet_no);
					pstat.setString(6, intake);
					
					successCnt = successCnt + pstat.executeUpdate();
					
				} else if(food_creation_type.equals("1")) {
					
					sql  = """
							insert into intake_record(intake_record_no, regdate, intake_kcal, meal_classify, creator_id, food_no, custom_food_no, diet_no, food_creation_type, intake)
  values(seqIntakeRecord.nextVal, sysdate, (select (300/100) * kcal_per_unit as real_intake from custom_food c where c.custom_food_no = ?)
            , ?, ?, null, ?, ?, 1, ?)
							""";
					pstat = conn.prepareStatement(sql);
					pstat.setString(1, food_no);
					pstat.setString(2, meal_classify);
					pstat.setString(3, creator_id);
					pstat.setString(4, food_no);
					pstat.setString(5, diet_no);
					pstat.setString(6, intake);
					
					successCnt = successCnt + pstat.executeUpdate();
					
					
				}
				
				
				
			}
			
			return successCnt;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	
	/**
	 * 주어진 아이디와 비밀번호로 회원 정보를 조회하여 로그인 처리합니다.
	 * <p>
	 * 로그인에 성공하면 해당 회원의 주요 정보를 담은 {@link UserDTO} 객체를 반환하며,
	 * 실패 시 {@code null}을 반환합니다.
	 * 이 메서드는 회원의 나이, 성별, 신체 정보, 랭킹 정보 등을 함께 조회하여 DTO에 저장합니다.
	 * </p>
	 *
	 * <p><b>※ 비밀번호는 현재 평문 비교 방식으로 처리되고 있으며,
	 * 추후 {@code BCrypt} 암호화 방식으로 교체될 예정입니다.</b></p>
	 *
	 * @author 이지온
	 * @param id 로그인 시도할 사용자 아이디
	 * @param pw 로그인 시도할 사용자 비밀번호 (현재는 평문 비교)
	 * @return 로그인 성공 시 {@link UserDTO} 객체, 실패 시 {@code null}
	 * throws SQLException 데이터베이스 연결 또는 쿼리 실행 중 예외가 발생할 수 있음
	 */
	public UserDTO login(String id, String pw) {
	    UserDTO dto = null;
	    try {
	        String sql = """
	        		select MEMBER_NO, MEMBER_ID, PW, MEMBER_PIC, BACKGROUND_PIC, MEMBER_NICKNAME, MEMBER_NAME, PERSONALNUMBER, ALLERGY, TEL, EMAIL, ADDRESS, FITNESS_SCORE, COMMUNITY_SCORE, RESTRICT_CHECK, WITHDRAW_CHECK, MENTOR_CHECK, ADMIN_CHECK, PLAN_PUBLIC_CHECK, REPORT_CNT
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
					     , (
					         select CLASS_NAME
					          from (
					                    select mc.class_no, mc.member_id, class_name 
					                      from member_class mc
					                     inner join class c
					                        on mc.class_no = c.class_no
					                     order by mc.class_no desc
					                ) 
					         where rownum <= 1
					           and member_id = m.member_id
					           ) as rank
					  from member m
					 where MEMBER_ID = ?
					   and pw = ?
	        		""";
	        pstat = conn.prepareStatement(sql);
	        pstat.setString(1, id);
	        pstat.setString(2, pw);
	        rs = pstat.executeQuery();

	        // 추후 암호화 도입 시 사용 예정
	        // if (rs.next() && BCrypt.checkpw(pw, rs.getString("pw"))) {

	        if (rs.next()) {
	            dto = new UserDTO();
	            dto.setMemberNo(rs.getInt("member_no"));
	            dto.setMemberId(rs.getString("member_id"));
	            dto.setPw(rs.getString("pw"));
	            dto.setMemberName(rs.getString("member_name"));
	            dto.setMemberNickname(rs.getString("member_nickname"));
	            dto.setAdminCheck(rs.getInt("admin_check"));
				dto.setMentorCheck(rs.getInt("mentor_check"));
				dto.setGender(rs.getString("gender"));
				dto.setAge(rs.getString("age"));
				dto.setHeight(rs.getString("height"));
				dto.setWeight(rs.getString("weight"));
				dto.setRank(rs.getString("rank"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (Exception e) {}
	        try { if (pstat != null) pstat.close(); } catch (Exception e) {}
	    }
	    return dto;
	}
	/**
	 * 회원정보 수정 시 사용자의 개인정보를 가져온다
	 * @author 한가람
	 * @param id 회원의 id
	 * @return 사용자 id, 이름, 주민등록번호, 닉네임, 연락처, 연락처 직접입력 구분, 이메일, 이메일 도메인 직접입력 구분, 주소 정보를 반환한다.
	 */
	public UserDTO getUserInfo(String id) {
		try {
			UserDTO dto = new UserDTO();
			
			
			String sql = """
							select MEMBER_ID
							     , MEMBER_NAME
							     , substr(substr(PERSONALNUMBER, 1, 7), 1, 6) || '-' || substr(substr(PERSONALNUMBER, 1, 7), 7, 1) || '******' as PERSONALNUMBER
							     , MEMBER_NICKNAME 
							     , case when tel like '%-%-%' then substr(tel, 1, instr(tel, '-', 1, 1) -1) else null end as tel1
							     , case when tel like '%-%-%' then substr(tel, instr(tel, '-', 1, 1) + 1, instr(tel, '-', 1, 2) - 1 - instr(tel, '-', 1, 1)) else null end as tel2
							     , case when tel like '%-%-%' then substr(tel, instr(tel, '-', 1, 2) + 1, length(tel)) else null end as tel3
							     , case when tel like '%-%-%' then 'default' else 'custom' end as tel_select
							     , substr(EMAIL, 1, instr(EMAIL, '@', 1, 1) -1) as email1
							     , substr(EMAIL, instr(EMAIL, '@', 1, 1) + 1, length(EMAIL)) as email2
							     , case when substr(EMAIL, instr(EMAIL, '@', 1, 1) + 1, length(EMAIL)) in ('gmail.com', 'naver.com', 'daum.net', 'hanmail.net', 'nate.com', 'kakao.com') then 'default' else 'custom' end as eamil_domain_select
							     , case when ADDRESS like '%◈%◈%' or ADDRESS like '%◈%' then substr(ADDRESS, 1, instr(ADDRESS, '◈', 1, 1) -1)
							             when ADDRESS like '%◈%' then substr(ADDRESS, instr(ADDRESS, '◈', 1, 1) -1, length(instr(ADDRESS, '◈', 1, 1) -1))
							             else null end as addr1
							     , case when ADDRESS like '%◈%◈%' then substr(ADDRESS, instr(ADDRESS, '◈', 1, 1) + 1, instr(ADDRESS, '◈', 1, 2) - 1 - instr(ADDRESS, '◈', 1, 1)) 
							            when ADDRESS like '%◈%' then substr(ADDRESS, instr(ADDRESS, '◈', 1, 1) + 1, length(ADDRESS))
							             else null end as addr2
							     , case when ADDRESS like '%◈%◈%' then substr(ADDRESS, instr(ADDRESS, '◈', 1, 2) + 1, length(ADDRESS)) else null end as addr3
							    from member
							    where member_id = ?
					""";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			
			rs = pstat.executeQuery();
			
			if(rs.next()) {
				dto.setMemberId(rs.getString("MEMBER_ID")); 
				dto.setMemberName(rs.getString("MEMBER_NAME"));
				dto.setPersonalNumber(rs.getString("PERSONALNUMBER")); 
				dto.setMemberNickname(rs.getString("MEMBER_NICKNAME")); 
				dto.setTel1(rs.getString("tel1")); 
				dto.setTel2(rs.getString("tel2")); 
				dto.setTel3(rs.getString("tel3"));
				dto.setEmail1(rs.getString("EMAIL1"));
				dto.setEmail2(rs.getString("EMAIL2"));
				dto.setAddress1(rs.getString("addr1")); 
				dto.setAddress2(rs.getString("addr2")); 
				dto.setAddress3(rs.getString("addr3"));
				dto.setTel_select(rs.getString("tel_select"));
				dto.setEmail_domain_select(rs.getString("eamil_domain_select"));
				
				
				return dto;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 입력된 이름과 이메일을 기준으로 회원의 아이디를 조회합니다.
	 * <p>
	 * member 테이블에서 이름과 이메일이 모두 일치하는 회원을 검색하여,
	 * 해당 회원의 {@code member_id}를 반환합니다.
	 * </p>
	 * 
	 * @author 이지온
	 * @param name 회원 이름
	 * @param email 회원 이메일
	 * @return 일치하는 회원이 존재하면 아이디 문자열, 존재하지 않으면 {@code null}
	 * throws SQLException 데이터베이스 연결 또는 쿼리 실행 중 예외가 발생할 수 있음
	 */
	public String findIdByNameAndEmail(String name, String email) {
	    String sql = "SELECT member_id FROM member WHERE member_name = ? AND email = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, name);
	        pstmt.setString(2, email);

	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getString("member_id");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	

	// 비밀번호 변경 메서드
	/**
	 * 주어진 아이디에 해당하는 회원의 비밀번호를 새 비밀번호로 수정합니다.
	 * <p>
	 * 현재는 평문 비밀번호를 저장하고 있으며, 추후 보안을 위해 암호화 방식({@code BCrypt})으로 전환될 예정입니다.
	 * </p>
	 * 
	 * @author 이지온
	 * @param id 비밀번호를 변경할 회원 아이디
	 * @param newPassword 새 비밀번호 문자열 (현재는 평문, 추후 암호화 예정)
	 * @return 비밀번호 업데이트 성공 시 1, 실패 또는 대상 없음 시 0
	 * throws SQLException 데이터베이스 연결 또는 쿼리 실행 중 예외가 발생할 수 있음
	 */
	public int updatePassword(String id, String newPassword) {
	    int result = 0;
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    try {
	        conn = DBUtil.getConnection();
	        String sql = "UPDATE member SET pw = ? WHERE member_id = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, newPassword); // 🔐 나중에 암호화 예정
	        pstmt.setString(2, id);
	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	this.close(conn, pstmt, null);
	    }
	    return result;
	}

	// 사용자 ID + 이메일 일치 여부 확인
	/**
	 * 입력된 아이디와 이메일이 일치하는 회원이 존재하는지 확인합니다.
	 * <p>
	 * 비밀번호 찾기 등의 인증 절차에서 회원 본인 여부를 검증하기 위한 메서드입니다.
	 * </p>
	 * 
	 * @author 이지온
	 * @param id 확인할 회원 아이디
	 * @param email 확인할 회원 이메일
	 * @return 일치하는 회원이 존재하면 {@code true}, 그렇지 않으면 {@code false}
	 * throws SQLException 데이터베이스 연결 또는 쿼리 실행 중 예외가 발생할 수 있음
	 */
	public boolean checkUserByIdAndEmail(String id, String email) {
	    boolean result = false;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        conn = DBUtil.getConnection();
	        String sql = "SELECT COUNT(*) FROM member WHERE member_id = ? AND email = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, email);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            result = rs.getInt(1) > 0;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(conn, pstmt, rs);
	    }
	    return result;
	}


	//자원 해제를 위한 유틸리티 메서드
	/**
	 * 데이터베이스 작업 후 사용한 리소스(Connection, PreparedStatement, ResultSet)를 안전하게 닫습니다.
	 * <p>
	 * 각 리소스는 {@code null} 여부를 검사한 후 개별적으로 닫히며,
	 * 예외가 발생하더라도 무시하고 다음 리소스를 계속 정리합니다.
	 * </p>
	 * 
	 * @author 이지온
	 * @param conn 닫을 DB 연결 객체 (Connection)
	 * @param pstmt 닫을 SQL 실행 객체 (PreparedStatement)
	 * @param rs 닫을 결과 집합 객체 (ResultSet)
	 */
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
	    try { if (rs != null) rs.close(); } catch (Exception e) {}
	    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
	    try { if (conn != null) conn.close(); } catch (Exception e) {}
	}

}
