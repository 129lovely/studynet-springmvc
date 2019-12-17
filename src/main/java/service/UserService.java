package service;

import java.util.HashMap;
import java.util.Map;

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
		
		Map userMap = new HashMap();
		
		String res = "";
		
		UserVO user = userDAO.selectOne(email);
		
		
		if ( user == null ) { // email이 일치하지 않는 경우
			res = "no_email";
			userMap.put("res", res);
		} else if ( ! user.getPassword().equals(password) ) { // 비밀번호가 일치하지 않는 경우
			res = "no_password";
			userMap.put("res", res);
		} else {
			// 모두 일치하는 경우
			res = "clear";
			userMap.put("user", user);
		}
		
		// 맵에 담아준다. 
		userMap.put("res", res);

		return userMap;
	}
}
