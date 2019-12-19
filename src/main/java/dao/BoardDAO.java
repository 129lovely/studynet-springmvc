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

	//전체 게시물 조회
	public List<BoardVO> List(){

		List<BoardVO> list = null;
		list = sqlSession.selectList("board.list_page");
		return list;

	}

	//페이징을 포함한 조건별 검색
	public List<BoardVO> selectList( Map map ){

		List<BoardVO> list = null;

		list = sqlSession.selectList("board.list_condition", map);

		return list;
	}

	//게시글 갯수
	public int getRowTotal() {

		int count = sqlSession.selectOne("board.count");

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

	// 댓글 전체 가져오기
	public List<BoardCommentVO> selectCommentList(int board_idx) {
		List<BoardCommentVO> list = new ArrayList<BoardCommentVO>();
		list = sqlSession.selectList("comment.selectList", board_idx);
		return list;
	}

	// 글 리스트 가져오기
	public List<BoardVO> selectList_index() {
		List<BoardVO> list = new ArrayList<BoardVO>();
		list = sqlSession.selectList("board.selectList_index");
		return list;
	}

	// 댓글 수정
	public int update_comment(BoardCommentVO vo) {
		int result = sqlSession.update("comment.update", vo);
		return result;
	}

	// 커뮤니티 원글 수정
	public int update_community(BoardVO vo) {
		int result=sqlSession.update("board.update_modify",vo);
		return result;
	}

	// 커뮤니티 추천수 올리기
	public int update_recommend(int idx) {
		int result=sqlSession.update("board.update_recommend", idx);
		return result;
	}

	// 커뮤니티 원글에 댓글달기
	public int insert_comment(BoardCommentVO vo) {
		int result=sqlSession.insert("comment.insert", vo);
		return result;
	}

	// 조회수 증가시키기
	public int update_hit(int idx){
		int result1=sqlSession.update("board.update_hit",idx);
		return result1;
	}

	//작성자 idx이용해서 이름 나오게 하기
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

	//게시글 삭제... 인데 왜 이렇게 하셨는진 잘 모르겠음
	public int del_update( BoardVO baseVO ) {

		int res = sqlSession.update("board_del_update", baseVO);

		return res;
	}

	//검색기능 (리스트 가져오기)
	public List<BoardVO> search(Map map){
		List<BoardVO>result=sqlSession.selectList("board.list_search",map);
		return result;
	}
	
	// 검색기능 (총 리스트 갯수)
	public int search_cnt(String search){
		int cnt = sqlSession.selectOne("board.search_count", search);
		return cnt;
	}
	
	//원글 삭제
	public int delete_community(int idx) {
		int res = sqlSession.delete("board.delete_community",idx);
		return res;
	}



}
