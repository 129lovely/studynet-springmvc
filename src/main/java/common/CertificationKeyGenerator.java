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
	 * 인증키를 디비에서 지우고 새로운 인증키를 생성하여 디비에 삽입한다.
	 * @param thamesMemberDAO
	 * @param phone
	 */
	public void tempKeyGenerator(CertifiDAO certifiDAO ,String phone) throws Exception{
		//인증키 생성
		String tempKey = tempKeyGenarator(phone);
		System.out.println("암호화키 : "+tempKey);

		//이전 인증키 삭제
		certifiDAO.deleteTempKey(phone);
		
		//인증키및 전화번호 파라미터화
		HashMap<Object, Object> param = new HashMap<Object, Object> ();
		param.put("tempKey", tempKey);
		param.put("phone", phone);
		
		//SMS를 보내기위해 작업
		SMSFactory smsFactory = new SMSFactory(tempKey, phone);
		if(smsFactory.Send()){
			//sms로 발송한 신규 인증키를 db에 삽입
			System.out.println("sms 전송 완료");
			certifiDAO.insertCertificationKey(param);			
		}
	}
	
	/**
	 * 인풋키와 임시키를 비교하여 일치하는지 반환함
	 * @param thamesMemberDAO
	 * @param phone
	 * @param input
	 * @return
	 */
	public boolean isCorrectCertifiKey(CertifiDAO certifiDAO, String phone , String inputKey){
		//db에서 dbKey를 가져와 저장할 임시변수
		String dbKey = "";
		//암호화된 전화번호로 임시키 가져옴
		dbKey = certifiDAO.getTempKey(phone);
		//임시키와 인풋키 공백제거
		dbKey = dbKey.trim();
		inputKey = inputKey.trim();
		//디비에 누적된 임시키 삭제
		certifiDAO.deleteTempKey(phone);
		
		//인풋키와 임시키 비교
		if(inputKey.equals(dbKey)){
			return true;
		}
		else{
			return false;
		}
	}
}
