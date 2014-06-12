package com.bnu.card.entity;

import java.util.Date;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.bnu.card.entity.SysRoles;
@Entity
@Table(name = "sys_user",catalog="bnu_card")
public class SysUser  extends IdEntity {
	  private String name;
	  private String loginName;
	  private String password;
	  private String memo;
	  private Date createDate;
	  private String status;
	  private String role;

		private String salt;
	  
	  private Set<SysRoles> userRoles;
	  
	  
	  
	  
	  
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
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
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
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
	
	@OneToMany
	@JoinTable(name ="user_roles",joinColumns =@JoinColumn(name="user_id"),inverseJoinColumns =@JoinColumn(name="role_id"))
	public Set<SysRoles> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(Set<SysRoles> userRoles) {
		this.userRoles = userRoles;
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
        if (!(o instanceof SysUser)) {
            return false;
        }

        final SysUser obj = (SysUser) o;
        
        return obj.id == id;
    }
	
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}