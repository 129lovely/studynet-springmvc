package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.BoardCommentVO;
import vo.BoardVO;

public class BoardDAO implements DAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 게시판 리스트 가져오기
	@Override
	public List<BoardVO> selectList() {
		List<BoardVO> list = new ArrayList<BoardVO>();
		list = sqlSession.selectList("board.selectList");
		return list;
	}

	//전체 게시물 페이지 조회
	public List<BoardVO> selectList( Map map ){

		List<BoardVO> list = null;

		list = sqlSession.selectList("b.board_list_page", map);

		return list;

	}
	
	//게시글 갯수
	public int getRowTotal() {

		int count = sqlSession.selectOne("board_count");

		return count;

	}

	// 게시판 게시물 1개 가져오기
	@Override
	public BoardVO selectOne(int idx) {
		BoardVO vo = sqlSession.selectOne("board.selectOne", idx);
		return vo;
	}

	@Override
	public int insert(Object vo) {
		int result = sqlSession.insert("board.insert", vo);
		return result;
	}

	@Override
	public int update(Object vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int idx) {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<BoardCommentVO> selectCommentList(int board_idx) {
		List<BoardCommentVO> list = new ArrayList<BoardCommentVO>();
		list = sqlSession.selectList("comment.selectList", board_idx);
		return list;
	}

	public List<BoardVO> selectList_index() {
		List<BoardVO> list = new ArrayList<BoardVO>();
		list = sqlSession.selectList("board.selectList_index");
		return list;
	}

	public int update(BoardCommentVO vo) {
		int result = sqlSession.update("comment.update", vo);
		return result;
	}
	
	//조회수 증가시키기
	public int update_hit(int idx){
		int result1=sqlSession.update("board.update_hit",idx);
		return result1;
	}
	
	//작성자 idx이용해서 이름나오게하기
	public int list_name(int idx) {
		int result=sqlSession.selectOne("board.select_community_list_name",idx);
		return result;
	}
	
	// 커뮤니티 리스트가져오기
	public List<BoardVO> select_community_list() {
		List<BoardVO> list = new ArrayList<BoardVO>();
		list = sqlSession.selectList("board.select_community_list");
		return list;
	}


}
