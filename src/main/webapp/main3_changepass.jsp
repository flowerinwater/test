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
	<script type="text/javascript" src="${ctx}/static/jquery-validation/1.10.0/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body style="margin:2px;padding:1px" >
<script>
	$(document).ready(function(){	
		
		changePass();
	});	
				
	function changePass(){  
//alert(1);
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
					//alert(row);
					if (row){  
						$('#dlgChangePass').dialog('open').dialog('setTitle','修改密码');  
						$('#fmChangePass').form('load',row);    
						$('#password').val("");       
					}else{
						alert("please choose one row!");
					}                   
				}
			}  
		});		    
	} 

	function saveChangePass(){
		if(!$('#fmChangePass').valid())
			return;
		
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
					alert("密码修改成功!");
					$('#dlgChangePass').dialog('close');                  
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
            <label>当前密码:</label>  
            <input id="password" name="password" class="easyui-validatebox" required="true" type="password">  
        </div>  
        <div class="fitem">  
            <label>新密码:</label>  
            <input id="newpassword" name="newpassword" class="easyui-validatebox" required="true" type="password">  
        </div>
		<div class="fitem">  
            <label>再输入一遍新密码:</label>  
            <input id="repassword" name="repassword" class="easyui-validatebox" required="true" type="password">  
        </div>
    </form>  
</div>   
<div id="dlgChangePass-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveChangePass()">保存</a>  
</div>
<!--new edit dialog ending-->
</body>
</html>