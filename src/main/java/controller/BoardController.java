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
import common.PagingOption;
import dao.BoardDAO;
import service.BoardService;
import vo.BoardCommentVO;
import vo.BoardVO;
import vo.UserVO;

@Controller
public class BoardController {
	BoardService boardService;
	BoardDAO boardDAO;
	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	// 커뮤니티 리스트
	@RequestMapping( "/community_list.do")
	public String list( Model model, Integer page, HttpServletRequest request ) {
		int nowPage = 1;

		if( page != null ) {
			nowPage = page; // ~.do?page=3 처럼 입력할 경우
		}

		//한페이지에서 표시되는 게시물의 시작과 끝번호를 계산
		//1페이지라면 1 ~ 10번 게시물까지만 보여줘야 한다.
		//2페이지라면 11 ~ 20번 게시물까지만 보여줘야한다.
		int start = (nowPage -1) * Common.BoardPaging.BLOCKLIST + 1;

		//start와 end를 map에 저장
		HashMap<String, Object> map = PagingOption.getPagingOption(start, Common.BoardPaging.BLOCKLIST );
		
		//게시글 전체목록 가져오기
		List<BoardVO> list = null;
		list = boardDAO.selectList( map );	

		//전체 게시물 수 구하기
		int row_total = boardDAO.getRowTotal();

		//페이지 메뉴 생성하기
		//ㄴ ◀1 2 3 4 5▶
		String pageMenu = Paging.getPaging(
				"community_list.do", nowPage, row_total, Common.BoardPaging.BLOCKLIST, 
				Common.BoardPaging.BLOCKPAGE, null, 0);

		//request영역에 list바인딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("row_total", row_total);

		//세션에 등록되어 있던 show정보를 없앤다
		request.getSession().removeAttribute("show");

		return Common.Board.VIEW_PATH + "community_list.jsp";
	}

	// 커뮤니티 리스트 검색
	@RequestMapping("/community_list_search.do")
	public String list_search( Model model, Integer page, HttpServletRequest request, String search ) {
		int nowPage = 1;

		if( page != null ) {
			nowPage = page; // ~.do?page=3 처럼 입력할 경우
		}

		//한페이지에서 표시되는 게시물의 시작과 끝번호를 계산
		//1페이지라면 1 ~ 10번 게시물까지만 보여줘야 한다.
		//2페이지라면 11 ~ 20번 게시물까지만 보여줘야한다.
		int start = (nowPage -1) * Common.BoardPaging.BLOCKLIST + 1;

		//start와 end를 map에 저장
		HashMap<String, Object> map = PagingOption.getPagingOption(start, search, Common.BoardPaging.BLOCKLIST);

		//게시글 전체목록 가져오기
		List<BoardVO> list = null;
		list = (List<BoardVO>) boardService.search_list(map).get("list");

		//전체 게시물 수 구하기
		int row_total = (int) boardService.search_list(map).get("cnt");

		//페이지 메뉴 생성하기
		//ㄴ ◀1 2 3 4 5▶
		String pageMenu = Paging.getPaging(
				"community_list_search.do" , nowPage, row_total,
				Common.BoardPaging.BLOCKLIST, Common.BoardPaging.BLOCKPAGE,
				search, 0);

		//request영역에 list바인딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("row_total", row_total);

		//세션에 등록되어 있던 show정보를 없앤다
		request.getSession().removeAttribute("show");

		return Common.Board.VIEW_PATH + "community_list.jsp";

	}

	// 커뮤니티 게시글 작성1 - 페이지 이동
	@RequestMapping("/community_write_form.do")
	public String community_write_form() {
		return Common.Board.VIEW_PATH + "community_write.jsp";
	}

	// 커뮤니티 게시글 작성2 - db작업
	@RequestMapping("/community_write.do")
	public String community_write(BoardVO vo) {
		boardService.writeCommunity(vo);
		return "redirect:community_list.do";
	}

	// 커뮤니티 게시글 삭제
	@RequestMapping("/del.do")
	public String board_del(int idx) {
		boardService.board_del(idx);
		return "redirect:community_list.do";

	}

	// 커뮤니티 게시글 수정1 - 페이지 이동
	@RequestMapping("/community_write_modify_form.do")
	public String community_write_modify_form(Model model, int idx) {
		BoardVO vo = (BoardVO) boardService.showCommunityListDetail(idx).get("board");
		model.addAttribute("vo", vo);
		return Common.Board.VIEW_PATH + "community_write_modify.jsp";
	}

	// 커뮤니티 게시글 수정2 - db작업
	@RequestMapping("/community_write_update.do")
	public String community_write_update(BoardVO vo) {
		int res=boardService.updateCommunity(vo);
		return "community_list_detail.do?idx=" + vo.getIdx();
	}

	// 커뮤니티 게시글 상세보기
	@RequestMapping("/community_list_detail.do")
	public String community_list_detail(Model model, int idx , HttpServletRequest request) {
		BoardVO board = (BoardVO) boardService.showCommunityListDetail(idx).get("board");
		List<BoardCommentVO> comment = (ArrayList<BoardCommentVO>) boardService.showCommunityListDetail(idx).get("comment");
		
		
		System.out.println("controller: " + board.getUser_idx() );
		
		
		String name = boardService.select_user_name( board.getUser_idx() );

		board.setName(name);

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

	// 추천수 증가
	@RequestMapping("/community_recommend.do")
	@ResponseBody
	public String community_recommend(int idx, int user_idx, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");

		String res = boardService.updateRecommend(idx, user_idx, user.getIdx());
		return res;
	}

	// 댓글 작성
	@RequestMapping("/comment_origin_reply.do")
	public String comment_origin_reply(BoardCommentVO vo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");

		vo.setUser_idx( user.getIdx() );
		boardService.writeComment(vo);
		return "community_list_detail.do?idx="+vo.getBoard_idx();
	}

	// 댓글 수정
	@RequestMapping("/comment_mod.do")
	@ResponseBody
	public String comment_mod(int idx, int user_idx, String content, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO vo = (UserVO) session.getAttribute("user");

		String res = "fail";

		if( vo.getIdx() == user_idx ) { // 유저 정보 일치하면
			int sqlRes = boardService.comment_mod(idx, content);
			res = "success";
		}

		return res;
	}

	// 댓글 삭제
	@RequestMapping("/comment_del.do")
	@ResponseBody
	public String comment_del(int idx, int user_idx, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO vo = (UserVO) session.getAttribute("user");

		String res = "fail";

		if( vo.getIdx() == user_idx ) { // 유저 정보 일치하면
			int sqlRes = boardService.comment_del(idx);
			res = "success";
		}

		return res;
	}
	
	// 대댓글 작성
	@RequestMapping("/write_comment_reply.do")
	public String write_comment_reply(int parent, String content, int is_re, int b_idx, HttpServletRequest request) {
		UserVO user = (UserVO) request.getSession().getAttribute("user");

		Map map = new HashMap();
		map.put("parent", parent); // 부모 댓글
		map.put("content", content); // 내용
		map.put("is_re", is_re); // 0: 원댓의 댓, 1: 대댓의 댓
		map.put("b_idx", b_idx); // 게시글 idx
		map.put("user_idx", user.getIdx()); // 작성자 idx

		int res = boardService.comment_reply(map);
		return "redirect:community_list_detail.do?idx="+b_idx;
	}

}
