package common;

import java.util.HashMap;


/**
 * @author lejewk
 * sms인증시 전화번호에대한 키 제네레이터
 */

public class CertificationKeyGenerator {
	public static CertificationKeyGenerator newInstance(){
		return new CertificationKeyGenerator();
	}
	
	private CertificationKeyGenerator(){}
	
	/**
	 * 인증키 생성 유틸
	 * 인증키는 아래와 같이 시간을 전번 뒤에 섞고 끝에서 6자리를 서브스트링한다.
	 * @param Number
	 * @return
	 */
	public String tempKeyGenarator(String Number){
		String lastNumberString = null;
		String numberArray[] = Number.split("-");
		
		if(numberArray[2].charAt(0) == '0'){
			lastNumberString = "1"+numberArray[2].substring(1, numberArray[2].length());
		}else{
			lastNumberString = numberArray[2];
		}
		
		String last = Long.toString((Integer.parseInt(lastNumberString) * System.currentTimeMillis()));
		return last.substring(last.length()-6, last.length());
	}
	
	/**
	 * 새로운 인증키를 생성하고 SMS를 보낸다.
	 * @param thamesMemberDAO
	 * @param phone
	 */
	public HashMap tempKeyGenerator( String phone ) throws Exception{
		//인증키 생성
		String tempKey = tempKeyGenarator(phone);
		System.out.println("암호화키 : "+tempKey);

		//인증키및 전화번호 파라미터화
		HashMap<Object, Object> param = new HashMap<Object, Object> ();
		param.put("tempKey", tempKey);
		param.put("phone", phone);
		
		//SMS를 보내기위해 작업
		SMSFactory smsFactory = new SMSFactory(tempKey, phone);
		if(smsFactory.Send()){
			// 발송 완료 확인
			System.out.println("sms 전송 완료");	
		}
		
		return param;
	}
}
