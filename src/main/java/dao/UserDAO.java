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
		UserVO vo = sqlSession.selectOne("user.selectOne_idx", idx);
		return vo;
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

	// 전화번호 중복체크
	public int selectPhone( String phone ) {
		int res = sqlSession.selectOne("user.phoneCheck", phone);
		return res;
	}
	
	// 이메일 찾기 전화번호 인증 
	public UserVO selectEmail(Map map) {
		UserVO vo = sqlSession.selectOne("user.phone_name_check", map);
		return vo;
	}

	// 가입한 스터디수 1 증가
	public int update_study_cnt(int create_user_idx) {
		int res = sqlSession.update("user.update_study_cnt", create_user_idx);
		return 0;
	}

	//--------------------------------------------------------------------
	//
	// sns 로그인 처리 관련
	//
	//--------------------------------------------------------------------
	public UserVO selectOne_user_sns(String sns_id) {
		UserVO vo = sqlSession.selectOne("user.selectOne_user_sns", sns_id);
		return vo;
	}

	public int update_user_sns(Map<String, String> info) {
		int res = sqlSession.update("user.update_user_sns", info);
		return res;
	}

	public int insert_user_sns(Map<String, String> info) {
		int res = sqlSession.insert("user.insert_user_sns", info);
		return res;
	}


	// 내 정보 수정 
	public int update_user(UserVO vo) {
		int result=sqlSession.update("user.update_user", vo);
		return result;
	}
	
	// 이메일 - 이름 확인 
	public int email_name_check( Map map ) {
		int res = sqlSession.selectOne("user.email_name_check", map);
		return res;
	}
	
	// 임시 비밀번호 
	public int update_user_TempPwd(Map map) {
	
		int res = sqlSession.update("user.update_user_TempPwd", map);

		return res;		
	}
	
	
	//회원 탈퇴
	public int user_del_update( UserVO baseVO ) {

		int res = sqlSession.update("user_del_update", baseVO);

		return res;
	}
}
