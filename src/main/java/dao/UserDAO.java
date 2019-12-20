package dao;

import java.util.List;
import java.util.Map;

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

	@Override
	public int insert(Object vo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	// 회원 가입
	public int insert(UserVO vo) {
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
	
	// 로그인 정보 가져오기 
	public UserVO selectOne( String email ) {
		UserVO user = sqlSession.selectOne("user.login", email);
		return user;
	}
	
	// user의 이름 가져오기
	public UserVO selectUserName(int idx) {
		UserVO vo=sqlSession.selectOne("user.select_name", idx);
		return vo;
	}
	
	//--------------------------------------------------------------------
	//
	// sns 로그인 처리 관련
	//
	//--------------------------------------------------------------------
	public UserVO selectOne_user_sns(String sns_id) {
		UserVO vo = sqlSession.selectOne("user.selectOne_user_sns", sns_id);
		return null;
	}

	public int update_user_sns(Map<String, String> info) {
		int res = sqlSession.update("update_user_sns", info);
		return 0;
	}

	public int insert_user_sns(Map<String, String> info) {
		int res = sqlSession.insert("insert_user_sns", info);
		return 0;
	}
	
	
}
