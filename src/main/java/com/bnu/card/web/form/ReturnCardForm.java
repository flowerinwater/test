package com.bnu.card.web.form;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReturnCardForm  extends BaseOperationForm {
	  private int cardId;
	  private Date returnDate;
	  private String memo;
	  private String name;
	  
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCardId() {
		return cardId;
	}
	public void setCardId(int cardId) {
		this.cardId = cardId;
	}
	// 设定JSON序列化时的日期格式
		@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
		public Date getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}