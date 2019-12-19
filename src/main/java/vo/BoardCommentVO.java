package vo;

import java.util.Date;

public class BoardCommentVO {
	
	private int idx, board_idx, user_idx, parent, seq;
	private String content;
	private Date created_at, updated_at, deleted_at;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getContent() {
		return content;
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
	public void setContent(String content) {
		this.content = content;
	}

}
