package vo;

public class UserVO {
	private int idx, is_email_auth, is_phone_auth, study;
	private String email, password, name, phone, job
				   , region, created_at, updated_at, deleted_at
				   , sns_token, sns_type, sns_connected_at;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getIs_email_auth() {
		return is_email_auth;
	}
	public void setIs_email_auth(int is_email_auth) {
		this.is_email_auth = is_email_auth;
	}
	public int getIs_phone_auth() {
		return is_phone_auth;
	}
	public void setIs_phone_auth(int is_phone_auth) {
		this.is_phone_auth = is_phone_auth;
	}
	public int getStudy() {
		return study;
	}
	public void setStudy(int study) {
		this.study = study;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}
	public String getDeleted_at() {
		return deleted_at;
	}
	public void setDeleted_at(String deleted_at) {
		this.deleted_at = deleted_at;
	}
	public String getSns_token() {
		return sns_token;
	}
	public void setSns_token(String sns_token) {
		this.sns_token = sns_token;
	}
	public String getSns_type() {
		return sns_type;
	}
	public void setSns_type(String sns_type) {
		this.sns_type = sns_type;
	}
	public String getSns_connected_at() {
		return sns_connected_at;
	}
	public void setSns_connected_at(String sns_connected_at) {
		this.sns_connected_at = sns_connected_at;
	}
	
}
