<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>ssh4 test示例:<sitemesh:title/></title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<link href="${ctx}/static/layout/t1layout.css" type="text/css" rel="stylesheet" />

<sitemesh:head/>
</head>

<body>
	<div id="container">
	  <div id="header">
	  	<%@ include file="/WEB-INF/layouts/t1header.jsp"%>
	  </div>
	  <br class="clearfloat" />
	  <div id="menu">
	  <%@ include file="/WEB-INF/layouts/t1menu.jsp"%>
	  </div>
	  <br class="clearfloat" />
	  <div id="mainContent">
	    <div id="sidebar">
	    	<%@ include file="/WEB-INF/layouts/t1sidebar.jsp"%>
	    </div>
	    <div id="content">
			<sitemesh:body/>
	    </div>
	  </div>
	  <br class="clearfloat" />
	  <div id="footer">
	  	<%@ include file="/WEB-INF/layouts/t1footer.jsp"%>
	  </div>
	</div>
</body>
</html>