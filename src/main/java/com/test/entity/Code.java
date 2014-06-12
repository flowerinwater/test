package com.test.entity;


import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;


@Entity
@Table(name = "code")
public class Code extends IdEntity {
	private String codeType;
	private String codeValue;
	private String codeName;

	public Code() {
	}

	public Code(Long id) {
		this.id = id;
	}
	
	
	
	
	public String getCodeType() {
		return codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	public String getCodeValue() {
		return codeValue;
	}

	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}