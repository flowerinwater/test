package com.bnu.card.web.form;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class LendCardForm  extends BaseOperationForm {
	  private String memo;
	  
	  private Date lendDate;
	  private Date toReturnDate;
	  private String mobile;
	  private String tel;
	  private String qq;
	  private String email;
	  private int cardId;
	  private String name;
	  private String purpose;
	  
	  public String getPurpose() {
			return purpose;
		}
		public void setPurpose(String purpose) {
			this.purpose = purpose;
		}
	  public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	// 设定JSON序列化时的日期格式
				@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getLendDate() {
		return lendDate;
	}
	public void setLendDate(Date lendDate) {
		this.lendDate = lendDate;
	}
	// 设定JSON序列化时的日期格式
				@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
		
	public Date getToReturnDate() {
		return toReturnDate;
	}
	public void setToReturnDate(Date toReturnDate) {
		this.toReturnDate = toReturnDate;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getCardId() {
		return cardId;
	}
	public void setCardId(int cardId) {
		this.cardId = cardId;
	}

}