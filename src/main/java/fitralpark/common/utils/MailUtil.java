package fitralpark.common.utils;

import java.io.InputStream;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

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
