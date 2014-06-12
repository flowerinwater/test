<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title>登录页</title>
	
	<link href="${ctx}/static/jquery-validation/1.10.0/validate.css" type="text/css" rel="stylesheet" />
	<link href="${ctx}/static/styles/default.css" type="text/css" rel="stylesheet" />
	<script src="${ctx}/static/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery-validation/1.10.0/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery-validation/1.10.0/messages_bs_zh.js" type="text/javascript"></script>

	<script>
		$(document).ready(function() {
			$("#loginForm").validate();
		});
	</script>
	<style type="text/css">
	html {
		background-color: #E9EEF0;
		background-image:url(${ctx}/static/images/beautiful-mountains_00450239.jpg);
	}
	.wrapper {
		margin: 140px auto;
		width: 884px;
	}
	.loginBox {
		background-color: #FEFEFE;
		border: 1px solid #BfD6E1;
		border-radius: 5px;
		color: #444;
		font: 14px 'Microsoft YaHei','微软雅黑';
		margin: 0 auto;
		width: 388px
	}
	.loginBox .loginBoxCenter {
		border-bottom: 1px solid #DDE0E8;
		padding: 24px;
	}
	.loginBox .loginBoxCenter p {
		margin-bottom: 10px
	}
	.loginBox .loginBoxButtons {
		background-color: #F0F4F6;
		border-top: 1px solid #FFF;
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 5px;
		line-height: 28px;
		overflow: hidden;
		padding: 20px 24px;
		vertical-align: center;
	}
	.loginBox .loginInput {
		border: 1px solid #D2D9dC;
		border-radius: 2px;
		color: #444;
		font: 12px 'Microsoft YaHei','微软雅黑';
		padding: 8px 14px;
		margin-bottom: 8px;
		width: 310px;
	}
	.loginBox .loginInput:FOCUS {
		border: 1px solid #B7D4EA;
		box-shadow: 0 0 8px #B7D4EA;
	}
	.loginBox .loginBtn {
		background-image: -moz-linear-gradient(to bottom, #B5DEF2, #85CFEE);
		border: 1px solid #98CCE7;
		border-radius: 20px;
		box-shadow:inset rgba(255,255,255,0.6) 0 1px 1px, rgba(0,0,0,0.1) 0 1px 1px;
		color: #FFF;
		cursor: pointer;
		float: right;
		font: bold 13px Arial;
		padding: 5px 14px;
	}
	.loginBox .loginBtn:HOVER {
		background-image: -moz-linear-gradient(to top, #B5DEF2, #85CFEE);
	}
	.loginBox a.forgetLink {
		color: #ABABAB;
		cursor: pointer;
		float: right;
		font: 11px/20px Arial;
		text-decoration: none;
		vertical-align: middle;
	}
	.loginBox a.forgetLink:HOVER {
		text-decoration: underline;
	}
	.loginBox input#remember {
		vertical-align: middle;
	}
	.loginBox label[for="remember"] {
		font: 11px Arial;
	}
	</style>
</head>

<body>
	<div class="wrapper" >
		<form id="loginForm" action="${ctx}/bnulogin" method="post">
		<div class="loginBox">
			<div class="loginBoxCenter">
				<p><label for="username">用户名：</label></p>
				<p><input type="text" id="username" name="username"  value="${username}" class="loginInput" autofocus="autofocus" required="required" placeholder="请输入用户名" autocomplete="off" /></p>
				<p><label for="password">密码：</label><a class="forgetLink" href="#">忘记密码?</a></p>
				<p><input type="password" id="password" name="password" class="loginInput" required="required" placeholder="请输入密码" value="" /></p>
			</div>
			<div class="loginBoxButtons">
				<input id="remember" type="checkbox" name="remember" />
				<label for="remember">记住登录状态</label>
				<input type="submit" name="Submit" value="提交" class="loginBtn"/>			
			</div>
			<div class="loginBoxButtons">
				<%
				String error1 = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
				if(error1 != null){
				%>
						<label>登录失败，请重试.</label>
				<%
				}
				%>
				
			</div>
		</div>
		</form>
	</div>
</body>
</html>
