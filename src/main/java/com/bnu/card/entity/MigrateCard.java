package com.bnu.card.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "migrate_card_info",catalog="bnu_card")
public class MigrateCard  extends IdEntity {

	  private String memo;
	  private Long creatorId;
	  private String creatorName;
	  private Date createDate;
	  private Long updaterId;
	  private String updaterName;
	  private Date updaterDate;
	  private String status;
	  private String migratePlace;
	  private Date migrateDate;
	  private Long cardId;
	  
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	// 设定JSON序列化时的日期格式
		@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getUpdaterName() {
		return updaterName;
	}
	public void setUpdaterName(String updaterName) {
		this.updaterName = updaterName;
	}
	// 设定JSON序列化时的日期格式
		@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getUpdaterDate() {
		return updaterDate;
	}
	public void setUpdaterDate(Date updaterDate) {
		this.updaterDate = updaterDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMigratePlace() {
		return migratePlace;
	}
	public void setMigratePlace(String migratePlace) {
		this.migratePlace = migratePlace;
	}
	// 设定JSON序列化时的日期格式
		@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getMigrateDate() {
		return migrateDate;
	}
	public void setMigrateDate(Date migrateDate) {
		this.migrateDate = migrateDate;
	}
	
	public Long getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(Long creatorId) {
		this.creatorId = creatorId;
	}
	public Long getUpdaterId() {
		return updaterId;
	}
	public void setUpdaterId(Long updaterId) {
		this.updaterId = updaterId;
	}
	public Long getCardId() {
		return cardId;
	}
	public void setCardId(Long cardId) {
		this.cardId = cardId;
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
        if (!(o instanceof MigrateCard)) {
            return false;
        }

        final MigrateCard obj = (MigrateCard) o;
        
        return obj.id == id;
    }
	
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}