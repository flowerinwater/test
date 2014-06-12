package com.bnu.card.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.EntityResult;
import javax.persistence.FieldResult;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.SqlResultSetMappings;
import javax.persistence.Table;
import javax.persistence.ColumnResult;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonFormat;
@NamedNativeQueries({
		@NamedNativeQuery(
				name="CardInfo.findByNationGroup",
				query=" select nation groupname, " + 
						" sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall,"+
						" sum((case when (gender='1' and job='1') THEN 1 ELSE 0 END)) sumbachelormale,  sum((case when gender='2' and job='1' THEN 1 ELSE 0 END)) sumbachelorfemale ,sum((case when gender='1' and job='1' THEN 1 ELSE 0 END)+(case when gender='2' and job='1' THEN 1 ELSE 0 END)) sumbachelorall,"+
						" sum((case when (gender='1' and job='2') THEN 1 ELSE 0 END)) summastermale,  sum((case when gender='2' and job='2' THEN 1 ELSE 0 END)) summasterfemale ,sum((case when gender='1' and job='2' THEN 1 ELSE 0 END)+(case when gender='2' and job='2' THEN 1 ELSE 0 END)) summasterall,"+
						" sum((case when (gender='1' and job='3') THEN 1 ELSE 0 END)) sumdoctormale,  sum((case when gender='2' and job='3' THEN 1 ELSE 0 END)) sumdoctorfemale ,sum((case when gender='1' and job='3' THEN 1 ELSE 0 END)+(case when gender='2' and job='3' THEN 1 ELSE 0 END)) sumdoctorall"+
						" from bnu_card.card_info " +
						" where job in ('1','2','3') and academe like :academa" +
						" group by nation",
				resultSetMapping="findByNationGroupMap"),
				
		@NamedNativeQuery(
				name="CardInfo.findByOriginGroup",
				query=" select origin_student groupname, " + 
						" sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall,"+
						" sum((case when (gender='1' and job='1') THEN 1 ELSE 0 END)) sumbachelormale,  sum((case when gender='2' and job='1' THEN 1 ELSE 0 END)) sumbachelorfemale ,sum((case when gender='1' and job='1' THEN 1 ELSE 0 END)+(case when gender='2' and job='1' THEN 1 ELSE 0 END)) sumbachelorall,"+
						" sum((case when (gender='1' and job='2') THEN 1 ELSE 0 END)) summastermale,  sum((case when gender='2' and job='2' THEN 1 ELSE 0 END)) summasterfemale ,sum((case when gender='1' and job='2' THEN 1 ELSE 0 END)+(case when gender='2' and job='2' THEN 1 ELSE 0 END)) summasterall,"+
						" sum((case when (gender='1' and job='3') THEN 1 ELSE 0 END)) sumdoctormale,  sum((case when gender='2' and job='3' THEN 1 ELSE 0 END)) sumdoctorfemale ,sum((case when gender='1' and job='3' THEN 1 ELSE 0 END)+(case when gender='2' and job='3' THEN 1 ELSE 0 END)) sumdoctorall"+
						" from bnu_card.card_info " +
						" where job in ('1','2','3') and academe like :academa" +
						" group by origin_student",
				resultSetMapping="findByNationGroupMap"),
						
		@NamedNativeQuery(
				name="CardInfo.findByGradeGroup",
				query=" select grade groupname, " + 
						" sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall,"+
						" sum((case when (gender='1' and job='1') THEN 1 ELSE 0 END)) sumbachelormale,  sum((case when gender='2' and job='1' THEN 1 ELSE 0 END)) sumbachelorfemale ,sum((case when gender='1' and job='1' THEN 1 ELSE 0 END)+(case when gender='2' and job='1' THEN 1 ELSE 0 END)) sumbachelorall,"+
						" sum((case when (gender='1' and job='2') THEN 1 ELSE 0 END)) summastermale,  sum((case when gender='2' and job='2' THEN 1 ELSE 0 END)) summasterfemale ,sum((case when gender='1' and job='2' THEN 1 ELSE 0 END)+(case when gender='2' and job='2' THEN 1 ELSE 0 END)) summasterall,"+
						" sum((case when (gender='1' and job='3') THEN 1 ELSE 0 END)) sumdoctormale,  sum((case when gender='2' and job='3' THEN 1 ELSE 0 END)) sumdoctorfemale ,sum((case when gender='1' and job='3' THEN 1 ELSE 0 END)+(case when gender='2' and job='3' THEN 1 ELSE 0 END)) sumdoctorall"+
						" from bnu_card.card_info " +
						" where job in ('1','2','3') and academe like :academa" +
						" group by grade",
				resultSetMapping="findByNationGroupMap"),
				
		@NamedNativeQuery(
				name="CardInfo.findByDetainedGradeGroup",
				query=" select grade groupname, " + 
						" sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall,"+
						" sum((case when (gender='1' and job='1') THEN 1 ELSE 0 END)) sumbachelormale,  sum((case when gender='2' and job='1' THEN 1 ELSE 0 END)) sumbachelorfemale ,sum((case when gender='1' and job='1' THEN 1 ELSE 0 END)+(case when gender='2' and job='1' THEN 1 ELSE 0 END)) sumbachelorall,"+
						" sum((case when (gender='1' and job='2') THEN 1 ELSE 0 END)) summastermale,  sum((case when gender='2' and job='2' THEN 1 ELSE 0 END)) summasterfemale ,sum((case when gender='1' and job='2' THEN 1 ELSE 0 END)+(case when gender='2' and job='2' THEN 1 ELSE 0 END)) summasterall,"+
						" sum((case when (gender='1' and job='3') THEN 1 ELSE 0 END)) sumdoctormale,  sum((case when gender='2' and job='3' THEN 1 ELSE 0 END)) sumdoctorfemale ,sum((case when gender='1' and job='3' THEN 1 ELSE 0 END)+(case when gender='2' and job='3' THEN 1 ELSE 0 END)) sumdoctorall"+
						" from bnu_card.card_info " +
						" where job in ('1','2','3') and status='3' and academe like :academa" +
						" group by grade",
				resultSetMapping="findByNationGroupMap"),
				
		@NamedNativeQuery(
				name="CardInfo.findByAcademeGroup",
				query=" select academe groupname, " + 
						" sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall,"+
						" sum((case when (gender='1' and job='4') THEN 1 ELSE 0 END)) sumbachelormale,  sum((case when gender='2' and job='4' THEN 1 ELSE 0 END)) sumbachelorfemale ,sum((case when gender='1' and job='4' THEN 1 ELSE 0 END)+(case when gender='2' and job='4' THEN 1 ELSE 0 END)) sumbachelorall,"+
						" sum((case when (gender='1' and job='5' and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')>=12)) THEN 1 ELSE 0 END)) summastermale,  sum((case when gender='2' and job='5' and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')>=12) THEN 1 ELSE 0 END)) summasterfemale ,sum(case when job='5' and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')>=12) THEN 1 ELSE 0 END) summasterall,"+
						" sum((case when (gender='1' and job='5' and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')<12)) THEN 1 ELSE 0 END)) sumdoctormale,  sum((case when gender='2' and job='5' and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')<12) THEN 1 ELSE 0 END)) sumdoctorfemale ,sum(case when job='5' and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')<12) THEN 1 ELSE 0 END) sumdoctorall"+
						" from bnu_card.card_info " + 
						"  where job='5'" +
						" group by academe"
//						" where (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')<12) " 
						,
				resultSetMapping="findByNationGroupMap"),
				
		@NamedNativeQuery(
				name="CardInfo.findByCardTypeGroup",
				query=" select '教工' groupname, " + 
						"  sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall" + 
						"  from bnu_card.card_info  " + 
						"  where job='4'" + 
						
						"  union " + 

						"  select '家属' groupname, " + 
						"  sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall" + 
						"  from bnu_card.card_info  " + 
						"  where job='5' and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')>12)  " + 

						"  union " + 

						"  select '儿童' groupname, " + 
						"  sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall" + 
						"  from bnu_card.card_info  " + 
						"  where job='5' and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')<12)  " 
						,
				resultSetMapping="findByCardTypeGroupMap"),
		
		@NamedNativeQuery(
				name="CardInfo.findByLessAgeGroup",
				query=" select academe groupname, " + 
						" sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall"+
						" from bnu_card.card_info " +
						"  where job in ('5','4') and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')< :ageTop )  " + 
						" group by academe",
				resultSetMapping="findByCardTypeGroupMap"),
		
		@NamedNativeQuery(
				name="CardInfo.findByGreaterAgeGroup",
				query=" select academe groupname, " + 
						" sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall"+
						" from bnu_card.card_info " +
						"  where job in ('5','4') and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')> :ageLow )  " + 
						" group by academe",
				resultSetMapping="findByCardTypeGroupMap"),
		

		@NamedNativeQuery(
				name="CardInfo.findByBetweenAgeGroup",
				query=" select academe groupname, " + 
						" sum((case when gender='1' THEN 1 ELSE 0 END)) summale,  sum((case when gender='2' THEN 1 ELSE 0 END)) sumfemale ,sum((case when gender='1' THEN 1 ELSE 0 END)+(case when gender='2' THEN 1 ELSE 0 END)) sumall"+
						" from bnu_card.card_info " +
						"  where job in ('5','4') and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')< :ageTop )  " + 
						" and (DATE_FORMAT(SYSDATE(),'%Y')-DATE_FORMAT(birth_day,'%Y')> :ageLow )  " + 
						" group by academe",
				resultSetMapping="findByCardTypeGroupMap"),
				
		@NamedNativeQuery(
				name="CardInfo.findLendReport",
				query=" select (DATE_FORMAT(lend_date,'%Y')) as year, " + 
						" (count(*)) count1 "+
						" from bnu_card.lend_card_info " +
						" group by (DATE_FORMAT(lend_date,'%Y'))",
				resultSetMapping="findLendReturnReport"),		
				
		@NamedNativeQuery(
				name="CardInfo.findReturnReport",
				query=" select (DATE_FORMAT(return_date,'%Y')) as year, " + 
						" (count(*)) count1 "+
						" from bnu_card.return_card_info " +
						" group by (DATE_FORMAT(return_date,'%Y'))",
				resultSetMapping="findLendReturnReport"),		
})


