package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import service.BoardService;
import vo.BoardVO;

@Controller
public class HomeController {
	BoardService boardService;
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	@RequestMapping("/socket_test2.do")
	public String socket_test(Model model) {
		return "/WEB-INF/views/socket_test2.jsp";
	}

	// main - iframe
	@RequestMapping("/socket_index.do")
	public String iframe_test(Model model, HttpServletRequest request) {		
		return "/WEB-INF/views/iframe.jsp";
	}

	// index 
	@RequestMapping(value = {"/", "index.do"})
	public String index(Model model) {
		List<BoardVO> board = boardService.showCommunityList_index();
		model.addAttribute("board", board);
		return "/WEB-INF/views/index.jsp";
	}
}
