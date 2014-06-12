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
		clickCardInfo();
		$('#s_birthday_low').datebox({
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
		$('#s_birthday_top').datebox({
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
		$('#birthDay').datebox({
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
		$('#lendDate').datebox({
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
		$('#returnDate').datebox({
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
		$('#toReturnDate').datebox({
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
		$('#migrateDate').datebox({
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
	});	
	//left menu
	function clickCardInfo(){
		$('#ttt').datagrid({  
			url:'${ctx}/jsonfindallcardInfopage',  
			toolbar:'#tb',
			pagination:true,//分页控件  
        		rownumbers:true,//行号  
			singleSelect:true,
			fit:true,
			columns:[[  
				 {field:'id',title:'id',width:15},  
				{field:'status',title:'状态',width:50,align:'right',
					formatter:function(val,rec){ 
						if (val == '0'){ 
							return '无效'; 
						}else if (val == '1'){ 
							return '有效'; 
						}else if (val == '2'){ 
							return '删除'; 
						}else if (val == '3'){ 
							return '滞留'; 
						}else { 
							return ''; 
						} 
					} 
				},  
				{field:'name',title:'名称',width:50,align:'right'},  
				{field:'gender',title:'性别',width:40,align:'right',
					formatter:function(val,rec){ 
						if (val == '1'){ 
							return '男'; 
						}else if (val == '2'){ 
							return '女'; 
						}else { 
							return ''; 
						} 
					} 
				},  
				{field:'nation',title:'民族',width:40,align:'right'},  
				{field:'cardOwner',title:'户主',width:150,align:'right'},
				{field:'birthDay',title:'生日',width:80,align:'right'},  
				{field:'identityCard',title:'身份证',width:80,align:'right'},  
				{field:'address',title:'住址',width:150,align:'right'},  
				{field:'birthPlace',title:'出生地',width:150,align:'right'},  
				{field:'originStudent',title:'生源地',width:150,align:'right'}, 
				{field:'memo',title:'备注',width:400,align:'right'} 
			]]  
		});				 
	}

	function queryCardInfo(){
		var frmDataStr = "";
		data = {
			s_name:$("#s_name").val(),
			s_birthday_low:$("#s_birthday_low").datebox('getValue'),
			s_birthday_top:$("#s_birthday_top").datebox('getValue'),
			s_birthPlace:$("#s_birthPlace").val(),
			s_address:$("#s_address").val(),
			s_originStudent:$("#s_originStudent").val()
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
			url:'${ctx}/jsonfindallcardInfopage', 
			pagination:true,//分页控件  
        		rownumbers:true,//行号  
			singleSelect:true,
			columns:[[  
				{field:'id',title:'id',width:15},    
				{field:'status',title:'状态',width:50,align:'right'},  
				{field:'name',title:'名称',width:50,align:'right'},  
				{field:'gender',title:'性别',width:40,align:'right'},  
				{field:'nation',title:'民族',width:40,align:'right'},  
				{field:'cardOwner',title:'户主',width:150,align:'right'},
				{field:'birthDay',title:'生日',width:80,align:'right'},  
				{field:'identityCard',title:'身份证',width:80,align:'right'},  
				{field:'address',title:'住址',width:150,align:'right'},  
				{field:'birthPlace',title:'出生地',width:150,align:'right'},  
				{field:'originStudent',title:'生源地',width:150,align:'right'}, 
				{field:'memo',title:'备注',width:400,align:'right'} 
			]]  
		});
	}
	
	//Content area
	var urlcardInfo;

	function addCardInfo(){  
		$('#dlg').dialog('open').dialog('setTitle','新建卡片信息');  
		$("#dlg").dialog("move",{top:$(document).scrollTop()}); 
		
		$('#fm').form('clear');   
		$('#cardOwner').val('集体');
		

		urlcardInfo = '${ctx}/jsonsavecardInfo'; 			
	} 
	
	function removeCardInfo(){  
		var row = $('#ttt').datagrid('getSelected');  
		//alert(row.id);
			if (row){
				$.ajax({
					type:'POST',
					async:false,
					url:'${ctx}/jsonremovecardInfobyid?id='+row.id,
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
							$('#ttt').datagrid('reload');    // reload the cardInfo data                  
						}
					}  
				});		
				
			}else{
				alert("please choose one row!");
			} 
	}
	
	function editCardInfo(){ 
		var row = $('#ttt').datagrid('getSelected');  
	  //  alert(JSON.stringify(row));
			if (row){  
				$('#dlg').dialog('open').dialog('setTitle','修改卡片信息'); 
				//$("#dlg").dialog("move",{top:$(document).scrollTop() + ($(window).height()-250) * 0.5}); 
				$("#dlg").dialog("move",{top:$(document).scrollTop()}); 

				$('#fm').form('load',row);  

				$('#status').val(row.status);
				$('#gender').val(row.gender);
				$('#bloodType').val(row.bloodType);

				$('#educationInfo').val(row.educationInfo);
				$('#marriageInfo').val(row.marriageInfo);
				$('#militarySituation').val(row.militarySituation);
				$('#job').val(row.job);

				$('#status').combobox('setValue',row.status);
				$('#gender').combobox('setValue',row.gender);
				$('#bloodType').combobox('setValue',row.bloodType);
				//$('#cardType').combobox('setValue',row.cardType);

				$('#educationInfo').combobox('setValue',row.educationInfo);
				$('#marriageInfo').combobox('setValue',row.marriageInfo);
				$('#militarySituation').combobox('setValue',row.militarySituation);
				$('#job').combobox('setValue',row.job);

				urlcardInfo = '${ctx}/jsonsavecardInfo?id='+row.id;  
				
				 //$('#ttt').datagrid('reload');    // reload the cardInfo data            
			}else{
				alert("请选择一个卡片!");
			} 
	} 
	
	function saveCardInfo(){
		var frmDataObj = $('#fm').serializeObject();
		//frmDataObj.birthDay = frmDataObj.birthDay + " 00:00:00";
		//frmDataObj.createDate = frmDataObj.createDate + " 00:00:00";
		//frmDataObj.updaterDate = frmDataObj.updaterDate + " 00:00:00";
	//	alert(JSON.stringify(frmDataObj));
//alert(1 + ":" + frmDataObj.status)
	
//alert(1 + ":" + $('#status').combobox('getValue'));
		frmDataObj.status = $('#status').combobox('getValue');
		frmDataObj.gender = $('#gender').combobox('getValue');
		frmDataObj.bloodType = $('#bloodType').combobox('getValue');
		//frmDataObj.cardType = $('#cardType').combobox('getValue');

		frmDataObj.educationInfo = $('#educationInfo').combobox('getValue');
		frmDataObj.marriageInfo = $('#marriageInfo').combobox('getValue');
		frmDataObj.militarySituation  = $('#militarySituation').combobox('getValue');
		frmDataObj.job = $('#job').combobox('getValue');

		var frmDataStr = JSON.stringify(frmDataObj);
		$.ajax({
			type:'POST',
			async:false,
			url:urlcardInfo,
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
					$('#ttt').datagrid('reload');    // reload the cardInfo data                  
				}
			}  
		});		    
	}  
	

	//////////////lend
	var urlLendCard;
	function addLendCard(){ 
		var row = $('#ttt').datagrid('getSelected');  
	  //  alert(JSON.stringify(row));
			if (row){  
				$('#dlgLend').dialog('open').dialog('setTitle','借出信息');  
				$("#dlgLend").dialog("move",{top:$(document).scrollTop()});  

				$('#fmLend').form('load',row);  
				$('#fmLend #id').val("");
				$('#fmLend #cardId').val(row.id);
				$('#fmLend #memo').val("");
				urlLendCard = '${ctx}/jsonsavelendCard';           
			}else{
				alert("please choose one row!");
			} 
	} 
	
	function saveLendCard(){
		var frmDataObj = $('#fmLend').serializeObject();
		frmDataObj.status = $('#status').combobox('getValue');
		frmDataObj.purpose = $('#purpose').combobox('getValue');
		var frmDataStr = JSON.stringify(frmDataObj);
		$.ajax({
			type:'POST',
			async:false,
			url:urlLendCard,
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
					$('#dlgLend').dialog('close');      // close the dialog             
				}
			}  
		});		    
	}  





	///////////////return
	var urlReturnCard;
	function addReturnCard(){ 
		var row = $('#ttt').datagrid('getSelected');  
	  //  alert(JSON.stringify(row));
			if (row){  
				$('#dlgReturn').dialog('open').dialog('setTitle','归还信息');   
				$("#dlgReturn").dialog("move",{top:$(document).scrollTop()}); 

				$('#fmReturn').form('load',row);  
				$('#fmReturn #id').val("");
				$('#fmReturn #cardId').val(row.id);
				$('#fmReturn #memo').val("");
				urlReturnCard = '${ctx}/jsonsavereturnCard';     
			}else{
				alert("please choose one row!");
			} 
	} 
	
	function saveReturnCard(){
		var frmDataObj = $('#fmReturn').serializeObject();
		frmDataObj.status = $('#status').combobox('getValue');
		var frmDataStr = JSON.stringify(frmDataObj);
		$.ajax({
			type:'POST',
			async:false,
			url:urlReturnCard,
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
					$('#dlgReturn').dialog('close');      // close the dialog             
				}
			}  
		});		    
	}


	///////////////migrate
	var urlMigrateCard;
	function addMigrageCard(){ 
		var row = $('#ttt').datagrid('getSelected');  
	  //  alert(JSON.stringify(row));
			if (row){  
				$('#dlgMigrate').dialog('open').dialog('setTitle','迁移信息');  
				$("#dlgMigrate").dialog("move",{top:$(document).scrollTop()}); 

				
				$('#fmMigrate').form('load',row);  
				$('#fmMigrate #id').val("");
				$('#fmMigrate #cardId').val(row.id);
				$('#fmMigrate #memo').val("");
				urlMigrateCard = '${ctx}/jsonsavemigrateCard';     
			}else{
				alert("please choose one row!");
			} 
	} 
	
	function saveMigrateCard(){
		var frmDataObj = $('#fmMigrate').serializeObject();
		frmDataObj.status = $('#status').combobox('getValue');
		var frmDataStr = JSON.stringify(frmDataObj);
		$.ajax({
			type:'POST',
			async:false,
			url:urlMigrateCard,
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
					$('#dlgMigrate').dialog('close');      // close the dialog             
				}
			}  
		});		    
	}
	////////////////dlg end

	
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
			padding:10px 10px;
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
			width:150px;
		}
	</style>
