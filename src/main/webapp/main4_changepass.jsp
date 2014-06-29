<%@ page contentType="text/html;charset=utf-8"%>
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

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>控制台 - Bootstrap后台管理系统模版Ace下载</title>
		<meta name="keywords" content="Bootstrap模版,Bootstrap模版下载,Bootstrap教程,Bootstrap中文" />
		<meta name="description" content="站长素材提供Bootstrap模版,Bootstrap教程,Bootstrap中文翻译等相关Bootstrap插件下载" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- basic styles -->
		<link href="${ctx}/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${ctx}/assets/css/font-awesome.min.css" />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="${ctx}/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!-- page specific plugin styles -->
		
		<link rel="stylesheet" href="${ctx}/assets/css/jquery-ui-1.10.3.full.min.css"/>
		
		<!-- fonts 00000000000000000000000000000

		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />
-->
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
							ACE后台管理系统
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="grey">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-tasks"></i>
								<span class="badge badge-grey">4</span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-ok"></i>
									还有4个任务完成
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">软件更新</span>
											<span class="pull-right">65%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:65%" class="progress-bar "></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">硬件更新</span>
											<span class="pull-right">35%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:35%" class="progress-bar progress-bar-danger"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">单元测试</span>
											<span class="pull-right">15%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:15%" class="progress-bar progress-bar-warning"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">错误修复</span>
											<span class="pull-right">90%</span>
										</div>

										<div class="progress progress-mini progress-striped active">
											<div style="width:90%" class="progress-bar progress-bar-success"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										查看任务详情
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>

						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span class="badge badge-important">8</span>
							</a>

							<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-warning-sign"></i>
									8条通知
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-pink icon-comment"></i>
												新闻评论
											</span>
											<span class="pull-right badge badge-info">+12</span>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<i class="btn btn-xs btn-primary icon-user"></i>
										切换为编辑登录..
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-success icon-shopping-cart"></i>
												新订单
											</span>
											<span class="pull-right badge badge-success">+8</span>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-info icon-twitter"></i>
												粉丝
											</span>
											<span class="pull-right badge badge-info">+11</span>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										查看所有通知
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>

						<li class="green">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-envelope icon-animated-vertical"></i>
								<span class="badge badge-success">5</span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-envelope-alt"></i>
									5条消息
								</li>

								<li>
									<a href="#">
										<img src="assets/avatars/avatar.png" class="msg-photo" alt="Alex's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Alex:</span>
												不知道写啥 ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>1分钟以前</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="#">
										<img src="assets/avatars/avatar3.png" class="msg-photo" alt="Susan's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Susan:</span>
												不知道翻译...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>20分钟以前</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="#">
										<img src="assets/avatars/avatar4.png" class="msg-photo" alt="Bob's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Bob:</span>
												到底是不是英文 ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>下午3:15</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="inbox.html">
										查看所有消息
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>

						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="assets/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									<small>欢迎光临,</small>
									Jason
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="#">
										<i class="icon-cog"></i>
										设置
									</a>
								</li>

								<li>
									<a href="#">
										<i class="icon-user"></i>
										个人资料
									</a>
								</li>

								<li class="divider"></li>

								<li>
									<a href="#">
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
							<a href="index.html">
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
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 民族性别 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 滞留情况 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 年级分布 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 生源地 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 明细信息 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 院系教职工儿童 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 校系教职工儿童 </span>
									</a>
								</li>
								
								<li class="">
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 教工年龄 </span>
									</a>
								</li>
								<li class="">
									<a href="index.html">
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
									<a href="index.html">
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
									<a href="index.html">
										<i class="icon-dashboard"></i>
										<span class="menu-text"> 修改密码 </span>
									</a>
								</li>
							</ul>
						</li>
