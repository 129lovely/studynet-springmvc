package service;

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
	public String user_login( String email, String password ) {
		
		String res = "";
		
		UserVO user = userDAO.selectOne(email);
		
		// email이 일치하지 않는 경우
		if ( user == null ) {
			res = "no_email";
			return res;
		}
		
		// 비밀번호가 일치하지 않는 경우
		if ( ! user.getPassword().equals(password) ) {
			res = "no_password";
			return res;
		}
		
		// 모두 일치하는 경우
		res = "clear";
		
		// 세션에 정보를 담아준다.
		
		return res;
	}
}
