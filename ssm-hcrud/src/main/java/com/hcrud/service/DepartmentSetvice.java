package com.hcrud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcrud.bean.Deparment;
import com.hcrud.dao.DeparmentMapper;

/***
 * 部门业务处理
 * @author Administrator
 *
 */
@Service
public class DepartmentSetvice {
	@Autowired
	private DeparmentMapper deparmentMapper ;
	
	//返回所有部门信息
	public List<Deparment> getDepts() {
		List<Deparment> list =deparmentMapper.selectByExample(null);
		return list;
	}
	
	
}
