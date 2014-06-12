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
		queryBill();
		
		$('#businessDate').datebox({
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

		$('#warehouseDate').datebox({
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
		
		$(".datebox :text").attr("readonly","readonly");
		
			 $.extend($.fn.datagrid.defaults.editors, {  
			    numbertext: {  
			        init: function(container, options){  
			            //alert(container.parents('table').html());
			            var input = $('&nbsp;<input type="text" class="datagrid-editable-input" size="12" class="easyui-numberbox" precision="2" max="9999999.99" min="0.0" maxlength="10" style="text-align:right;" onChange="caclAmount()">&nbsp;&nbsp;').appendTo(container);
			            return input;  
			        },  
			        getValue: function(target){  
			            return $(target).val();  
			        },  
			        setValue: function(target, value){  
			            $(target).val(value);  
			        },  
			        resize: function(target, width){  
			            var input = $(target);  
			            if ($.boxModel == true){  
			                input.width(width - (input.outerWidth() - input.width()));  
			            } else {  
			                input.width(width-5);  
			            }  
			        }  
			    },
			    searchtext: {  
			        init: function(container, options){  
			        		
			            var input = $('<input class="easyui-combobox" style="width:100px" readonly><a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryCustomerForBillDetail()">Search</a> ').appendTo(container);
			            return input;  
			        },  
			        getValue: function(target){
			        		return $(target).val();  
			        },  
			        setValue: function(target, value){  
			        	$(target).val(value);  
			        },  
			        resize: function(target, width){  
			            var input = $(target);  
			            if ($.boxModel == true){  
			                input.width(width - (input.outerWidth() - input.width()));  
			            } else {  
			                input.width(width-50);  
			            }  
			        }  
			    },
			    readonlytext: {  
			        init: function(container, options){  
			        		
			            var input = $('<input class="easyui-combobox" style="width:100px"  type="hidden">').appendTo(container);
			            return input;  
			        },  
			        getValue: function(target){
			        		return $(target).val();  
			        },  
			        setValue: function(target, value){  
			        	$(target).val(value);  
			        },  
			        resize: function(target, width){  
			            var input = $(target);  
			            if ($.boxModel == true){  
			                input.width(width - (input.outerWidth() - input.width()));  
			            } else {  
			                input.width(width-50);  
			            }  
			        }  
			    }			    
			}); 
	});	
	
		function caclAmount(){
			var amount = 0;
      
      
      var row1 = $('#billDetail').datagrid('getSelected');
      var rows = $('#billDetail').datagrid('getRows');
      
      if(row1){
	      var rindex = $('#billDetail').datagrid('getRowIndex', row1);
	      var ed = $('#billDetail').datagrid('getEditor', {
	              index : rindex,
	              field : 'unitPrice'
	          });
	      var unitPrice = ed.target.val();
	      
	      var ed1 = $('#billDetail').datagrid('getEditor', {
	              index : rindex,
	              field : 'increaseQuantity'
	          });
	      var increaseQuantity = ed1.target.val();
	      
	      amount = unitPrice*increaseQuantity;
		  	
		  	for(var i=0;i<rows.length;i++){
	      	if(rows[i].id != row1.id){
	      		amount += rows[i].unitPrice * rows[i].increaseQuantity;
	      	}
	      }
		  }else{
		  	for(var i=0;i<rows.length;i++){	      	
	      	amount += rows[i].unitPrice * rows[i].increaseQuantity;
	      }
	      alert(amount);
		  }
      $("#amount").numberbox('setValue',amount);
		}
			
		function queryBill(){
			$('#ttt').datagrid({  
			    url:'${ctx}/jsonfindallbillpage',  
					toolbar:'#tb',
			    pagination:true,//分页控件  
        	rownumbers:true,//行号  
					singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},
			        {field:'billCode',title:'单据编号',width:100,align:'right'},
			        {field:'customerName',title:'客户名称',width:100},
			        {field:'contractId',title:'合同号',width:100},
			        {field:'amount',title:'总价',width:100},
			        {field:'salesPersonName',title:'业务员',width:100},
			        {field:'businessDate',title:'业务日期',width:100},
			        {field:'warehouseKeeperName',title:'库管员',width:100},
			        {field:'warehouseDate',title:'库管日期',width:100},
			        {field:'memo',title:'备注',width:100}
			    ]]  
			});
			
			$('#billDetail').datagrid({  
  				toolbar:'#billDetailToolbar',
			    singleSelect:true,
			    data:[],
			    columns:[[  
			        {field:'id',title:'id',width:30},  
			        {field:'productId',title:'代码',width:50,align:'left',editor:'readonlytext',headalign:'center'},  
			        {field:'productName',title:'产品名称',width:200,align:'left',editor:'searchtext',headalign:'center'},  
			        {field:'unitPrice',title:'单价',width:100,align:'right',editor:'numbertext',headalign:'center'} ,
			        {field:'increaseQuantity',title:'数量',width:100,align:'right',editor:'numbertext',headalign:'center'},
			        {field:'memo',title:'备注',width:200,align:'left',editor:'text',headalign:'center'}  
			    ]]  
			});
				
		}
		
		//Content area
		var urlBill;
	
		function addBill(){  
				var X = $('#dlg').offset().left-320;
  			var Y = $('#dlg').offset().top+20;
		  	$('#dlg').dialog({position:[X,Y]});
		    $('#dlg').dialog('open').dialog('setTitle','New Bill');  
		    $('#billDetail').datagrid('loadData',[]);
		    
		    //alert(1);
		    $('#fm').form('clear');   
		    
		    urlBill = '${ctx}/jsonsavebill'; 
		} 
		
		function removeBill(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row.id);
				if (row){
				    $.ajax({
							type:'POST',
							async:false,
							url:'${ctx}/jsonremovebillbyid?id='+row.id,
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
		                $('#ttt').datagrid('reload');    // reload the bill data                  
		            }
			        }  
						});		
				    
				}else{
					alert("please choose one row!");
				} 
		}
		
		function editBill(){  
		    var row = $('#ttt').datagrid('getSelected');  
		    //alert(row);
				if (row){  
				  //alert(JSON.stringify(row));
				  	var X = $('#dlg').offset().left-320;
      			var Y = $('#dlg').offset().top+20;
				  	$('#dlg').dialog({position:[X,Y]});
				    $('#dlg').dialog('open').dialog('setTitle','Edit Bill');  
				    
				  	urlBill = '${ctx}/jsonsavebill?id='+row.id;  
				  	
				    //row detail
				    $('#billDetail').datagrid({  
				    		toolbar:'#billDetailToolbar',
				    		url:'${ctx}/jsonfindbilldetail?billId=' + row.id,
						    singleSelect:true,
						    columns:[[  
						        {field:'id',title:'id',width:30},  
						        {field:'productId',title:'代码',width:50,align:'left',editor:'readonlytext',headalign:'center'},  
						        {field:'productName',title:'产品名称',width:200,align:'left',editor:'searchtext',headalign:'center'},  
						        {field:'unitPrice',title:'单价',width:100,align:'right',editor:'numbertext',headalign:'center'} ,
						        {field:'increaseQuantity',title:'数量',width:100,align:'right',editor:'numbertext',headalign:'center'},
						        {field:'memo',title:'备注',width:200,align:'left',editor:'text',headalign:'center'}  
						    ]],
						    onLoadSuccess : function() {  
					         var target = $(this);  
					         var opts = $.data(this, "datagrid").options;  
					         var panel = $(this).datagrid("getPanel");  
					         //获取列
					         var fields=$(this).datagrid('getColumnFields',false);
					         //datagrid头部 table 的第一个tr 的td们，即columns的集合
					         var headerTds =panel.find(".datagrid-view2 .datagrid-header .datagrid-header-inner table tr:first-child").children();
					         //重新设置列表头的对齐方式
					         headerTds.each(function (i, obj) {
					             var col = target.datagrid('getColumnOption',fields[i]);
					             if (!col.hidden && !col.checkbox)
					             {
					                 var headalign=col.headalign||col.align||'left';
					                 $("div:first-child", obj).css("text-align", headalign);
					             }
					         })
					     },
					     onSelect : function(rowIndex, rowData){
					     		if (lastIndex != rowIndex) {
					            $('#billDetail').datagrid('endEdit', lastIndex);
					           // $('#billDetail').datagrid('beginEdit', rowIndex);
					        }
					        //lastIndex = rowIndex;
					     }
						});
				    
				    
				    $('#fm').form('load',row);
				    
				}else{
					alert("please choose one row!");
				} 
		} 
		
		
		function saveBill(){  	
				if(!$("#fm").form('validate')){
					return false;
				}		
				 //$("#fm").validate();
			
			
				//////////////////////////
				var rows = $('#billDetail').datagrid('getRows');  
        for ( var i = 0; i < rows.length; i++) {  
            $('#billDetail').datagrid('endEdit', i);  
        }          
				//////////////////
		    var frmDataObj = $('#fm').serializeObject();
		    frmDataObj.billItems = $('#billDetail').datagrid('getRows');  
		    var frmDataStr = JSON.stringify(frmDataObj);
		    alert(frmDataStr);
		    alert(urlBill);
		    $.ajax({
					type:'POST',
					async:false,
					url:urlBill,
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
                $('#ttt').datagrid('reload');    // reload the bill data                  
            }
	        }  
				});		    
		}  
		
		////////////begin bill detail
		var lastIndex;
		function addBillDetail(){  
		    $('#billDetail').datagrid('appendRow', {});  
        var rows = $('#billDetail').datagrid('getRows');  
        $('#billDetail').datagrid('beginEdit', rows.length - 1).datagrid('selectRow',rows.length - 1);  
      
      	var row = $('#billDetail').datagrid('getSelected');  
        var rowIndex = $('#billDetail').datagrid('getRowIndex', row);  
          
        if (lastIndex != rowIndex) {
            $('#billDetail').datagrid('endEdit', lastIndex);
            $('#billDetail').datagrid('beginEdit', rowIndex);
        }
        lastIndex = rowIndex;
		} 
		
		function removeBillDetail(){
		    var row = $('#billDetail').datagrid('getSelected');  
		    //alert(row.id);
				if (row){
			    var rowIndex = $('#billDetail').datagrid('getRowIndex', row);  
          $('#billDetail').datagrid('deleteRow', rowIndex);  
          
          caclAmount();
				}else{
					alert("please choose one row!");
				} 
		}
		
		
		function editBillDetail(){  
		  var row = $('#billDetail').datagrid('getSelected');  
      if (row) {  
          var rowIndex = $('#billDetail').datagrid('getRowIndex', row);  
          $('#billDetail').datagrid('beginEdit', rowIndex);  
          
          if (lastIndex != rowIndex) {
              $('#billDetail').datagrid('endEdit', lastIndex);
              $('#billDetail').datagrid('beginEdit', rowIndex);
          }
          lastIndex = rowIndex;
      } else{
					alert("please choose one row!");
				}  
		} 
		////////////end bill detail 
		
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
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick=addBill()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editBill()></a>  
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeBill()></a>  
    </div>   
    <div>  
        Date From: <input class="easyui-datebox" style="width:80px">  
        To: <input class="easyui-datebox" style="width:80px">  
        Language:   
        <input class="easyui-combobox" style="width:100px"  
                url="data/combobox_data.json"  
                valueField="id" textField="text">  
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onClick="queryBill()">Search</a>  
    </div>  
