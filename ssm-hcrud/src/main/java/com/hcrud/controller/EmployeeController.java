package com.hcrud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hcrud.bean.Employee;
import com.hcrud.bean.Msg;
import com.hcrud.bean.User;
import com.hcrud.service.EmployeeService;

/***
 * 处理员工EMP CRUD请求
 * 
 * @author Administrator 使用JSR303 需要hibernate - validator包支持
 */
@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping("/handler")
	public String showHandlerTest(){
		return"handlerTest";
	}

	/***
	 * 登录页面
	 * @return
	 */
	@RequestMapping("/login")
	public String showLgoin(String redirect,Model model){
		model.addAttribute("redirect",redirect);
		return "login";
	}
	
	@ResponseBody
	@RequestMapping(value="/userLogin",method=RequestMethod.POST)
	public Msg Userlogin(User user,HttpServletRequest request){
		if(user.getName()!=""&&user.getPwd()!=""){
			request.getSession().setAttribute("userInfo", user.getName());
			return Msg.success();
		}else{
			return Msg.fail().add("hylmsg", "用户名或者密码错误");
		}
	}

	/***
	 * 员工单个+批量删除 多个ID：1-2-3-4-5-6 单个ID：1
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	public Msg DelEmps(@PathVariable("ids") String ids) {
		// 判断ids是否存在-
		if (ids.contains("-")) {
			List<Integer> empid_list = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String strid : str_ids) {
				empid_list.add(Integer.parseInt(strid));
			}
			employeeService.deleteBatch(empid_list);
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.delempbyid(id);
		}

		return Msg.success();
	}

	/***
	 * 根据ID删除员工 需要改造删除方法 单个+批量删除 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 【此方法不再使用】
	 */
	@ResponseBody
	// @RequestMapping( value="/emp/{id}",method=RequestMethod.DELETE)
	public Msg DelEmpByid(@PathVariable("id") Integer id) {
		employeeService.delempbyid(id);
		return Msg.success();
	}

	/***
	 * 查询所有员工 +部门 、使用JSON返回 使用ResponseBody 需要jackson包
	 * 
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {

		// 引入PageHelper分页插件
		// 在查询之前只需要调用 (Param 开始页 ，每页多少条)
		PageHelper.startPage(pn, 5);
		// starPage后面紧跟的查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageinfo包装查询后，只需要将pageinfo交给页面
		// PageInfo包括详细的分页信息 Param (数据集，连续显示的页码)
		PageInfo page = new PageInfo(emps, 5);

		return Msg.success().add("pageinfo", page);
	}

	/**
	 * 查询员工数据（分页查询） 旧【不再使用】 Model不支持移动端界面显示 所以改用 JSON @ResponseBody 返回
	 * ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	 * 
	 * @return
	 */
	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 引入PageHelper分页插件
		// 在查询之前只需要调用 (Param 开始页 ，每页多少条)
		PageHelper.startPage(pn, 5);
		// starPage后面紧跟的查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageinfo包装查询后，只需要将pageinfo交给页面
		// PageInfo包括详细的分页信息 Param (数据集，连续显示的页码)
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageinfo", page);
		return "list";
	}

	/***
	 * ID查询员工
	 * 
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	/***
	 * 用户名校验
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName") String empName) {
		// 先判断格式
		String regex = "(^[A-Za-z0-9]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)";
		if (!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "用户名必须6-16位字母或者2-5位中文。");
		}
		// 数据库校验
		boolean b = employeeService.checkuser(empName);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}

	/***
	 * 员工添加方法 POST方式为添加
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldErrorr : errors) {
				System.out.println("错误的字段" + fieldErrorr.getField());
				System.out.println("错误信息" + fieldErrorr.getDefaultMessage());
				map.put(fieldErrorr.getField(), fieldErrorr.getDefaultMessage());
			}
			return Msg.fail().add("errorfields", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}

	/***
	 * 1.如果是put请求 ，tomcat只会将post求情的数据封装成map，然后springMvc封装POJO对象，中每个属性值
	 * 调用request.getParamter("pojo.XXX") 2.所以PUT请求不能直接发送.
	 * 
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}

}
