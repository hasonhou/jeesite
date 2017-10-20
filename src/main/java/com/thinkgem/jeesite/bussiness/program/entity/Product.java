package com.thinkgem.jeesite.bussiness.program.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class Product extends DataEntity<Product> {

	/**  */
	private static final long serialVersionUID = 1L;

	private String proName;  //产品名称
	private String proSupplier; //产品厂家
	private String memo; //产品描述
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getProSupplier() {
		return proSupplier;
	}
	public void setProSupplier(String proSupplier) {
		this.proSupplier = proSupplier;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}

	
}
