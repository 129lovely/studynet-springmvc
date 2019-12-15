package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.UserVO;

public class UserDAO implements DAO {
	
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

	// 회원 가입
	public int insert(UserVO vo) {
		System.out.println(vo.getPassword() + ":dao");
		int res = sqlSession.insert( "user.insert", vo );
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

	// 이메일 중복 체크
	public String emailCheck(String input_email) {
		String email = sqlSession.selectOne("user.emailCheck", input_email);
		return email;
	}

	@Override
	public int insert(Object vo) {
		// TODO Auto-generated method stub
		return 0;
	}
}
