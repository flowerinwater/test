package com.test.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "bill_detail")
public class BillDetail extends IdEntity {
	private int orderNumber;
	private double unitPrice;
	private double increaseQuantity;
	private double decreaseQuantity;
	private String memo;
	
	private Product product;
	
	public BillDetail() {
	}

	public BillDetail(Long id) {
		this.id = id;
	}

	@OneToOne
	@JoinColumn(name ="product_id")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	@Transient
	public long getProductId() {
		return product!=null?product.getId():0;
	}
	
	@Transient
	public String getProductName() {
		return product!=null?product.getName():"";
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