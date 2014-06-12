package com.test.web.account;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BillInfo {
	private long id;
	private String billCode;
	private String contractId;
	private Date businessDate;
	private Date warehouseDate;
	private double amount;
	private String memo;
	private long customerId;
	private String customerName;
	private long salesPersonId;
	private String salesPersonName;
	private long warehouseKeeperId;
	private String warehouseKeeperName;
	
	private List<BillDetailInfo> billItems;
	
	public BillInfo() {
	}

	public BillInfo(Long id) {
		this.id = id;
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}


	public long getSalesPersonId() {
		return salesPersonId;
	}

	public void setSalesPersonId(long salesPersonId) {
		this.salesPersonId = salesPersonId;
	}

	public String getSalesPersonName() {
		return salesPersonName;
	}

	public void setSalesPersonName(String salesPersonName) {
		this.salesPersonName = salesPersonName;
	}

	public long getWarehouseKeeperId() {
		return warehouseKeeperId;
	}

	public void setWarehouseKeeperId(long warehouseKeeperId) {
		this.warehouseKeeperId = warehouseKeeperId;
	}

	public String getWarehouseKeeperName() {
		return warehouseKeeperName;
	}

	public void setWarehouseKeeperName(String warehouseKeeperName) {
		this.warehouseKeeperName = warehouseKeeperName;
	}

	public List<BillDetailInfo> getBillItems() {
		return billItems;
	}

	public void setBillItems(List<BillDetailInfo> billItems) {
		this.billItems = billItems;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
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

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}