package service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;
import vo.UserVO;

public class UserService {
	BoardDAO boardDAO;
	StudyDAO studyDAO;
	UserDAO userDAO;
	
	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	public void setStudyDAO(StudyDAO studyDAO) {
		this.studyDAO = studyDAO;
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
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
	public String user_insert( UserVO vo ) {
		int res = userDAO.insert(vo);
		String result = "fail";
		
		if ( res != 0 ) {
			result = vo.getName();
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
}
