package fitralpark.common.utils;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//JDBC 커넥션 및 자원 해제 관련 공통 메서드 제공
/**
 * JDBC 커넥션 풀을 통한 데이터베이스 연결 및 관리 유틸리티 클래스입니다.
 * <p>
 * 서버에 설정된 JNDI 리소스({@code java:/comp/env/jdbc/pool})를 통해
 * {@link javax.sql.DataSource} 객체를 획득하고,
 * 해당 커넥션 풀로부터 DB 연결을 반환하는 메서드를 제공합니다.
 * </p>
 *
 * <p><b>주의:</b> 커넥션 사용 후에는 반드시 닫아야 하며,
 * {@code try-with-resources} 또는 별도의 {@code close()} 유틸 메서드를 사용할 수 있습니다.</p>
 * 
 * @author 이지온
 */
public class DBUtil {

	private static DataSource dataSource;

	static {
		try {
			Context ctx = new InitialContext();
			Context envCtx = (Context) ctx.lookup("java:/comp/env");
			dataSource = (DataSource) envCtx.lookup("jdbc/pool");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

    /**
     * 커넥션 풀(DataSource)로부터 데이터베이스 연결(Connection)을 반환합니다.
     *
     * @return 사용 가능한 DB 커넥션 객체
     * @throws SQLException 커넥션 획득 중 오류가 발생한 경우
     */
	public static Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
}
