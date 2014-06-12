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
		//alert(11112)
		clickUser();
	});	
		//left menu
		function clickUser(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonalertlendcard?expiredays=10',  
				toolbar:'#tb',
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
				fit:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'name',title:'名称',width:100},  
			        {field:'lendDate',title:'借出日期',width:100},  
			        {field:'toReturnDate',title:'预计归还日期',width:100},  
			        {field:'mobile',title:'移动电话',width:100},  
			        {field:'tel',title:'住宅电话',width:100},  
			        {field:'purpose',title:'用途',width:100},  
			        {field:'memo',title:'备注',width:250}
			    ]]  
			});				 
		}
	
		function queryUser(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonalertlendcard',  
				toolbar:'#tb',
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'name',title:'名称',width:100},  
			        {field:'lendDate',title:'借出日期',width:100},  
			        {field:'toReturnDate',title:'预计归还日期',width:100},  
			        {field:'mobile',title:'移动电话',width:100},  
			        {field:'tel',title:'住宅电话',width:100},  
			        {field:'purpose',title:'用途',width:100},  
			        {field:'memo',title:'备注',width:250}
			    ]]  
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
		<center><div style="margin-bottom:5px">  
			借出[10天]未归还卡片预警
		</div></center>
	</div>
</div>
<!--new edit dialog ending-->

</body>
</html>