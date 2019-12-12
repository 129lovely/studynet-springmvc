package dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.SampleVO;

public class SampleDAOImpl implements SampleDAO {

	// 셋터인젝션으로 sqlSession 받기
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List selectList() {
		List<SampleVO> list = new ArrayList<SampleVO>();
		list = sqlSession.selectList("sample.selectList");
		
		return list;
	}

	@Override
	public int insert(Object vo) {
		// TODO Auto-generated method stub
		return 0;
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

}
