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
<body style="margin:2px;padding:1px" class="easyui-layout" id="main">
<script>
$(document).ready(function(){
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
			        {field:'createDate',title:'创建日期',width:100,align:'right'},  
			        {field:'status',title:'状态',width:100,align:'right'} 
			    ]],
			    onSelect: function (rowIndex, rowData) { //双击事件
			    		//alert(1);
              $('#detailgrid').datagrid({
                  url: '${ctx}/jsonfindsysuserrole?loginName=' + rowData.loginName,
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
                  		{ field: 'code', title: '代码', width: 50 },
                      { field: 'name', title: '角色名', width: 100 }
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
	      url: '${ctx}/jsonaddsysuserrole?loginName='+loginName + "&roleCodes=" + roleCodes,
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
			var frmDataStr = "";
			data = {
				s_name:$("#s_name").val(),
				s_createDate_low:$("#s_createDate_low").datebox('getValue'),
				s_createDate_top:$("#s_createDate_top").datebox('getValue'),
				s_loginName:$("#s_loginName").val()
			};
			frmDataStr = JSON.stringify(data);
//alert(frmDataStr);

			$('#ttt').datagrid({  
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
			        {field:'createDate',title:'创建日期',width:100,align:'right'},  
			        {field:'status',title:'状态',width:100,align:'right'} 
			    ]]  
			});
		}
		
		//Content area
		var urlUser;
	
		function addUser(){  
		    $('#dlg').dialog('open').dialog('setTitle','New User');  
		    $('#fm').form('clear');   
		    urlUser = '${ctx}/jsonsavesysuser'; 
		} 
		
		
		function editUser(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlg').dialog('open').dialog('setTitle','Edit User');  
				    $('#fm').form('load',row);  
				    urlUser = '${ctx}/jsonsavesysuser?id='+row.id;  
				    
				     $('#ttt').datagrid('reload');    // reload the user data            
				}else{
					alert("please choose one row!");
				} 
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
			    <div>  
			        创建日期: <input class="easyui-datebox" style="width:120px"  id="s_createDate_low" class="easyui-datebox">  
			        To: <input class="easyui-datebox" style="width:120px"  id="s_createDate_top" class="easyui-datebox">  
			        登录名：<input style="width:150px" id="s_loginName">
					用户名：<input style="width:150px" id="s_name">   
			        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryUser()">Search</a>  
			    </div>  
			</div>
			</div>		
    </div>  
    <div id="rolepanel" data-options="region:'center',title:'角色'" style="padding:1px;background:#eee;width: 300px;overflow-y: auto ">
    		<div id="detailgrid">					
				</div>		
    </div>  
</body>
</html>