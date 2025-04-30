package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.text.DecimalFormat;
import java.util.Properties;

import org.apache.log4j.Logger;

public class EmailUtil {

    private static final Logger logger = Logger.getLogger(EmailUtil.class);

    public static void sendOrderConfirmationEmail(String toEmail, String orderId, double totalAmount) {
        logger.info("Bắt đầu gửi email xác nhận đơn hàng tới: " + toEmail);
        // Cấu hình các thông số SMTP
        String host = "smtp.gmail.com";
        final String user = "gnhu.work@gmail.com";
        final String password = "aaoa mtfo zuzo dvqt";

        // Thiết lập thông tin server và kết nối
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Khởi tạo session để gửi email
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            // Tạo email
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Xác nhận đơn hàng #" + orderId);

            DecimalFormat formatter = new DecimalFormat("#.###");
            String formattedAmount = formatter.format(totalAmount);

            // Nội dung email
            String emailContent = "<h3>Cảm ơn bạn đã đặt hàng tại cửa hàng chúng tôi!</h3>"
                    + "<p>Mã đơn hàng của bạn là: <strong>" + orderId + "</strong></p>"
                    + "<p>Tổng số tiền: <strong>" + formattedAmount + " VND</strong></p>"
                    + "<p>Chúng tôi sẽ liên hệ với bạn sớm nhất để xác nhận đơn hàng.</p>";

            message.setContent(emailContent, "text/html; charset=UTF-8");

            // Gửi email
            Transport.send(message);
            logger.info("Email đã gửi thành công tới: " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            logger.error("Lỗi khi gửi email đến " + toEmail + ": " + e.getMessage(), e);
        }
    }
}
