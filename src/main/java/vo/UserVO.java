package vo;

import java.util.Date;

public class UserVO {
	private int idx, is_email_auth, is_phone_auth, study;
	private String email, password, name, phone, job, region;
	private Date created_at, updated_at, deleted_at;
	
	// sns 관련
	private String sns_type, sns_id, sns_access_token, sns_refresh_token;
	
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
	public String getSns_type() {
		return sns_type;
	}
	public void setSns_type(String sns_type) {
		this.sns_type = sns_type;
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
	public String getSns_id() {
		return sns_id;
	}
	public void setSns_id(String sns_id) {
		this.sns_id = sns_id;
	}
	public String getSns_access_token() {
		return sns_access_token;
	}
	public void setSns_access_token(String sns_access_token) {
		this.sns_access_token = sns_access_token;
	}
	public String getSns_refresh_token() {
		return sns_refresh_token;
	}
	public void setSns_refresh_token(String sns_refresh_token) {
		this.sns_refresh_token = sns_refresh_token;
	}

	
}
