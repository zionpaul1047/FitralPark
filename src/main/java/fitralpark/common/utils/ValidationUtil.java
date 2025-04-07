package fitralpark.common.utils;
//입력값 유효성 검증 공통 메서드 제공
public class ValidationUtil {

    /**
     * 닉네임 유효성 검사
     * - 허용 문자: 한글, 영문 대소문자, 숫자
     * - 길이: 2자 이상 15자 이하
     */
    public static boolean isValidNickname(String nickname) {
        if (nickname == null) return false;
        return nickname.matches("^[가-힣a-zA-Z0-9]{2,15}$");
    }

    /**
     * 아이디 유효성 검사
     * - 영문 소문자 + 숫자 조합
     * - 길이: 4~16자
     */
    public static boolean isValidId(String id) {
        if (id == null) return false;
        return id.matches("^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{4,16}$");
    }

    /**
     * 비밀번호 유효성 검사
     * - 길이: 8~16자
     * - 조건: 영문 대소문자 / 숫자 / 특수문자 중 2가지 이상 조합
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
     * 주민등록번호 유효성 검사
     * - 총 13자리, 숫자만
     */
    public static boolean isValidJumin(String jumin) {
        return jumin != null && jumin.matches("\\d{13}");
    }

    /**
     * 이메일 유효성 검사
     */
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    }

    /**
     * 전화번호 유효성 검사 (010-0000-0000 형식 또는 +82 포함 형식)
     */
    public static boolean isValidPhone(String tel) {
        return tel != null && tel.matches("^(\\+82)?[0-9\\-]{9,15}$");
    }
}