@SqlResultSetMappings({
		@SqlResultSetMapping(
				name="findByNationGroupMap",
				entities={},
				columns={
						 @ColumnResult(name="groupname"),
						 
						 @ColumnResult(name="summale"),
						 @ColumnResult(name="sumfemale"),
						 @ColumnResult(name="sumall"),
						 
						 @ColumnResult(name="sumbachelormale"),
						 @ColumnResult(name="sumbachelorfemale"),
						 @ColumnResult(name="sumbachelorall"),

						 @ColumnResult(name="summastermale"),
						 @ColumnResult(name="summasterfemale"),
						 @ColumnResult(name="summasterall"),

						 @ColumnResult(name="sumdoctormale"),
						 @ColumnResult(name="sumdoctorfemale"),
						 @ColumnResult(name="sumdoctorall")
				}
		),
		@SqlResultSetMapping(
				name="findByCardTypeGroupMap",
				entities={},
				columns={
						 @ColumnResult(name="groupname"),
						 
						 @ColumnResult(name="summale"),
						 @ColumnResult(name="sumfemale"),
						 @ColumnResult(name="sumall")
				}
		),
		@SqlResultSetMapping(
				name="findLendReturnReport",
				entities={},
				columns={
						 @ColumnResult(name="year"),
						 
						 @ColumnResult(name="count1")
				}
		)
})



