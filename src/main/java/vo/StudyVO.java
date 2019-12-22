package vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class StudyVO {
	
	private int idx, create_user_idx, min_count, max_count
				, apply_count, approve_count, is_online;
	private String title, photo, open_kakao, purpose, place, extra_info, 
					apply_condition, detail_info, study_status; 
	
	private MultipartFile photo_file;
	private String deadline, start_date, end_date;
	private Date created_at, updated_at, deleted_at;
	
	public MultipartFile getPhoto_file() {
		return photo_file;
	}
	public void setPhoto_file(MultipartFile photo_file) {
		this.photo_file = photo_file;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getCreate_user_idx() {
		return create_user_idx;
	}
	public void setCreate_user_idx(int create_user_idx) {
		this.create_user_idx = create_user_idx;
	}
	public int getMin_count() {
		return min_count;
	}
	public void setMin_count(int min_count) {
		this.min_count = min_count;
	}
	public int getMax_count() {
		return max_count;
	}
	public void setMax_count(int max_count) {
		this.max_count = max_count;
	}
	public int getApply_count() {
		return apply_count;
	}
	public void setApply_count(int apply_count) {
		this.apply_count = apply_count;
	}
	public int getApprove_count() {
		return approve_count;
	}
	public void setApprove_count(int approve_count) {
		this.approve_count = approve_count;
	}
	public int getIs_online() {
		return is_online;
	}
	public void setIs_online(int is_online) {
		this.is_online = is_online;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getOpen_kakao() {
		return open_kakao;
	}
	public void setOpen_kakao(String open_kakao) {
		this.open_kakao = open_kakao;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getExtra_info() {
		return extra_info;
	}
	public void setExtra_info(String extra_info) {
		this.extra_info = extra_info;
	}

	public String getApply_condition() {
		return apply_condition;
	}
	public void setApply_condition(String apply_condition) {
		this.apply_condition = apply_condition;
	}
	public String getStudy_status() {
		return study_status;
	}
	public void setStudy_status(String study_status) {
		this.study_status = study_status;
	}
	public String getDetail_info() {
		return detail_info;
	}
	public void setDetail_info(String detail_info) {
		this.detail_info = detail_info;
	}
	public String getStatus() {
		return study_status;
	}
	public void setStatus(String status) {
		this.study_status = status;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public Date getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}
	public Date getDeleted_at() {
		return deleted_at;
	}
	public void setDeleted_at(Date deleted_at) {
		this.deleted_at = deleted_at;
	}

	

}
