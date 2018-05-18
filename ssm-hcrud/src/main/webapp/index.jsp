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
	<!-- 添加Modal -->
	<div class="modal fade" id="myMobal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工 添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">Name</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="name"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@me.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">DName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select">

								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">退出</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 修改Modal -->
	<div class="modal fade" id="empUpdateMobal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工 修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">Name</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@me.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">DName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_select">

								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">退出</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12" id="crud_index">
				<h1>员工信息管理-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-9">
				<a class="btn btn-default" href="${APP_PATH}/login" role="button">LOGIN<%=session.getAttribute("userInfo")%></a>
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_del_all_btn">删除</button>
			</div>
		</div>

		<!-- 数据表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>Name</th>
							<th>Gender</th>
							<th>Email</th>
							<th>DeptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
			</div>

		</div>
		<!-- 分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>

			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav_area"></div>


		</div>
	</div>



	<script type="text/javascript">
		//全局总记录数变量
		var totalRecount, currentPage;
		//1、页面加载完毕发送ajax /emps 获得数据。
		$(function() {
			to_page(1);
			console.log($.session);
		});

		//页码跳转
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//1、解析并且显示员工数据
					build_emps_table(result);
					//2、解析并且显示分页信息
					build_emps_info(result);
					//3、解析并且显示分页条
					build_emps_nav(result);
				},
				error : function() {
					alert("服务器未响应，请稍后再试。")
				}
			});
		}

		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			//员工数据
			var emps = result.extend.pageinfo.list;
			$
					.each(
							emps,
							function(index, item) {
								var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>")
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var empgenderTd = $("<td></td>").append(
										item.gender == 'M' ? "男" : "女");
								var empEmailTd = $("<td></td>").append(
										item.email);
								var deptNameTd = $("<td></td>").append(
										item.deparment.deptName);
								var editbtn = $("<button></button>")
										.addClass(
												"btn btn-primary btn-sm edit_btn ")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil"))
										.append("编辑");
								//添加一个自定义属性标识ID
								editbtn.attr("edit_id", item.empId);
								var delbtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn ")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-remove"))
										.append("删除");
								delbtn.attr("del_id", item.empId);
								var btntd = $("<td></td>").append(editbtn)
										.append(" ").append(delbtn)
								$("<tr></tr>").append(checkBoxTd).append(
										empIdTd).append(empNameTd).append(
										empgenderTd).append(empEmailTd).append(
										deptNameTd).append(btntd).appendTo(
										$("#emps_table tbody"));
							})

		}
		//解析显示分页信息
		function build_emps_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageinfo.pageNum + " 页，总共"
							+ result.extend.pageinfo.pages + " 页，总共"
							+ result.extend.pageinfo.total + " 条记录")
			totalRecount = result.extend.pageinfo.total;
			currentPage = result.extend.pageinfo.pageNum;
		}
		//解析显示分页条
		function build_emps_nav(result) {
			$("#page_nav_area").empty();
			var nav = $("<nav></nav>").addClass("Page navigation");
			var ul = $("<ul></ul>").addClass("pagination ");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href",
							"javascript:void(0);"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href",
							"javascript:void(0);"));
			//禁用样式
			if (!result.extend.pageinfo.hasPreviousPage) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//添加翻页
				firstPageLi.click(function() {
					to_page(1);
				})
				prePageLi.click(function() {
					to_page(result.extend.pageinfo.pageNum - 1);
				})
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href",
							"javascript:void(0);"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href",
							"javascript:void(0);"));
			//禁用样式
			if (!result.extend.pageinfo.hasNextPage) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				//添加翻页
				nextPageLi.click(function() {
					to_page(result.extend.pageinfo.pageNum + 1);
				})

				lastPageLi.click(function() {
					to_page(result.extend.pageinfo.pages);
				})
			}

			//添加首页、前一页
			ul.append(firstPageLi).append(prePageLi);
			//获取连续页码
			var navNum = result.extend.pageinfo.navigatepageNums;
			//迭代添加页码
			$.each(navNum, function(index, item) {
				var pageLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href",
								"javascript:void(0);"));
				if (result.extend.pageinfo.pageNum == item) {
					pageLi.addClass("active");
				}
				//添加单击事件
				pageLi.click(function() {
					to_page(item);
				});
				//添加页码
				ul.append(pageLi);
			});
			//添加后一页、末页
			ul.append(nextPageLi).append(lastPageLi);
			//nav包含ul，添加到page_nav_area
			nav.append(ul).appendTo("#page_nav_area");
		}
		//表单重置
		function reset_form(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		//新增按钮
		$("#emp_add_modal_btn").click(function() {
			//初始化表单
			reset_form("#myMobal form");
			//AJAX获得部门信息，显示下拉列表
			getDepts("#dept_add_select");
			//弹出模态框
			$("#myMobal").modal({
				backdrop : true
			})
		});
		//获得部门信息
		function getDepts(ele) {
			//先清除
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//生成下拉列表
					//$("#dept_add_select").append("<option></option>")
					$("#dept_add_select").empty();
					$.each(result.extend.depts, function() {
						//this代表当前迭代的对象
						var deptOption = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						deptOption.appendTo(ele);
					})
				}
			});
		}

		//抽取校验方法
		function show_validate_msg(ele, status, msg) {
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if (status == "success") {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if (status == "error") {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);

			}

		}
		//ajax = empName校验
		$("#empName_add_input").change(
				function() {
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + empName,
						type : "GET",
						success : function(result) {
							if (result.code == 100) {
								show_validate_msg("#empName_add_input",
										"success", "用户名可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							} else {
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_save_btn").attr("ajax-va", "error");
							}
						}
					})
				});

		//email校验
		$("#email_add_input")
				.change(
						function() {
							var email = this.value;
							var regemail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
							if (!regemail.test(email)) {
								show_validate_msg("#email_add_input", "error",
										"邮箱格式不正确");
								$("#emp_save_btn").attr("ajax-va", "error");
							} else {
								show_validate_msg("#email_add_input",
										"success", "邮箱可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							}
						});

		//emp_save_btn添加员工
		$("#emp_save_btn")
				.click(
						function() {
							//判断用户名校验是否成功
							if ($(this).attr("ajax-va") == "error") {
								return false;
							}

							var emp = $("#myMobal form").serialize();
							$
									.ajax({
										url : "${APP_PATH}/emp",
										type : "POST",
										data : emp,
										success : function(result) {
											if (result.code == 100) {
												//保存成功后 ，1.关闭模态框 。
												$("#myMobal").modal("hide");
												//2、查询最后一页 ，动态生成
												to_page(totalRecount);
											} else {
												if (undefined != result.extend.errorfields.empName) {
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.extend.errorfields.empName);
												}
												if (undefined != result.extend.errorfields.email) {
													show_validate_msg(
															"#email_add_input",
															"error",
															result.extend.errorfields.email);
												}
											}
										}
									});
						})

		//员工更新按钮
		//因为是动态生成的input，提前绑定不到，
		//使用.live() 绑定  新版没有live就用on代替
		$(document).on("click", ".edit_btn", function() {
			//1.查询部门信息和员工信息 
			getDepts("#dept_update_select");
			getEmp($(this).attr("edit_id"));
			//2.弹出模态框
			//传递ID给更新按钮模态框
			$("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
			//弹出模态框//初始化表单
			$("#empUpdateMobal").modal({
				backdrop : true
			})
		});

		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					var empdate = result.extend.emp;
					$("#empName_update").text(empdate.empName);
					$("#email_update_input").val(empdate.email);
					//传入数组 自动选中
					$("#empUpdateMobal input[name=gender]").val(
							[ empdate.gender ]);
					$("#empUpdateMobal select").val([ empdate.dId ]);
				}
			});
		}

		//员工修改ajax
		$("#emp_update_btn")
				.click(
						function() {
							//重置表单

							//检验邮箱
							var email = $("#email_update_input").val();
							var regemail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
							if (!regemail.test(email)) {
								show_validate_msg("#email_update_input",
										"error", "邮箱格式不正确");
								return false;
							} else {
								show_validate_msg("#email_update_input",
										"success", "邮箱可用");
							}
							//发送ajax 保存更新
							$.ajax({
								url : "${APP_PATH}/emp/"
										+ $(this).attr("edit_id"),
								type : "PUT",
								data : $("#empUpdateMobal form").serialize(),
								success : function(result) {
									//1关闭模态框
									$("#empUpdateMobal").modal("hide");
									//2跳转当前页(刷新数据)
									to_page(currentPage);
								}
							})

						});
		//员工单个删除
		$(document).on("click", ".delete_btn", function() {
			//弹出删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text()
			var empId = $(this).attr("del_id");
			if (confirm("确认删除【" + empName + "】吗？")) {
				//确认
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						alert(result.msg);
						to_page(currentPage);
					}
				})
			}
		});
		//全选check
		$("#check_all").click(function() {
			$(".check_item").prop("checked", $(this).prop("checked"));
		})
		//check_item 选中
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							//判断当前选中check item是否选满
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});

		//批量删除点击
		$("#emp_del_all_btn").click(
				function() {
					//获取所有选中按钮的empName
					var empNames = "";
					var ids = "";
					//遍历姓名提示
					$.each($(".check_item:checked"), function() {
						empNames += $(this).parents("tr").find("td:eq(2)")
								.text()
								+ ",";
						//组装ID用于删除 使用后台约定 - 进行分割 
						ids += $(this).parents("tr").find("td:eq(1)").text()
								+ "-";
					})
					//非空判断
					if (empNames.length <= 0) {
						alert("未选中");
						return false;
					}
					//去除多余的逗号和-
					empNames = empNames.substring(0, empNames.length - 1);
					ids = ids.substring(0, ids.length - 1);

					if (confirm("确认删除【" + empNames + "】吗？")) {
						$.ajax({
							url : "${APP_PATH}/emp/" + ids,
							type : "DELETE",
							success : function(result) {
								alert(result.msg);
								to_page(currentPage);
							}
						});
					}
					;
				})
		//回到首页
		$("#crud_index").click(function() {
			to_page(1);
		})
	</script>
</body>
</html>