package com.hcrud.bean;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/***
 * 登录检查拦截器
 * @author Administrator
 *
 */
public class LoginHandlerInterCeptor implements HandlerInterceptor {
	/*
	 * (non-Javadoc)模型对象处理（Handler）调用Controller执行前
	 * @see org.springframework.web.servlet.HandlerInterceptor#preHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object)
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		//获取session
		Object name=request.getSession().getAttribute("userInfo");
		//获取去掉协议+IP域名+端口 的请求
		String uri = request.getServletPath();
		System.out.println("获取session:"+name);
		if(name==null){
				System.out.println(uri+"请求被拦截");
				//arg0.getRequestDispatcher("/login").forward(arg0, arg1);
				//跳转到登录页面 传递拦截的url  页面js作回调
				response.sendRedirect("/ssm-hcrud/login?redirect="+request.getRequestURL());
				return false;
		}else{
			return true;
		}
		
	}


	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}


	
}
