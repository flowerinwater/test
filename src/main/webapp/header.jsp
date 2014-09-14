<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.apache.shiro.subject.Subject"%>
<%@ page import="javax.servlet.ServletContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.bnu.card.service.LendCardService"%>
<%@ page import="com.bnu.card.service.SysUserService"%>
<%@ page import="com.bnu.card.entity.SysUser"%>
<%@ page import="com.bnu.card.service.ShiroDbRealm.ShiroUser"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<%
	ServletContext sc = pageContext.getServletContext();
	ApplicationContext ac1 = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
	LendCardService lendCardService = (LendCardService)ac1.getBean("lendCardService");
	List l = lendCardService.getLendCardExpireAlert(10);
	boolean hasAlert = l.size()>0;	
	
	Subject subject = SecurityUtils.getSubject();
	ShiroUser user = (ShiroUser)subject.getPrincipal();
	SysUserService sysUserService = (SysUserService)ac1.getBean("sysUserService");
	SysUser su = sysUserService.findOneSysUserByLoginName(user.loginName);

	String role = "";
	try{
		subject.checkRole("AD");
		role = "AD";
	}catch(Exception e){
	}

	if(role.equals("")){
		try{
			subject.checkRole("L1");
			role = "L1";
		}catch(Exception e){
		}
	}

	if(role.equals("")){
		try{
			subject.checkRole("L2");
			role = "L2";
		}catch(Exception e){
		}
	}

	System.out.println("---------------------:" + role);
