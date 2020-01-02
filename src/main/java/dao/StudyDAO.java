package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.StudyMemberVO;
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

	//index.jsp에서 스터디목록들 나오게하기(페이지 안넘김)
	public List<StudyVO> index_study_list(){
		List<StudyVO> list=null;
		list=sqlSession.selectList("index_study_list");
		return list;
	}
	//스터디 리스트 페이징을 포함한 전체목록
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

	// 검색기능 (총 리스트 갯수)//온라인,오프라인,복합 옵션일떄
	public int search_cnt_condition(Map map){
		int cnt = sqlSession.selectOne("study.search_count_condition", map);
		return cnt;
	}
	
	//조건별 검색 :온라인 ,오프라인,복합
	public List<StudyVO> search_condition(Map map){
		List<StudyVO> condition = sqlSession.selectList("study.search_list_condition",map);
		return condition;
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

	// 스터디 중복체크
	public StudyMemberVO selectOne_member(Map map) {
		StudyMemberVO vo = sqlSession.selectOne("study.selectOne_member", map);
		return vo;
	}


	public int add_admin_member(Map map) {
		int res = sqlSession.insert("study.add_admin_member", map);
		return res;
	}

	// study_member_status가져오기
	public StudyMemberVO study_member_status(int user_idx) {
		StudyMemberVO vo = sqlSession.selectOne("study.study_mem_status", user_idx);
		return vo;
	}
	
	// study_member의 study_idx를 통해서 study내용 가져오기
	public List<StudyVO> study_member_list(int study_idx){
		List<StudyVO> list=sqlSession.selectList("study.study_mem_list", study_idx);
		return list;
	}
	
	// 스터디에 참여/신청 중인 멤버 리스트 가져오기
	public List<StudyMemberVO> member_list( int study_idx ) {
		List<StudyMemberVO> member = sqlSession.selectList("study.member_list", study_idx);
		return member;
	}
	
	// 선택한 스터디 멤버 승인
	public int mem_approve ( int idx ) {
		int res = sqlSession.update("study.mem_approve", idx);
		return res;
	}
	
	// 선택한 스터디 멤버 거절
	public int mem_reject ( int idx ) {
		int res = sqlSession.update("study.mem_reject", idx);
		return res;
	}
	
	// 스터디 관리자 추가
	public int add_admin ( int idx ) {
		int res = sqlSession.update("study.add_admin", idx);
		return res;
	}
	
	// 선택한 스터디 멤버 강퇴
	public int mem_kick ( int idx ) {
		int res = sqlSession.update("study.mem_kick", idx);
		return res;
	}

	public List<StudyVO> study_myinfo(int user_idx) {
		List<StudyVO> list = sqlSession.selectList("study.study_myinfo", user_idx);
		return list;
	}
	
	// 스터디 공지 수정
	public int update_notice(HashMap<String, Object> params) {
		int res = sqlSession.update("study.update_notice", params);
		return res;
	}

	// 스터디 모집 취소
	public int recruit_cancel( int idx ) {
		int res = sqlSession.update("study.recruit_cancel", idx);
		return res;
	}
	
	// 스터디 삭제
	public int del_study_member( int idx ) {
		int res = sqlSession.delete("study.del_study_member", idx);
		return res;
	}
	
	// 스터디 모집 마감 
	public int apply_close( int study_idx ) {
		int res = sqlSession.update("study.apply_close", study_idx);
		return res;
	}
	
	// apply count - 1 하고 approve count + 1
	public int in_member( int study_idx ) {
		int res = sqlSession.delete("study.in_member", study_idx);
		return res;
	}
	
	//  approve count - 1
	public int out_member( int study_idx ) {
		int res = sqlSession.delete("study.out_member", study_idx);
		return res;
	}
	
	// 모집 자동 마감을 위해 스터디 목록 가져오기
	public List<StudyVO> auto_apply_close() {
		List<StudyVO> list = sqlSession.selectList("study.auto_apply_close");
		return list;
	}
	
	// 스터디 자동 마감을 위해 스터디 목록 가져오기
	public List<StudyVO> auto_study_close() {
		List<StudyVO> list = sqlSession.selectList("study.auto_study_close");
		return list;
	}
	
	// 스터디 종료
	public int study_close( int study_idx ) {
		int res = sqlSession.update("study.study_close", study_idx);
		return res;
	}
	
	// 스터디 개설 취소
	public int open_cancel( int idx ) {
		int res = sqlSession.update("study.open_cancel", idx);
		return res;
	}
	
	// 스터디 모집 마감일 연장
	public int apply_extend( int idx ) {
		int res = sqlSession.update("study.apply_extend", idx);
		return res;
	}
	
	// 스터디 모집 마감일 연장
	public int study_extend( int idx ) {
		int res = sqlSession.update("study.study_extend", idx);
		return res;
	}
}