</div>
</div>

<div id="dlg" class="easyui-dialog" style="width:900px;height:550px;padding:5px 10px"  
        closed="true" buttons="#dlg-buttons" modal="true"  >  
    <form id="fm" method="post" contentType="application/json">
    	<div><table width="100%"><tr><td colspan="2">
    	<div class="fitem">  
            <label>Id:</label>  
            <input name="id" readOnly="true">  
        </div></td></tr>
        <tr><td>   
        <div class="fitem">  
            <label>单号:</label>  
            <input name="billCode" class="easyui-validatebox" required="true">  
        </div></td><td>          
        <div class="fitem">  
            <label>顾客名称:</label>  
            <input id="customerId" name="customerId" type="hidden">
            <input id="customerName" name="customerName" readOnly="true" class="easyui-validatebox" required="true"><a href="#" id="btnQueryCustomer" iconCls="icon-search" onClick="queryCustomer()">选择</a>   
        </div></td></tr>
        <tr><td>
        <div class="fitem">  
            <label>合同号:</label>  
            <input name="contractId"  class="easyui-validatebox" required="true">  
        </div></td><td> 
        <div class="fitem">  
            <label>总价:</label>  
            <input name="amount" id="amount" class="easyui-numberbox" precision="2" max="9999999.99" min="0.0" maxlength="10" style="text-align:right;" readOnly>  
        </div></td></tr>
        <tr><td>
        <div class="fitem">  
            <label>业务员:</label>  
            <input id="salesPersonId" name="salesPersonId" type="hidden">
            <input id="salesPersonName" name="salesPersonName" readOnly="true" class="easyui-validatebox" required="true"><a href="#" id="btnQueryUser" iconCls="icon-search" onClick="queryUser('salesPersonId','salesPersonName')">选择</a>      
        </div> </td><td> 
        <div class="fitem">  
            <label>业务日期:</label>  
            <input id="businessDate" name="businessDate"  class="easyui-datebox" readOnly="true"  class="easyui-validatebox" required="true">  
        </div></td></tr>
        <tr><td>
        <div class="fitem">  
            <label>库管员:</label>  
            <input id="warehouseKeeperId" name="warehouseKeeperId" type="hidden">
            <input id="warehouseKeeperName" name="warehouseKeeperName" readOnly="true" class="easyui-validatebox" required="true"><a href="#" id="btnQueryUser" iconCls="icon-search" onClick="queryUser('warehouseKeeperId','warehouseKeeperName')">选择</a>      
        </div>  </td><td>
        <div class="fitem">  
            <label>库管日期:</label>  
            <input id="warehouseDate" name="warehouseDate"  class="easyui-datebox" readOnly="true" class="easyui-validatebox" required="true">  
        </div></td></tr>
        <tr><td colspan="2">  
        <div class="fitem">  
            <label>备注:</label>  
            <input name="memo" size="100">  
        </div></td></tr></table></div>
        <div id="billDetailContainer">
        <div id="billDetail">
        	<div id="billDetailToolbar" style="padding:5px;height:auto">  
        	<div style="margin-bottom:5px">  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onClick=addBillDetail()></a>  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onClick=editBillDetail()></a>  
			        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onClick=removeBillDetail()></a>  
			    </div>
			    </div>
			    </div>
        </div>
    </form>  
