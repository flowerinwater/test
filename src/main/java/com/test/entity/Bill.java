package com.test.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "bill")
public class Bill extends IdEntity {
	private String billCode;
	private String contractId;
	private Date businessDate;
	private Date warehouseDate;
	private double amount;
	private String memo;
	private Customer customer;
	private User salesPerson;
	private User warehouseKeeper;
	
	private List<BillDetail> billItems;
	
	public Bill() {
	}

	public Bill(Long id) {
		this.id = id;
	}
	
	@OneToMany(targetEntity=BillDetail.class,cascade={CascadeType.ALL})
	@JoinColumn(name="bill_id")  
	public List<BillDetail> getBillItems() {
		return billItems;
	}

	public void setBillItems(List<BillDetail> billItems) {
		this.billItems = billItems;
	}

	@OneToOne
	@JoinColumn(name ="customer_id")
	public Customer getCustomer() {
		return customer;
	}


	@OneToOne
	@JoinColumn(name ="sales_person_id")
	public User getSalesPerson() {
		return salesPerson;
	}
	
	@OneToOne
	@JoinColumn(name ="warehouse_keeper_id")
	public User getWarehouseKeeper() {
		return warehouseKeeper;
	}


	@Transient
	public long getCustomerId() {
		return customer!=null?customer.getId():0;
	}
	
	@Transient
	public String getCustomerName() {
		return customer!=null?customer.getShortName():"";
	}

	
	@Transient
	public long getSalesPersonId() {
		return salesPerson!=null?salesPerson.getId():0;
	}
	
	@Transient
	public String getSalesPersonName() {
		return salesPerson!=null?salesPerson.getFullName() + "[" + salesPerson.getLoginName() + "]":"";
	}
	
	@Transient
	public long getWarehouseKeeperId() {
		return warehouseKeeper!=null?warehouseKeeper.getId():0;
	}
	
	@Transient
	public String getWarehouseKeeperName() {
		return warehouseKeeper!=null?warehouseKeeper.getFullName() + "[" + warehouseKeeper.getLoginName() + "]":"";
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getBusinessDate() {
		return businessDate;
	}

	public void setBusinessDate(Date businessDate) {
		this.businessDate = businessDate;
	}


	public String getBillCode() {
		return billCode;
	}

	public void setBillCode(String billCode) {
		this.billCode = billCode;
	}

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getWarehouseDate() {
		return warehouseDate;
	}

	public void setWarehouseDate(Date warehouseDate) {
		this.warehouseDate = warehouseDate;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public void setSalesPerson(User salesPerson) {
		this.salesPerson = salesPerson;
	}

	public void setWarehouseKeeper(User warehouseKeeper) {
		this.warehouseKeeper = warehouseKeeper;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}