<div id=ttt>
<div id="tb" style="padding:5px;height:auto">  
    <div style="margin-bottom:5px">  
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick=addCardInfo()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editCardInfo()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeCardInfo()></a>  
    </div> 
	<div>  
		名称：<input style="width:150px" id="s_name">   
		生日: <input class="easyui-datebox" style="width:120px"  id="s_birthday_low" name="s_birthday_low" class="easyui-datebox">  
		To: <input class="easyui-datebox" style="width:120px"  id="s_birthday_top" name="s_birthday_top" class="easyui-datebox">  		
		出生地：<input style="width:150px" id="s_birthPlace">  
		住址：<input style="width:150px" id="s_address">  
		生源地：<input style="width:150px" id="s_originStudent"> 
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryCardInfo()">查询</a> ||
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="addMigrageCard()">迁移</a> ||
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="addLendCard()">外借</a> ||
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="addReturnCard()">归还</a> 
	</div>
</div>
</div>

<div id="dlg" class="easyui-dialog" style="width:1000px;height:450px;padding:5px 5px"  
        closed="true" buttons="#dlg-buttons" modal="true"  > 
    <form id="fm" method="post" contentType="application/json">
    	<div><table width="100%">
        <tr><td>   
        <div class="fitem"> 
            <label>名称</label>  
            <input id="name" name="name" class="easyui-validatebox" required="true">  
        </div></td><td>          
        <div class="fitem">  
            <label>户主或与户主关系</label>  
            <input id="cardOwner" name="cardOwner" value="集体" readOnly="readOnly">  
        </div></td><td>
        <div class="fitem">  
            <label>曾用名</label>  
            <input id="oldName" name="oldName" class="easyui-validatebox" >  
        </div></td><td>
        <div class="fitem">  
			<label>性别</label>  
			<input id="gender" name="gender"  required="true" class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=gender_type"  
			                valueField="codeValue" textField="codeName">  
		</div></td><td>
        <div class="fitem">  
            <label>出生地</label>  
            <input id="birthPlace" name="birthPlace"  class="easyui-validatebox" required="true">  
        </div>  </td></tr>

        <tr><td>
        <div class="fitem">  
            <label>民族</label>  
            <input id="nation" name="nation"  class="easyui-validatebox" required="true">  
        </div>  </td><td>
        <div class="fitem">  
            <label>籍贯</label>  
            <input id="nativePlace" name="nativePlace"  class="easyui-validatebox" required="true">  
        </div></td><td> 
        <div class="fitem">  
            <label>出生日期</label>  
            <input id="birthDay" name="birthDay"  class="easyui-datebox" readOnly="true"  class="easyui-validatebox" required="true"> 
        </div></td><td>
        <div class="fitem">  
            <label>本市(县)其他住址</label>  
            <input id="address" name="address"  class="easyui-validatebox" required="true">  
        </div></td><td>
        <div class="fitem">  
            <label>宗教信仰</label>  
            <input id="belief" name="belief" >  
        </div>  </td></tr>
        
        <tr><td>
        <div class="fitem">  
            <label>身份证</label>  
            <input id="identityCard" name="identityCard"  class="easyui-validatebox" required="true">  
        </div></td><td>
        <div class="fitem">  
			<label>身高</label>  
			<input id="height" name="height" >  
		</div></td><td>
        <div class="fitem">  
			<label>血型</label>  
			<input id="bloodType" name="bloodType"  class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=blood_type"  
			                valueField="codeValue" textField="codeName">  
		</div></td><td>
        <div class="fitem">  
			<label>文化程度</label>  
			<input id="educationInfo" name="educationInfo"  class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=educationInfo"  
			                valueField="codeValue" textField="codeName">  
		</div></td><td>
        <div class="fitem">  
			<label>婚姻情况</label>  
			<input id="marriageInfo" name="marriageInfo"  class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=marriageInfo"  
			                valueField="codeValue" textField="codeName">  
		</div></td></tr>

		<tr><td>
        <div class="fitem">  
			<label>兵役情况</label>  
			<input id="militarySituation" name="militarySituation"  class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=militarySituation"  
			                valueField="codeValue" textField="codeName">  
		</div></td><td>
        <div class="fitem">  
			<label>服务处所(院系所)</label>  
			<input id="academe" name="academe"  class="easyui-validatebox" required="true">  
		</div></td><td>
        <div class="fitem">  
			<label>职业(卡类型)</label>  
			<input id="job" name="job"  class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=job"  
			                valueField="codeValue" textField="codeName"  class="easyui-validatebox" required="true">  
		</div></td><td>
        <div class="fitem">  
			<label>生源地</label>  
			<input id="originStudent" name="originStudent"  class="easyui-validatebox" required="true">  
		</div></td><td>
        <div class="fitem">  
            <label>家属情况</label>  
            <input id="family" >  
        </div>  </td></tr>

		<tr><td colspan="2">
        <div class="fitem">  
            <label>何时由何地迁来本市(县）</label>  
            <input id="whenWhereToThisCity" name="whenWhereToThisCity" style="width:400px"  >  
        </div></td><td>
        <div class="fitem">  
            <label>创建人</label>  
            <input id="creatorName" name="creatorName"   readOnly="true">  
        </div></td><td>
        <div class="fitem">  
			<label>创建日期</label>  
			<input id="createDate" name="createDate"   readOnly="true">  
		</div></td></tr>
		
		<tr><td colspan="2">
        <div class="fitem">  
            <label>何时由何地迁来本址</label>  
            <input id="whenWhereToThisAddress" name="whenWhereToThisAddress" style="width:400px"  >  
        </div>  </td><td>
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

        <tr><td colspan="5">  
        <div class="fitem">  
            <label>备注:</label>  
            <input id="memo" name="memo" size="180">  
			<input id="id" name="id" readOnly="true" type="hidden"> 
        </div></td></tr></table></div>
    </form>  
</div>   
<div id="dlg-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCardInfo()">保存</a>  
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
            <label>用途:</label>  
            <input id="purpose" name="purpose" class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=purpose"  
			                valueField="codeValue" textField="codeName">  
        </div>
		<div class="fitem">  
            <label>备注:</label>  
            <input id="memo" name="memo" class="easyui-validatebox" >  
        </div>
    </form>  
</div>   
<div id="dlgLend-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveLendCard()">保存</a>  
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
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveReturnCard()">保存</a>  
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
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveMigrateCard()">保存</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgMigrate').dialog('close')">关闭</a>  
</div>
<!--new edit dialog ending-->


</body>
</html>