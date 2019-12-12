package service;

import java.util.List;

import org.springframework.stereotype.Service;

import dao.SampleDAO;

@Service
public class SampleServiceImpl implements SampleService {
	// service: 여러 dao객체를 한데 묶어주는 역할
	// service에 필요한 모든 dao을 담고, main에서 service 안의 dao를 호출한 뒤
	// dao 인터페이스가 구현하고 있는 추상메서드 호출하여 사용
	
	// 셋터인젝션으로 dao객체 받기
	SampleDAO sampleDAO;
	public void setSampleDAO(SampleDAO sampleDAO) {
		this.sampleDAO = sampleDAO;
	}
	
	@Override
	public List showBoardList() {
		// TODO Auto-generated method stub
		return sampleDAO.selectList();
	}

}
