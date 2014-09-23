package com.bnu.card.web.form;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;


public class CardInfoForm  extends BaseOperationForm {
	  private String name;
	  private String memo;
	  
	  private String oldName;
	  private String nativePlace;
	  private String cardOwner;
	  private String gender;
	  private String nation;
	  private Date birthDay;
	  private String cardType;
	  private String belief;
	  private String identityCard;
	  private double height;
	  private String bloodType;
	  private String address;
	  private String birthPlace;
	  private String originStudent;
	  
	  private String grade;
	  private String job;
	  private String academe;
	  private String stuTeaNumber;
	  private String militarySituation;
	  private String marriageInfo;
	  private String educationInfo;
	  private String whenWhereToThisCity;
	  private String whenWhereToThisAddress;
	  
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
	
	public String getOldName() {
		return oldName;
	}
	public void setOldName(String old_name) {
		this.oldName = old_name;
	}
	public String getNativePlace() {
		return nativePlace;
	}
	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}
	public String getCardOwner() {
		return cardOwner;
	}
	public void setCardOwner(String cardOwner) {
		this.cardOwner = cardOwner;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	// 设定JSON序列化时的日期格式
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getBirthDay() {
		return birthDay;
	}
//	public void setBirthDay(String birthDay) {
////		Calendar.getInstance() ;
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		Date bd = null;
//		try {
//			bd = sdf.parse(birthDay);
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		this.birthDay = bd;
//	}
	
	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}
	
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public String getBelief() {
		return belief;
	}
	public void setBelief(String belief) {
		this.belief = belief;
	}
	public String getIdentityCard() {
		return identityCard;
	}
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
	public String getBloodType() {
		return bloodType;
	}
	public void setBloodType(String bloodType) {
		this.bloodType = bloodType;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getBirthPlace() {
		return birthPlace;
	}
	public void setBirthPlace(String birthPlace) {
		this.birthPlace = birthPlace;
	}
	public String getOriginStudent() {
		return originStudent;
	}
	public void setOriginStudent(String originStudent) {
		this.originStudent = originStudent;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getAcademe() {
		return academe;
	}
	public void setAcademe(String academe) {
		this.academe = academe;
	}
	public String getStuTeaNumber() {
		return stuTeaNumber;
	}
	public void setStuTeaNumber(String stuTeaNumber) {
		this.stuTeaNumber = stuTeaNumber;
	}
	public String getMilitarySituation() {
		return militarySituation;
	}
	public void setMilitarySituation(String militarySituation) {
		this.militarySituation = militarySituation;
	}
	public String getMarriageInfo() {
		return marriageInfo;
	}
	public void setMarriageInfo(String marriageInfo) {
		this.marriageInfo = marriageInfo;
	}
	public String getEducationInfo() {
		return educationInfo;
	}
	public void setEducationInfo(String educationInfo) {
		this.educationInfo = educationInfo;
	}
	public String getWhenWhereToThisCity() {
		return whenWhereToThisCity;
	}
	public void setWhenWhereToThisCity(String whenWhereToThisCity) {
		this.whenWhereToThisCity = whenWhereToThisCity;
	}
	public String getWhenWhereToThisAddress() {
		return whenWhereToThisAddress;
	}
	public void setWhenWhereToThisAddress(String whenWhereToThisAddress) {
		this.whenWhereToThisAddress = whenWhereToThisAddress;
	}

}