<!-- ---------------------------------------------->
						<li class="active">
							<a href="index.html">
								<i class="icon-dashboard"></i>
								<span class="menu-text"> 控制台 </span>
							</a>
						</li>
						<li>
							<a href="typography.html">
								<i class="icon-text-width"></i>
								<span class="menu-text"> 文字排版 </span>
							</a>
						</li>

						<li>
							<a href="#" class="dropdown-toggle">
								<i class="icon-desktop"></i>
								<span class="menu-text"> UI 组件 </span>

								<b class="arrow icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="elements.html">
										<i class="icon-double-angle-right"></i>
										组件
									</a>
								</li>

								<li>
									<a href="buttons.html">
										<i class="icon-double-angle-right"></i>
										按钮 &amp; 图表
									</a>
								</li>

								<li>
									<a href="treeview.html">
										<i class="icon-double-angle-right"></i>
										树菜单
									</a>
								</li>

								<li>
									<a href="jquery-ui.html">
										<i class="icon-double-angle-right"></i>
										jQuery UI
									</a>
								</li>

								<li>
									<a href="nestable-list.html">
										<i class="icon-double-angle-right"></i>
										可拖拽列表
									</a>
								</li>

								<li>
									<a href="#" class="dropdown-toggle">
										<i class="icon-double-angle-right"></i>

										三级菜单
										<b class="arrow icon-angle-down"></b>
									</a>

									<ul class="submenu">
										<li>
											<a href="#">
												<i class="icon-leaf"></i>
												第一级
											</a>
										</li>

										<li>
											<a href="#" class="dropdown-toggle">
												<i class="icon-pencil"></i>

												第四级
												<b class="arrow icon-angle-down"></b>
											</a>

											<ul class="submenu">
												<li>
													<a href="#">
														<i class="icon-plus"></i>
														添加产品
													</a>
												</li>

												<li>
													<a href="#">
														<i class="icon-eye-open"></i>
														查看商品
													</a>
												</li>
											</ul>
										</li>
									</ul>
								</li>
							</ul>
						</li>

						<li>
							<a href="#" class="dropdown-toggle">
								<i class="icon-list"></i>
								<span class="menu-text"> 表格 </span>

								<b class="arrow icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="tables.html">
										<i class="icon-double-angle-right"></i>
										简单 &amp; 动态
									</a>
								</li>

								<li>
									<a href="jqgrid.html">
										<i class="icon-double-angle-right"></i>
										jqGrid plugin
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="#" class="dropdown-toggle">
								<i class="icon-edit"></i>
								<span class="menu-text"> 表单 </span>

								<b class="arrow icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="form-elements.html">
										<i class="icon-double-angle-right"></i>
										表单组件
									</a>
								</li>

								<li>
									<a href="form-wizard.html">
										<i class="icon-double-angle-right"></i>
										向导提示 &amp; 验证
									</a>
								</li>

								<li>
									<a href="wysiwyg.html">
										<i class="icon-double-angle-right"></i>
										编辑器
									</a>
								</li>

								<li>
									<a href="dropzone.html">
										<i class="icon-double-angle-right"></i>
										文件上传
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="widgets.html">
								<i class="icon-list-alt"></i>
								<span class="menu-text"> 插件 </span>
							</a>
						</li>

						<li>
							<a href="calendar.html">
								<i class="icon-calendar"></i>

								<span class="menu-text">
									日历
									<span class="badge badge-transparent tooltip-error" title="2&nbsp;Important&nbsp;Events">
										<i class="icon-warning-sign red bigger-130"></i>
									</span>
								</span>
							</a>
						</li>

						<li>
							<a href="gallery.html">
								<i class="icon-picture"></i>
								<span class="menu-text"> 相册 </span>
							</a>
						</li>

						<li>
							<a href="#" class="dropdown-toggle">
								<i class="icon-tag"></i>
								<span class="menu-text"> 更多页面 </span>

								<b class="arrow icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="profile.html">
										<i class="icon-double-angle-right"></i>
										用户信息
									</a>
								</li>

								<li>
									<a href="inbox.html">
										<i class="icon-double-angle-right"></i>
										收件箱
									</a>
								</li>

								<li>
									<a href="pricing.html">
										<i class="icon-double-angle-right"></i>
										售价单
									</a>
								</li>

								<li>
									<a href="invoice.html">
										<i class="icon-double-angle-right"></i>
										购物车
									</a>
								</li>

								<li>
									<a href="timeline.html">
										<i class="icon-double-angle-right"></i>
										时间轴
									</a>
								</li>

								<li>
									<a href="login.html">
										<i class="icon-double-angle-right"></i>
										登录 &amp; 注册
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="#" class="dropdown-toggle">
								<i class="icon-file-alt"></i>

								<span class="menu-text">
									其他页面
									<span class="badge badge-primary ">5</span>
								</span>

								<b class="arrow icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="faq.html">
										<i class="icon-double-angle-right"></i>
										帮助
									</a>
								</li>

								<li>
									<a href="error-404.html">
										<i class="icon-double-angle-right"></i>
										404错误页面
									</a>
								</li>

								<li>
									<a href="error-500.html">
										<i class="icon-double-angle-right"></i>
										500错误页面
									</a>
								</li>

								<li>
									<a href="grid.html">
										<i class="icon-double-angle-right"></i>
										网格
									</a>
								</li>

								<li>
									<a href="blank.html">
										<i class="icon-double-angle-right"></i>
										空白页面
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

				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="#">首页</a>
							</li>
							<li class="active">控制台</li>
						</ul><!-- .breadcrumb -->

						<div class="nav-search" id="nav-search">
							<form class="form-search">
								<span class="input-icon">
									<input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
									<i class="icon-search nav-search-icon"></i>
								</span>
							</form>
						</div><!-- #nav-search -->
					</div>

					<div class="page-content">
						<div class="page-header">
							<h1>
								系统管理
								<small>
									<i class="icon-double-angle-right"></i>
									 修改密码
								</small>
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
<!----------------------------------->

											<div class=" row-fluid position-relative" id="">
														
															<h3 class="lighter block green">修改密码</h3>

															<form class="form-horizontal" id="fmChangePass"  method="post" contentType="application/json">
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="id">ID</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="id" id="id" readOnly class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="name">名称:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="name" id="name" readOnly class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="email">登录名:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="loginName" id="loginName"  readOnly class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																
																<div class="space-2"></div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="password">当前密码:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="password" name="password" id="password" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																<div class="space-2"></div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="newpassword">新密码:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="password" name="newpassword" id="newpassword" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="space-2"></div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="repassword">确认密码:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="password" name="repassword" id="repassword" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="space-2"></div>
																<div class="form-group">
																<div class="col-md-offset-2 col-xs-12 col-sm-5">
																	<center>
																	<button class="btn btn-info" type="submit">
																		<i class="icon-ok bigger-110"></i>
																		确定
																	</button>
						
																	&nbsp; &nbsp; &nbsp;
																	<button class="btn" type="reset">
																		<i class="icon-undo bigger-110"></i>
																		重置
																	</button>
																	</center>
																</div>
																</div>

																<div class="space-2"></div>
																<div class="form-group">
																<div class="col-md-offset-2 col-xs-12 col-sm-5">
																				<div class="alert alert-info">
																					<button type="button" class="close" data-dismiss="alert">
																						<i class="icon-remove"></i>
																					</button>
																					<strong>Heads up!</strong>
																					<span>
																					This alert needs your attention, but it's not super important.
																					</span>
																					<br />
																				</div>
																				
																				<div class="alert alert-danger">
																					<button type="button" class="close" data-dismiss="alert">
																						<i class="icon-remove"></i>
																					</button>
										
																					<strong>
																						<i class="icon-remove"></i>
																						Oh snap!
																					</strong>
																					<span>
																					Change a few things up and try submitting again.
																					</span>
																					<br />
																				</div>
																</div>
																</div>
																
															


															</form>														
													</div>

