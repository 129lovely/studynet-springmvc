package controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import service.BoardService;
import service.StudyService;
import service.UserService;
import vo.BoardCommentVO;
import vo.BoardVO;
import vo.UserVO;

@Controller
public class StudyController {

	StudyService studyService;
	UserService userService;
	BoardService boardService;

	public void setStudyService(StudyService studyService) {
		this.studyService = studyService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	@RequestMapping(value = { "/", "/index.do" })
	public String index(Model model) {
		List<BoardVO> board = boardService.showCommunityList_index();
		model.addAttribute("board", board);
		return "/WEB-INF/views/index.jsp";
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
	
	
	@RequestMapping("/community_list.do")
	public String community_list(Model model) {
		List<BoardVO> list = boardService.showCommunityList();
		model.addAttribute("list", list);
		return Common.Board.VIEW_PATH + "community_list.jsp";
	}

	@RequestMapping("/community_write_form.do")
	public String community_write_form() {
		return Common.Board.VIEW_PATH + "community_write.jsp";
	}

	@RequestMapping("/community_list_detail.do")
	public String community_list_detail(Model model, int idx) {
		BoardVO board = (BoardVO) boardService.showCommunityListDetail(idx).get("board");
		List<BoardCommentVO> comment = (ArrayList<BoardCommentVO>) boardService.showCommunityListDetail(idx)
				.get("comment");
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
	
	// 페이징
	@RequestMapping( "/page.do" )
	public String list( Model model, int page ) {

		int nowPage = 1;

		if( page != 0 ) {
			nowPage = page;
		}
		
		
		Map pageMap = boardService.showCommunityListPage(nowPage);
		
		model.addAttribute("list", pageMap.get("list") );
		model.addAttribute("page", pageMap.get("page"));

		
		return Common.Board.VIEW_PATH + "board_list.jsp";

	}
}
