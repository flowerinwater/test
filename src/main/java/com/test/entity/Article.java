package com.test.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "article")
public class Article extends IdEntity {
	private String publisherId;
	private String content;
	private String img;
	private String video;
	private String clientInfo;
	private Date publishTime;

	public Article() {
	}

	public Article(Long id) {
		this.id = id;
	}


	public String getClientInfo() {
		return clientInfo;
	}

	public void setClientInfo(String clientInfo) {
		this.clientInfo = clientInfo;
	}

	public String getPublisherId() {
		return publisherId;
	}

	public void setPublisherId(String publisherId) {
		this.publisherId = publisherId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	// 设定JSON序列化时的日期格式
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(Date publishtime) {
		this.publishTime = publishtime;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}