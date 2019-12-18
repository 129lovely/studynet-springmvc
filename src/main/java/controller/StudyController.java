package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import common.Paging;
import dao.BoardDAO;
import service.BoardService;
import service.StudyService;
import service.UserService;
import vo.BoardCommentVO;
import vo.BoardVO;
import vo.StudyVO;
import vo.UserVO;

@Controller
public class StudyController {

	StudyService studyService;
	UserService userService;
	BoardService boardService;
	BoardDAO boardDAO;

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
	
	//----------------------------------------------------------------------------
	//
	// mapping
	//
	//----------------------------------------------------------------------------
	@RequestMapping("/socket_test2.do")
	public String socket_test(Model model) {
		return "/WEB-INF/views/socket_test2.jsp";
	}
	
	@RequestMapping("/")
	public String iframe_test(Model model) {
		return "/WEB-INF/views/iframe.jsp";
	}
	
	// index 
	@RequestMapping(value = { "/index.do" })
	public String index(Model model) {
		List<BoardVO> board = boardService.showCommunityList_index();
		model.addAttribute("board", board);
		return "/WEB-INF/views/index.jsp";
	}

	// 로그인 - 1 ( 페이지 이동 )
	@RequestMapping("/user_login_form.do")
	public String user_login_form( HttpServletRequest request ) {
		
		// 이전 페이지 정보 세션에 저장
		String prevPage = request.getHeader("referer");
		HttpSession session = request.getSession();
		session.setAttribute("prevPage", prevPage);
		return Common.User.VIEW_PATH + "user_login.jsp";
	}

	// 로그인 - 2 ( 폼 전송, 세션에 저장 )
	@RequestMapping("/user_login.do")
	@ResponseBody
	public String user_login( String email, String password, HttpServletRequest request ) {
		Map map = (Map) userService.user_login( email, password );
		
		// res 담기
		String res = (String) map.get("res");
		
		// 세션에 유저 정보 담기 ( res == clear인 경우만 )
		if ( res.equals("clear") ) {
			
			UserVO user = (UserVO) map.get("user");
			
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			session.setMaxInactiveInterval(120 * 60);
		}
		
		return res;
	}

	// 회원 가입 - 1 ( 약관 동의 페이지 )
	@RequestMapping("/user_join_caution.do")
	public String user_join_caution( ) {
		return Common.User.VIEW_PATH + "user_join_caution.jsp";
	}
	
	// 회원 가입 - 2 ( 정보 입력 페이지 )
	@RequestMapping("/user_join_form.do")
	public String user_join_form( ) {
		return Common.User.VIEW_PATH + "user_join.jsp";
	}
	
	// 회원가입 - 3 ( 회원 가입 처리 후 완료 페이지로 포워딩)
	@RequestMapping("/user_insert.do")
	public String user_insert( UserVO vo, Model model ) {
		String res = userService.user_insert( vo );
		model.addAttribute("res", res);
		return Common.User.VIEW_PATH + "user_join_complete.jsp";
	}
	
	
	@RequestMapping( "/community_list.do")
	public String list( Model model, Integer page, HttpServletRequest request ) {
		int nowPage = 1;

		if( page != null ) {
			nowPage = page;
		}
		
		System.out.println(nowPage + ": now page");
		System.out.println(page + ": page");
		
		//한페이지에서 표시되는 게시물의 시작과 끝번호를 계산
		//1페이지라면 1 ~ 10번 게시물까지만 보여줘야 한다.
		//2페이지라면 11 ~ 20번 게시물까지만 보여줘야한다.
		int start = (nowPage -1) * Common.BoardPaging.BLOCKLIST + 1;
		int end = start + Common.BoardPaging.BLOCKLIST -1;

		//start와 end를 map에 저장
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);

		//게시글 전체목록 가져오기
		//List<BoardVO> list = boardService.showCommunityList(map);
		//model.addAttribute("list", list);
		List<BoardVO> list = null;
		
		list = boardDAO.selectList( map );	

		//전체 게시물 수 구하기
		int row_total = boardDAO.getRowTotal();

		//페이지 메뉴 생성하기
		//ㄴ ◀1 2 3 4 5▶
		String pageMenu = Paging.getPaging(
				"community_list.do", nowPage, row_total, Common.BoardPaging.BLOCKLIST, Common.BoardPaging.BLOCKPAGE);

		//request영역에 list바인딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("row_total", row_total);
		
		//세션에 등록되어 있던 show정보를 없앤다
		request.getSession().removeAttribute("show");

