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

		clickCardInfo();
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
				onDblClickRow:function(rowIndex, rowData){
					viewCardInfo(rowData);
				},
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
			        {field:'native_place',title:'籍贯',width:150,align:'right'},
					{field:'identityCard',title:'身份证',width:150,align:'right'},  
					{field:'address',title:'住址',width:200,align:'right'},  
					{field:'birthPlace',title:'出生地',width:200,align:'right'},  
					{field:'originStudent',title:'生源地',width:200,align:'right'}, 
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
				onDblClickRow:function(rowIndex, rowData){
					viewCardInfo(rowData);
				},
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
			        {field:'native_place',title:'籍贯',width:150,align:'right'},
					{field:'identityCard',title:'身份证',width:150,align:'right'},  
					{field:'address',title:'住址',width:200,align:'right'},  
					{field:'birthPlace',title:'出生地',width:200,align:'right'},  
					{field:'originStudent',title:'生源地',width:200,align:'right'}, 
					{field:'memo',title:'备注',width:400,align:'right'} 
			    ]]  
			});
		}
		
		
		////////////view detail
		function viewCardInfo(){ 
		    var row = $('#ttt').datagrid('getSelected');  

			$.ajax({
				type:'POST',
				async:false,
				url:'${ctx}/jsonfindcardInfobyid?id='+row.id,
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
         
						}else{
							alert("please choose one row!");
						} 

						$('#dlgReturn').dialog('close');      // close the dialog             
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

		function exportxls(){
			var url = "${ctx}/exportExcel?type=StuList&academe="+$('#academe').val();
			url += "&s_name="+$("#s_name").val();
			url += "&s_birthday_low="+$("#s_birthday_low").datebox('getValue');
			url += "&s_birthday_top="+$("#s_birthday_top").datebox('getValue');
			url += "&s_birthPlace="+$("#s_address").val();
			url += "&s_address="+$("#s_address").val();			
			url += "&s_originStudent="+$("#s_originStudent").val();
			window.open(url);   
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
	<div>  
		名称：<input style="width:150px" id="s_name">   
		生日: <input class="easyui-datebox" style="width:120px"  id="s_birthday_low" name="s_birthday_low" class="easyui-datebox">  
		To: <input class="easyui-datebox" style="width:120px"  id="s_birthday_top" name="s_birthday_top" class="easyui-datebox">  		
	</div>
	<div>出生地：<input style="width:150px" id="s_birthPlace">  
		住址：<input style="width:150px" id="s_address">  
		生源地：<input style="width:150px" id="s_originStudent"> 		
		<!-- 状态：<input id="s_status" class="easyui-combobox" style="width:100px"  
			                url="${ctx}/jsonbnufindallcodebytypeforcombobox?codeType=user_status"  
			                valueField="codeValue" textField="codeName">
							-->
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryCardInfo()">查询</a> ||
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="exportxls()">导出</a> 
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
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>  
</div>
<!--new edit dialog ending-->


</body>
</html>