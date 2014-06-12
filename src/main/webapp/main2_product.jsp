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
		alert(11112)
		queryProduct();
		
		$('#createDate').datebox({
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
			
		function queryProduct(flag){
			var myurl = "";
			var frmDataStr = "";
			var data = {};
			if(!flag){
				myurl = '${ctx}/jsonfindallproductpage';
				data = {					
					s_page:1,
					s_rows:10
				};
				frmDataStr = JSON.stringify(data);
			}else if(flag=1){
				myurl = '${ctx}/findAllProductByFullTextSearch2?searchContent='+$("#searchContent").val();
			}else{
				myurl = '${ctx}/jsonfindallproductpage';
				data = {
					s_name:$("#s_name").val(),
					s_tradeMark:$("#s_tradeMark").val(),
					s_type:$("#s_type").val(),
					s_model:$("#s_model").val(),
					s_cost_low:$("#s_cost_low").val(),
					s_cost_top:$("#s_cost_top").val(),
					s_unitprice_low:$("#s_unitprice_low").val(),
					s_unitprice_top:$("#s_unitprice_top").val(),
					s_allowance_low:$("#s_allowance_low").val(),
					s_allowance_top:$("#s_allowance_top").val(),
					s_page:$('#ttt').datagrid('getPageNumber'),
					s_rows:$('#ttt').datagrid('getPageSize')
					};
					
				frmDataStr = JSON.stringify(data);
			}
			
			alert(myurl);
			alert(frmDataStr);
			
			$('#ttt').datagrid({  
					type:'POST',
					async:false,					
			    url:myurl,  
			   	queryParams:frmDataStr,
					dataType: 'json',
					contentType : 'application/json',					
					toolbar:'#tb',
			    pagination:true,//分页控件  
        	rownumbers:true,//行号  
					singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},
			        {field:'name',title:'名称',width:100,align:'right'},
			        {field:'tradeMark',title:'品牌',width:100},
			        {field:'supplierName',title:'供货商',width:100},
			        {field:'productType',title:'类别',width:100},
			        {field:'model',title:'型号',width:100},
			        {field:'createDate',title:'创建日期',width:100},
			        {field:'createUserName',title:'创建人',width:100},
			        {field:'cost',title:'成本',width:100},
			        {field:'unit',title:'单位',width:100},
			        {field:'unitPrice',title:'单价',width:100},
			        {field:'allowance',title:'余量',width:100},
			        {field:'allowancePrice',title:'余量总额',width:100}
			    ]]  
			});
		}
		
		//Content area
		var urlProduct;
	
		function addProduct(){  
		    $('#dlg').dialog('open').dialog('setTitle','New Product');  
		    $('#fm').form('clear');   
		    urlProduct = '${ctx}/jsonsaveproduct'; 
		} 
		
		function removeProduct(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    alert(row.id);
				if (row){
				    $.ajax({
							type:'POST',
							async:false,
							url:'${ctx}/jsonremoveproductbyid?id='+row.id,
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
		                $('#ttt').datagrid('reload');    // reload the product data                  
		            }
			        }  
						});		
				    
				}else{
					alert("please choose one row!");
				} 
		}
		
		function editProduct(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				    $('#dlg').dialog('open').dialog('setTitle','Edit Product');  
				    $('#fm').form('load',row);  
				    urlProduct = '${ctx}/jsonsaveproduct?id='+row.id;  
				    
				     $('#ttt').datagrid('reload');    // reload the product data            
				}else{
					alert("please choose one row!");
				} 
		} 
		
		function saveProduct(){  				
		    var frmDataObj = $('#fm').serializeObject();
		    var frmDataStr = JSON.stringify(frmDataObj);
		    $.ajax({
					type:'POST',
					async:false,
					url:urlProduct,
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
                $('#ttt').datagrid('reload');    // reload the product data                  
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
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick=addProduct()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editProduct()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeProduct()></a>  
        &nbsp;&nbsp;<input style="width:200px" id="searchContent"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryProduct('1')">Search</a>  
    </div>
    <div>  
        名称: <input style="width:150px" id="s_name">  
        品牌: <input style="width:150px" id="s_tradeMark">  
        供货商: <input style="width:150px" id="s_supplier">  
        类别:
        <input class="easyui-combobox" style="width:100px"  id="s_type"
                url="${ctx}/getcode?type=1"  
                valueField="id" textField="text">  
        型号:
        <input class="easyui-combobox" style="width:100px"  id="s_model"
                url="${ctx}/getcode?type=2"  
                valueField="id" textField="text"></br>
        成本: <input style="width:150px" id="s_cost_low" class="easyui-numberbox" precision="2" max="9999999.99" min="0.0" maxlength="10">  -  <input style="width:150px" id="s_cost_top" class="easyui-numberbox" precision="2" max="9999999.99" min="0.0" maxlength="10">  
        单价: <input style="width:150px" id="s_unitprice_low" class="easyui-numberbox" precision="2" max="9999999.99" min="0.0" maxlength="10">  -  <input style="width:150px" id="s_unitprice_top" class="easyui-numberbox" precision="2" max="9999999.99" min="0.0" maxlength="10">  
        余量: <input style="width:150px" id="s_allowance_low" class="easyui-numberbox" precision="2" max="9999999.99" min="0.0" maxlength="10">  -  <input style="width:150px" id="s_allowance_top" class="easyui-numberbox" precision="2" max="9999999.99" min="0.0" maxlength="10">  
        
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryProduct('2')">查询</a>  
    </div>
</div>
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:550px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttons" modal="true"  >  
    <div class="ftitle">Product Information</div>  
    <form id="fm" method="post" contentType="application/json">
    	<div class="fitem">  
            <label>Id:</label>  
            <input name="id" readOnly="true">  
        </div>   
        <div class="fitem">  
            <label>名称:</label>  
            <input name="name" class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>类别:</label>  
            <input name="productType" class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>品牌:</label>  
            <input name="tradeMark" class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>型号:</label>  
            <input name="model">  
        </div>
        <div class="fitem">  
            <label>供货商:</label>  
            <input id="supplierId" name="supplierId" type="hidden">
            <input id="supplierName" name="supplierName"  class="easyui-validatebox" required="true" readOnly><a href="#" id="btnQuerySupplier" iconCls="icon-search" onClick="querySupplier()">选择</a>   
        </div>
        <div class="fitem">  
            <label>成本:</label>  
            <input name="cost" readOnly>  
        </div>
        <div class="fitem">  
            <label>单价:</label>  
            <input name="unitPrice" readOnly>  
        </div>
        <div class="fitem">  
            <label>单位:</label>  
            <input name="unit"  class="easyui-validatebox" required="true">  
        </div>
        <div class="fitem">  
            <label>余量:</label>  
            <input name="allowance" readOnly>  
        </div>
        <div class="fitem">  
            <label>余额:</label>  
            <input name="allowancePrice" readOnly>  
        </div>  
        <div class="fitem">  
            <label>登记人:</label>  
            <input id="createUserId" name="createUserId" type="hidden">
            <input id="createUserName" name="createUserName" >      
        </div>  
        <div class="fitem">  
            <label>登记日期:</label>  
            <input id="createDate" name="createDate"  class="easyui-datebox"  class="easyui-validatebox" required="true">  
        </div>  
        <div class="fitem">  
            <label>备注:</label>  
            <input name="memo">  
        </div>  
    </form>  
</div>   
<div id="dlg-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveProduct()">Save</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>  
</div>



<script>

		function querySupplier(){
			$('#dlgCustomerQuery').dialog('open').dialog('setTitle','选择供货商');  
			
			$('#customerQueryGrid').datagrid({  
			    url:'${ctx}/jsonfindallcustomerpage',  
				toolbar:'#tbUQ',
			    pagination:true,//分页控件  
        		rownumbers:true,//行号  
				singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'shortName',title:'简称',width:100},  
			        {field:'type',title:'类别',width:100,align:'right'},  
			        {field:'address',title:'地址',width:100,align:'right'},  
			        {field:'salesManName',title:'业务员',width:100,align:'right'} 
			    ]]  
			});
		}
		
		function selectSupplier(){
			var row = $('#customerQueryGrid').datagrid('getSelected');  
			if(!row){
				alert("请选择用户!");
			}else{
				$("#supplierId").val(row.id);
				$("#supplierName").val(row.shortName);
				$('#dlgCustomerQuery').dialog('close');
				
				
				$("#fm").form('validate');
			}
		}
</script>
<div id="dlgCustomerQuery" class="easyui-dialog" style="width:900px;height:500px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttonsCustomerQuery" modal="true"  >  
    <div class="ftitle">Product Information</div>  
    <div id="customerQueryGrid">
			<div id="tbUQ" style="padding:5px;height:auto">  
			    <div>  
			        Date From: <input class="easyui-datebox" style="width:80px">  
			        To: <input class="easyui-datebox" style="width:80px">  
			        Language:   
			        <input class="easyui-combobox" style="width:100px"  
			                url="data/combobox_data.json"  
			                valueField="id" textField="text">  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="querySupplier()">Search</a>  
			    </div>  
			</div>
		</div>
</div>   
<div id="dlg-buttonsCustomerQuery">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="selectSupplier()">确定</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgCustomerQuery').dialog('close')">Cancel</a>  
</div>

</body>
</html>