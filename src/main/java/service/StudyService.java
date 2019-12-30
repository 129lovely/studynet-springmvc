package service;

import java.util.ArrayList;
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
	
	//index.jsp에서 스터디 목록나오게하기
	public List<StudyVO> index_study_list(){
		List<StudyVO> list=studyDAO.index_study_list();
		return list;
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
	public HashMap<String, Object> search_list_condition(HashMap<String, Object> map){

		List<StudyVO> list = studyDAO.search_condition(map);
		int cnt = studyDAO.search_cnt_condition(map);//게시물수
		
		HashMap<String, Object> res = new HashMap<String, Object>();
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

//	이부분 유저 스터디 리스트, 유저 스테이터스 등으로 바꾸는 게 좋을 것 같아여 
	// study_myinfo에서 study_member의 status가져오기
	public StudyMemberVO studyMemStatus(int user_idx) {
		StudyMemberVO vo = studyDAO.study_member_status(user_idx);
		return vo; 
	}

	// study_member의 study_idx를 통해서 study내용 가져오기
	public List<StudyVO> studyMemList(int study_idx){
		List<StudyVO> list=(ArrayList<StudyVO>)studyDAO.study_member_list(study_idx);
		return list;
	}
	
	// 스터디에 참여 / 신청 중인 멤버 리스트 가져오기
	public List<StudyMemberVO> member_list( int study_idx ) {
		List<StudyMemberVO> member = studyDAO.member_list(study_idx);
		return member;
	}
}