%>

	<head>
		<meta charset="utf-8" />
		<title> <%=path1%> - <%=path2%> </title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- basic styles -->
		<link href="${ctx}/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${ctx}/assets/css/font-awesome.min.css" />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="${ctx}/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!-- page specific plugin styles -->
		
		<link rel="stylesheet" href="${ctx}/assets/css/jquery-ui-1.10.3.full.min.css"/>
		<link rel="stylesheet" href="assets/css/datepicker.css" />
		<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
		
		<!-- ace styles -->

		<link rel="stylesheet" href="${ctx}/assets/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="${ctx}/assets/css/ace-skins.min.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->

		<script src="${ctx}/assets/js/ace-extra.min.js"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="${ctx}/assets/js/html5shiv.js"></script>
		<script src="${ctx}/assets/js/respond.min.js"></script>
		<![endif]-->
	</head>


	<body>
		<div class="navbar navbar-default" id="navbar">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand">
						<small>
							<i class="icon-leaf"></i>
							户籍管理系统
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						
						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="assets/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									<small>欢迎光临,</small>
									<%=su.getName()%>[<%=su.getLoginName()%>]
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								
								<li>
									<a href="main4_changepass.jsp">
										<i class="icon-user"></i>
										修改密码
									</a>
								</li>

								<li class="divider"></li>

								<li>
									<a href="/test/logout">
										<i class="icon-off"></i>
										退出
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div><!-- /.navbar-header -->
			</div><!-- /.container -->
		</div>
		
		
				<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#">
					<span class="menu-text"></span>
				</a>

				<div class="sidebar" id="sidebar">
					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
					</script>

					<div class="sidebar-shortcuts" id="sidebar-shortcuts">
						<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
							<button class="btn btn-success">
								<i class="icon-signal"></i>
							</button>

							<button class="btn btn-info">
								<i class="icon-pencil"></i>
							</button>

							<button class="btn btn-warning">
								<i class="icon-group"></i>
							</button>

							<button class="btn btn-danger">
								<i class="icon-cogs"></i>
							</button>
						</div>

						<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
							<span class="btn btn-success"></span>

							<span class="btn btn-info"></span>

							<span class="btn btn-warning"></span>

							<span class="btn btn-danger"></span>
						</div>
					</div><!-- #sidebar-shortcuts -->

					<ul class="nav nav-list">
						<li class="active">
							<a href="main4.jsp">
								<i class="icon-dashboard"></i>
								<span class="menu-text"> 我的首页 </span>
							</a>
						</li>
					<%if(role.equals("L1")){%>	
						<li class="">
							<a href="index.html" class="dropdown-toggle">
								<i class="icon-dashboard"></i>
								<span class="menu-text"> 信息登记 </span>
								<b class="arrow icon-angle-down"></b>
							</a>
							<ul class="submenu">
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 卡信息登记 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 历史查询 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 预警信息 </span>
									</a>
								</li>
							</ul>
						</li>
					<%}%>
						
					<%if(role.equals("L1")||role.equals("L2")){%>			
						<li class="">
							<a href="#" class="dropdown-toggle">
								<i class="icon-dashboard"></i>
								<span class="menu-text"> 统计查询 </span>
								<b class="arrow icon-angle-down"></b>
							</a>
						
							<ul class="submenu">
								<li class="">
									<a href="main4_report_s_nation.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 民族性别 </span>
									</a>
								</li>
								
								<li class="">
									<a href="main4_report_s_detained.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 滞留情况 </span>
									</a>
								</li>
								
								<li class="">
									<a href="main4_report_s_grade.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 年级分布 </span>
									</a>
								</li>
								
								<li class="">
									<a href="main4_report_s_origin.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 生源地 </span>
									</a>
								</li>
								
								<li class="">
									<a href="main4_report_s_cardinfo.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 明细信息（？） </span>
									</a>
								</li>
								
								<li class="">
									<a href="main4_report_t_academe.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 院系教职工儿童 </span>
									</a>
								</li>
								
								<li class="">
									<a href="main4_report_t_family.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 校系教职工儿童 </span>
									</a>
								</li>
								
								<li class="">
									<a href="main4_report_t_academe_nation_age.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 教工年龄（？） </span>
									</a>
								</li>
								<li class="">
									<a href="main4_report_t_return_lend.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 借出归还情况 </span>
									</a>
								</li>
							</ul>
						</li>
					<%}%>
					
						
						<li class="">
							<a href="#" class="dropdown-toggle">
								<i class="icon-dashboard"></i>
								<span class="menu-text"> 系统管理 </span>
								<b class="arrow icon-angle-down"></b>
							</a>
							
							<ul class="submenu">
							<%if(role.equals("AD")){%>
								<li class="">
									<a href="main4_user.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 用户管理 </span>
									</a>
								</li>
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 代码管理 </span>
									</a>
								</li>
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 角色管理 </span>
									</a>
								</li>
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 导入数据 </span>
									</a>
								</li>
							<%}%>
								<li class="">
									<a href="main4_changepass.jsp">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 修改密码 </span>
									</a>
								</li>
							</ul>
						</li>

						
					</ul><!-- /.nav-list -->


					<div class="sidebar-collapse" id="sidebar-collapse">
						<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
					</div>

					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
					</script>
				</div>
				
				
				<div class="ace-settings-container" id="ace-settings-container">
					<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
						<i class="icon-cog bigger-150"></i>
					</div>

					<div class="ace-settings-box" id="ace-settings-box">
						<div>
							<div class="pull-left">
								<select id="skin-colorpicker" class="hide">
									<option data-skin="default" value="#438EB9">#438EB9</option>
									<option data-skin="skin-1" value="#222A2D">#222A2D</option>
									<option data-skin="skin-2" value="#C6487E">#C6487E</option>
									<option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
								</select>
							</div>
							<span>&nbsp; 选择皮肤</span>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
							<label class="lbl" for="ace-settings-navbar"> 固定导航条</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
							<label class="lbl" for="ace-settings-sidebar"> 固定滑动条</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
							<label class="lbl" for="ace-settings-breadcrumbs">固定面包屑</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
							<label class="lbl" for="ace-settings-rtl">切换到左边</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
							<label class="lbl" for="ace-settings-add-container">
								切换窄屏
								<b></b>
							</label>
						</div>
					</div>
				</div><!-- /#ace-settings-container -->