		return Common.Board.VIEW_PATH + "community_list.jsp";
	}
	
	//검색기능 and 검색결과 레코드 개수
	@RequestMapping("/community_list_search.do")
	public String list_search(Model model, String search ) {
		System.out.println(search);
		List<BoardVO> list = boardService.search_list(search);
		model.addAttribute("list", list);
		return Common.Board.VIEW_PATH + "community_list.jsp";
	}

	@RequestMapping("/community_write_form.do")
	public String community_write_form() {
		return Common.Board.VIEW_PATH + "community_write.jsp";
	}
	
	//원글 삭제
	@RequestMapping("/del.do")
	public String board_del(int idx) {
		int res = boardService.board_del(idx);
		return "redirect:community_list.do";
		
	}

	// 원글 수정하기
	@RequestMapping("/community_write_update.do")
	public String community_write_update(BoardVO vo) {
		
		int res=boardService.updateCommunity(vo);
		return "community_list_detail.do?idx="+vo.getIdx();
		
	}
	
	@RequestMapping("/community_list_detail.do")
	public String community_list_detail(Model model, int idx , HttpServletRequest request) {
		BoardVO board = (BoardVO) boardService.showCommunityListDetail(idx).get("board");
		List<BoardCommentVO> comment = (ArrayList<BoardCommentVO>) boardService.showCommunityListDetail(idx).get("comment");
		
		//조회수 증가
		HttpSession session = request.getSession();
				String show = (String)session.getAttribute("show");
				if( show == null ) {
					//읽지 않은 게시물일때만 조회수를 증가
					int res = boardService.hit_increase(idx);
					session.setAttribute("show", "yes");
				}
		
		model.addAttribute("board", board);
		model.addAttribute("comment", comment);
		return Common.Board.VIEW_PATH + "community_list_detail.jsp";
	}

	// 댓글 수정 박스띄우기
	@RequestMapping("/community_list_detail_modify_form.do")
	public String community_list_detail_modify_form(Model model, int idx, String show) {
		show="yes";
		model.addAttribute("show", show);
		return Common.Board.VIEW_PATH + "community_list_detail.jsp";
	}

	@RequestMapping("/community_list_detail_modify.do")
	public String community_list_detail_modify(Model model, int idx) {
		BoardVO vo = (BoardVO) boardService.showCommunityListDetail(idx).get("board");
		model.addAttribute("vo", vo);
		return Common.Board.VIEW_PATH + "community_list_detail.jsp";
	}

	@RequestMapping("/community_write_modify_form.do")
	public String community_write_modify_form(Model model, int idx) {
		BoardVO vo = (BoardVO) boardService.showCommunityListDetail(idx).get("board");
		model.addAttribute("vo", vo);
		return Common.Board.VIEW_PATH + "community_write_modify.jsp";
	}

	@RequestMapping("/community_write.do")
	public String community_write(BoardVO vo) {
		boardService.writeCommunity(vo);
		return "redirect:community_list.do";
	}

	// 이메일 중복 확인
	@RequestMapping("/email_check.do")
	@ResponseBody
	public String email_check( String input_email, HttpServletRequest request ){
		String res = userService.emailCheck(input_email);
		request.setAttribute("res", res);
		return res;
	}
	
	//게시글 삭제
	@RequestMapping("/community_delete.do")
	public String delete(int idx) {
		boardService.del(idx);

		return "redirect:community_list.do";

	}
	
	// 추천버튼 클릭시 추천 수 올리기
	@RequestMapping("/community_recommend.do")
	public String community_recommend(int idx) {
		
		int res=boardService.updateRecommend(idx);
		return "community_list_detail.do?idx="+idx;
		
	}
	
	// 댓글달기
	@RequestMapping("/comment_origin_reply.do")
	public String comment_origin_reply(BoardCommentVO vo) {
		boardService.writeComment(vo);
		return "community_list_detail.do?idx="+vo.getBoard_idx();		
	}

	// 댓글 수정
	@RequestMapping("/comment_update.do")
	@ResponseBody
	public String comment_update(BoardCommentVO vo) {
		
		int res= boardService.updateComment(vo);
		
		String result="no";
		if(res!=0) {
			result="yes";
		}
		return result;
	}

	// 마이페이지 스터디룸 - 1 
	// 유저가 참여 중인 스터디의 idx를 모두 가져온 뒤 해당하는 idx의 스터디 정보와 유저의 참여 상태를 가져와야 함
	// 일단은 이동만 ^^...
	@RequestMapping("/study_myinfo.do")
	public String user_study_list ( ) {
		
		return Common.Study.VIEW_PATH + "study_myinfo.jsp";
	}

	// 스터디 만들기 페이지 - 1 ( 이동 )
	@RequestMapping("/study_create_form.do")
	public String study_create_form ( ) {
		
		return Common.Study.VIEW_PATH + "study_create.jsp";
	}
	
	// 스터디 만들기 페이지 - 2 ( 생성 안내 페이지로 이동 )
	@RequestMapping("/study_create_caution.do")
	public String create_caution ( StudyVO vo, Model model ) {
		model.addAttribute("vo", vo);
		return Common.Study.VIEW_PATH + "study_create_caution.jsp";
	}

	// 스터디 만들기 페이지 - 3 ( vo 정보 DB로 전송 )
	@RequestMapping("/study_insert.do")
	public String study_insert ( StudyVO vo ) {
		
		studyService.insert( vo );
		
		
		return "redirect:study_list.do";
	}
	
	// 스터디 찾기 페이지 목록
	@RequestMapping("/study_list.do")
	public String study_list() {
		return Common.Study.VIEW_PATH + "study_list.jsp";
	}
		
	//스터디 상세 페이지
		@RequestMapping("/study_list_detail.do")
		public String study_list_detail() {
			return Common.Study.VIEW_PATH + "study_list_detail.jsp";
		}
		
	//스터디 참가 신청하기
	@RequestMapping("/study_apply_caution.do")
	public String study_apply_caution() {
		return Common.Study.VIEW_PATH + "study_apply_caution.jsp";
	}
	
}
