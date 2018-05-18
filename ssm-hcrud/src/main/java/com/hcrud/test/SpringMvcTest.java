package com.hcrud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.hcrud.bean.Employee;

/***
 * 使用SpringTest模块提供的测试请求功能，测试CRUD请求的正确性 Spring4测试的时候需要servlet3.0的支持
 * 
 * @author Administrator
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // 能注入springMvc web容器本身
@ContextConfiguration(locations = { "classpath:applicationContext.xml", "classpath:spring-mvc.xml" })
public class SpringMvcTest {
	// 传入SpringMvc的IOC
	@Autowired
	WebApplicationContext context;
	// 虚拟MVC类，获取处理结果
	MockMvc mockMvc;

	// 初始化
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();

	}

	@Test
	public void TestPage() throws Exception {
		// 模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "112")).andReturn();
		// 请求成功后Controller返回的pageInfo，来验证数据
		// 获取请求对象
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageinfo");
		// 获取pageinfo信息进行验证
		System.out.println("当前页码：" + pageInfo.getPageNum());
		System.out.println("总页码：" + pageInfo.getPages());
		System.out.println("总记录数：" + pageInfo.getTotal());
		System.out.println("页面连续显示的页码:");
		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.print("   " + i);
		}
		// 验证员工信息

		System.out.println("");
		List<Employee> list = pageInfo.getList();
		for (Employee employee : list) {
			System.out.println("ID:" + employee.getEmpId() + "==>" + "NAME：" + employee.getEmpName());
		}
	}
}
