package com.test.data;

import com.test.entity.Friend;
import com.test.entity.User;
import org.springside.modules.test.data.RandomData;

public class FriendData {

	public static Friend randomNewFriend() {
		Friend friend = new Friend();
		friend.setFriendNote("friendNote");
		friend.setUserId(2L);
		friend.setFriendId(2L);

		return friend;
	}
}
