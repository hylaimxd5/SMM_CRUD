


<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>员工列表页面</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- 
以../开始相对路径，是以当前文件为标准，容易出问题
以/开始的相对路径，是以服务器的路径为标准(http://localhost:8080) 需要加上项目名
http://localhost:8080/ssm-crud/
 -->
<!-- 记住 必须先加载js  再加载bootstrap 的js -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
	<form class="form-inline" id="userform">
		<div class="form-group">
			<label class="sr-only" for="exampleInputEmail3">Email address</label>
			<input type="text" class="form-control" id="username"  name="name"
				placeholder="name">
		</div>
		<div class="form-group">
			<label class="sr-only" for="exampleInputPassword3">Password</label> <input
				type="password" class="form-control" id="pwd"    name="pwd"
				placeholder="Password">
		</div>
		
		<a class="btn btn-default" href="javascript:void(0)"  id="loginsubmit" role="button">login</a>
	</form>
<script type="text/javascript">
var redirectUrl ="${redirect}";
var LOGIN ={
		checkInput : function(){
			if($("#username").val()==""){
				alert("用户名不能为空");
				$("#username").focus();
				return false;
			}
			if($("#pwd").val()==""){
				alert("密码不能为空")
				$("#pwd").focus();
				return false;
			}
			
			return true ;
		},
		doLogin : function(){
			$.ajax({
				url:"${APP_PATH}/userLogin",
				data:$("#userform").serialize(),
				type:"POST",
				success : function(retult){
					if(retult.code==100){
						alert("登录成功");
						if(redirectUrl==""){
							location.href="http://localhost:8080${APP_PATH}/";
						}else{
							location.href=redirectUrl;
						}
					}else{
						alert(retult.hylmsg);
					}
				},error : function(){
					alert("服务器未响应")
				}
			})
		},
		login : function(){
			if(this.checkInput()){
				LOGIN.doLogin();
			}
		}
		
}
$("#loginsubmit").click(function(){
	LOGIN.login();
	
	
})
</script>
</body>
</html>