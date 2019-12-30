package common;

public class TempPwdGenerator {

	/**
	    * 임의 비밀번호 10자리 생성
	    * @return
	    */
	    public static String randomPw(){
	    	
	      char pwCollection[] = new char[] {
	                        '1','2','3','4','5','6','7','8','9','0',
	                        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
	                        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
	                        '!','@','#','$','%','^','&','*'}; // 배열에 선언

	      String ranPw = "";

	      for (int i = 0; i < 10; i++) {
	        int selectRandomPw = (int)(Math.random()*(pwCollection.length)); // Math.rondom()은 0.0이상 1.0미만의 난수를 생성해 준다.
	        ranPw += pwCollection[selectRandomPw];
	      }
	      
	    return ranPw;
	    
	  }
		
}
