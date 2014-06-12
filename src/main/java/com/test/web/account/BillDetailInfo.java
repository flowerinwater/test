package com.test.web.account;

public class BillDetailInfo{
	private long id;
	private int orderNumber;
	private double unitPrice;
	private double increaseQuantity;
	private double decreaseQuantity;
	private String memo;
	private long productId;
	private String productName;
	
	public BillDetailInfo() {
	}

	public BillDetailInfo(Long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(int orderNumber) {
		this.orderNumber = orderNumber;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public double getIncreaseQuantity() {
		return increaseQuantity;
	}

	public void setIncreaseQuantity(double increaseQuantity) {
		this.increaseQuantity = increaseQuantity;
	}

	public double getDecreaseQuantity() {
		return decreaseQuantity;
	}

	public void setDecreaseQuantity(double decreaseQuantity) {
		this.decreaseQuantity = decreaseQuantity;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}