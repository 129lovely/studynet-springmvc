package service;

import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;

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

}
