package com.hcrud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcrud.bean.Deparment;
import com.hcrud.bean.Msg;
import com.hcrud.service.DepartmentSetvice;

/***
 * 
 * 处理部门crud
 * 
 * @author Administrator
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentSetvice departmentSetvice;

	/**
	 * 
	 * 查询所有部门信息
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Deparment> list = departmentSetvice.getDepts();
		return Msg.success().add("depts", list);
	}
}
