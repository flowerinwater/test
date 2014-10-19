<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">

<%
String path1 = "系统管理";
String path2 = "用户管理";
%>
<%@ include  file="header.jsp"%>

	


<!-- ---------------------------------------------->
				

				<div class="main-content">
					<!----------------------------------->
							<div id="resetPassDlg" class="modal fade in">
								<div class="modal-dialog"><div class="modal-content">


								
									<div class="modal-header">
									<a class="close" data-dismiss="modal">×</a>
									<h3>重置密码</h3>
									</div>
									
									<div class="modal-body">
													<form class="form-horizontal" id="fmChangePass"  method="post" contentType="application/json">
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="id">ID</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="id" id="id" readOnly class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="name">名称:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="name" id="name" readOnly class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="email">登录名:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="loginName" id="loginName"  readOnly class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																
																<div class="space-2"></div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="password">当前密码:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="password" name="password" id="password" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																<div class="space-2"></div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="newpassword">新密码:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="password" name="newpassword" id="newpassword" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="space-2"></div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="repassword">确认密码:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="password" name="repassword" id="repassword" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="space-2"></div>
																<div class="form-group">
																<div class="col-md-offset-2 col-xs-12 col-sm-6">
																	<center>
																	<button class="btn btn-info" type="submit">
																		<i class="icon-ok bigger-110"></i>
																		确定
																	</button>
						
																	&nbsp; &nbsp; &nbsp;
																	<button class="btn" type="reset">
																		<i class="icon-undo bigger-110"></i>
																		重置
																	</button>
																	</center>
																</div>
																</div>

																<div class="space-2"></div>
																<div class="form-group">
																<div class="col-md-offset-2 col-xs-12 col-sm-5">
																				<div class="alert alert-info">
																					<button type="button" class="close" data-dismiss="alert">
																						<i class="icon-remove"></i>
																					</button>
																					<strong>Heads up!</strong>
																					<span>
																					This alert needs your attention, but it's not super important.
																					</span>
																					<br />
																				</div>
																				
																				<div class="alert alert-danger">
																					<button type="button" class="close" data-dismiss="alert">
																						<i class="icon-remove"></i>
																					</button>
										
																					<strong>
																						<i class="icon-remove"></i>
																						Oh snap!
																					</strong>
																					<span>
																					Change a few things up and try submitting again.
																					</span>
																					<br />
																				</div>
																</div>
																</div>
															</form>							
									</div>
									
									
								</div></div>
							</div>
								
					<!------------------------------------>			
					

					<div class="page-content">
						<div class="page-header">
							<h1>
								<%=path1%>
								<small>
									<i class="icon-double-angle-right"></i>
									 <%=path2%>
 								</small>
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
<!----------------------------------->

								<div class="row">
									<div class="col-xs-12">
										<!-- PAGE CONTENT BEGINS -->
		
										<table id="grid-table"></table>
		
										<div id="grid-pager"></div>
		
										<script type="text/javascript">
											var $path_base = "/";//this will be used in gritter alerts containing images
										</script>
		
										<!-- PAGE CONTENT ENDS -->
									</div><!-- /.col -->
								</div><!-- /.row -->

<!----------------------------------->							

								<!-- PAGE CONTENT ENDS -->
							
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->

				
			</div><!-- /.main-container-inner -->

			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->

	<!-- basic scripts -->

		<!--[if !IE]> -->

		<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>-->
<script src="${ctx}/assets/js/jquery-2.0.3.min.js"></script>
		<!-- <![endif]-->

		<!--[if IE]>
