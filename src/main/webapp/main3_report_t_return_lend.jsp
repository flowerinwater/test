<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title></title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/demo/demo.css">
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body style="margin:2px;padding:1px" >
<script>
		$(document).ready(function(){
			click();
		});	

		//left menu
		function click(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonlendreturn',  
				toolbar:'#tb',
        		rownumbers:true,//行号  
				singleSelect:true,
				fit:true,
			    columns:[[
					{field:'year',title:'年度',width:100},  
			        {field:'lend',title:'借出',width:100},  
			        {field:'return',title:'归还',width:100}
				]]   
			});				 
		}		

		function query(){
			var frmDataStr = "";
			data = {
				s_name:$("#s_academy").val()				
			};
			frmDataStr = JSON.stringify(data);
			//alert(frmDataStr);

			$('#ttt').datagrid({
				toolbar:'#tb',
				type:'POST',
				async:false,		
			   	queryParams:data,
				dataType: 'json',
				contentType : 'application/json',			
			    url:'${ctx}/jsonlendreturn',
        		rownumbers:true,//行号  
				singleSelect:true,
			    columns:[[
					{field:'year',title:'年度',width:100},  
			        {field:'lend',title:'借出',width:100},  
			        {field:'return',title:'归还',width:100}
				]]  
			});
		}
		function exportxls(){
			var url = "${ctx}/exportExcel?type=LendReturn";
			window.open(url);   
		}
</script>
<style type="text/css">
		#fm{
			margin:0;
			padding:10px 30px;
		}
		.ftitle{
			font-size:14px;
			font-weight:bold;
			color:#666;
			padding:5px 0;
			margin-bottom:10px;
			border-bottom:1px solid #ccc;
		}
		.fitem{
			margin-bottom:5px;
		}
		.fitem label{
			display:inline-block;
			width:80px;
		}
	</style>
<div id=ttt>
<div id="tb" style="padding:5px;height:auto">
	<div>    
		<!--院系 <input style="width:120px"  id="s_academe">-->
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="query()">查询</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="exportxls()">导出</a>
	</div>
</div>
</div>

<!--new edit dialog ending-->
</body>
</html>