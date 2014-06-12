package com.bnu.card.web.form;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BaseOperationForm extends BaseForm {
	  protected int creatorId;
	  protected String creatorName;
	  protected Date createDate;
	  
	  protected int updaterId;
	  protected String updaterName;
	  protected Date updaterDate;
	  
	  protected String status;
	  
	  
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(int creatorId) {
		this.creatorId = creatorId;
	}
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	// 设定JSON序列化时的日期格式
			@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	
	public int getUpdaterId() {
		return updaterId;
	}
	public void setUpdaterId(int updaterId) {
		this.updaterId = updaterId;
	}
	public String getUpdaterName() {
		return updaterName;
	}
	public void setUpdaterName(String updaterName) {
		this.updaterName = updaterName;
	}
	
	// 设定JSON序列化时的日期格式
			@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getUpdaterDate() {
		return updaterDate;
	}
	public void setUpdaterDate(Date updaterDate) {
		this.updaterDate = updaterDate;
	}
	  
	  
}
