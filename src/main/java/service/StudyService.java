package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import org.springframework.mail.javamail.JavaMailSender;

import common.MailUtils;
import dao.BoardDAO;
import dao.StudyDAO;
import dao.UserDAO;
import vo.StudyMemberVO;
import vo.StudyVO;

public class StudyService {
	BoardDAO boardDAO;
	StudyDAO studyDAO;
	UserDAO userDAO;
	
	JavaMailSender mailSender;
	
	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	public void setStudyDAO(StudyDAO studyDAO) {
		this.studyDAO = studyDAO;
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	//index.jsp에서 스터디 목록나오게하기
	public List<StudyVO> index_study_list(){
		List<StudyVO> list=studyDAO.index_study_list();
		return list;
	}
	
	
	// 스터디 생성
	public int insert( StudyVO vo ) {
		// 레코드 생성 후 study_idx값 반환
		int res = studyDAO.insert(vo);
		
		Map map = new HashMap();
		map.put("user_idx", vo.getCreate_user_idx());
		map.put("idx", vo.getIdx());
		
		res = studyDAO.add_admin_member(map);
		res = userDAO.update_study_cnt(vo.getCreate_user_idx());
		
		return res; 
	}

	//검색기능and게시물수,옵션이 분류일때
	public Map search_list(Map map){

		List<StudyVO> list = studyDAO.search(map);
		int cnt = studyDAO.search_cnt( (String) map.get("search") );
		
		Map res = new HashMap();
		res.put("list", list);
		res.put("cnt", cnt);
		
		return res;
	}
	
	//검색기능and게시물수,조건별 검색
	public HashMap<String, Object> search_list_condition(HashMap<String, Object> map){

		List<StudyVO> list = studyDAO.search_condition(map);
		int cnt = studyDAO.search_cnt_condition(map);//게시물수
		
		HashMap<String, Object> res = new HashMap<String, Object>();
		res.put("list", list);
		res.put("cnt", cnt);
		
		return res;
	}
		
	public StudyVO showStudyDetail(int idx) {
		StudyVO vo=studyDAO.selectOne(idx);
		return vo;
	}

	public int studyModify(int idx) {
		int res=studyDAO.update_study(idx);
		return res;
	}
	
    // 스터디 가입 신청  
	public int study_apply(Map map) {
		int res = studyDAO.study_apply(map);
		res = studyDAO.study_add_member(map); // 신청수 1증가
		userDAO.update_study_cnt( (int) map.get("user_idx") ); // 유저의 스터디 수 하나 추가
		return res;
	}

	// 스터디 중복 체크
	public StudyMemberVO selectOne_member(Map map) {
		StudyMemberVO vo = studyDAO.selectOne_member(map);
		return vo;
	}

	// study_myinfo에서 study_member의 status가져오기
	public StudyMemberVO studyMemStatus(int user_idx) {
		StudyMemberVO vo = studyDAO.study_member_status(user_idx);
		return vo; 
	}

	// study_member의 study_idx를 통해서 study내용 가져오기
	public List<StudyVO> studyMemList(int study_idx){
		List<StudyVO> list=(ArrayList<StudyVO>)studyDAO.study_member_list(study_idx);
		return list;
	}
	
	// 스터디에 참여 / 신청 중인 멤버 리스트 가져오기
	public List<StudyMemberVO> member_list( int study_idx ) {
		List<StudyMemberVO> member = studyDAO.member_list(study_idx);
		return member;
	}
	
	// 선택한 멤버 승인
	public int mem_approve( String[] idx_arr ) {
		
		int result = 0;
		
		for(int i = 0; i < idx_arr.length ; i++ ) {
			int idx = Integer.parseInt(idx_arr[i]);
			int res = studyDAO.mem_approve( idx );
			
			if( res == 0 ) {
				result += 0;
			} else {
				result += 1;
			}
		}
		
		return result;
	}
	
	// 선택한 멤버 거부
	public int mem_reject( String[] idx_arr ) {
		
		int result = 0;
		
		for(int i = 0; i < idx_arr.length ; i++ ) {
			int idx = Integer.parseInt(idx_arr[i]);
			int res = studyDAO.mem_reject( idx );
			
			if( res == 0 ) {
				result += 0;
			} else {
				result += 1;
			}
		}
		
		return result;
	}
	
	// 선택한 멤버 강퇴
	public int mem_kick( String[] idx_arr ) {
		
		int result = 0;
		
		for(int i = 0; i < idx_arr.length ; i++ ) {
			int idx = Integer.parseInt(idx_arr[i]);
			int res = studyDAO.mem_kick( idx );
			
			if( res == 0 ) {
				result += 0;
			} else {
				result += 1;
			}
		}
		
		return result;
	}
		
	// 공동 관리자 요청 메일 전송
	public void add_study_admin_mail( int idx, int study_idx, String email ) throws Exception {

		System.out.println("email: " + email);
		System.out.println("idx: " + idx);
		System.out.println("study_idx: " + study_idx);
		
		// 메일 발송
		MailUtils mail = new MailUtils(mailSender);
		
		mail.setSubject("[스터디넷] 스터디 공동 관리자 추가 요청입니다.");
		mail.setTo(email);
		mail.setFrom("studynet2019web@gmail.com", "스터디넷");
		

		
		mail.setText(new StringBuffer()
				.append("<body><div><table align=\"center\"><tr><td style=\"border-bottom: 1px solid gray; padding: 10px;\"><img src=\"https://i.imgur.com/ATMKhlq.png\" style=\"width:150px; margin: 0 auto; \"><br></td></tr><tr><td style=\"border-bottom: 1px solid gray; padding: 10px; text-align: center;\"><h2 style=\"color: steelblue;\">스터디 공동 관리자 추가 요청입니다.</h2><p>스터디 개설자가 회원님을 공동 관리자로 추가하길 원합니다. <br>공동 관리자 요청을 승인하고 스터디를 관리하시려면<br>아래의 승인하기 버튼을 눌러주세요.</p><p>공동 관리자는 기존 관리자와 같은 권한을 가지며<br>자신을 제외한 공동 관리자가 없을 경우 스터디 탈퇴가 불가능합니다.</p><br>")
				.append("<a href=\"http://localhost:9090/web/study_list_detail.do?idx=")
				.append(study_idx + "\"")
				.append(" style=\"background: steelblue; color: white; font-weight: bold;padding: 10px;width: 200px;text-align: center;border-radius: 10px;margin: 0 auto; text-decoration: none;\">스터디 모집글 확인하기</a><br><br><br>")
				.append("<a href=\"http://localhost:9090/web/add_admin.do?idx=")
				.append(idx + "\"")
				.append(" style=\"background: steelblue; color: white; font-weight: bold;padding: 10px;width: 200px;text-align: center;border-radius: 10px;margin: 0 auto; text-decoration: none;\">요청 승인하기</a><br><br>")
				.append("<small style=\"color: steelblue;\">만약 스터디넷에 가입한 적이 없으시다면 이 메일을 무시해주세요.</small><br><br> </td></tr><tr><td><small style=\"color: gray; margin-top: 30px;\">(주)스터디넷 | 서울특별시 마포구 서강로 136 아이비 타워 2층 | 02-1111-3333 | studynet2019web@gmail.com </small></td></tr></table></div></body>")
				.toString());
		
		mail.send();

	}
	
	// 공동 관리자 추가
	public int add_admin( int idx ) {
		int res = studyDAO.add_admin( idx );
		
		return res;
	}
	
	// 마이페이지 - 내스터디룸 전체 리스트 가져오기
	public List<StudyVO> study_myinfo(int user_idx) {
		List<StudyVO> list = studyDAO.study_myinfo(user_idx);
		return list;
	}
	
<<<<<<< HEAD
	// 스터디 모집 취소 ( 글 삭졔, 개설 취소 )
	public int recruit_cancel( int idx ) {
		int res = studyDAO.recruit_cancel( idx );
=======
	// 스터디룸 공지 수정
	public int update_notice(HashMap<String, Object> params) {
		int res = studyDAO.update_notice(params);
>>>>>>> 72d1462c1ad59a6f9a172618904d7a936668db07
		return res;
	}
}
