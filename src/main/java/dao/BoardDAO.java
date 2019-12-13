package dao;

import java.util.ArrayList;
import java.util.List;

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

}
