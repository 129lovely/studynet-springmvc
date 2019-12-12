package controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import service.BoardService;
import service.StudyService;
import service.UserService;
import vo.BoardVO;

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
	
	@RequestMapping("/")
	public String index() {
		return "/WEB-INF/views/index.jsp";
	}
	
	@RequestMapping("/community_list.do")
	public String community_list(Model model) {
		List<BoardVO> list = boardService.showCommunityList();
		model.addAttribute("list", list);
		return Common.Board.VIEW_PATH + "community_list.jsp";
	}
	
	@RequestMapping("/community_write.do")
	public String community_write() {
		return Common.Board.VIEW_PATH + "community_write.jsp";
	}
	
	@RequestMapping("/community_list_detail.do")
	public String community_list_detail() {
		return Common.Board.VIEW_PATH + "community_list_detail.jsp";
	}
	
	
}