@Entity
@Table(name = "card_info",catalog="bnu_card")
public class CardInfo  extends IdEntity {
	  private String name;
	  private String memo;
	  private Long creatorId;
	  private String creatorName;
	  private Date createDate;
	  private Long updaterId;
	  private String updaterName;
	  private Date updaterDate;
	  private String status;
	  private String oldName;
	  private String nativePlace;
	  private String cardOwner;
	  private String gender;
	  private String nation;
	  private Date birthDay;
	  private String cardType;//和job重复，通过job进行赋值
	  private String belief;
	  private String identityCard;
	  private Double height;
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

	public String getOldName() {
		return oldName;
	}
	public void setOldName(String oldName) {
		this.oldName = oldName;
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
	
	public Date getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
//		this.cardType = cardType;
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
	public Double getHeight() {
		return height;
	}
	public void setHeight(Double height) {
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
		setStuTeaNumber(address);
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
//		this.grade = grade;由stuTeaNum进行赋值
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
		this.cardType = job;
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
		if(stuTeaNumber!=null){
			
			if(stuTeaNumber.startsWith("0")&&stuTeaNumber.length()>1)
				grade = "20"+ stuTeaNumber.substring(0,2);
			else if(stuTeaNumber.startsWith("19")&&stuTeaNumber.length()>3)
				grade = stuTeaNumber.substring(0,4);
			else if(stuTeaNumber.startsWith("20")&&stuTeaNumber.length()>3)
				grade = stuTeaNumber.substring(0,4);
			else if(!stuTeaNumber.startsWith("19") && !stuTeaNumber.startsWith("20") && stuTeaNumber.length()>1)
				grade = "20"+ stuTeaNumber.substring(0,2);
		}
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
    public boolean equals(Object o) {
        if (!(o instanceof CardInfo)) {
            return false;
        }

        final CardInfo obj = (CardInfo) o;
        
        return obj.id == id;
    }
	
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    }
