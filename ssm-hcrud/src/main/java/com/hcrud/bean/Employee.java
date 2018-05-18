package com.hcrud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
	private Integer empId;
	@Pattern(regexp = "(^[A-Za-z0-9]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)", message = "用户名必须6-16位字母或者2-5位中文。JSR303")
	private String empName;

	private String gender;

	@Pattern(regexp = "^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+", message = "邮箱格式不正确JSR303")
	private String email;

	private Integer dId;

	// 查询员工同时，部门信息也是附带查询好的
	private Deparment deparment;

	public Employee() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Deparment getDeparment() {
		return deparment;
	}

	public void setDeparment(Deparment deparment) {
		this.deparment = deparment;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName == null ? null : empName.trim();
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender == null ? null : gender.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public Integer getdId() {
		return dId;
	}

	public void setdId(Integer dId) {
		this.dId = dId;
	}
}