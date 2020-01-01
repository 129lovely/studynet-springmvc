package controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import common.PagingOption;
import common.Paging_study;
import dao.BoardDAO;
import dao.StudyDAO;
import service.BoardService;
import service.StudyService;
import service.UserService;
import vo.StudyMemberVO;
import vo.StudyVO;
import vo.UserVO;

@Controller
public class StudyController {

	private static final int ArrayList = 0;
	private static final int StudyMemberVO = 0;
	StudyService studyService;
	UserService userService;
	BoardService boardService;
	BoardDAO boardDAO;
	StudyDAO studyDAO;

	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}

	public void setStudyService(StudyService studyService) {
		this.studyService = studyService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	public void setStudyDAO(StudyDAO studyDAO) {
		this.studyDAO = studyDAO;
	}

	// 마이페이지 스터디룸 - 1 
	// 유저가 참여 중인 스터디의 idx를 모두 가져온 뒤 해당하는 idx의 스터디 정보와 유저의 참여 상태를 가져와야 함
	// 일단은 이동만 ^^...
	@RequestMapping("/study_myinfo.do")
	public String user_study_list(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		
		List<StudyVO> list=(List<StudyVO>)studyService.study_myinfo(user.getIdx());
				
		model.addAttribute("user", user);
		model.addAttribute("list", list);
		
		return Common.Study.VIEW_PATH + "study_myinfo.jsp";
	}

	// 마이페이지 회원 정보
	@RequestMapping("/user_myinfo.do")
	public String user_myinfo () {
		return Common.User.VIEW_PATH + "user_myinfo.jsp";
	}
	
	// 스터디 만들기 페이지 - 1 ( 생성 안내 페이지로 이동 )
	@RequestMapping("/study_create_caution.do")
	public String study_create_caution ( ) {

		return Common.Study.VIEW_PATH + "study_create_caution.jsp";
	}

	// 스터디 만들기 페이지 - 2 ( 생성 폼 페이지로 이동 )
	@RequestMapping("/study_create_form.do")
	public String create_form ( ) {

		return Common.Study.VIEW_PATH + "study_create.jsp";
	}

	// 스터디 만들기 페이지 - 3 ( vo 정보 DB로 전송 )
	@RequestMapping("/study_insert.do")
	public String study_insert ( StudyVO vo, HttpServletRequest request) {


		ServletContext application = request.getServletContext();

		// 대표 사진은 따로 저장해주기 위해 절대 경로를 만든다.
		String webPath = "/resources/images/study_profile";
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);

		MultipartFile photo_file = vo.getPhoto_file();
		String photo = "no_photo";

		if ( ! photo_file.isEmpty() ) {

			// 실제 파일명으로 변경 
			photo = photo_file.getOriginalFilename();

			File saveFile = new File(savePath, photo);

			if ( ! saveFile.exists() ) {	// 저장할 경로가 존재하지 않는다면 새로 생성
				saveFile.mkdirs();

			} else {	// 동일 파일명 처리
				long time = System.currentTimeMillis();
				photo = String.format("%d_%s", time, photo);
				saveFile = new File(savePath, photo);
			}

			try {	// 로컬 파일로 복사 
				photo_file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			} 

		} else {
			// 지정된 파일이 없을 경우 랜덤하게 샘플에서 가져온다.
			photo = "preview0" + (new Random().nextInt(3) + 1) + ".jpg";
		}

		vo.setPhoto(photo);

		int res = studyService.insert( vo );	

		return "redirect:study_list.do";
	}

	// 스터디 찾기 페이지 목록
	@RequestMapping("/study_list.do")
	public String study_list(Model model, HttpServletRequest request,
			@RequestParam HashMap<String, Object> params) {
		
		int nowPage = 1;
		if( params.get("page") != null ) {
			nowPage = Integer.parseInt( params.get("page").toString() );
		}
		
		List<StudyVO> list = null; // 게시글 전체 목록
		int row_total = 0; // 전체 게시물 수
		
		String purpose = null;
		
		if( params.get("purpose") != null ) {
			purpose = params.get("purpose").toString();
		
			if( purpose.isEmpty() == false ) {
				String[] purposeArr = params.get("purpose").toString().split(",");
				params.put("array", purposeArr);
			}
		}
		
		if( params.get("search_option") == null ) {
			params.put("search_option", 3);
		}
		
		// start, end값 셋팅
		params = PagingOption.setPage(params, nowPage, Common.StudyPaging.BLOCKLIST);
				
		list = (List<StudyVO>) studyService.search_list_condition(params).get("list");
		row_total = (int) studyService.search_list_condition(params).get("cnt");

		// view 하단 페이지 메뉴 생성
		String pageMenu = Paging_study.getPaging(
				"study_list.do", nowPage, row_total, Common.StudyPaging.BLOCKLIST, 
				Common.StudyPaging.BLOCKPAGE, params);

		// request영역에 list 바인딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("row_total", row_total);

		return Common.Study.VIEW_PATH + "study_list.jsp";

	}

	//스터디 상세 페이지
	@RequestMapping("/study_list_detail.do")
	public String study_list_detail(Model model, int idx,HttpServletRequest request) {
		StudyVO study=studyService.showStudyDetail(idx);
		UserVO user=userService.select_userName(idx);

		model.addAttribute("study",study);
		model.addAttribute("user", user);
		return Common.Study.VIEW_PATH + "study_list_detail.jsp";
	}

	//스터디 참가 신청 페이지 이동
	@RequestMapping("/study_apply_caution.do")
	public String study_apply_caution(Model model, int study_idx) {
		StudyVO vo = studyService.showStudyDetail(study_idx);
		model.addAttribute("vo", vo); // 데이터 바인딩
		return Common.Study.VIEW_PATH + "study_apply_caution.jsp";
	}

	// 스터디 수정하기 폼
	@RequestMapping("/study_create_modify_form.do")
	public String study_create_mod(Model model, int idx) {
		StudyVO study = studyService.showStudyDetail(idx);

		model.addAttribute("study", study);
		return Common.Study.VIEW_PATH + "study_create_modify.jsp";
	}

	// 스터디 수정하기
	@RequestMapping("/study_create_modify.do")
	public String study_create_modify(int idx) {
		int res = studyService.studyModify(idx);

		return "study_list_detail.do?idx=" + idx;
	}

	//스터디 지원
	@RequestMapping("/study_apply.do")
	public String study_apply(String introduce, int study_idx, HttpServletRequest request){

		UserVO user = (UserVO) request.getSession().getAttribute("user");
		Map map = new HashMap();
		map.put("user_idx", user.getIdx());
		map.put("study_idx", study_idx);
		map.put("introduce", introduce);

		int res = studyService.study_apply(map);
		return "redirect:study_list_detail.do?idx=" + study_idx; 

	}

	// 스터디 중복 체크
	@RequestMapping("/study_check.do")
	@ResponseBody
	public String study_check( int study_idx, int user_idx ){
		Map map = new HashMap();
		map.put("user_idx", user_idx);
		map.put("study_idx", study_idx);

		String resStr = "fail";
		
		StudyMemberVO vo = studyService.selectOne_member(map);
		if( vo != null ) {
			return resStr;
		}

		return resStr = "success";
	}

	// 스터디 룸 개별 페이지 
	@RequestMapping("/study_room_detail.do")
	public String study_room_detail () {
		return Common.Study.VIEW_PATH + "study_room.jsp";
	}
	
	// 스터디 룸 개별 페이지 : 관리자
	@RequestMapping("/study_room_manage.do")
	public String study_room_manage ( int study_idx, Model model ) {
		// 스터디 정보 가져오기
		StudyVO study = studyService.showStudyDetail(study_idx);
		model.addAttribute("study", study);
		
		// 스터디 멤버 정보 가져오기
		List<StudyMemberVO> member = studyService.member_list(study_idx);
		model.addAttribute("member", member);
		
		// 스터디 게시판 정보 가져오기		
		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}

		int start = (nowPage -1) * Common.BoardPaging.BLOCKLIST + 1;

		//start와 end를 map에 저장
		HashMap<String, Object> map = PagingOption.getPagingOption(start, Common.BoardPaging.BLOCKLIST );
		map.put("study_idx", study_idx);
		
		//게시글 전체목록 가져오기
		List<BoardVO> list = null;
		list = studyService.study_board_list(map);

		//전체 게시물 수 구하기
		int row_total = studyService.study_board_list_cnt(map);

		//페이지 메뉴 생성하기
		//ㄴ ◀1 2 3 4 5▶
		String pageMenu = Paging.getPaging(
				"study_room_manage.do", nowPage, row_total, Common.BoardPaging.BLOCKLIST, 
				Common.BoardPaging.BLOCKPAGE, null, study_idx);

		//request영역에 list바인딩
		model.addAttribute("board", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("row_total", row_total);
		
		return Common.Study.VIEW_PATH + "study_room_manage.jsp";
	}
	
	// 선택 인원 승인
	@RequestMapping("/mem_approve.do")
	@ResponseBody
	public int mem_approve( String[] idx ) {
		
		int res = studyService.mem_approve( idx );
			
		return res;
	}
	
	// 선택 인원 거부
	@RequestMapping("/mem_reject.do")
	@ResponseBody
	public int mem_reject( String[] idx ) {
		
		int res = studyService.mem_reject( idx );
			
		return res;
	}
		
	// 선택 인원 추방
	@RequestMapping("/mem_kick.do")
	@ResponseBody
	public int mem_kick( String[] idx ) {
		
		int res = studyService.mem_kick( idx );
			
		return res;
	}
	
	// 관리자 추가 요청 메일
	@RequestMapping("/add_study_admin_mail.do")
	@ResponseBody
	public void add_study_admin_mail( int idx, int study_idx, String email ) {
		
		try {
			studyService.add_study_admin_mail( idx, study_idx, email );
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	// 공동 관리자 추가
	@RequestMapping("/add_admin.do")
	public String add_admin( int idx, Model model ) { 
		
		studyService.add_admin( idx );
		
		return Common.Study.VIEW_PATH + "add_admin_complete.jsp";
	}
	
	// 스터디 모집 취소 ( 글 삭졔, 개설 취소 )
	@RequestMapping("/recruit_cancel.do")
	@ResponseBody
	public int recruit_cancel( int idx ) {
		int res = studyService.recruit_cancel( idx );
		return res;
	}

	// 스터디 공지 수정
	@RequestMapping("/notice_update.do")
	@ResponseBody
	public String notice_update(@RequestParam HashMap<String, Object> params, Model model) {
		String resStr = "fail";
		int res = studyService.update_notice(params);
		if( res != 0 ) {
			resStr = "success";
		}
		return resStr;
	}
	
	// 스터디 게시판 글쓰기
	@RequestMapping("/study_board_write.do")
	public String study_board_write(@RequestParam HashMap<String, Object> params, HttpServletRequest request) {
		UserVO user = (UserVO) request.getSession().getAttribute("user");	
		params.put("user_idx", user.getIdx());
		
		if( params.get("is_notice") == null ) {
			params.put("is_notice", 0);
		}
	// 내 스터디 룸에서 스터디 삭제
	@RequestMapping("/del_study.do")
	@ResponseBody
	public String del_study(@RequestParam HashMap<String, Object> params) {
		
		int res = studyService.study_board_write(params);
		String res = studyService.del_study(params);
		
		return "redirect:study_room_manage.do?study_idx=" + params.get("study_idx") + "#study_board_tb";
		return res;
	}
}
