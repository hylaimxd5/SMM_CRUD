<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="button" onclick="JQUER.login();"/>
<script type="text/javascript">
// jquery 封装函数 ，使用 onclick 调用， 内部可互相调用 ,使用boolean控制流程
//做校验需要添加随机数，【get请求 ，相同的请求会被浏览器缓存， 导致校验结果一直相同】
	var JQUER = {
			login:function(){
				
				return false ;
			},
			regetis:function(){
				
				return false ;
			},submit:function(){
				
				return false ;
			}
			
			
			
	}
</script>
</body>
</html>