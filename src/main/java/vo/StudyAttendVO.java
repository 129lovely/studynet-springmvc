package vo;

public class StudyAttendVO {
	private int study_idx, user_idx;
	private String attend_at;
	
	public int getStudy_idx() {
		return study_idx;
	}
	public void setStudy_idx(int study_idx) {
		this.study_idx = study_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getAttend_at() {
		return attend_at;
	}
	public void setAttend_at(String attend_at) {
		this.attend_at = attend_at;
	}
}
