package com.bnu.card.web.form;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class HistoryForm  extends BaseForm {
	  private String caption;
	  private String memo;
	  private String name;
	  private Long operatorId;
	  private String operatorName;
	  private Date operateDate;
	  private String status;
	  private String cardType;
	  private Long cardId;
	  private Long registerCardId;
	  private String operateType;
	  
	  
	  public Long getRegisterCardId() {
		return registerCardId;
	}
	public void setRegisterCardId(Long registerCardId) {
		this.registerCardId = registerCardId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	// 设定JSON序列化时的日期格式
			@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getOperateDate() {
		return operateDate;
	}
	public void setOperateDate(Date operateDate) {
		this.operateDate = operateDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	
	public Long getOperatorId() {
		return operatorId;
	}
	public void setOperatorId(Long operatorId) {
		this.operatorId = operatorId;
	}
	public Long getCardId() {
		return cardId;
	}
	public void setCardId(Long cardId) {
		this.cardId = cardId;
	}
	public String getOperateType() {
		return operateType;
	}
	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}
}