</div>   
<div id="dlg-buttons">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveBill()">Save</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>  
</div>



<script>

		function queryCustomer(){
			$('#dlgCustomerQuery').dialog('open').dialog('setTitle','选择客户');  
			
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
		
		function selectCustomer(){
			var row = $('#customerQueryGrid').datagrid('getSelected');  
			if(!row){
				alert("请选择用户!");
			}else{
				$("#customerId").val(row.id);
				$("#customerName").val(row.shortName);
				$('#dlgCustomerQuery').dialog('close');
				
				$("#fm").form('validate');
			}
		}
</script>

<div id="dlgCustomerQuery" class="easyui-dialog" style="width:900px;height:500px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttonsCustomerQuery" modal="true"  >  
    <div class="ftitle">Bill Information</div>  
    <div id="customerQueryGrid">
			<div id="tbUQ" style="padding:5px;height:auto">  
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
</div>   
<div id="dlg-buttonsCustomerQuery">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="selectCustomer()">确定</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgCustomerQuery').dialog('close')">Cancel</a>  
</div>

<script>

		function queryCustomerForBillDetail(){
			$('#dlgCustomerQueryForBillDetail').dialog('open').dialog('setTitle','选择产品');  
			
			$('#customerQueryGridForBillDetail').datagrid({  
			    url:'${ctx}/jsonfindallproductpage',  
					toolbar:'#tbUQForBillDetail',
			    pagination:true,//分页控件  
        	rownumbers:true,//行号  
					singleSelect:true,
			    columns:[[  
			        {field:'id',title:'id',width:100},  
			        {field:'name',title:'名称',width:100},  
			        {field:'tradeMark',title:'品牌',width:100,align:'right'},  
			        {field:'productType',title:'productType',width:100,align:'right'},  
			        {field:'model',title:'型号',width:100,align:'right'},  
			        {field:'allowance',title:'余量',width:100,align:'right'},  
			        {field:'unit',title:'单位',width:100,align:'right'},  
			        {field:'memo',title:'备注',width:100,align:'right'} 
			    ]]  
			});
		}
		
		function selectCustomerForBillDetail(){
			var row = $('#customerQueryGridForBillDetail').datagrid('getSelected');  
			if(!row){
				alert("请选择产品!");
			}else{
				var row1 = $('#billDetail').datagrid('getSelected');
        var rindex = $('#billDetail').datagrid('getRowIndex', row1);
        var ed = $('#billDetail').datagrid('getEditor', {
                index : rindex,
                field : 'productName'
            });
        ed.target.val(row.name);
        
        var ed1 = $('#billDetail').datagrid('getEditor', {
                index : rindex,
                field : 'productId'
            });
        ed1.target.val(row.id);
        
				$('#dlgCustomerQueryForBillDetail').dialog('close');
			}
		}
</script>

<div id="dlgCustomerQueryForBillDetail" class="easyui-dialog" style="width:900px;height:500px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttonsCustomerQueryForBillDetail" modal="true"  >  
    <div class="ftitle">Bill Information</div>  
    <div id="customerQueryGridForBillDetail">
			<div id="tbUQ" style="padding:5px;height:auto">  
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
</div>   
<div id="dlg-buttonsCustomerQueryForBillDetail">  
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="selectCustomerForBillDetail()">确定</a>  
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgCustomerQueryForBillDetail').dialog('close')">Cancel</a>  
</div>
<script>
		var selectedUserId,selectedUserName;
		function queryUser(id,name){
			selectedUserId = id;
			selectedUserName = name;
			$('#dlgUserQuery').dialog('open').dialog('setTitle','选择用户');  
			
			$('#userQueryGrid').datagrid({  
			    url:'${ctx}/jsonfindalluserpage',  
					toolbar:'#tbUQUser',
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
				$("#"+selectedUserId).val(row.id);
				$("#"+selectedUserName).val(row.fullName+"["+row.loginName+"]");
				$('#dlgUserQuery').dialog('close');
				
				$("#fm").form('validate');
			}
		}
</script>

<div id="dlgUserQuery" class="easyui-dialog" style="width:900px;height:500px;padding:10px 20px"  
        closed="true" buttons="#dlg-buttonsUserQuery" modal="true"  >  
    <div class="ftitle">Customer Information</div>  
    <div id="userQueryGrid">
			<div id="tbUQUser" style="padding:5px;height:auto">  
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