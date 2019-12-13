package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

public interface DAO {
		
	public List selectList();
	public Object selectOne(int idx);
	public int insert(Object vo);
	public int update(Object vo);
	public int delete(int idx);

}
