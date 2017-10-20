package com.thinkgem.jeesite.bussiness.program.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class Materials extends DataEntity<Materials> {

	/**  */
	private static final long serialVersionUID = 1L;
	private String cellName; //细胞名称
	private String patientSample; //病人标本
	private String biologySample; //生物标本
	public String getCellName() {
		return cellName;
	}
	public void setCellName(String cellName) {
		this.cellName = cellName;
	}
	public String getPatientSample() {
		return patientSample;
	}
	public void setPatientSample(String patientSample) {
		this.patientSample = patientSample;
	}
	public String getBiologySample() {
		return biologySample;
	}
	public void setBiologySample(String biologySample) {
		this.biologySample = biologySample;
	}
	
	

}
