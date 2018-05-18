package com.hcrud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcrud.bean.Employee;
import com.hcrud.bean.EmployeeExample;
import com.hcrud.bean.EmployeeExample.Criteria;
import com.hcrud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工+部门信息
	 * 
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		example.setOrderByClause("e.emp_id ASC");
		return employeeMapper.selectByExampleWithDept(example);
	}

	/**
	 * 员工添加
	 * 
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);

	}

	/**
	 * 检验用户面
	 * 
	 * @param empName
	 */
	public boolean checkuser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 查询单个用户
	 * 
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/***
	 * 员工更新
	 * 
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);

	}

	/**
	 * 员工ByID删除
	 * 
	 * @param id
	 */
	public void delempbyid(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);

	}

	/**
	 * 员工批量删除
	 * 
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		// 实例化实体的example(条件)对象
		EmployeeExample example = new EmployeeExample();
		// 创建条件Criteria : where =
		Criteria createCriteria = example.createCriteria();
		// 选则andEmpIdIn : empId in (List) ;
		createCriteria.andEmpIdIn(ids);
		// 删除 deleteByExample : delete from Employee
		employeeMapper.deleteByExample(example);

	}

}
