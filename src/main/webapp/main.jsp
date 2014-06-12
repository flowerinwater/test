<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/demo/demo.css">
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

	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		
	</script>
	
	
</head>
<body style="margin:1px;padding:0px" class="easyui-layout" >	
	
<script>
		$(document).ready(function(){
			alert(1);
			  $('#tt').tree({					
						data: [{
							id : 'item1',
							text: 'Item1',
							state: 'closed',
							children: [{
								id : 'item11',
								text: 'Item11'
							},{
								id : 'item12',
								text: 'Item12'
							}]
						},{
							id : 'item2',
							text: 'User'
						}],
					
					onClick: function(node){
						alert(node.text);  // alert node text property when clicked
						if(node.id == 'item2'){
							clickUserMenu();
						}
					}
				});
				alert(1);
		});		
		
</script>
	

		<div data-options="region:'north',split:true" style="height:50px;">
			<p style="text-align:center">header</p>
		</div>  
		
    <div id="leftmenu" data-options="region:'west',title:'Menu Tree',split:true" style="width:150px;">
    	
    		
    		<div id="menugroup" class="easyui-accordion"  data-options="fit:true">  
				    <div title="Title1" data-options="iconCls:'icon-save'" style="overflow:auto">  
				        <h3 style="color:#0099FF;">Accordion for jQuery</h3>  
				        <p>Accordion is a part of easyui framework for jQuery.   
				        It lets you define your accordion component on web page more easily.</p>  
				    </div>  
				    <div title="Title2" data-options="iconCls:'icon-reload',selected:true" style="">  
				        <ul id="tt" >  								    
								</ul>  
				    </div>  
				    <div title="Title3">  
				        content2  
				    </div>  
				</div>
				
				
				 
    </div>  
    <div id="rightcontent" data-options="region:'center',title:'Content Panel'" style="padding:1px;background:#eee;">
    		<div id="dg">
		    		<div id="toolbar">  						    
						</div>  
		    		<table class="easyui-datagrid" data-options="fit:true" toolbar="#toolbar" pagination rownumbers="true" fitColumns="true" singleSelect="true">  				    
						</table>
			</div>
    </div>  
    
    <div data-options="region:'south',split:true" style="height:50px;">
    	<p style="text-align:center;text-valign:middle">footer</p> 
    </div>  



<!--add edit user dialog-->
<script>
		//left menu
		function clickUserMenu(){
			$.getJSON('${ctx}/jsonfinduser?name=admin&id=1', function(data){
				var dataFromServer = data.results;
				$('#dg').datagrid({  
				    //url:'${ctx}/jsonfinduser',  
				    /*data:[
										{code:1,firstname:1,price:1},
										{code:2,firstname:2,price:2}
									],*/
					data:dataFromServer,
				    /*toolbar: [{
										iconCls: 'icon-add',
										text:'new',
										handler: addUser
									},'-',{
										iconCls: 'icon-edit',
										text:'edit',
										handler: editUser
									},'-',{
										iconCls: 'icon-remove',
										text:'remove',
										handler: function(){alert('remove')}
									},'-',{
										iconCls: 'icon-search',
										text:'search',
										handler: function(){alert('search')}
									}],*/
									toolbar:'#tb',
				    pagination:true,//分页控件  
        		rownumbers:true,//行号  
						singleSelect:true,
				    columns:[[  
				        {field:'id',title:'id',width:100},  
				        {field:'fullName',title:'fullName',width:100},  
				        {field:'loginName',title:'loginName',width:100,align:'right'}  
				    ]]  
				});  
			});
		}
		
		function queryUser(){
			$('#dg').datagrid({  
			    url:'${ctx}/jsonfindalluserpage',  
				toolbar:'#tb',
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
		
		//Content area
		var urlUser;
	
		function addUser(){  
		    $('#dlg').dialog('open').dialog('setTitle','New User');  
		    $('#fm').form('clear');   
		    urlUser = '${ctx}/jsonsaveuser'; 
		} 
		
		function removeUser(){  
		    var row = $('#dg').datagrid('getSelected');  
		    alert(row.id);
				if (row){
				    $.ajax({
							type:'POST',
							async:false,
							url:'${ctx}/jsonremoveuserbyid?id='+row.id,
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
		                $('#dg').datagrid('reload');    // reload the user data                  
		            }
			        }  
						});		
				    
				}else{
					alert("please choose one row!");
				} 
		}
		
		function editUser(){  
		    var row = $('#dg').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlg').dialog('open').dialog('setTitle','Edit User');  
				    $('#fm').form('load',row);  
				    urlUser = '${ctx}/jsonsaveuser?id='+row.id;  
				    
				     $('#dg').datagrid('reload');    // reload the user data            
				}else{
					alert("please choose one row!");
				} 
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
                $('#dg').datagrid('reload');    // reload the user data                  
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

<div id="tb" style="padding:5px;height:auto">  
    <div style="margin-bottom:5px">  
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick=addUser()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editUser()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeUser()></a>  
    </div>   
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

<div id="dlg" class="easyui-dialog" style="width:350px;height:300px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttons" modal="true"  >  
    <div class="ftitle">User Information</div>  
    <form id="fm" method="post" contentType="application/json">
    		<div class="fitem">  
            <label>Id:</label>  
            <input name="id" readOnly="true">  
        </div>   
        <div class="fitem">  
            <label>FullName:</label>  
            <input name="fullName" class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>LoginName:</label>  
            <input name="loginName" class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>Phone:</label>  
            <input name="phone">  
        </div>  
        <div class="fitem">  
            <label>Email:</label>  
            <input name="email" class="easyui-validatebox" validType="email">  
        </div>  
    </form>  
</div>   
<div id="dlg-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>  
</div>
<!--new edit dialog ending-->


</body>  
</html>