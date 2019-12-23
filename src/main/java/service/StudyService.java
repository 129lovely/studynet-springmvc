package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;
import vo.StudyMemberVO;
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
	
	// 스터디 생성
	public int insert( StudyVO vo ) {
		// 레코드 생성 후 study_idx값 반환
		int res = studyDAO.insert(vo);
		
		Map map = new HashMap();
		map.put("user_idx", vo.getCreate_user_idx());
		map.put("idx", vo.getIdx());
		
		res = studyDAO.add_admin_member(map);
		res = userDAO.update_study_cnt(vo.getCreate_user_idx());
		
		return res; 
	}

	//검색기능and게시물수,옵션이 분류일때
	public Map search_list(Map map){

		List<StudyVO> list = studyDAO.search(map);
		int cnt = studyDAO.search_cnt( (String) map.get("search") );
		
		Map res = new HashMap();
		res.put("list", list);
		res.put("cnt", cnt);
		
		return res;
	}
	
	//검색기능and게시물수,조건별 검색
	public Map search_list_condition(Map map){

		List<StudyVO> list=studyDAO.search_condition( map );
			
		int cnt = studyDAO.search_cnt_condition( (String) map.get("search") );//게시물수
		
		Map res = new HashMap();
		res.put("list", list);
		res.put("cnt", cnt);
		
		return res;
	}
		
	public StudyVO showStudyDetail(int idx) {
		StudyVO vo=studyDAO.selectOne(idx);
		return vo;
	}

	public int studyModify(int idx) {
		int res=studyDAO.update_study(idx);
		return res;
	}
	
    // 스터디 가입 신청  
	public int study_apply(Map map) {
		int res = studyDAO.study_apply(map);
		res = studyDAO.study_add_member(map); // 신청수 1증가
		return res;
	}

	// 스터디 중복 체크
	public StudyMemberVO selectOne_member(Map map) {
		StudyMemberVO vo = studyDAO.selectOne_member(map);
		return vo;
	}

	
	
	
	
	
}
