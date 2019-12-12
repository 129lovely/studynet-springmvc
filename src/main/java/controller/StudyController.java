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
	
	@RequestMapping(value = {"/", "/community_list.do"})
	public String sample(Model model) {
		List<BoardVO> list = boardService.showCommunityList();
		model.addAttribute("list", list);
		return Common.Default.VIEW_PATH + "community_list.jsp";
	}
	
	
}
