package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.Common;
import common.Paging;
import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;
import vo.BoardCommentVO;
import vo.BoardVO;
import vo.UserVO;

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

	// 커뮤니티 index페이지 최근 게시물 출력하기
	public List<BoardVO> showCommunityList_index() {
		return boardDAO.selectList_index();
	}

	// 커뮤니티 상세페이지 / 수정페이지 출력하기
	public Map<String, Object> showCommunityListDetail(int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board", boardDAO.selectOne(idx));

		BoardVO vo = (BoardVO)map.get("board");

		map.put("comment", boardDAO.selectCommentList(idx));

		return map;
	}


	// 커뮤니티 글작성 / 글수정하기
	public void writeCommunity(BoardVO vo) {
		boardDAO.insert(vo);
	}

	//상세페이지 들어갈때 조회수 증가시키기
	public int hit_increase(int idx){
		int re = boardDAO.update_hit(idx);
		return re;
	}

	//작성자 idx이용해서 이름나오게하기
	public int listview(int idx) {
		int res=boardDAO.list_name(idx);
		return res;
	}

	// 글 삭제
	public String del( int idx) {

		BoardVO baseVO = boardDAO.selectOne(idx);

		String result = "no";

		if( baseVO == null ) {
			return result;
		}

		int res = boardDAO.del_update( baseVO );

		if( res == 1 ) {
			result = "yes";
		}

		return result;
	}

	// 커뮤니티 원글 수정하기
	public int updateCommunity(BoardVO vo) {
		int res=boardDAO.update_community(vo);
		return res;
	}

	// 추천수 올리기
	public String updateRecommend(int idx, int board_user, int now_user ) {
		String resStr = "";
		
		Map map = new HashMap();
		map.put("idx", idx);
		map.put("board_user", board_user);
		map.put("now_user", now_user);
		
		if( board_user == now_user ) { // 본인 글
			return resStr = "self";
		}
		
		if( boardDAO.check_recommend(map) != 0 ) { // 중복 추천
			return resStr = "over";
		}
		
		int res = boardDAO.update_b_recommend(idx);
		res = boardDAO.update_br_recommend(map);
		return resStr = "success";
		
	}

	// 원글에 댓글달기
	public int writeComment(BoardCommentVO vo) {
		int res=boardDAO.insert_comment(vo);
		return res;
	}

	//검색기능
	public Map search_list(Map map){
		List<BoardVO> list = boardDAO.search(map);
		int cnt = boardDAO.search_cnt( (String) map.get("search") );

		System.out.println(cnt);

		Map res = new HashMap();
		res.put("list", list);
		res.put("cnt", cnt);

		return res;
	}

	// 원글 삭제
	public int board_del(int idx) {
		int res=boardDAO.delete_community(idx);
		return res;
	}

	// 댓글 삭제
	public int comment_del(int idx) {
		int res = boardDAO.delete_comment(idx);
		return res;
	}
	
	// 대댓글 달기
	public int comment_reply(Map map) {
		int is_re = (int) map.get("is_re");
		
		// parent 설정
		// 원댓의 대댓글일 경우 -> 가져온 parent 그대로 사용
		// 대댓의 대댓글일 경우 -> parent를 idx로 갖는 댓글의 parent(원댓)를 사용 
		if( is_re == 1 ) {
			map.put( "parent", boardDAO.getRealParent( map ) );
		}
		
		int res = boardDAO.update_comment_reply_seq(map);
		res = boardDAO.insert_comment_reply(map);
		
		return res;
	}
	
	// 댓글 수정
	public int comment_mod(int idx, String content) {
		Map map = new HashMap();
		map.put("idx", idx);
		map.put("content", content);
		
		int res = boardDAO.update_comment(map);
		return res;
	}
	
	// 이름 가져오기
	public String select_user_name( int idx ) {
		UserVO vo = (UserVO) userDAO.selectOne(idx);
		
		System.out.println("service: " + idx );
		
		String name = vo.getName();
		return name;
	}

}