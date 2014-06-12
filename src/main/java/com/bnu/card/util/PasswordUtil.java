package com.bnu.card.util;

import com.bnu.card.service.SysUserService;

public class PasswordUtil {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		SysUserService s = new SysUserService();
		try {
			s.changePass(6l, "1","1");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
