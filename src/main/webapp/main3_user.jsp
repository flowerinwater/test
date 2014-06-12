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
		$('#s_createDate_low').datebox({
		    formatter: function(date){ 
		    	var m = date.getMonth()+1;
		    	if(m<10)
		    		m = "0" + m;
		    	
		    	var d = date.getDate();
		    	if(d<10)
		    		d = "0" + d;
		    	
		    		
		    	return date.getFullYear()+'-'+m+'-'+d;
		    },
		    parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/")));}
		});	
		
		$('#s_createDate_top').datebox({
		    formatter: function(date){ 
		    	var m = date.getMonth()+1;
		    	if(m<10)
		    		m = "0" + m;
		    	
		    	var d = date.getDate();
		    	if(d<10)
		    		d = "0" + d;
		    	
		    		
		    	return date.getFullYear()+'-'+m+'-'+d;
		    },
		    parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/")));}
		});	

		clickUser();
	});	
		//left menu
		function clickUser(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonfindallsysuserpage',  
				toolbar:'#tb',
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
				fit:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'loginName',title:'登录名',width:100},  
			        {field:'name',title:'名称',width:100,align:'right'},  
			        {field:'createDate',title:'创建日期',width:150,align:'right'},  
			        {field:'status',title:'状态',width:100,align:'right'},
					{field:'memo',title:'备注',width:400,align:'right'} 
			    ]]  
			});				 
		}

		function queryUser(){
			var frmDataStr = "";
			data = {
				s_name:$("#s_name").val(),
				s_createDate_low:$("#s_createDate_low").datebox('getValue'),
				s_createDate_top:$("#s_createDate_top").datebox('getValue'),
				s_loginName:$("#s_loginName").val(),
				s_memo:$("#s_memo").val()
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
			    url:'${ctx}/jsonfindallsysuserpage', 
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'loginName',title:'登录名',width:100},  
			        {field:'name',title:'名称',width:100,align:'right'},  
			        {field:'createDate',title:'创建日期',width:150,align:'right'},  
			        {field:'status',title:'状态',width:100,align:'right'},
					{field:'memo',title:'备注',width:400,align:'right'} 
			    ]]  
			});
		}
		
		//Content area
		var urlUser;
	
		function addUser(){  
		    $('#dlg').dialog('open').dialog('setTitle','New User');  
		    
			$('#fm').form('clear');   
			$('#loginName').removeAttr("readonly");

		    urlUser = '${ctx}/jsonsavesysuser'; 			
		} 
		
		function removeUser(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row.id);
				if (row){
				    $.ajax({
						type:'POST',
						async:false,
						url:'${ctx}/jsonremovesysuserbyid?id='+row.id,
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
								$('#ttt').datagrid('reload');    // reload the user data                  
							}
						}  
					});		
				    
				}else{
					alert("please choose one row!");
				} 
		}
		
		function editUser(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlg').dialog('open').dialog('setTitle','Edit User');  
				    $('#fm').form('load',row);  

					$('#status').combobox('setValue',row.status);
					$('#loginName').attr("readonly","readonly");

				    urlUser = '${ctx}/jsonsavesysuser?id='+row.id;  
				    
				     $('#ttt').datagrid('reload');    // reload the user data            
				}else{
					alert("please choose one row!");
				} 
		} 
		
		function changePass(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlgChangePass').dialog('open').dialog('setTitle','Edit User');  
				    $('#fmChangePass').form('load',row);         
				}else{
					alert("please choose one row!");
				} 
		} 

		function saveChangePass(){
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
					//alert(result);
					//var result = eval('('+result+')');  
					if (!result.success){  
						$.messager.show({  
							title: 'Error',  
							msg: result.msg  
						});  
					} else {                  
						$('#dlgChangePass').dialog('close');                  
					}
				}  
			});		    
		}
		
		
		function saveUser(){
		    var frmDataObj = $('#fm').serializeObject();
		    var frmDataStr = JSON.stringify(frmDataObj);
		    $.ajax({
				type:'POST',
				async:false,
				url:urlUser,
				data:frmDataStr,
				dataType: 'json',
				contentType : 'application/json',
				success: function(result){  
					//alert(result);
					//var result = eval('('+result+')');  
					if (!result.success){  
						$.messager.show({  
							title: 'Error',  
							msg: result.msg  
						});  
					} else {                  
						$('#dlg').dialog('close');      // close the dialog  
						$('#ttt').datagrid('reload');    // reload the user data                  
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
    <div style="margin-bottom:5px">  
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick=addUser()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editUser()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeUser()></a>  
    </div> 
	<div>  
		创建日期: <input class="easyui-datebox" style="width:120px"  id="s_createDate_low" class="easyui-datebox">  
		To: <input class="easyui-datebox" style="width:120px"  id="s_createDate_top" class="easyui-datebox">  
		登录名：<input style="width:150px" id="s_loginName">
		用户名：<input style="width:150px" id="s_name">   
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryUser()">查询</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="changePass()">修改密码</a>
	</div>
</div>
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttons" modal="true"  >  
    <div class="ftitle">用户信息</div>  
    <form id="fm" method="post" contentType="application/json">
    	<div class="fitem">  
            <label>Id:</label>  
            <input id="id" name="id" readOnly="true">  
        </div>   
        <div class="fitem">  
            <label>名称:</label>  
            <input id="name" name="name" class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>登录名:</label>  
            <input id="loginName" name="loginName" class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>状态:</label>  
            <input1 name="status1" class="easyui-validatebox" > 
			<input id="status" name="status" class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=user_status"  
			                valueField="codeValue" textField="codeName">  
        </div>
		<div class="fitem">  
            <label>备注:</label>  
            <input id="memo" name="memo" class="easyui-validatebox" >  
        </div>
    </form>  
</div>   
<div id="dlg-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>  
</div>




<div id="dlgChangePass" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"  
        closed="true" buttons="#dlgChangePass-buttons" modal="true"  >  
    <div class="ftitle">用户信息</div>  
    <form id="fmChangePass" method="post" contentType="application/json">
    	<div class="fitem">  
            <label>Id:</label>  
            <input id="id" name="id" readOnly="true">  
        </div>   
        <div class="fitem">  
            <label>名称:</label>  
            <input id="name" name="name" class="easyui-validatebox" required="true" readOnly="true">  
        </div>  
        <div class="fitem">  
            <label>登录名:</label>
            <input id="loginName" name="loginName" class="easyui-validatebox" required="true" readOnly="true">  
        </div>  
        <div class="fitem">  
            <label>新密码:</label>  
            <input id="newpassword" name="newpassword" class="easyui-validatebox" required="true" >  
        </div>
		<div class="fitem">  
            <label>再输入一遍新密码:</label>  
            <input id="repassword" name="repassword" class="easyui-validatebox" required="true" >  
        </div>
    </form>  
</div>   
<div id="dlgChangePass-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveChangePass()">保存</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgChangePass').dialog('close')">Cancel</a>  
</div>
<!--new edit dialog ending-->
</body>
</html>