package controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import service.SampleService;
import vo.SampleVO;

@Controller
public class SampleController {
	
	// 셋터인젝션으로 service 받기
	SampleService sampleService;
	public void setSampleService(SampleService sampleService) {
		this.sampleService = sampleService;
	}
	
	@RequestMapping(value = {"/", "/sample.do"})
	public String sample(Model model) {
		// SampleServiceImpl의 selectList를 가져온 것
		List<SampleVO> list = sampleService.showBoardList();
		
		System.out.println(list.get(0).getCreated_at());
		
		model.addAttribute("list", list);
		return Common.Default.VIEW_PATH + "sample.jsp";
	}
	
}