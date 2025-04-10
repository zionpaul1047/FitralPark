package fitralpark.common.utils;
//입력값 유효성 검증 공통 메서드 제공
/**
 * 사용자 입력값에 대한 서버 측 유효성 검사를 수행하는 유틸리티 클래스입니다.
 * <p>
 * 아이디, 비밀번호, 닉네임, 이메일, 전화번호, 주민등록번호 등의 입력 형식을 정규표현식을 이용하여 검증합니다.
 * 이 클래스는 {@code static} 메서드로 구성되어 있으며, 인스턴스 생성 없이 사용 가능합니다.
 * </p>
 * 
 * <p><b>예시 사용:</b><br>
 * {@code ValidationUtil.isValidEmail("test@example.com");}
 * </p>
 * 
 * @author 이지온
 */
public class ValidationUtil {

    /**
     * 닉네임의 유효성을 검사합니다.
     * <p>
     * 허용 문자: 한글, 영문 대소문자, 숫자<br>
     * 길이: 2자 이상 15자 이하
     * </p>
     *
     * @param nickname 검사할 닉네임 문자열
     * @return 유효한 경우 {@code true}, 아니면 {@code false}
     */
    public static boolean isValidNickname(String nickname) {
        if (nickname == null) return false;
        return nickname.matches("^[가-힣a-zA-Z0-9]{2,15}$");
    }

    /**
     * 아이디의 유효성을 검사합니다.
     * <p>
     * 영문 소문자와 숫자를 포함한 4~16자의 문자열이어야 하며,
     * 영문 소문자와 숫자가 반드시 조합되어야 합니다.
     * </p>
     *
     * @param id 검사할 아이디 문자열
     * @return 유효한 경우 {@code true}, 아니면 {@code false}
     */
    public static boolean isValidId(String id) {
        if (id == null) return false;
        return id.matches("^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{4,16}$");
    }

    /**
     * 비밀번호의 유효성을 검사합니다.
     * <p>
     * 길이: 8~16자<br>
     * 다음 중 2가지 이상 조합: 영문 대문자, 영문 소문자, 숫자, 특수문자
     * </p>
     *
     * @param pw 검사할 비밀번호 문자열
     * @return 유효한 경우 {@code true}, 아니면 {@code false}
     */
    public static boolean isValidPassword(String pw) {
        if (pw == null || pw.length() < 8 || pw.length() > 16) return false;

        int count = 0;
        if (pw.matches(".*[A-Z].*")) count++;
        if (pw.matches(".*[a-z].*")) count++;
        if (pw.matches(".*[0-9].*")) count++;
        if (pw.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) count++;

        return count >= 2;
    }

    /**
     * 주민등록번호의 유효성을 검사합니다.
     * <p>
     * 13자리 숫자 형식만 허용합니다.
     * </p>
     *
     * @param jumin 검사할 주민번호 문자열
     * @return 유효한 경우 {@code true}, 아니면 {@code false}
     */
    public static boolean isValidJumin(String jumin) {
        return jumin != null && jumin.matches("\\d{13}");
    }

    /**
     * 이메일 주소의 유효성을 검사합니다.
     *
     * @param email 검사할 이메일 문자열
     * @return 유효한 경우 {@code true}, 아니면 {@code false}
     */
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    }

    /**
     * 전화번호의 유효성을 검사합니다.
     * <p>
     * 형식 예시: {@code 010-1234-5678}, {@code +82-10-1234-5678}, 숫자만도 가능
     * </p>
     *
     * @param tel 검사할 전화번호 문자열
     * @return 유효한 경우 {@code true}, 아니면 {@code false}
     */
    public static boolean isValidPhone(String tel) {
        return tel != null && tel.matches("^(\\+82)?[0-9\\-]{9,15}$");
    }
}
