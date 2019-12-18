package common;

public class Common {
	
	public static class User{
		public static final String VIEW_PATH = "/WEB-INF/views/user/";
	}
	
	public static class Board{
		public static final String VIEW_PATH = "/WEB-INF/views/board/";
	}
	
	public static class Study{
		public static final String VIEW_PATH = "/WEB-INF/views/study/";
	}
	
	public static class BoardPaging{
		//한 페이지당 보여줄 게시물 수
		public final static int BLOCKLIST = 3;

		//한 화면에 보여지는 페이지 메뉴 수
		//◀ 1 2 3 4 5 ▶
		public final static int BLOCKPAGE = 2;
	}
	
}
