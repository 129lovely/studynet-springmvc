package controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

	// index 
	@RequestMapping(value = { "/", "/index.do" })
	public String index(Model model) {
		List<BoardVO> board = boardService.showCommunityList_index();
		model.addAttribute("board", board);
		return "/WEB-INF/views/index.jsp";
	}

	// 로그인 - 1 ( 페이지 이동 )
	@RequestMapping("/user_login_form.do")
	public String user_login_form(  ) {
		return Common.User.VIEW_PATH + "user_login.jsp";
	}

	// 로그인 - 1 ( 페이지 이동 )
	@RequestMapping("/user_login.do")
	public String user_login(  ) {
		return Common.User.VIEW_PATH + "user_login.jsp";
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
	public String community_list(Model model, HttpServletRequest request) {
		List<BoardVO> list = boardService.showCommunityList();
		model.addAttribute("list", list);
		//세션에 등록되어 있던 show정보를 없앤다
		request.getSession().removeAttribute("show");
				
		return Common.Board.VIEW_PATH + "community_list.jsp";
	}

	@RequestMapping("/community_write_form.do")
	public String community_write_form() {
		return Common.Board.VIEW_PATH + "community_write.jsp";
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


}
