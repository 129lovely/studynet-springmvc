package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import common.CertificationKeyGenerator;
import common.Common;
import common.Paging;
import dao.BoardDAO;
import dao.StudyDAO;
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
	public String iframe_test(Model model, HttpServletRequest request) {		
		return "/WEB-INF/views/iframe.jsp";
	}
	
	// 네이버 로그인
	@RequestMapping("/nlogin.do")
	public ModelAndView nlogin(HttpServletRequest request) {		
		String clientId = "weu2tfr6_Z8ML_0Dng4h"; // 애플리케이션 클라이언트 아이디값
		String redirectURI = "";
	    
		try {
			redirectURI = URLEncoder.encode("http://localhost:9090/web/nlogin_callback.do", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id=" + clientId;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&state=" + state;
		request.getSession().setAttribute("state", state);
		
		return new ModelAndView("redirect:" + apiURL); 
	}
	
	// 네이버 로그인 - 콜백
	@RequestMapping("/nlogin_callback.do")
	public ModelAndView nlogin_callback(HttpServletRequest request) {
		String prevPage = "";
		
		String clientId = "weu2tfr6_Z8ML_0Dng4h"; // 애플리케이션 클라이언트 아이디값
		String clientSecret = "b5nklGsDtk"; // 애플리케이션 클라이언트 시크릿값
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = "";
		try {
			redirectURI = URLEncoder.encode("http://localhost:9090/web/nlogin_callback.do", "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;
		String access_token = "";
		String refresh_token = "";
		System.out.println("apiURL="+apiURL);
		try {
			// access_token 발급 요청
			// response : access_token, refresh_token, token_type, expires_in
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			
			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {  // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();

			if(responseCode==200) { // 로그인 성공했을 경우
				ObjectMapper mapper = new ObjectMapper();
				Map<String, String> map = mapper.readValue(res.toString(), Map.class);
				access_token = map.get("access_token");
				refresh_token = map.get("refresh_token");
				
				// access_token 사용하여 프로필api 호출
				Map<String, String> info = getProfileApi(access_token);
				
				// info 황용하여 db 작업
				UserVO user = userService.nlogin(info);
				
				// 로그인 세션 처리
				HttpSession session = request.getSession();
				
				session.setAttribute("user", user);
				prevPage = (String) session.getAttribute("prevPage");
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return new ModelAndView("redirect:" + prevPage);
	}

	public Map<String, String> getProfileApi(String access_token) {
		Map<String, String> info = new HashMap<>();

		try {
			URL url = new URL("https://openapi.naver.com/v1/nid/me");
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");

			// 요청 header에 포함될 내용
			con.setRequestProperty("Authorization", "Bearer " + access_token);
			
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200){ // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			}else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			String result = "";
			while ((inputLine = br.readLine()) != null) {
				result += inputLine;
			}
			br.close();
			
			if(responseCode==200) { // 로그인 성공했을 경우
				// 프로필api map에 저장
				com.google.gson.JsonParser parser = new com.google.gson.JsonParser();
				JsonElement element = parser.parse(result);
				JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();
				
				String name = response.getAsJsonObject().get("name").getAsString();
				String email = response.getAsJsonObject().get("email").getAsString();
				String id = response.getAsJsonObject().get("id").getAsString();
				
				info.put("name", name);
				info.put("email", email);
				info.put("id", id);				
			}
		} catch (Exception e) { 
			System.out.println(e);
		}
		
		return info;
	}
	
	// index 
	@RequestMapping("/index.do")
	public String index(Model model) {
		List<BoardVO> board = boardService.showCommunityList_index();
		model.addAttribute("board", board);
		return "/WEB-INF/views/index.jsp";
	}
	
	@RequestMapping("/community_list2.do")
	public String com_list2(Model model) {
		List<BoardVO> list = boardService.showCommunityList();
		model.addAttribute("list", list);
		return Common.Board.VIEW_PATH + "community_list2.jsp";
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
	public Map user_login( String email, String password, HttpServletRequest request ) {
		Map map = (Map) userService.user_login( email, password );
		
		// 결과 문장, 유저 이름 배열에 담기
		Map<String, String> resMap = new HashMap<String, String>();
		String res = (String) map.get("res");
		resMap.put("res", res);
		
		// 세션에 유저 정보 담기 ( res == clear인 경우만 )
		if ( res.equals("clear") ) {
			
			UserVO user = (UserVO) map.get("user");
			
			resMap.put("name", user.getName());
			
			HttpSession session = request.getSession();
//			session.removeAttribute("user");
			session.setAttribute("user", user);
			session.setMaxInactiveInterval(120 * 60);
		}
		
		return resMap;
	}
	
	// 로그아웃
	@RequestMapping("/user_logout.do")
	public String user_logout( HttpServletRequest request ) {
		HttpSession session = request.getSession();
		session.removeAttribute("user");

//		Map user = new HashMap();
//		user.put("name", "비회원");
//		user.put("idx", -1);
//		session.setAttribute("user", user);
//		session.setMaxInactiveInterval(300 * 60);
		
		return "redirect:index.do";
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
	public String user_insert( UserVO vo, Model model ) throws Exception {
		String res = userService.user_insert( vo );
		model.addAttribute("res", res);
		return Common.User.VIEW_PATH + "user_join_complete.jsp";
	}
	
	
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
		int end = start + Common.BoardPaging.BLOCKLIST - 1;

		//start와 end를 map에 저장
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);

		//게시글 전체목록 가져오기
		List<BoardVO> list = null;
		list = boardDAO.selectList( map );	

		//전체 게시물 수 구하기
		int row_total = boardDAO.getRowTotal();

		//페이지 메뉴 생성하기
		//ㄴ ◀1 2 3 4 5▶
		String pageMenu = Paging.getPaging(
				"community_list.do", nowPage, row_total, Common.BoardPaging.BLOCKLIST, 
				Common.BoardPaging.BLOCKPAGE, null);

		//request영역에 list바인딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("row_total", row_total);
		
		//세션에 등록되어 있던 show정보를 없앤다
		request.getSession().removeAttribute("show");

		return Common.Board.VIEW_PATH + "community_list.jsp";
	}
	
	// 커뮤니티 검색기능 and 검색결과 레코드 개수 (페이징 적용)
	@RequestMapping("/community_list_search.do")
	public String list_search( Model model, Integer page, HttpServletRequest request, String search ) {
		int nowPage = 1;

		if( page != null ) {
			nowPage = page; // ~.do?page=3 처럼 입력할 경우
		}
		
//		System.out.println(nowPage + ": now page");
//		System.out.println(page + ": page");
		
		//한페이지에서 표시되는 게시물의 시작과 끝번호를 계산
		//1페이지라면 1 ~ 10번 게시물까지만 보여줘야 한다.
		//2페이지라면 11 ~ 20번 게시물까지만 보여줘야한다.
		int start = (nowPage -1) * Common.BoardPaging.BLOCKLIST + 1;
		int end = start + Common.BoardPaging.BLOCKLIST - 1;

		//start와 end를 map에 저장
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		map.put("search", search);

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
				search);

		//request영역에 list바인딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("row_total", row_total);
		
		//세션에 등록되어 있던 show정보를 없앤다
		request.getSession().removeAttribute("show");

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
		return res;
	}
	
	// 회원 가입 본인 인증  (인증 번호 ajax로 보내기)
	@RequestMapping("/user_join_certificate.do")
	@ResponseBody
	public Map user_join_certificate( String phone ) {

		CertificationKeyGenerator keyGen = CertificationKeyGenerator.newInstance();
		Map map = null;
		
		// 전화번호 중복되는 거 없는지도 확인해야함 
		int res = userService.selectOne( phone );
		
		if ( res != 0 ) {
			map = new HashMap();
			map.put("tempKey", "member");
			map.put("phone", "phone");
			
			return map;
		}
		
		
		try {
			map = keyGen.tempKeyGenerator(phone);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return map;
	}
	
	// 이메일 찾기 본인 인증  (인증 번호 ajax로 보내기)
		@RequestMapping("/user_find_phone_certificate.do")
		@ResponseBody
		public Map user_find_phone_certificate( String phone, String name ) {

			CertificationKeyGenerator keyGen = CertificationKeyGenerator.newInstance();
			
			Map map = null;
			
			int res = userService.selectOne( phone, name );
			
			if ( res == 0 ) {
				map = new HashMap();
				map.put("tempKey", "not_member");
				map.put("phone", "phone");
				
				return map;
			}
			
			
			try {
				map = keyGen.tempKeyGenerator(phone);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			return map;
		}
		
	//게시글 삭제
	@RequestMapping("/community_delete.do")
	public String delete(int idx) {
		boardService.del(idx);

		return "redirect:community_list.do";

	}
	
	// 추천버튼 클릭시 추천 수 올리기
	@RequestMapping("/community_recommend.do")
	@ResponseBody
	public String community_recommend(int idx, int user_idx, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		
		String res = boardService.updateRecommend(idx, user_idx, user.getIdx());
		return res;
	}
	
	// 댓글달기
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

	// 마이페이지 스터디룸 - 1 
	// 유저가 참여 중인 스터디의 idx를 모두 가져온 뒤 해당하는 idx의 스터디 정보와 유저의 참여 상태를 가져와야 함
	// 일단은 이동만 ^^...
	@RequestMapping("/study_myinfo.do")
	public String user_study_list ( ) {
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
			// 지정된 파일이 없을 경우 샘플에서 가져온다. 
			if( vo.getPurpose().equals("공모전") ) {
				photo = "preview01.jpg";
			} else if( vo.getPurpose().equals("취업준비") ) {
				photo = "preview02.jpg";
			} else if( vo.getPurpose().equals("기상/습관") ) {
				photo = "preview03.jpg";
			} else {
				photo = "preview04.jpg";
			}
		}
		 
		vo.setPhoto(photo);
		
		studyService.insert( vo );	
		
		return "redirect:study_list.do";
	}
	
	// 스터디 찾기 페이지 목록
	@RequestMapping("/study_list.do")
	public String study_list(Model model, Integer page, HttpServletRequest request ) {
		int nowPage = 1;

		if( page != null ) {
			nowPage = page; // ~.do?page=3 처럼 입력할 경우
		}

		//		System.out.println(nowPage + ": now page");
		//		System.out.println(page + ": page");

		//한페이지에서 표시되는 게시물의 시작과 끝번호를 계산
		//1페이지라면 1 ~ 5번 게시물까지만 보여줘야 한다.
		//2페이지라면 6 ~ 10번 게시물까지만 보여줘야한다.
		int start = (nowPage -1) * Common.StudyPaging.BLOCKLIST + 1;
		int end = start + Common.StudyPaging.BLOCKLIST - 1;

		//start와 end를 map에 저장
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);

		//게시글 전체목록 가져오기
		List<StudyVO> list = null;
		list = studyDAO.selectList( map );	
		
		//전체 게시물 수 구하기
		int row_total = studyDAO.getRowTotal();

		//페이지 메뉴 생성하기
		//ㄴ ◀1 2 3 4 5▶
		String pageMenu = Paging.getPaging(
				"study_list.do", nowPage, row_total, Common.StudyPaging.BLOCKLIST, 
				Common.StudyPaging.BLOCKPAGE, null);

		//request영역에 list바인딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("row_total", row_total);

		//세션에 등록되어 있던 show정보를 없앤다
		request.getSession().removeAttribute("show");
		
		return Common.Study.VIEW_PATH + "study_list.jsp";
	}
		
	
	// 스터디 찾기에서 검색기능 and 검색결과 레코드 개수 (페이징 적용)
		@RequestMapping("/study_list_search.do")
		public String study_list_search( Model model, Integer page, HttpServletRequest request, String search, int search_option ) {
			int nowPage = 1;

			if( page != null ) {
				nowPage = page; // ~.do?page=3 처럼 입력할 경우
			}
			
			//한페이지에서 표시되는 게시물의 시작과 끝번호를 계산
			//1페이지라면 1 ~ 10번 게시물까지만 보여줘야 한다.
			//2페이지라면 11 ~ 20번 게시물까지만 보여줘야한다.
			int start = (nowPage -1) * Common.StudyPaging.BLOCKLIST + 1;
			int end = start + Common.StudyPaging.BLOCKLIST - 1;

			//start와 end를 map에 저장
			Map map = new HashMap();
			map.put("start", start);
			map.put("end", end);
			map.put("search_option", search_option);
			map.put("search", search);

			//게시글 전체목록 가져오기
			List<StudyVO> list = null;
			int row_total = 0;
			
			//search_option[index] 유무에따라 온라인,오프라인,복합 결정
			if(search_option==2||search_option==0||search_option==1) {//옵션 선택일떄 온라인,오프라인 ,복합
				//게시글 전체목록 가져오기
				list = (List<StudyVO>) studyService.search_list_condition(map).get("list");
				//전체 게시물 수 구하기
				row_total = (int) studyService.search_list_condition(map).get("cnt");
				
			} else {//분류일때
				//게시글 전체목록 가져오기
				list = (List<StudyVO>) studyService.search_list(map).get("list");
				//전체 게시물 수 구하기
				row_total = (int) studyService.search_list(map).get("cnt");
			}

			//페이지 메뉴 생성하기
			//ㄴ ◀1 2 3 4 5▶
			String pageMenu = Paging.getPaging(
					"study_list_search.do" , nowPage, row_total,
					Common.StudyPaging.BLOCKLIST, Common.StudyPaging.BLOCKPAGE,
					search);

			//request영역에 list바인딩
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
		model.addAttribute("study_idx", study_idx); // 데이터 바인딩
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
	
	// 아이디 비번 찾기 페이지로 이동
	@RequestMapping("/user_find.do")
	public String user_find(HttpServletRequest request ) {

		return Common.User.VIEW_PATH + "user_find.jsp";
	}
	
	// 스터디 중복 체크
	@RequestMapping("/study_check.do")
	@ResponseBody
	public String study_check( int study_idx, HttpServletRequest request ){
		UserVO user = (UserVO) request.getSession().getAttribute("user");
		Map map = new HashMap();
		map.put("user_idx", user.getIdx());
		map.put("study_idx", study_idx);
		
		String res = studyService.studyCheck(map);
		System.out.println("res: " + res);
		
		return res;
	}

}