<!----------------------------------->							

								<!-- PAGE CONTENT ENDS -->
							
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->

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
			</div><!-- /.main-container-inner -->

			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->

	<!-- basic scripts -->

		<!--[if !IE]> -->

		<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>-->
<script src="${ctx}/assets/js/jquery-2.0.3.min.js"></script>
		<!-- <![endif]-->

		<!--[if IE]>
<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>-->
<script src="${ctx}/assets/js/jquery-1.10.2.min.js"></script>
<![endif]-->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='${ctx}/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]--> 

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${ctx}/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='${ctx}/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="${ctx}/assets/js/bootstrap.min.js"></script>
		<script src="${ctx}/assets/js/typeahead-bs2.min.js"></script>

		<!-- page specific plugin scripts -->
		<script src="assets/js/jquery-ui-1.10.3.full.min.js"></script>  
		<script src="assets/js/jquery.ui.touch-punch.min.js"></script>
                                                                  
		<script src="assets/js/fuelux/fuelux.wizard.min.js"></script>
		<script src="assets/js/jquery.validate.min.js"></script>
		<script src="assets/js/additional-methods.min.js"></script>
		<script src="assets/js/bootbox.min.js"></script>
		<script src="assets/js/jquery.maskedinput.min.js"></script>
		<script src="assets/js/select2.min.js"></script>

		<!-- ace scripts -->

		<script src="${ctx}/assets/js/ace-elements.min.js"></script>
		<script src="${ctx}/assets/js/ace.min.js"></script>

		<!-- inline scripts related to this page -->

		<script type="text/javascript">
				$('.alert-danger').hide();
				$('.alert-info').hide();
		
			function changePass(){  
				$.ajax({
					type:'POST',
					async:false,
					url:'${ctx}/jsongetcurrloginname',
					dataType: 'json',
					contentType : 'application/json',
					success: function(result){  
						//alert(result.success);
						//var result = eval('('+result+')');  
						if (!result.success){  
							$.messager.show({  
								title: 'Error',  
								msg: result.msg  
							});  
						} else {                  
							var row = result.obj;  
							if (row){  
								$('#dlgChangePass').dialog('open').dialog('setTitle','修改密码');  
								//$('#fmChangePass').form('load',row);    
								$('#id').val(row.id);
								$('#name').val(row.name);
								$('#loginName').val(row.loginName);
								$('#password').val("");       
							}else{
								alert("please choose one row!");
							}                   
						}
					}  
				});		    
			} 
		
			function saveChangePass(){
				//if(!$('#fmChangePass').valid())
				//	return;
				
				var frmDataObj = $('#fmChangePass').serializeObject();
				var frmDataStr = JSON.stringify(frmDataObj);
				$.ajax({
					type:'POST',
					async:false,
					url:'${ctx}/jsonchangepass',
					data:frmDataStr,
					dataType: 'json',
					contentType : 'application/json',
					success: function(result){  
						//alert(result.msg);
						//var result = eval('('+result+')');  
						if (!result.success){  
							$('.alert-danger strong').text("错误!");
							$('.alert-danger span').text(result.msg);
							$('.alert-danger').show();
							$('.alert-info').hide();
						} else {
							//alert("密码修改成功!");
							$('.alert-info strong').text("提示!");
							$('.alert-info span').text("密码修改成功!");
							$('.alert-danger').hide();
							$('.alert-info').show();
							$('#password').val("");       
							$('#newpassword').val("");       
							$('#repassword').val("");       
							//$('#dlgChangePass').dialog('close');                  
						}
					}  
				});		    
			}
				
			
			$.fn.serializeObject = function() {
				var o = {};
				var a = this.serializeArray();
				$.each(a, function() {
					if (o[this.name]) {
						if (!o[this.name].push) {
							o[this.name] = [ o[this.name] ];
						}
						o[this.name].push(this.value || '');
					} else {
						o[this.name] = this.value || '';
					}
				});
				return o;
			}
		
