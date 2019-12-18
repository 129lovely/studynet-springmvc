package service;

import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;
import vo.StudyVO;

public class StudyService {
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

	public int insert( StudyVO vo ) {
		return studyDAO.insert(vo);
	}
}
