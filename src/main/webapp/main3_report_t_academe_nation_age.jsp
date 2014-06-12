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
			//click();
		});	

		//left menu
		function click(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonacademenationage',  
				toolbar:'#tb',
        		rownumbers:true,//行号  
				singleSelect:true,
				fit:true,
			    columns:[[ 
			        {field:'origin',title:'院系所',width:100,rowspan:2},  
			        {field:'origin',title:'民族',width:100,rowspan:2},  
			        {title:'合计',width:100,colspan:3},    
			        {title:'教职工',width:200,colspan:2},    
			        {title:'家属',width:200,colspan:2},    
			        {title:'儿童',width:200,colspan:2} 
			    ],[
					{field:'sumAll',title:'合计',width:100,rowspan:2},  
			        {field:'sumM',title:'男',width:100,rowspan:2},  
			        {field:'sumF',title:'女',width:100,rowspan:2},  
			        {field:'bachelorM',title:'男',width:100,rowspan:2},  
			        {field:'bachelorF',title:'女',width:100,rowspan:2},  
			        {field:'masterM',title:'男',width:100,rowspan:2},  
			        {field:'masterF',title:'女',width:100,rowspan:2},  
			        {field:'doctorM',title:'男',width:100,rowspan:2},  
			        {field:'doctorF',title:'女',width:100,rowspan:2}
				]]   
			});				 
		}		

		function query(){
			var frmDataStr = "";
			data = {
				s_name:$("#s_academy").val(),
				s_age1_low:$("#s_age1_low").val(),
				s_age1_top:$("#s_age1_top").val(),

				s_age2_low:$("#s_age2_low").val(),
				s_age2_top:$("#s_age2_top").val(),

				s_age3_low:$("#s_age3_low").val(),
				s_age3_top:$("#s_age3_top").val(),

				s_age4_low:$("#s_age4_low").val(),
				s_age4_top:$("#s_age4_top").val(),

				s_age5_low:$("#s_age5_low").val(),
				s_age5_top:$("#s_age5_top").val(),

				s_age6_low:$("#s_age6_low").val(),
				s_age6_top:$("#s_age6_top").val()	
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
			    url:'${ctx}/jsonacademenationage',
        		rownumbers:true,//行号  
				singleSelect:true,
			    columns:[[  
			        {field:'groupName',title:'学院',width:100,rowspan:2},
			        {title:'合计',width:100,colspan:3},    
			        {title:'本科生',width:200,colspan:2},    
			        {title:'研究生',width:200,colspan:2},    
			        {title:'博士生',width:200,colspan:2} 
			    ],[
					{field:'sumAll',title:'合计',width:100,rowspan:2},  
			        {field:'sumM',title:'男',width:100,rowspan:2},  
			        {field:'sumF',title:'女',width:100,rowspan:2},  
			        {field:'bachelorM',title:'男',width:100,rowspan:2},  
			        {field:'bachelorF',title:'女',width:100,rowspan:2},  
			        {field:'masterM',title:'男',width:100,rowspan:2},  
			        {field:'masterF',title:'女',width:100,rowspan:2},  
			        {field:'doctorM',title:'男',width:100,rowspan:2},  
			        {field:'doctorF',title:'女',width:100,rowspan:2}
				]]  
			});
		}
		function exportxls(){
			var url = "${ctx}/exportExcel?type=AcademeAge&s_age1_low="+$('#s_age1_low').val()+"&s_age1_top="+$('#s_age1_top').val();
			url = url + "&s_age2_low="+$('#s_age2_low').val()+"&s_age2_top="+$('#s_age2_top').val();
			url = url + "&s_age3_low="+$('#s_age3_low').val()+"&s_age3_top="+$('#s_age3_top').val();
			url = url + "&s_age4_low="+$('#s_age4_low').val()+"&s_age4_top="+$('#s_age4_top').val();
			url = url + "&s_age5_low="+$('#s_age5_low').val()+"&s_age5_top="+$('#s_age5_top').val();
			url = url + "&s_age6_low="+$('#s_age6_low').val()+"&s_age6_top="+$('#s_age6_top').val();
			alert(url);
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
		年龄段：<br>
		1:<input style="width:120px"  id="s_age1_low"> to <input style="width:120px"  id="s_age1_top"><br> 
		2:<input style="width:120px"  id="s_age2_low"> to <input style="width:120px"  id="s_age2_top"><br>
		3:<input style="width:120px"  id="s_age3_low"> to <input style="width:120px"  id="s_age3_top"><br>
		4:<input style="width:120px"  id="s_age4_low"> to <input style="width:120px"  id="s_age4_top"><br>
		5:<input style="width:120px"  id="s_age5_low"> to <input style="width:120px"  id="s_age5_top"><br>
		6:<input style="width:120px"  id="s_age6_low"> to <input style="width:120px"  id="s_age6_top"><br>
		<!--<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="query()">查询</a>-->
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="exportxls()">导出</a>
	</div>
</div>
</div>

<!--new edit dialog ending-->
</body>
</html>