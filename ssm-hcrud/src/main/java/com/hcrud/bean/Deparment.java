package com.hcrud.bean;

public class Deparment {
	private Integer deptId;

	private String deptName;

	public Deparment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Deparment(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName == null ? null : deptName.trim();
	}
}