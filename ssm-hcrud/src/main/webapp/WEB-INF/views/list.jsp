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
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>员工信息管理-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 数据表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Email</th>
						<th>DeptName</th>
						<th>操作</th>
					</tr>

					<c:forEach items="${pageinfo.list}" var="emp">
						<tr>
							<th>${emp.empId}</th>
							<th>${emp.empName}</th>
							<th>${emp.gender=="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.deparment.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyohicon-pencil"></span> 编辑
								</button>
								<button class="btn btn-danger  btn-sm">
									<span class="glyphicon glyohicon-trash"></span> 删除
								</button>
							</th>
						</tr>
					</c:forEach>


				</table>
			</div>

		</div>
		<!-- 分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">当前${pageinfo.pageNum }页，总共${pageinfo.pages }页，总共${pageinfo.total }条记录
			</div>

			<!-- 分页条 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">
				
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					
					<c:if test="${pageinfo.hasPreviousPage }">
						<li><a href="${APP_PATH}/emps?pn=${pageinfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach items="${pageinfo.navigatepageNums}" var="page_num">
						<c:if test="${page_num==pageinfo.pageNum}">
							<li class="active"><a href="#">${page_num }</a></li>
						</c:if>
						<c:if test="${page_num!=pageinfo.pageNum}">
							<li><a href="${APP_PATH}/emps?pn=${page_num }">${page_num }</a></li>
						</c:if>
					</c:forEach>

					<c:if test="${pageinfo.hasNextPage }">
						<li><a href="${APP_PATH}/emps?pn=${pageinfo.pageNum+1}" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>

					<li><a href="${APP_PATH}/emps?pn=${pageinfo.pages}">末页</a></li>
				</ul>
				</nav>
			</div>

		</div>
	</div>

</body>
</html>