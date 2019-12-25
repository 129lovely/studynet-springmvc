package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.BoardDAO;
import dao.StudyDAO;
import service.BoardService;
import service.StudyService;
import service.UserService;
import vo.BoardVO;
import vo.StudyVO;

@Controller
public class HomeController {
	StudyService studyService;
	BoardService boardService;
	BoardDAO boardDAO;
	StudyDAO studyDAO;
	public void setStudyService(StudyService studyService) {
		this.studyService = studyService;
	}


	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	public void setStudyDAO(StudyDAO studyDAO) {
		this.studyDAO = studyDAO;
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
	public String index(Model model,HttpServletRequest request,Integer page) {
		List<BoardVO> board = boardService.showCommunityList_index();
		List<StudyVO> list=studyDAO.index_study_list();
		model.addAttribute("board", board);
		model.addAttribute("list",list);
		System.out.println(list);
		return "/WEB-INF/views/index.jsp";
	}
}
