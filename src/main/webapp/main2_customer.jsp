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
</head>
<body style="margin:2px;padding:1px" >
<script>
$(document).ready(function(){
		//alert(11112)
		queryCustomer();
	});	
			
		function queryCustomer(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonfindallcustomerpage',  
				toolbar:'#tb',
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},
			        {field:'shortName',title:'简称',width:100,align:'right'},
			        {field:'fullName',title:'全称',width:100},
			        {field:'address',title:'地址',width:100},
			        {field:'fax',title:'传真',width:100},
			        {field:'email',title:'email',width:100},
			        {field:'url',title:'公司网址',width:100},
			        {field:'postCode',title:'邮编',width:100},
			        {field:'contactPerson',title:'联系人',width:100},
			        {field:'telephone',title:'联系电话',width:100},
			        {field:'mobileCode',title:'联系人手机',width:100},
			        {field:'salesManName',title:'业务员',width:100}
			    ]]  
			});
		}
		
		//Content area
		var urlCustomer;
	
		function addCustomer(){  
		    $('#dlg').dialog('open').dialog('setTitle','New Customer');  
		    $('#fm').form('clear');   
		    urlCustomer = '${ctx}/jsonsavecustomer'; 
		} 
		
		function removeCustomer(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    alert(row.id);
				if (row){
				    $.ajax({
							type:'POST',
							async:false,
							url:'${ctx}/jsonremovecustomerbyid?id='+row.id,
							dataType: 'json',
							contentType : 'application/json',
							success: function(result){  
								alert(result.success);
		            //var result = eval('('+result+')');  
		            if (!result.success){  
		                $.messager.show({  
		                    title: 'Error',  
		                    msg: result.msg  
		                });  
		            } else {                  
		                $('#ttt').datagrid('reload');    // reload the customer data                  
		            }
			        }  
						});		
				    
				}else{
					alert("please choose one row!");
				} 
		}
		
		function editCustomer(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlg').dialog('open').dialog('setTitle','Edit Customer');  
				    $('#fm').form('load',row);  
				    urlCustomer = '${ctx}/jsonsavecustomer?id='+row.id;  
				    
				     $('#ttt').datagrid('reload');    // reload the customer data            
				}else{
					alert("please choose one row!");
				} 
		} 
		
		function saveCustomer(){  				
		    var frmDataObj = $('#fm').serializeObject();
		    var frmDataStr = JSON.stringify(frmDataObj);
		    $.ajax({
					type:'POST',
					async:false,
					url:urlCustomer,
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
                $('#ttt').datagrid('reload');    // reload the customer data                  
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
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick=addCustomer()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editCustomer()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeCustomer()></a>  
    </div>   
    <div>  
        Date From: <input class="easyui-datebox" style="width:80px">  
        To: <input class="easyui-datebox" style="width:80px">  
        Language:   
        <input class="easyui-combobox" style="width:100px"  
                url="data/combobox_data.json"  
                valueField="id" textField="text">  
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryCustomer()">Search</a>  
    </div>  
</div>
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:550px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttons" modal="true"  >  
    <div class="ftitle">Customer Information</div>  
    <form id="fm" method="post" contentType="application/json">
    		<div class="fitem">  
            <label>Id:</label>  
            <input name="id" readOnly="true">  
        </div>   
        <div class="fitem">  
            <label>简称:</label>  
            <input name="shortName" class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>全称:</label>  
            <input name="fullName" class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>类型:</label>  
            <input name="type">  
        </div>
        <div class="fitem">  
            <label>地址:</label>  
            <input name="address">  
        </div>
        <div class="fitem">  
            <label>邮政编码:</label>  
            <input name="postCode" class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>传真:</label>  
            <input name="fax">  
        </div>  
        <div class="fitem">  
            <label>Email:</label>  
            <input name="email" class="easyui-validatebox" validType="email" required="true">  
        </div>
        <div class="fitem">  
            <label>联系人:</label>  
            <input name="contactPerson" class="easyui-validatebox" required="true">  
        </div>          
        <div class="fitem">  
            <label>联系电话:</label>  
            <input name="telephone" class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>移动电话:</label>  
            <input name="mobileCode" class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>业务员:</label>  
            <input id="salesManId" name="salesManId" type="hidden">
            <input id="salesManName" name="salesManName" readOnly class="easyui-validatebox" required="true"><a href="#" id="btnQueryUser" iconCls="icon-search" onClick="queryUser()">选择</a>      
        </div>  
        <div class="fitem">  
            <label>备注:</label>  
            <input name="memo">  
        </div>  
    </form>  
</div>   
<div id="dlg-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCustomer()">Save</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>  
</div>



<script>

		function queryUser(){
			$('#dlgUserQuery').dialog('open').dialog('setTitle','选择用户');  
			
			$('#userQueryGrid').datagrid({  
			    url:'${ctx}/jsonfindalluserpage',  
					toolbar:'#tbUQ',
			    pagination:true,//分页控件  
        	rownumbers:true,//行号  
					singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'fullName',title:'fullName',width:100},  
			        {field:'loginName',title:'loginName',width:100,align:'right'}  
			    ]]  
			});
		}
		
		function selectUser(){
			var row = $('#userQueryGrid').datagrid('getSelected');  
			if(!row){
				alert("请选择用户!");
			}else{
				$("#salesManId").val(row.id);
				$("#salesManName").val(row.fullName+"["+row.loginName+"]");
				$('#dlgUserQuery').dialog('close');
				
				$("#fm").form('validate');
			}
		}
</script>
<div id="dlgUserQuery" class="easyui-dialog" style="width:900px;height:500px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttonsUserQuery" modal="true"  >  
    <div class="ftitle">Customer Information</div>  
    <div id="userQueryGrid">
			<div id="tbUQ" style="padding:5px;height:auto">  
			    <div>  
			        Date From: <input class="easyui-datebox" style="width:80px">  
			        To: <input class="easyui-datebox" style="width:80px">  
			        Language:   
			        <input class="easyui-combobox" style="width:100px"  
			                url="data/combobox_data.json"  
			                valueField="id" textField="text">  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryUser()">Search</a>  
			    </div>  
			</div>
		</div>
</div>   
<div id="dlg-buttonsUserQuery">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="selectUser()">确定</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgUserQuery').dialog('close')">Cancel</a>  
</div>

</body>
</html>