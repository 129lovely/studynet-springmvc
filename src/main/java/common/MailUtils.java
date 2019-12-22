package common;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailUtils {
	    
	    private JavaMailSender mailSender;
	    private MimeMessage message;
	    private MimeMessageHelper messageHelper;

	    public MailUtils(JavaMailSender mailSender) {
	        this.mailSender = mailSender;
	        message = this.mailSender.createMimeMessage();
	        
	        try {
				messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				
			} catch (MessagingException e) {
				e.printStackTrace();
			}
	    }
	    
	    // 제목
	    public void setSubject(String subject) throws MessagingException {
	        messageHelper.setSubject(subject);
	    }
	    
	    // 내용
	    public void setText(String htmlContent) throws MessagingException {
	        messageHelper.setText(htmlContent, true);
	    }
	    
	    // 보내는 사람
	    public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
	        messageHelper.setFrom(email, name);
	    }
	    
	    // 받는 사람
	    public void setTo(String email) throws MessagingException {
	        messageHelper.setTo(email);
	    }
	    
	    // 인라인 자원 추가
	    public void addInline(String contentId, DataSource dataSource) throws MessagingException {
	        messageHelper.addInline(contentId, dataSource);
	    }
	    
	    // 발송
	    public void send() {
	        mailSender.send(message);
	    }
	
}
