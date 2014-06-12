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
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
	
	<script type="text/javascript">
		
	</script>
	
	
</head>
<body style="margin:2px;padding:1px" class="easyui-layout" id="main">	
	
<script>
		$(document).ready(function(){
			  $('#maincodegrid').datagrid({  
				    url:'${ctx}/jsonfindallcodetype',  
				    rownumbers:true,//
					singleSelect:true,
					toolbar:'#tb1',
					fit:true,
					onClickRow:function(rowIndex, rowData){  
	            //alert(rowIndex + ":" +rowData.typeValue);
	            queryCodeByType(rowData.typeValue);
	        },
			    columns:[[  
			        {field:'typeValue',title:'代码类别',width:200}
			    ]],
			    onLoadSuccess: function (data) {
              if (data.total > 0)
                  $('#maincodegrid').datagrid('selectRow', 0);

          },
          onLoadError: function () {
              $.messager.alert('提示', '数据加载失败', 'error');
          },
          onSelect: function (rowIndex, rowData) { //双击事件
			    		queryCodeByType(rowData.typeValue);
          }
          
				});				 
			
				/*$('#detailgrid').datagrid({  
			    	url:'${ctx}/jsonfindallcode',  
					toolbar:'#tb',
			    	pagination:true,//			
			    	rownumbers:true,// 
					singleSelect:true,
					fit:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'fullName',title:'fullName',width:100},  
			        {field:'loginName',title:'loginName',width:100,align:'right'}  
			    ]]  
				});*/			
			
		});		
</script>
<script>		
		//Content area
		var urlCodeType;
	
		function addCodeType(){  				
		    $('#dlg').dialog('open').dialog('setTitle','New CodeType');  
		    $('#fm').form('clear');   
		    urlCodeType = '${ctx}/jsonsavecodetype'; 
		} 
		
		function removeCodeType(){  
		    var row = $('#maincodegrid').datagrid('getSelected');  
		    //alert(row.id);
				if (row){
				    $.ajax({
							type:'POST',
							async:false,
							url:'${ctx}/jsonremovecodetypebyid?id='+row.id,
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
		                $('#maincodegrid').datagrid('reload');    // reload the CodeType data                  
		            }
			        }  
						});		
				    
				}else{
					alert("please choose one row!");
				} 
		}
		
		function editCodeType(){  
		    var row = $('#maincodegrid').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlg').dialog('open').dialog('setTitle','Edit CodeType');  
				    $('#fm').form('load',row);  
				    urlCodeType = '${ctx}/jsonsavecodetype?id='+row.id;  
				    
				     $('#detailgrid').datagrid('reload');    // reload the CodeType data            
				}else{
					alert("please choose one row!");
				} 
		} 
		
		function saveCodeType(){  				
		    var frmDataObj = $('#fm').serializeObject();
		    var frmDataStr = JSON.stringify(frmDataObj);
		    $.ajax({
					type:'POST',
					async:false,
					url:urlCodeType,
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
                $('#maincodegrid').datagrid('reload');    // reload the CodeType data                  
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


<script>
		function queryCodeByType(typeValue){
			$('#detailgrid').datagrid({  
			    url:'${ctx}/jsonfindallcodebytype?codeType='+typeValue,  
					toolbar:'#tb',
			    rownumbers:true,// 
					singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'codeValue',title:'代码',width:100},  
			        {field:'codeName',title:'名称',width:100,align:'right'}  
			    ]]  
			});
		}
		
		//Content area
		var urlCode;
	
		function addCode(){  
				var row = $('#maincodegrid').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlg1').dialog('open').dialog('setTitle','New Code');  
				    $('#fm1').form('clear'); 
				    $('#codeType').val(row.typeValue);  
				     urlCode = '${ctx}/jsonaddcode'; 
				    
				    $('#detailgrid').datagrid('reload');    // reload the CodeType data            
				}else{
						alert("please choose one codetype!");
				} 
		} 
		
		function removeCode(){  
		    var row = $('#detailgrid').datagrid('getSelected');  
		    alert(row.id);
				if (row){
				    $.ajax({
							type:'POST',
							async:false,
							url:'${ctx}/jsonremovecodebyid?id='+row.id,
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
		                $('#detailgrid').datagrid('reload');    // reload the Code data                  
		            }
			        }  
						});		
				    
				}else{
					alert("please choose one row!");
				} 
		}
		
		function editCode(){
		    var row = $('#detailgrid').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlg1').dialog('open').dialog('setTitle','Edit CodeType');  
				    $('#fm1').form('load',row);  
				    urlCode = '${ctx}/jsonsavecode?id='+row.id;  
				    
				     $('#detailgrid').datagrid('reload');    // reload the CodeType data            
				}else{
					alert("please choose one row!");
				} 
		}
		
		function saveCode(){		
		    var frmDataObj = $('#fm1').serializeObject();
		    var frmDataStr = JSON.stringify(frmDataObj);
		    $.ajax({
					type:'POST',
					async:false,
					url:urlCode,
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
                $('#dlg1').dialog('close');      // close the dialog  
                $('#detailgrid').datagrid('reload');    // reload the CodeType data                  
            }
	        }  
				});
		}  
</script>	

		<div id="maincode" data-options="region:'west',title:'代码类别',split:true" style="width:300px;">
			<div id="maincodegrid">
				<div id="tb1" style="padding:5px;height:auto">
					<div style="margin-bottom:5px">  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick=addCodeType()></a>  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editCodeType()></a>  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeCodeType()></a>  
			    </div>   			    
				</div>		
			</div>			
    </div>  
    <div id="detailcode" data-options="region:'center',title:'代码'" style="padding:1px;background:#eee;">
    		<div id="detailgrid">
					<div id="tb" style="padding:5px;height:auto">  
			    <div style="margin-bottom:5px">  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick="alert(1);addCode()"></a>  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editCode()></a>  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeCode()></a>  
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
    
    
    
<div id="dlg" class="easyui-dialog" style="width:350px;height:300px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttons" modal="true"  >  
    <div class="ftitle">CodeType Information</div>  
    <form id="fm" method="post" contentType="application/json">
    		<div class="fitem">  
            <label>Id:</label>  
            <input name="id" readOnly="true">  
        </div>   
        <div class="fitem">  
            <label>类别代码</label>  
            <input name="typeValue" class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>类别名称</label>  
            <input name="typeName" class="easyui-validatebox" required="true">  
        </div>         
    </form>  
</div>   
<div id="dlg-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCodeType()">Save</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>  
</div>



<div id="dlg1" class="easyui-dialog" style="width:350px;height:300px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttons1" modal="true"  >  
    <div class="ftitle">CodeType Information</div>  
    <form id="fm1" method="post" contentType="application/json">
    		<div class="fitem">  
            <label>Id:</label>  
            <input name="id" readOnly="true">  
        </div>   
        <div class="fitem">  
            <label>代码类别</label>  
            <input id="codeType" name="codeType" readOnly="true">  
        </div>   
        <div class="fitem">  
            <label>代码</label>  
            <input name="codeValue" class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>名称</label>  
            <input name="codeName" class="easyui-validatebox" required="true">  
        </div>
    </form>  
</div>   
<div id="dlg-buttons1">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCode()">Save</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg1').dialog('close')">Cancel</a>  
</div>
</body>  
</html>