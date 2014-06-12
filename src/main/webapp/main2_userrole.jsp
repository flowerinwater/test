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
<body style="margin:2px;padding:1px" class="easyui-layout" id="main">
<script>
$(document).ready(function(){
		//alert(11112)
		clickUser();
	});	
		//left menu
		function clickUser(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonfindalluserpage',  
				toolbar:'#tb',
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
				fit:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'fullName',title:'全称',width:100},  
			        {field:'loginName',title:'登录名',width:100,align:'right'}  
			    ]],
			    onSelect: function (rowIndex, rowData) { //双击事件
			    		//alert(1);
              $('#detailgrid').datagrid({
                  url: '${ctx}/jsonfinduserrole?loginName=' + rowData.loginName,
                  rownumbers: true,
                  method: 'post',
                  striped: true,
                  idField: "code",
                  toolbar: [{
                      text: '保存角色',
                      iconCls: 'icon-save',
                      handler: saveRoles,
                      id: 'btnSave',
                      disable: true
                  }],
                  frozenColumns: [[
                      {
                          field: 'Checked',
                          checkbox: true
                      }
                  ]],
                  columns: [[
                  		{ field: 'code', title: '代码', width: 200 },
                      { field: 'name', title: '角色名', width: 200 }
                  ]],
                  onBeforeLoad: function (param) {
                      //setButtonPermissions(permissions);
                  },
                  onLoadSuccess: function (data) { //当数据加载成功时触发

                      $('#detailgrid').datagrid('unselectAll');
                      for (var i = 0; i < data.rows.length; i++) {
                          if (data.rows[i].checked) {
                              $('#detailgrid').datagrid('selectRecord', data.rows[i].code); //根据id选中行 
                          }
                      }
                  },
                  onLoadError: function () {
                      $.messager.alert('提示', '数据加载失败', 'error');
                  }
              });
          },
          onLoadSuccess: function (data) {
              if (data.total > 0)
                  $('#ttt').datagrid('selectRow', 0);

          },
          onLoadError: function () {
              $.messager.alert('提示', '数据加载失败', 'error');
          }
			});				 
		}
	
	function saveRoles() {
    var rows = $("#detailgrid").datagrid('getSelections');
    var roleCodes = "";
    for(var i=0;i<rows.length;i++){
    	roleCodes += rows[i].code + ",";
    }
    //alert(roleCodes);
    var loginName = $("#ttt").datagrid('getSelected').loginName;
    //alert(loginName);
    $.ajax({
	      url: '${ctx}/jsonadduserrole?loginName='+loginName + "&roleCodes=" + roleCodes,
	      type: 'Post',
	      datatype: 'json; charset=utf-8',
	      contentType : 'application/json',
	      data:rows,
	      error: function (result) {
	          Msgalert('错误', '操作失败：' + result, 'error');
	      },
	      success: function (result) {
	          //result为请求处理后的返回值   
	          result = result.replace(/\\/g, '');
	          result = eval('(' + result + ')');
	          alert(result.success);
            //var result = eval('('+result+')');  
            if (!result.success){  
                $.messager.show({  
                    title: 'Error',  
                    msg: result.msg  
                });  
            } else {                  
                //$('#ttt').datagrid('reload');    // reload the user data                  
            }
	      }
	  });
	}
	
	
	
	////////////////////////////////
		function queryUser(){
			$('#ttt').datagrid({  
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
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row.id);
				if (row){
				    $.ajax({
							type:'POST',
							async:false,
							url:'${ctx}/jsonremoveuserbyid?id='+row.id,
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
				    urlUser = '${ctx}/jsonsaveuser?id='+row.id;  
				    
				     $('#ttt').datagrid('reload');    // reload the user data            
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
	
		<div id="userpanel" data-options="region:'west',title:'用户',split:true" style="width:900px;padding: 0px;">
			<div id=ttt>
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
			</div>		
    </div>  
    <div id="rolepanel" data-options="region:'center',title:'角色'" style="padding:1px;background:#eee;width: 300px;overflow-y: auto ">
    		<div id="detailgrid">					
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
            <label>全称:</label>  
            <input name="fullName" class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>登录名:</label>  
            <input name="loginName" class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>电话:</label>  
            <input name="phone" class="easyui-validatebox" required="true">  
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
</body>
</html>