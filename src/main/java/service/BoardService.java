package service;

import java.util.List;

import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;
import vo.BoardVO;

public class BoardService {
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
	
	// 커뮤니티 리스트 출력하기
	public List<BoardVO> showCommunityList() {
		return boardDAO.selectList();
	}
	

}
