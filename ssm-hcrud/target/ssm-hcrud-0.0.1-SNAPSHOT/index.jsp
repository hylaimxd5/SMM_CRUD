<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员登录页面</title>
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
	<div class="container-fluid">
		<div class="jumbotron">
			<h1>Hello, world!</h1>
			<form class="form-inline" >
				<div class="form-group">
					<input type="text" class="form-control" name="name" placeholder="name">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name="pwd" placeholder="Password">
				</div>
				<button  class="btn btn-default">Sign in</button>
			</form>
		</div>
	</div>

</body>
</html>