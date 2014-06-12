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
			$('#s_operateDate_low').datebox({
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

			$('#s_operateDate_top').datebox({
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


			query();
		});	

		//left menu
		function init(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonfindallhistorypage',  
				toolbar:'#tb',
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
				fit:true,
			    columns:[[  
					{field:'id',title:'id',width:30},  
					{field:'operateDate',title:'维护时间',width:120},  
					{field:'operatorName',title:'操作人员',width:100},
					{field:'name',title:'名称',width:100},  
					{field:'cardType',title:'卡类型',width:100},  
					{field:'operateType',title:'操作类型',width:100},  
					{field:'memo',title:'备注',width:250} 
			    ]]  
			});				 
		}
	
		
		
		function query(flag){
			var myurl = "";
			var frmDataStr = "";
			var data = {};
			if(!flag){
				myurl = '${ctx}/jsonfindallhistorypage';
				data = {					
					s_page:1,
					s_rows:10
				};
				frmDataStr = JSON.stringify(data);
			}else{
				myurl = '${ctx}/jsonfindallhistorypage';
				data = {
					s_name:$("#s_name").val(),
					s_operateDate_low:$("#s_operateDate_low").datebox('getValue'),
					s_operateDate_top:$("#s_operateDate_top").datebox('getValue'),
					s_operatorName:$("#s_operatorName").val()
					};
				frmDataStr = JSON.stringify(data);
				//alert(frmDataStr);
			}
			
			//alert(myurl);
			//alert(frmDataStr);
			
			$('#ttt').datagrid({  
				type:'POST',
				async:false,					
			    url:myurl,  
			   	queryParams:data,
				dataType: 'json',
				contentType : 'application/json',					
				toolbar:'#tb',
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
				fit:true,
				onDblClickRow:function(rowIndex, rowData){
					//alert(rowData.cardType + ":" + rowData.cardId);
					if(rowData.cardType == "登记卡")
						viewCardInfo(rowData);
					if(rowData.cardType == "借出卡")
						viewLendCard(rowData);
					if(rowData.cardType == "归还卡")
						viewReturnCard(rowData);
					if(rowData.cardType == "迁移卡")
						viewMigrageCard(rowData);
				},
			    columns:[[  
					{field:'id',title:'id',width:30},  
					{field:'operateDate',title:'维护时间',width:120},  
					{field:'operatorName',title:'操作人员',width:100},
					{field:'name',title:'名称',width:100},   
					{field:'cardType',title:'卡类型',width:100},  
					{field:'operateType',title:'操作类型',width:100},  
					{field:'memo',title:'备注',width:250}  
			    ]]  
			});
		}
		

		////////////view detail
		function viewCardInfo(){ 
		    var row = $('#ttt').datagrid('getSelected');  

			$.ajax({
				type:'POST',
				async:false,
				url:'${ctx}/jsonfindcardInfobyid?id='+row.cardId,
				data:'',
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
						row= result.obj;

						if (row){  
							$('#dlg').dialog('open').dialog('setTitle','Edit cardInfo');   
							$('#dlg').dialog("move",{top:$(document).scrollTop()}); 

							$('#fm').form('load',row);  
							$('#status').combobox('setValue',row.status);
							$('#gender').combobox('setValue',row.gender);
							$('#bloodType').combobox('setValue',row.bloodType);
							$('#cardType').combobox('setValue',row.cardType);
         
						}else{
							alert("请选择一行记录!");
						} 

						$('#dlgReturn').dialog('close');      // close the dialog             
					}
				}  
			});		  
		} 

		function viewLendCard(){ 
		    var selrow = $('#ttt').datagrid('getSelected');   

			$.ajax({
				type:'POST',
				async:false,
				url:'${ctx}/jsonfindlendCardbyid?id='+selrow.cardId,
				data:'',
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
						row= result.obj;

						if (row){  
							$('#dlgLend').dialog('open').dialog('setTitle','借出信息');   
							$("#dlgLend").dialog("move",{top:$(document).scrollTop()}); 

							$('#fmLend').form('load',row);  
							$('#fmLend #id').val("");
							$('#fmLend #name').val(selrow.name);
							$('#fmLend #cardId').val(row.id);
						}else{
							alert("请选择一行记录!");
						}   
					}
				}  
			});		  
		} 

		function viewReturnCard(){ 
		    var selrow = $('#ttt').datagrid('getSelected'); 
			
			$.ajax({
				type:'POST',
				async:false,
				url:'${ctx}/jsonfindreturnCardbyid?id='+selrow.cardId,
				data:'',
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
						row= result.obj;

						if (row){  
							$('#dlgReturn').dialog('open').dialog('setTitle','归还信息');   
							$('#dlgReturn').dialog("move",{top:$(document).scrollTop()}); 

							$('#fmReturn').form('load',row);  
							$('#fmReturn #id').val("");
							$('#fmReturn #name').val(selrow.name);
							$('#fmReturn #cardId').val(row.id);
						}else{
							alert("请选择一行记录!");
						}   
					}
				}  
			});	
		} 

		function viewMigrageCard(){ 
		    var selrow = $('#ttt').datagrid('getSelected');  

			$.ajax({
				type:'POST',
				async:false,
				url:'${ctx}/jsonfindmigrateCardbyid?id='+selrow.cardId,
				data:'',
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
						row= result.obj;

						if (row){  
							$('#dlgMigrate').dialog('open').dialog('setTitle','迁移信息');   
							$('#dlgMigrate').dialog("move",{top:$(document).scrollTop()}); 

							$('#fmMigrate').form('load',row);  
							$('#fmMigrate #id').val("");
							$('#fmMigrate #name').val(selrow.name);
							$('#fmMigrate #cardId').val(row.id);
						}else{
							alert("请选择一行记录!");
						}   
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
    <div>  
        名称: <input style="width:150px" id="s_name">  
        操作日期: <input style="width:150px" id="s_operateDate_low" class="easyui-datebox">  到  <input class="easyui-datebox" style="width:150px" id="s_operateDate_top">
        操作员: <input style="width:150px" id="s_operatorName">  
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="query('2')">查询</a>  
    </div>
</div>
</div>









<div id="dlg" class="easyui-dialog" style="width:1000px;height:400px;padding:5px 5px"  
        closed="true" buttons="#dlg-buttons" modal="true"  > 
    <form id="fm" method="post" contentType="application/json">
    	<div><table width="100%">
        <tr><td>   
        <div class="fitem"> 
            <label>名称</label>  
            <input id="name" name="name" class="easyui-validatebox" required="true">  
        </div></td><td>          
        <div class="fitem">  
            <label>曾用名</label>  
            <input id="oldName" name="oldName" class="easyui-validatebox" >  
        </div></td><td>
        <div class="fitem">  
            <label>籍贯</label>  
            <input id="nativePlace" name="nativePlace"  class="easyui-validatebox" required="true">  
        </div></td></tr>

        <tr><td> 
        <div class="fitem">  
            <label>生日</label>  
            <input id="birthDay" name="birthDay"  class="easyui-datebox" readOnly="true"  class="easyui-validatebox" required="true"> 
        </div></td><td>
        <div class="fitem">  
            <label>信仰</label>  
            <input id="belief" name="belief"  class="easyui-validatebox" required="true">  
        </div>  </td><td>
        <div class="fitem">  
			<label>血型</label>  
			<input id="bloodType" name="bloodType"  class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=blood_type"  
			                valueField="codeValue" textField="codeName">  
		</div></td></tr>
        
        <tr><td>
        <div class="fitem">  
            <label>出生地</label>  
            <input id="birthPlace" name="birthPlace"  class="easyui-validatebox" required="true">  
        </div>  </td><td>
        <div class="fitem">  
			<label>生源地</label>  
			<input id="originStudent" name="originStudent"  class="easyui-validatebox" required="true">  
		</div></td><td>
        <div class="fitem">  
            <label>住址</label>  
            <input id="address" name="address"  class="easyui-validatebox" required="true">  
        </div></td></tr>

		<tr><td>
        <div class="fitem">  
			<label>身高</label>  
			<input id="height" name="height"  class="easyui-validatebox" required="true">  
		</div></td><td>
        <div class="fitem">  
            <label>身份证</label>  
            <input id="identityCard" name="identityCard"  class="easyui-validatebox" required="true">  
        </div></td><td>
        <div class="fitem">  
			<label>卡类型</label>  
			<input id="cardType" name="cardType"  class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=card_type"  
			                valueField="codeValue" textField="codeName">  
		</div></td></tr>

		<tr><td>
        <div class="fitem">  
            <label>民族</label>  
            <input id="nation" name="nation"  class="easyui-validatebox" required="true">  
        </div>  </td><td>
        <div class="fitem">  
			<label>性别</label>  
			<input id="gender" name="gender"  required="true" class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=gender_type"  
			                valueField="codeValue" textField="codeName">  
		</div></td><td>
        <div class="fitem">  
            <label>户主</label>  
            <input id="cardOwner" name="cardOwner"  class="easyui-validatebox" required="true">  
        </div></td></tr>

		<tr><td>
        </td><td>
        <div class="fitem">  
            <label>创建人</label>  
            <input id="creatorName" name="creatorName"   readOnly="true">  
        </div></td><td>
        <div class="fitem">  
			<label>创建日期</label>  
			<input id="createDate" name="createDate"   readOnly="true">  
		</div></td></tr>
		
		<tr><td>
        <div class="fitem">  
            <label>最后修改人</label>  
            <input id="updaterName" name="updaterName"   readOnly="true">  
        </div>  </td><td>
        <div class="fitem">  
			<label>最后修改日期</label>  
			<input id="updaterDate" name="updaterDate"  readOnly="true">  
		</div></td><td>
        <div class="fitem">  
			<label>状态</label>  
			<input id="status" name="status" class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=user_status"  
			                valueField="codeValue" textField="codeName">  
		</div></td></tr>

        <tr><td colspan="2">  
        <div class="fitem">  
            <label>备注:</label>  
            <input id="memo" name="memo" size="100">  
			<input id="id" name="id" readOnly="true" type="hidden"> 
        </div></td></tr></table></div>
    </form>  
</div>   
<div id="dlg-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>  
</div>
<!--///////////////////////////////////-->
<div id="dlgLend" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"  
        closed="true" buttons="#dlgLend-buttons" modal="true"  >  
    <div class="ftitle">借出信息</div>  
    <form id="fmLend" method="post" contentType="application/json">
    	<div class="fitem">  
            <label>Id:</label>  
            <input id="id" name="id" readOnly="true">  
			<input id="cardId" name="cardId" type="hidden"> 
        </div>   
        <div class="fitem">  
            <label>名称:</label>  
            <input id="name" name="name" class="easyui-validatebox" required="true" readOnly="true">  
        </div>  
        <div class="fitem">  
            <label>借出日期:</label>  
            <input id="lendDate" name="lendDate"  class="easyui-datebox" readOnly="true"  class="easyui-validatebox" required="true">
        </div>  
        <div class="fitem">  
            <label>预计归还日期:</label>  
            <input id="toReturnDate" name="toReturnDate"  class="easyui-datebox" readOnly="true"  class="easyui-validatebox" required="true">
        </div>
		<div class="fitem">  
            <label>移动电话:</label>  
            <input id="mobile" name="mobile" class="easyui-validatebox" required="true">  
        </div> 
		<div class="fitem">  
            <label>住宅电话:</label>  
            <input id="tel" name="tel" class="easyui-validatebox" required="true">  
        </div> 
		<div class="fitem">  
            <label>备注:</label>  
            <input id="memo" name="memo" class="easyui-validatebox" >  
        </div>
    </form>  
</div>   
<div id="dlgLend-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgLend').dialog('close')">关闭</a>  
</div>


<!--///////////////////////////////////-->
<div id="dlgReturn" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"  
        closed="true" buttons="#dlgReturn-buttons" modal="true"  >  
    <div class="ftitle">归还信息</div>  
    <form id="fmReturn" method="post" contentType="application/json">
    	<div class="fitem">  
            <label>Id:</label>  
            <input id="id" name="id" readOnly="true">
			<input id="cardId" name="cardId" type="hidden"> 
        </div>   
        <div class="fitem">  
            <label>名称:</label>  
            <input id="name" name="name" class="easyui-validatebox" required="true" readOnly="true">  
        </div>  
         <!--<div class="fitem">  
            <label>借出日期:</label>  
            <input id="lendDate"  readOnly="true">
        </div>  
        <div class="fitem">  
            <label>预计归还日期:</label>  
            <input id="toReturnDate"   readOnly="true">
        </div>-->
		<div class="fitem">  
            <label>实际归还日期:</label>  
            <input id="returnDate" name="returnDate"  class="easyui-datebox" readOnly="true"  class="easyui-validatebox" required="true">
        </div>
		<div class="fitem">  
            <label>备注:</label>  
            <input id="memo" name="memo" class="easyui-validatebox" >  
        </div>
    </form>  
</div>   
<div id="dlgReturn-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgReturn').dialog('close')">关闭</a>  
</div>

<!--///////////////////////////////////-->
<div id="dlgMigrate" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"  
        closed="true" buttons="#dlgMigrate-buttons" modal="true"  >  
    <div class="ftitle">迁出信息</div>  
    <form id="fmMigrate" method="post" contentType="application/json">
    	<div class="fitem">  
            <label>Id:</label>  
            <input id="id" name="id" readOnly="true"> 
			<input id="cardId" name="cardId" type="hidden"> 
        </div>   
        <div class="fitem">  
            <label>名称:</label>  
            <input id="name" name="name" class="easyui-validatebox" required="true" readOnly="true">  
        </div>  
        <div class="fitem">  
            <label>迁出日期:</label>  
            <input id="migrateDate" name="migrateDate"  class="easyui-datebox" readOnly="true"  class="easyui-validatebox" required="true">
        </div>  
       <div class="fitem">  
            <label>迁移目的地:</label>  
            <input id="migratePlace" name="migratePlace" class="easyui-validatebox" required="true" >  
        </div> 
		<div class="fitem">  
            <label>备注:</label>  
            <input id="memo" name="memo" class="easyui-validatebox" >  
        </div>
    </form>  
</div>   
<div id="dlgMigrate-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgMigrate').dialog('close')">关闭</a>  
</div>

<!--new edit dialog ending-->
</body>
</html>