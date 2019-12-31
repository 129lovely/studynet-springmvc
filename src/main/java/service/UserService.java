package service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.mail.javamail.JavaMailSender;

import common.MailUtils;
import common.TempPwdGenerator;
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
					.append("<body><div><table align=\"center\"><tr><td><img src=\"https://i.imgur.com/ATMKhlq.png\" style=\"width:150px; margin: 0 auto; \"><br></td></tr><tr><td><div style=\"background-image: url(https://i.imgur.com/xvx3htM.jpg); width:100%; height:300px; background-size:cover;\"><h1 style=\"color: ghostwhite; text-align: center; padding-top: 100px; padding-left: 10px;padding-right: 10px;\">함께하는 시작, 스터디넷에 가입하신 것을 환영합니다.</h1><a href=\"http://localhost:9090/web/index.do\" style=\"background: ghostwhite; text-decoration: none; padding: 15px 10px; color: steelblue; font-size: 1.5rem; font-weight: bold; border-radius: 10px; display: inline-block; width:30%; text-align:center; margin:10px 35%\">스터디넷 둘러보기</a></div><br></td></tr><tr><td style=\"border-bottom: 1px solid gray; padding: 10px;\"><h2 style=\"color: steelblue;\">스터디넷에서 시작해요</h2><p style=\"color: dimgrey ;\">자신과 딱 맞는, 자신이 원하는 스터디를 골라 신청하거나 직접 개설해서 인원을 모집할 수 있습니다. 또한 마이페이지에서 참여 중인 스터디를 손쉽게 관리하고 공지와 일정을 확인할 수 있습니다.</p><p style=\"color: dimgrey ;\">커뮤니티에서 글과 댓글을 자유롭게 작성하고 토론할 수 있습니다. 취업이나 스터디 등에 필요한 정보를 쉽게 얻고 공유할 수 있으며, 스터디 별로 개별적인 커뮤니티도 사용 가능합니다.</p><small style=\"color: steelblue;\">만약 스터디넷에 가입한 적이 없으시다면 이 메일을 무시해주세요.</small><br><br></td></tr><tr><td><small style=\"color: gray; margin-top: 30px;\">(주)스터디넷 | 서울특별시 마포구 서강로 136 아이비 타워 2층 | 02-1111-3333 | studynet2019web@gmail.com </small></td></tr></table></div></body>")
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
	public UserVO selectOne( String phone, String name ) {
		
		Map map = new HashMap();
		map.put("phone", phone);
		map.put("name", name);
		
		UserVO vo = userDAO.selectEmail(map);
		
		return vo;
	}
	
	// 회원 정보 불러오기
	public UserVO showUserDetail(int idx) {
		UserVO vo=(UserVO) userDAO.selectOne(idx);
		return vo;
	}
	
	// 회원 정보 수정
	public int userMyinfo(UserVO vo) throws Exception {
		int res=userDAO.update_user(vo);
		
		return res;
	}
	
	// 비밀번호 발송을 위한 이름 - 이메일 확인 
	public String email_name_check( String email, String name ) {
		Map map = new HashMap();
		map.put("email", email);
		map.put("name", name);
		
		int res = userDAO.email_name_check( map );
		
		String result = "no";
		
		if ( res != 0 ) {
			result = "yes";
		}
		
		return result;
	}
		
	// 임시 비밀번호 전송
	public int userTempPwd(String email) throws Exception {
	
		// temp키 를 가져와서 idx 랑 초기비밀 맵으로 묶고 그다음 dao로 보내고 원래비밀번호를 temp 비밀번호로  동시에 메일로
		
		new TempPwdGenerator();
		String tempPwd = TempPwdGenerator.randomPw();
		
		Map map = new HashMap();
		map.put("email", email);
		map.put("tempPwd", tempPwd);
		
		int res = userDAO.update_user_TempPwd(map);
		
		if ( res != 0 ) {

			// 가입 축하 메일 발송
			MailUtils mail = new MailUtils(mailSender);

			mail.setSubject("[스터디넷] 임시 비밀번호를 보내 드립니다.");
			mail.setTo( email );
			mail.setFrom("studynet2019web@gmail.com", "스터디넷");

			mail.setText(new StringBuffer()
					.append("<body><div><table align=\"center\"><tr><td style=\"border-bottom: 1px solid gray; padding: 10px;\"><img src=\"https://i.imgur.com/ATMKhlq.png\" style=\"width:150px; margin: 0 auto; \"><br></td></tr><tr><td style=\"border-bottom: 1px solid gray; padding: 10px; text-align: center;\"><h2 style=\"color: steelblue;\">요청하신 임시 비밀번호입니다.</h2><p style=\"background: steelblue; color: white; font-weight: bold;padding: 10px;width: 200px;text-align: center;border-radius: 10px;margin: 0 auto;\">")
					.append(tempPwd)
					.append("</p><br><a href=\'http://localhost:9090/web/user_login_form.do\' style=\"font-weight: bold;\">로그인 하러 가기</a><br><br><small style=\"color: steelblue;\">만약 스터디넷에 가입한 적이 없으시다면 이 메일을 무시해주세요.</small><br><br></td></tr><tr><td><small style=\\\"color: gray; margin-top: 30px;\\\">(주)스터디넷 | 서울특별시 마포구 서강로 136 아이비 타워 2층 | 02-1111-3333 | studynet2019web@gmail.com </small></td></tr></table></div></body>")
					.toString());

			mail.send();

		}
		
		
		
		return res;
	}
	
	// 회원탈퇴
	public String user_del(int idx) {
		
		UserVO baseVO = (UserVO) userDAO.selectOne(idx);

		String result = "no";

		if( baseVO == null ) {
			return result;
		}

		int res = userDAO.user_del_update( baseVO );

		if( res == 1 ) {
			result = "yes";
		}

		return result;
	}
		
	
	


}
