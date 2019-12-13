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
	
	// 커뮤니티 상세페이지 / 수정페이지 출력하기
	public BoardVO showCommunityListDetail(int idx) {
		return boardDAO.selectOne(idx);
	}
	
	// 커뮤니티 글작성 / 글수정하기
	public void writeCommunity(BoardVO vo) {
		boardDAO.insert(vo);
	}

}
