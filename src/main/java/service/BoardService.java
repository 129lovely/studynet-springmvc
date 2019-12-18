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
		System.out.println( vo.getContent() );

		map.put("comment", boardDAO.selectCommentList(idx));

		return map;
	}


	// 커뮤니티 글작성 / 글수정하기
	public void writeCommunity(BoardVO vo) {
		boardDAO.insert(vo);
	}

	// 게시글 댓글 수정하기
	public int updateComment(BoardCommentVO vo) {
		int res=boardDAO.update_comment(vo);
		return res;
	}

	//상세페이지 들어갈때 조회수 증가시키기
	public int hit_increase(int idx){
		int re = boardDAO.update_hit(idx);
		return re;
	}

	//	// 커뮤니티 리스트 페이징 포함 출력하기
	//	public Map showCommunityListPage( int nowPage ) {
	//		Map pageMap = null;
	//		
	//		BoardDAO board_dao = null;
	//		int row_total = board_dao.getRowTotal();
	//		String pageMenu = Paging.getPaging("page.do", nowPage, row_total,
	//				Common.BoardPaging.BLOCKLIST, Common.BoardPaging.BLOCKPAGE);
	//		
	//		// 페이지별 리스트 가져오기
	//		
	//		pageMap.put("pageMenu", pageMenu);
	//		
	//		
	//		return pageMap;
	//	}


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
	public int updateRecommend(int idx) {
		int res=boardDAO.update_recommend(idx);
		return res;
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
	public int board_del( int idx) {
		int res=boardDAO.delete_community(idx);
		return res;
	}

}