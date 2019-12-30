package common;

import java.util.HashMap;

public class PagingOption {
	public static HashMap<String, Object> getPagingOption( int start, int blocklist ) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int end = start + blocklist - 1;
		
		result.put("start", start);
		result.put("end", end);
		
		return result;
	}
	
	public static HashMap<String, Object> getPagingOption( int start, String search, int blocklist ) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int end = start + blocklist - 1;
		
		result.put("start", start);
		result.put("end", end);
		result.put("search", search);
		
		return result;
	}
	
	public static HashMap<String, Object> setPage(HashMap<String, Object> params, int currentPage, int blocklist ){

		// 한 페이지에서 표시되는 게시물의 시작과 끝번호를 계산
		// 1페이지라면 1 ~ 10번 게시물까지만 보여줘야 한다.
		// 2페이지라면 11 ~ 20번 게시물까지만 보여줘야한다.
		int start = ( currentPage - 1 ) * Common.StudyPaging.BLOCKLIST + 1;
		int end = start + blocklist - 1;
		
		params.put("start", start);
		params.put("end", end);
		
		return params;
	}
}
