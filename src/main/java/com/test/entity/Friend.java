package com.test.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;

@Entity
@Table(name = "friend")
public class Friend extends IdEntity {
	private Long friendId;
	private Long userId;
	private String friendNote;

	public Friend() {
	}

	public Friend(Long id) {
		this.id = id;
	}

	public Long getFriendId() {
		return friendId;
	}

	public void setFriendId(Long friendId) {
		this.friendId = friendId;
	}

	public String getFriendNote() {
		return friendNote;
	}

	public void setFriendNote(String friendNote) {
		this.friendNote = friendNote;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}


	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}