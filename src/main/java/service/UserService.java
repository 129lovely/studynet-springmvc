package service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.mail.javamail.JavaMailSender;

import common.MailUtils;
import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;
import vo.UserVO;

public class UserService {
	BoardDAO boardDAO;
	StudyDAO studyDAO;
	UserDAO userDAO;
	
	JavaMailSender mailSender;
	
	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	public void setStudyDAO(StudyDAO studyDAO) {
		this.studyDAO = studyDAO;
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	// 이메일 중복 체크
	public String emailCheck(String input_email) {
		String email = userDAO.emailCheck(input_email);
		
		// 중복되는 이메일이 없을 경우
		String res = "no";
		
		if ( email != null ) {
			res = "yes";
		}
		
		return res;
	}
	

	// 회원 가입 
	public String user_insert( UserVO vo ) throws Exception {
		int res = userDAO.insert(vo);
		String result = "fail";
		
		if ( res != 0 ) {
			result = vo.getName();
			
			// 가입 축하 메일 발송
			MailUtils mail = new MailUtils(mailSender);
			
			mail.setSubject("[스터디넷] 회원 가입을 축하드립니다");
			mail.setTo(vo.getEmail());
			mail.setFrom("studynet2019web@gmail.com", "스터디넷");
			
			mail.setText(new StringBuffer()
					.append("<body> <div>")
					.append("<a href=\"http://localhost:9090/web/index.do\">")
					.append("<img src=\"/images/icon/logo.png\" style=\"width: 150px; padding-top: 20px;\"> </a>")
					.append("<h1 style=\"text-align: center; color: #eef3fa; background-color: #32539D; padding: 10px;\" >")
					.append( "스터디넷 회원 가입을 축하드려요 !</h1>")
					.append("<p style=\"margin: 10px; font-size: 1.5rem; text-align: center;\">")
					.append("함께하는 시작을 위한 스터디 매칭 웹 사이트, 스터디넷입니다.<br>")
					.append(vo.getName())
					.append(" 님의 회원 가입을 진심으로 환영합니다.")
					.append("</p> </div> </body>")
					.toString());
			
			mail.send();
			
		}
		
		return result;
	}
	
	// 로그인
	public Map user_login( String email, String password ) {
		
		UserVO user = null;
		user = userDAO.selectOne(email);
		
		Map map = new HashMap();
		String res = "";	
		
		if ( user == null ) { // email이 일치하지 않는 경우
			res = "no_email";
			map.put("res", res);
		} else if ( !user.getPassword().equals(password) ) { // 비밀번호가 일치하지 않는 경우
			res = "no_password";
			map.put("res", res);
		} else { // 모두 일치하는 경우
			res = "clear";
			map.put("user", user);
		}
		
		// 맵에 담아준다. 
		map.put("res", res);

		return map;
	}
	
	// study의 create_user_idx의 name가져오기
	public UserVO select_userName(int idx) {
		UserVO vo=userDAO.selectUserName(idx);
		return vo;
	}
	
	// 네이버 sns 로그인
	public UserVO nlogin(Map<String, String> info) {
		/**
		 * 이후 service와 controller에 토큰 관련 처리 추가할 것
		 */
		
		UserVO user = null;
		int result = 0;
		
		// 기존 sns 회원인지 확인
		user = userDAO.selectOne_user_sns(info.get("id"));	
		if( user != null ) {
			return user; // 기존 sns 회원이면 바로 로그인
		}
		
		// sns 회원이 아니라면...
		// 기존 email 회원인지 확인
		user = userDAO.selectOne(info.get("email"));
		if( user != null ) {
			result = userDAO.update_user_sns(info); // 기존 email 회원이면 기존 정보에 sns 정보 추가
			return user;
		}
		
		// sns 회원도 email 회원도 아니라면...
		String password = UUID.randomUUID().toString(); // password 랜덤 생성
		System.out.println(password);
		info.put("password", password);
		result = userDAO.insert_user_sns(info);
		
		user = userDAO.selectOne_user_sns(info.get("id"));
		
		return user;
	}
	
	// 전화번호 중복 체크
	public int selectOne( String phone ) {
		int res = userDAO.selectPhone(phone);
		
		return res;
	}
	
	public UserVO selectOne(int user_idx) {
		UserVO vo = (UserVO) userDAO.selectOne(user_idx);
		return vo;
	}
	// 전화번호 + 이름 확인
		public int selectOne( String phone, String name ) {
			
			Map map = new HashMap();
			map.put("phone", phone);
			map.put("name", name);
			
			int res = userDAO.selectEmail(map);
			
			return res;
		}
}
