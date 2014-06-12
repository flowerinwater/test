package com.test.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "product")
@Indexed(index = "Product")
public class Product extends IdEntity {
	private String name;
	private String tradeMark;
	private String productType;
	private String model;
	private Date createDate;
	private double cost;
	private double unitPrice;
	private long allowance;
	private double allowancePrice;
	private String unit;
	private String memo;

	private Customer supplier;
	private User createUser;
	
	public Product() {
	}

	public Product(Long id) {
		this.id = id;
	}
		
	@Transient  
	@Field(index=Index.YES)  
	public String getContent() {  
	return  this.name+" "+this.tradeMark+" "+this.model + " " + memo;  
	}  
	
	@OneToOne
	@JoinColumn(name ="supplier_id")
	public Customer getSupplier() {
		return supplier;
	}

	public void setSupplier(Customer supplier) {
		this.supplier = supplier;
	}

	@OneToOne
	@JoinColumn(name ="create_user_id")
	public User getCreateUser() {
		return createUser;
	}

	public void setCreateUser(User createUser) {
		this.createUser = createUser;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTradeMark() {
		return tradeMark;
	}

	public void setTradeMark(String tradeMark) {
		this.tradeMark = tradeMark;
	}

	@Transient
	public long getSupplierId() {
		return supplier!=null?supplier.getId():0;
	}
	
	@Transient
	public String getSupplierName() {
		return supplier!=null?supplier.getShortName():"";
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Transient
	public long getCreateUserId() {
		return createUser!=null?createUser.getId():0;
	}
	
	@Transient
	public String getCreateUserName() {
		return createUser!=null?createUser.getFullName() + "[" + createUser.getLoginName() + "]":"";
	}

	public double getCost() {
		return cost;
	}

	public void setCost(double cost) {
		this.cost = cost;
	}

	@Field(index=Index.YES)
	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public long getAllowance() {
		return allowance;
	}

	public void setAllowance(long allowance) {
		this.allowance = allowance;
	}

	public double getAllowancePrice() {
		return allowancePrice;
	}

	public void setAllowancePrice(double allowancePrice) {
		this.allowancePrice = allowancePrice;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}