package com.bnu.card.web.form;

import java.util.Date;


import org.apache.commons.lang3.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonFormat;


public class SysUserForm  extends BaseForm {
	  private String name;
	  private String loginName;
	  private String password;
	  private String memo;
	  private Date createDate;
	  private String status;
	  private String role;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	public String getStatus() {
		return status;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	// 设定JSON序列化时的日期格式
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
    public boolean equals(Object o) {
        if (!(o instanceof SysUserForm)) {
            return false;
        }

        final SysUserForm obj = (SysUserForm) o;
        
        return obj.id == id;
    }
	
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}