package com.bnu.card.web.form;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class MigrateCardForm  extends BaseOperationForm {

	  private String memo;
	  private String name;
	  private String migratePlace;
	  private Date migrateDate;
	  private int cardId;
	  
	  
	  
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

	public String getMigratePlace() {
		return migratePlace;
	}
	public void setMigratePlace(String migratePlace) {
		this.migratePlace = migratePlace;
	}
	// 设定JSON序列化时的日期格式
		@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getMigrateDate() {
		return migrateDate;
	}
	public void setMigrateDate(Date migrateDate) {
		this.migrateDate = migrateDate;
	}
	public int getCardId() {
		return cardId;
	}
	public void setCardId(int cardId) {
		this.cardId = cardId;
	}
}