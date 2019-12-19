package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.StudyVO;

public class StudyDAO implements DAO {
	
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List selectList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object selectOne(int idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(Object vo) {
		int res = sqlSession.insert("study.insert", vo);
		return res;
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
	
		//검색기능 (리스트 가져오기)
		public List<StudyVO> search(Map map){
			List<StudyVO> result=sqlSession.selectList("study.list_search",map);
			return result;
		}
		
		// 검색기능 (총 리스트 갯수)
		public int search_cnt(String search){
			int cnt = sqlSession.selectOne("study.search_count", search);
			return cnt;
		}

}
