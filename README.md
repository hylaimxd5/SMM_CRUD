# SMM_CRUD
一个简单的SSM项目模板；

EmployeeManagementSystem
这是完整使用SSM框架开发的第一个项目，项目来源于北京动力节点的SSM框架整合教程，

其中加入了一些自己的理解，增加了登录权限控制，使用springMvc HandlerInterceptor；

这个项目总体来说对于新手是很友好的，

涉及到了简单的ajax和jquery处理，UI搭建，后端SSM环境搭建，简单的业务流程设计（使用JSON交互）

使用SSM框架搭建的一个简单的员工信息管理系统，实现了基本的增删改查整个流程



功能分解
查询和分页显示
新增员工信息功能
数据校验，需要校验用户名和邮箱是否合法
前端使用jquery校验，后端使用JSR303
修改员工信息功能
单个删除员工
批量删除员工
使用Rest风格的URI
页面拦截登录权限控制

技术点
基础框架：SpringMVC+Spring+MyBatis
数据库：MySQL
前端框架：BootStrap快速搭建
项目依赖管理：Maven
分页：pagehelper（Mybatis的工具）
逆向工程：MyBatis Generator
