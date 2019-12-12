package dao;

import java.util.List;

public interface SampleDAO {
	// 쿼리 단위
	
	public List selectList(); // read
	int insert(Object vo); // create
	int update(Object vo); // update
	int delete(int idx); // delete

}
