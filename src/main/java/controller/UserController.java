package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import common.CertificationKeyGenerator;
import common.Common;
import service.UserService;
import vo.UserVO;

@Controller
public class UserController {
	// 셋터 인젝션
	UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	// 로그인1 - 로그인 페이지로 이동
	@RequestMapping("/user_login_form.do")
	public String user_login_form( HttpServletRequest request ) {

		// 이전 페이지 정보 세션에 저장
		String prevPage = request.getHeader("referer");
		HttpSession session = request.getSession();
		session.setAttribute("prevPage", prevPage);
		return Common.User.VIEW_PATH + "user_login.jsp";
	}

	// 로그인2 - db작업, 세션 처리
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

		return "redirect:index.do";
	}

	// 회원 가입1 - 약관 동의
	@RequestMapping("/user_join_caution.do")
	public String user_join_caution( ) {
		return Common.User.VIEW_PATH + "user_join_caution.jsp";
	}

	// 회원 가입2 - 정보 입력 페이지
	@RequestMapping("/user_join_form.do")
	public String user_join_form( ) {
		return Common.User.VIEW_PATH + "user_join.jsp";
	}

	// 회원가입3 - 회원 가입 처리 후 완료 페이지로 포워딩
	@RequestMapping("/user_insert.do")
	public String user_insert( UserVO vo, Model model ) throws Exception {
		String res = userService.user_insert( vo );
		model.addAttribute("res", res);
		return Common.User.VIEW_PATH + "user_join_complete.jsp";
	}

	// 이메일 중복 확인
	@RequestMapping("/email_check.do")
	@ResponseBody
	public String email_check( String input_email, HttpServletRequest request ){
		String res = userService.emailCheck(input_email);
		return res;
	}

	// 본인 인증  (인증 번호 ajax로 보내기)
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

	// 네이버 로그인1
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

	// 네이버 로그인2 - 콜백 메서드
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

	// 네이버 로그인3 - 프로필api 가져오기
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

			if(responseCode==200) {
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
	
	// 스터디 생성, 신청할 때 회원 정보 체크
	@RequestMapping("/user_check.do")
	@ResponseBody
	public String user_check(int user_idx) {
		UserVO vo = userService.selectOne(user_idx);
		
		String res = "fail";
		if( vo.getPhone() == null || vo.getJob() == null || vo.getRegion() == null ) {
			return res;
		}
		
		if( vo.getStudy() >= 3 ) {
			return res = "over";
		}
		
		return res = "success";
	}


}
