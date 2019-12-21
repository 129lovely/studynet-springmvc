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
	public StudyVO selectOne(int idx) {
		StudyVO vo=sqlSession.selectOne("study.selectOne", idx);
		return vo;
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
	
	
	
	//스터리 리스트 전체 게시물 조회
	public List<StudyVO> List(){

		List<StudyVO> list = null;
		list = sqlSession.selectList("study.list_page");
		return list;

	}

	//스터디 리스트 페이징을 포함한 조건별 검색
	public List<StudyVO> selectList( Map map ){

		List<StudyVO> list = null;

		list = sqlSession.selectList("study.list_condition", map);

		return list;
	}
	
	//스터디 갯수
	public int getRowTotal() {

		int count = sqlSession.selectOne("study.count");

		return count;

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

	// 스터디 수정
	public int update_study(int idx) {
		int result=sqlSession.update("study.update_study", idx);
		return result;
	}
	
	//스터디 신청하기
	public int study_apply(Map map) {
		int res = sqlSession.insert("study.apply", map);
		return res;
	}
	
	//스터디 신청인원 추가
	public int study_add_member(Map map) {
		int res = sqlSession.update("study.add_member", map);
		return res;
	}

	
}
