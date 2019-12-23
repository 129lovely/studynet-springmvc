package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.Common;
import common.Paging;
import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;
import vo.BoardVO;
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
	
    //신청하기  
	public int study_apply(Map map ) {
		int res = studyDAO.study_apply(map);
		int addRes = 0;
		// 신청이 성공적으로 이루어지면 그때 신청 인원을 늘려줘야 함
		if ( res != 0 ) {
			addRes = studyDAO.study_add_member(map);
		}
		
		return addRes;
		
	}

}