//			$('[data-rel=tooltip]').tooltip();

		
			jQuery(function($) {
			
				$('[data-rel=tooltip]').tooltip();
				
				$(".select2").css('width','200px').select2({allowClear:true})
				.on('change', function(){
					$(this).closest('form').validate().element($(this));
				}); 
			
			
				var $validation = false;
							
				//documentation : http://docs.jquery.com/Plugins/Validation/validate
		
			
				$('#fmChangePass').validate({
					errorElement: 'div',
					errorClass: 'help-block',
					focusInvalid: false,
					rules:{ 
						password: {
							required: true,
							minlength: 6
						},
						newpassword: {
							required: true,
							minlength: 6
						},
						repassword: {
							required: true,
							minlength: 6,
							equalTo: "#newpassword"
						}						
					},
			
					messages: {
						password: {
							required: "请输入密码.",
							minlength: "请输入最少6位的密码."
						},
						newpassword: {
							required: "请输入密码.",
							minlength: "请输入最少6位的密码."
						},
						repassword: {
							required: "请输入密码.",
							minlength: "请输入最少6位的密码.",
							equalTo:"两次输入的密码不相同."
						},
						
					},
			
					invalidHandler: function (event, validator) { //display error alert on form submit   
						$('.alert-danger', $('.login-form')).show();
					},
			
					highlight: function (e) {
						$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
					},
			
					success: function (e) {
						$(e).closest('.form-group').removeClass('has-error').addClass('has-info');
						$(e).remove();
					},
			
					errorPlacement: function (error, element) {
						if(element.is(':checkbox') || element.is(':radio')) {
							var controls = element.closest('div[class*="col-"]');
							if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
							else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
						}
						else if(element.is('.select2')) {
							error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
						}
						else if(element.is('.chosen-select')) {
							error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
						}
						else error.insertAfter(element.parent());
					},
			
					submitHandler: function (form) {
					 event.preventDefault() ;
						saveChangePass();
					},
					invalidHandler: function (form) {
					}
				});
			
			})
			
			$(document).ready(function(){					
				changePass();
			});	
		</script>
</body>
</html>