<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>-->
<script src="${ctx}/assets/js/jquery-1.10.2.min.js"></script>
<![endif]-->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='${ctx}/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]--> 

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${ctx}/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='${ctx}/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="${ctx}/assets/js/bootstrap.min.js"></script>
		<script src="${ctx}/assets/js/typeahead-bs2.min.js"></script>

		<!-- page specific plugin scripts -->
		<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/jqGrid/jquery.jqGrid-4.6.js"></script>
		<script src="assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
		
		<script src="assets/js/jquery.validate.min.js"></script>
		
		<!-- ace scripts -->

		<script src="${ctx}/assets/js/ace-elements.min.js"></script>
		<script src="${ctx}/assets/js/ace.min.js"></script>

		<!-- inline scripts related to this page -->

		




		<script type="text/javascript">
			
		
			function changePass(){  
				$.ajax({
					type:'POST',
					async:false,
					url:'${ctx}/jsongetcurrloginname',
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
							var row = result.obj;  
							if (row){  
								$('#dlgChangePass').dialog('open').dialog('setTitle','修改密码');  
								//$('#fmChangePass').form('load',row);    
								$('#id').val(row.id);
								$('#name').val(row.name);
								$('#loginName').val(row.loginName);
								$('#password').val("");       
							}else{
								alert("please choose one row!");
							}                   
						}
					}  
				});		    
			} 
		
			function saveChangePass(){
				//if(!$('#fmChangePass').valid())
				//	return;
				
				var frmDataObj = $('#fmChangePass').serializeObject();
				var frmDataStr = JSON.stringify(frmDataObj);
				$.ajax({
					type:'POST',
					async:false,
					url:'${ctx}/jsonchangepass',
					data:frmDataStr,
					dataType: 'json',
					contentType : 'application/json',
					success: function(result){  
						//alert(result.msg);
						//var result = eval('('+result+')');  
						if (!result.success){  
							$('.alert-danger strong').text("错误!");
							$('.alert-danger span').text(result.msg);
							$('.alert-danger').show();
							$('.alert-info').hide();
						} else {
							//alert("密码修改成功!");
							$('.alert-info strong').text("提示!");
							$('.alert-info span').text("密码修改成功!");
							$('.alert-danger').hide();
							$('.alert-info').show();
							$('#password').val("");       
							$('#newpassword').val("");       
							$('#repassword').val("");       
							//$('#dlgChangePass').dialog('close');                  
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
		
			function resetPassDlgShow(id){
				$("#fmChangePass").find(':input').each(  
            function(){  
                switch(this.type){  
                    case 'passsword':  
                    case 'select-multiple':  
                    case 'select-one':  
                    case 'text':  
                    case 'textarea':  
                        $(this).val('');  
                        break;  
                    case 'checkbox':  
                    case 'radio':  
                        this.checked = false;  
                }  
            }     
        );  
				 
				 
				var row = $("#grid-table").jqGrid('getRowData',id);
				$('#id').val(row.id);
				$('#name').val(row.name);
				$('#loginName').val(row.loginName);
				$('#password').val("");       
				$('#newpassword').val("");       
				$('#repassword').val("");     
				 
				$('.alert-danger').hide();
				$('.alert-info').hide(); 
				//$("#fmCardInfo #name").val('');
				$("#resetPassDlg").modal();
				
				var $validation = false;
							
				//documentation : http://docs.jquery.com/Plugins/Validation/validate
		
			
				$('#fmChangePass').validate({
					errorElement: 'div',
					errorClass: 'help-block',
					focusInvalid: false,
					rules:{ 
						password: {
							required: true,
							minlength: 6
						},
						newpassword: {
							required: true,
							minlength: 6
						},
						repassword: {
							required: true,
							minlength: 6,
							equalTo: "#newpassword"
						}						
					},
			
					messages: {
						password: {
							required: "请输入密码.",
							minlength: "请输入最少6位的密码."
						},
						newpassword: {
							required: "请输入密码.",
							minlength: "请输入最少6位的密码."
						},
						repassword: {
							required: "请输入密码.",
							minlength: "请输入最少6位的密码.",
							equalTo:"两次输入的密码不相同."
						},
						
					},
			
					invalidHandler: function (event, validator) { //display error alert on form submit   
						$('.alert-danger', $('.login-form')).show();
					},
			
					highlight: function (e) {
						$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
					},
			
					success: function (e) {
						$(e).closest('.form-group').removeClass('has-error').addClass('has-info');
						$(e).remove();
					},
			
					errorPlacement: function (error, element) {
						if(element.is(':checkbox') || element.is(':radio')) {
							var controls = element.closest('div[class*="col-"]');
							if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
							else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
						}
						else if(element.is('.select2')) {
							error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
						}
						else if(element.is('.chosen-select')) {
							error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
						}
						else error.insertAfter(element.parent());
					},
			
					submitHandler: function (form) {
					 event.preventDefault() ;
						saveChangePass();
					},
					invalidHandler: function (form) {
					}
				});
			
			
			}
			
/////////////////////////////////

			
			jQuery(function($) {
				var grid_selector = "#grid-table";
				var pager_selector = "#grid-pager";
			
				jQuery(grid_selector).jqGrid({
					//direction: "rtl",
					
					//data: grid_data,
					//datatype: "local",
					
					
					//url:"${ctx}/jsonfindallsysuserpage",
					url:"${ctx}/listuser4",
					contentType:'application/json;charset=UTF-8',
					datatype: "json",
					mtype:"post",
					
					height: 350,
					colNames:['id', '登录名','名称','创建日期','角色', '状态', '备注','操作'],
					colModel:[
						{name:'id',index:'id',width:100, sorttype:"int", editable: false},  
			      {name:'loginName',index:'loginName',width:100,editable: true,editoptions:{size:"20",maxlength:"30"}},  
			      {index:'name',name:'name',width:100,editable: true,editoptions:{size:"20",maxlength:"30"}},  
			      {index:'createDate',name:'createDate',width:150,editable:true, sorttype:"date",unformat: pickDate},  
			      {index:'role',name:'role',width:100, editable: true,edittype:"select",editoptions:{value:" : ;AD:管理员;L1:普通操作员;L2:查询操作员"}},
						{index:'status',name:'status',width:100, editable: true,edittype:"select",editoptions:{value:"1:有效;0:无效;2:删除;3:滞留"}},
						{index:'memo',name:'memo',width:400,sortable:false,editable: true,edittype:"textarea", editoptions:{rows:"2",cols:"10"}} ,						  			  
			      {name:'memo',index:'memo',width:100,editable:false,formatter:rowfun},  	
					], 
			
					viewrecords : true,
					rowNum:10,
					rowList:[10,20,30],
					pager : pager_selector,
					altRows: true,
					//toppager: true,
					
					multiselect: true,
					//multikey: "ctrlKey",
			        multiboxonly: true,
			
					loadComplete : function() {
						var table = this;
						setTimeout(function(){
							styleCheckbox(table);
							
							updateActionIcons(table);
							updatePagerIcons(table);
							enableTooltips(table);
						}, 0);
					},
			
					editurl: '${ctx}/jsonsavesysuser',//$path_base+"/dummy.html",//nothing is saved
					delurl: '${ctx}/jsonremovesysuserbyid',
					caption: "用户信息",
			
			
					autowidth: true
			
				});
				
				
				
				
			
				function rowfun(cellvalue, options, rowdata){
					return 	"<button onclick='resetPassDlgShow(" + rowdata.id + ")'>重置密码</button>";
									
				}
				
				//enable search/filter toolbar
				//jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
			
				//switch element when editing inline
				function aceSwitch( cellvalue, options, cell ) {
					setTimeout(function(){
						$(cell) .find('input[type=checkbox]')
								.wrap('<label class="inline" />')
							.addClass('ace ace-switch ace-switch-5')
							.after('<span class="lbl"></span>');
					}, 0);
				}
				//enable datepicker
				function pickDate( cellvalue, options, cell ) {
					setTimeout(function(){
						$(cell) .find('input[type=text]')
								.datepicker({format:'yyyy-mm-dd' , autoclose:true}); 
					}, 0);
				}
			
			
				//navButtons
				jQuery(grid_selector).jqGrid('navGrid',pager_selector,
					{ 	//navbar options
						edit: true,
						editicon : 'icon-pencil blue',
						add: true,
						addicon : 'icon-plus-sign purple',
						del: true,
						delicon : 'icon-trash red',
						search: true,
						searchicon : 'icon-search orange',
						refresh: true,
						refreshicon : 'icon-refresh green',
						view: true,
						viewicon : 'icon-zoom-in grey',
					},
					{
						//edit record form
			            reloadAfterSubmit: true,
			            closeOnEscape: true,
						closeAfterEdit: true,
						recreateForm: true,
						datatype: 'json',
						contentType:'application/json;charset=UTF-8',
						serializeEditData: function(postdata) {
							//alert("11edit:" + JSON.stringify(postdata));
							delete postdata.oper;
							//alert("111edit:" + JSON.stringify(postdata));
							
							return JSON.stringify(postdata);
						},
						beforeShowForm : function(e) {
							//alert(e[0].outerHTML);
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
							style_edit_form(form);
						}
					},
					{
						//new record form
						closeAfterAdd: true,
						recreateForm: true,
						viewPagerButtons: false,
						serializeEditData: function(postdata) {
							//alert("11add:" + JSON.stringify(postdata));
							delete postdata.oper;
							delete postdata.id;
							//alert("111add:" + JSON.stringify(postdata));
							
							return JSON.stringify(postdata);
						},
						beforeShowForm : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
							style_edit_form(form);
						}

					},
					{
						//delete record form
						recreateForm: true,
						serializeDelData: function(postdata) {
							//alert("11del:" + JSON.stringify(postdata));
							delete postdata.oper;
							//alert("111del:" + JSON.stringify(postdata));
							
							return JSON.stringify(postdata);
						},
						beforeShowForm : function(e) {
							var form = $(e[0]);
							if(form.data('styled')) return false;
							
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
							style_delete_form(form);
							
							form.data('styled', true);
						},
						onClick : function(e) {
							//alert(11);
						}
					},
					{
						//search form
						recreateForm: true,
						afterShowSearch: function(e){
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
							style_search_form(form);
						},
						afterRedraw: function(){
							style_search_filters($(this));
						}
						,
						multipleSearch: true,
						/**
						multipleGroup:true,
						showQuery: true
						*/
						
					},
					{
						//view record form
						recreateForm: true,
						beforeShowForm: function(e){
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
						}
					}
				)
			
			
				
				function style_edit_form(form) {
					//enable datepicker on "sdate" field and switches for "stock" field
					/*form.find('input[name=sdate]').datepicker({format:'yyyy-mm-dd' , autoclose:true})
						.end().find('input[name=stock]')
							  .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');
			*/
					form.find('input[name=createDate]').datepicker({format:'yyyy-mm-dd' , autoclose:true})
						.end();
					form.attr('contentType','application/json;charset=UTF-8');
			
			
					//update buttons classes
					var buttons = form.next().find('.EditButton .fm-button');
					buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
					buttons.eq(0).addClass('btn-primary').prepend('<i class="icon-ok"></i>');
					buttons.eq(1).prepend('<i class="icon-remove"></i>')
					
					buttons = form.next().find('.navButton a');
					buttons.find('.ui-icon').remove();
					buttons.eq(0).append('<i class="icon-chevron-left"></i>');
					buttons.eq(1).append('<i class="icon-chevron-right"></i>');		
				}
			
				function style_delete_form(form) {
					var buttons = form.next().find('.EditButton .fm-button');
					buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
					buttons.eq(0).addClass('btn-danger').prepend('<i class="icon-trash"></i>');
					buttons.eq(1).prepend('<i class="icon-remove"></i>')
				}
				
				function style_search_filters(form) {
					form.find('.delete-rule').val('X');
					form.find('.add-rule').addClass('btn btn-xs btn-primary');
					form.find('.add-group').addClass('btn btn-xs btn-success');
					form.find('.delete-group').addClass('btn btn-xs btn-danger');
				}
				function style_search_form(form) {
					var dialog = form.closest('.ui-jqdialog');
					var buttons = dialog.find('.EditTable')
					buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'icon-retweet');
					buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'icon-comment-alt');
					buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'icon-search');
				}
				
				function beforeDeleteCallback(e) {
					var form = $(e[0]);
					if(form.data('styled')) return false;
					
					form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
					style_delete_form(form);
					
					form.data('styled', true);
				}
				
				function beforeEditCallback(e) {
					var form = $(e[0]);
					form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
					style_edit_form(form);
				}
			
			
			
				//it causes some flicker when reloading or navigating grid
				//it may be possible to have some custom formatter to do this as the grid is being created to prevent this
				//or go back to default browser checkbox styles for the grid
				function styleCheckbox(table) {
				/**
					$(table).find('input:checkbox').addClass('ace')
					.wrap('<label />')
					.after('<span class="lbl align-top" />')
			
			
					$('.ui-jqgrid-labels th[id*="_cb"]:first-child')
					.find('input.cbox[type=checkbox]').addClass('ace')
					.wrap('<label />').after('<span class="lbl align-top" />');
				*/
				}
				
			
				//unlike navButtons icons, action icons in rows seem to be hard-coded
				//you can change them like this in here if you want
				function updateActionIcons(table) {
					/**
					var replacement = 
					{
						'ui-icon-pencil' : 'icon-pencil blue',
						'ui-icon-trash' : 'icon-trash red',
						'ui-icon-disk' : 'icon-ok green',
						'ui-icon-cancel' : 'icon-remove red'
					};
					$(table).find('.ui-pg-div span.ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
					*/
				}
				
				//replace icons with FontAwesome icons like above
				function updatePagerIcons(table) {
					var replacement = 
					{
						'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
						'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
						'ui-icon-seek-next' : 'icon-angle-right bigger-140',
						'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
					};
					$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
				}
			
				function enableTooltips(table) {
					$('.navtable .ui-pg-button').tooltip({container:'body'});
					$(table).find('.ui-pg-div').tooltip({container:'body'});
				}
			
				//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');
			
			
			});
		</script>


</body>
</html>

