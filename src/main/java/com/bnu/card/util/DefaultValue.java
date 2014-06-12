package com.bnu.card.util;

import org.apache.shiro.SecurityUtils;

import com.bnu.card.service.ShiroDbRealm.ShiroUser;

public class DefaultValue {
	public static final String CARD_TYPE = "job";
	public static final String PURPOSE = "purpose";
	public static final String MILITARY_SITUATION = "militarySituation";
	public static final String MARRIAGE_INFO = "marriageInfo";
	public static final String EDUCATION_INFO = "educationInfo";
	public static final String BLOOD_TYPE = "blood_type";
	public static final String USER_STATUS = "user_status";
	public static final String GENDER_TYPE = "gender_type";
	public static final String OPERATE_TYPE = "operate_type";
	public static final String CARD_TYPE4HISTORY = "cardtype4history";
	public static final Object CURRENT_USER = "current_user";

	public static String DEFAULT_PASSWORD = "12345678";

	//是否有效
	public static String VALID = "1";
	public static String UNVALID = "0";
	public static String DELETE = "2";//删除
	public static String DETAINED = "3";//滞留
	public static String LEND = "4";//借出
	public static String MIGRATE = "6";//迁移
	
	public static String VALID_CN = "有效";
	public static String UNVALID_CN = "无效";
	public static String DELETE_CN = "删除";
	public static String CURR_USER_NAME = "CURR_USER_NAME";
	public static String CURR_USER_ID = "CURR_USER_ID";
	
	public static String CARD_TYPE_REGISTER = "1";
	public static String CARD_TYPE_BATCH_REGISTER = "2";
	public static String CARD_TYPE_LEND = "4";
	public static String CARD_TYPE_RETURN = "5";
	public static String CARD_TYPE_MIGRATE = "6";
	
	public static String CARD_TYPE_CN_REGISTER = "登记卡";
	public static String CARD_TYPE_CN_LEND = "借出卡";
	public static String CARD_TYPE_CN_RETURN = "归还卡";
	public static String CARD_TYPE_CN_MIGRATE = "迁移卡";
	
	public static String OPERATE_TYPE_ADD = "1";
	public static String OPERATE_TYPE_UPDATE = "2";
	public static String OPERATE_TYPE_DEL = "3";
	public static String OPERATE_TYPE_LEND = "4";
	public static String OPERATE_TYPE_RETURN = "5";
	public static String OPERATE_TYPE_MIGRATE = "6";
	
	public static String OPERATE_TYPE_CN_ADD = "创建卡";
	public static String OPERATE_TYPE_CN_UPDATE = "修改卡";
	public static String OPERATE_TYPE_CN_DEL = "删除卡";
	public static String OPERATE_TYPE_CN_LEND = "借出卡";
	public static String OPERATE_TYPE_CN_RETURN = "归还卡";
	public static String OPERATE_TYPE_CN_MIGRATE = "迁出卡";
	
	public static String GENDER_MALE = "1";
	public static String GENDER_FEMALE = "2";
	public static String GENDER_CN_MALE = "男";
	public static String GENDER_CN_FEMALE = "女";
	
	public static String CARD_STUDENT = "1";
	public static String CARD_TEACHER = "2";
	public static String CARD_CN_STUDENT = "学生";
	public static String CARD_CN_TEACHER = "教工";
	
//	public static String transStatus(String code){
//		String value = "";
//		
//		if(code==null)
//			value = UNVALID_CN;
//		else if(code.equals(UNVALID))
//			value = UNVALID_CN;
//		else if(code.equals(VALID))
//			value = VALID_CN;
//		else if(code.equals(DELETE))
//			value = DELETE_CN;
//		else
//			value = UNVALID_CN;
//		
//		return value;
//	}
//	
//	public static String transOperateType(String code){
//		String value = "";
//		
//		if(code==null)
//			value = "";
//		else if(code.equals(OPERATE_TYPE_ADD))
//			value = OPERATE_TYPE_CN_ADD;
//		else if(code.equals(OPERATE_TYPE_DEL))
//			value = OPERATE_TYPE_CN_DEL;
//		else if(code.equals(OPERATE_TYPE_UPDATE))
//			value = OPERATE_TYPE_CN_UPDATE;
//		else if(code.equals(OPERATE_TYPE_LEND))
//			value = OPERATE_TYPE_CN_LEND;
//		else if(code.equals(OPERATE_TYPE_RETURN))
//			value = OPERATE_TYPE_CN_RETURN;
//		else if(code.equals(OPERATE_TYPE_MIGRATE))
//			value = OPERATE_TYPE_CN_MIGRATE;
//		return value;
//	}
//	
//	public static String transCardType(String code){
//		String value = "";
//		
//		if(code==null)
//			value = "";
//		else if(code.equals(CARD_TYPE_REGISTER))
//			value = CARD_TYPE_CN_REGISTER;
//		else if(code.equals(CARD_TYPE_LEND))
//			value = CARD_TYPE_CN_LEND;
//		else if(code.equals(CARD_TYPE_RETURN))
//			value = CARD_TYPE_CN_RETURN;
//		else if(code.equals(CARD_TYPE_MIGRATE))
//			value = CARD_TYPE_CN_MIGRATE;
//		return value;
//	}
//	
//	public static String transGenderType(String code){
//		String value = "";
//		
//		if(code==null)
//			value = "";
//		else if(code.equals(GENDER_MALE))
//			value = GENDER_CN_MALE;
//		else if(code.equals(GENDER_MALE))
//			value = GENDER_CN_FEMALE;
//
//		
//		return value;
//	}
//	
//	public static String transCardOwnerType(String code){
//		String value = "";
//		
//		if(code==null)
//			value = "";
//		else if(code.equals(CARD_STUDENT))
//			value = CARD_CN_STUDENT;
//		else if(code.equals(CARD_TEACHER))
//			value = CARD_CN_TEACHER;
//		
//		return value;
//	}
	
	/**
	 * 取出Shiro中的当前用户LoginName.
	 */
	public static String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.loginName;
	}
}
