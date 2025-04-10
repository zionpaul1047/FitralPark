package fitralpark.common.utils;

import java.io.InputStream;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 * SMTP를 이용한 이메일 발송 유틸리티 클래스입니다.
 * <p>
 * {@code config.properties} 파일에서 메일 서버 정보와 인증 계정을 로드하여,
 * JavaMail API를 통해 SMTP 방식으로 이메일을 전송합니다.
 * </p>
 *
 * <p><b>사용 예시:</b><br>
 * {@code MailUtil.sendMail("user@example.com", "제목", "내용");}
 * </p>
 *
 * <p><b>사용 환경:</b> 구글 Gmail SMTP, 포트 587, STARTTLS 사용</p>
 *
 * <ul>
 *   <li><b>설정 파일 위치:</b> {@code src/main/resources/config.properties}</li>
 *   <li><b>필수 설정 키:</b> {@code mail.username}, {@code mail.password}, {@code mail.fromName}</li>
 * </ul>
 * 
 * @author 이지온
 */
public class MailUtil {

    private static String username;
    private static String password;
    private static String fromName;

    static {
        try (InputStream input = MailUtil.class.getClassLoader().getResourceAsStream("config.properties")) {
            Properties config = new Properties();
            config.load(input);
            username = config.getProperty("mail.username");
            password = config.getProperty("mail.password");
            fromName = config.getProperty("mail.fromName");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 지정된 수신자에게 이메일을 전송합니다.
     * <p>
     * 제목과 본문 내용을 포함한 단순 텍스트 이메일을 Gmail SMTP 서버를 통해 전송합니다.
     * 인증 정보는 설정 파일에서 자동 로드되며, 발신자는 {@code mail.fromName}으로 표시됩니다.
     * </p>
     *
     * @param to 수신자 이메일 주소
     * @param subject 이메일 제목
     * @param content 이메일 본문 내용 (텍스트)
     * @return 이메일 전송 성공 여부 ({@code true}: 성공, {@code false}: 실패)
     */
    public static boolean sendMail(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
        	
        	System.out.println("[MailUtil] 메일 전송 시도 중: " + to);
        	System.out.println("[MailUtil] 발신자: " + username + " (" + fromName + ")");
        	
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username, fromName));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(content);
            Transport.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("[MailUtil] 이메일 전송 중 오류 발생!");
            e.printStackTrace();
            return false;
        }
    }
}
