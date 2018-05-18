package com.hcrud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hcrud.bean.Employee;
import com.hcrud.dao.DeparmentMapper;
import com.hcrud.dao.EmployeeMapper;

/***
 * 测试DAO是否能操作到数据库
 * 
 * @author Administrator
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {
	/**
	 * 测试DepartmentMapper 使用Spring 的单元测试，可以自动注入需要的组件 1.导入SpringTest包
	 * 2.使用@ContextConfiguration指定spring配置文件位置
	 * 3.使用junit的@RunWith指定测试使用的模块，指定为Spring的测试模块 4.直接使用@Autowired要使用的组件即可
	 */
	// 测试部门mapper
	@Autowired
	DeparmentMapper deparmentmapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlsession;

	@Test
	public void TestCrud() {
		/*
		 * 传统测试方法 1.创建spring ioc容器 ApplicationContext ioc =new
		 * ClassPathXmlApplicationContext("applicationContext.xml");
		 * 2.从容器中获取mapper ioc.getBean(DeparmentMapper.class);
		 */
		// System.out.println(deparmentmapper);
		// 1.插入几个部门
		// deparmentmapper.insertSelective(new Deparment(null,"开发部s"));
		// deparmentmapper.insertSelective(new Deparment(null,"测试部s"));
		// 2.插入员工数据
		// employeeMapper.insertSelective(new
		// Employee(null,"aben","M","aben@me.com",3));

		// 批量插入员工数据 使用可是执行批量操作的 sqlSession
		EmployeeMapper mapper = sqlsession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", uid + "@me.com", 4));
		}
		System.out.println("SUCCESS");
	}
}
