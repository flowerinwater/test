<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">

<%
String path1 = "系统管理";
String path2 = "修改密码";
%>
<%@ include  file="header.jsp"%>

	


<!-- ---------------------------------------------->
				

				<div class="main-content">
					

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

											<div class=" row-fluid position-relative" id="">
														
															

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
																<div class="col-md-offset-2 col-xs-12 col-sm-5">
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
		<script src="assets/js/jquery-ui-1.10.3.full.min.js"></script>  
		<script src="assets/js/jquery.ui.touch-punch.min.js"></script>
                                                                  
		<script src="assets/js/fuelux/fuelux.wizard.min.js"></script>
		<script src="assets/js/jquery.validate.min.js"></script>
		<script src="assets/js/additional-methods.min.js"></script>
		<script src="assets/js/bootbox.min.js"></script>
		<script src="assets/js/jquery.maskedinput.min.js"></script>
		<script src="assets/js/select2.min.js"></script>

		<!-- ace scripts -->

		<script src="${ctx}/assets/js/ace-elements.min.js"></script>
		<script src="${ctx}/assets/js/ace.min.js"></script>

		<!-- inline scripts related to this page -->

		<script type="text/javascript">
				$('.alert-danger').hide();
				$('.alert-info').hide();
		
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
		
//			$('[data-rel=tooltip]').tooltip();

		
			jQuery(function($) {
			
				$('[data-rel=tooltip]').tooltip();
				
				$(".select2").css('width','200px').select2({allowClear:true})
				.on('change', function(){
					$(this).closest('form').validate().element($(this));
				}); 
			
			
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
			
			})
			
			$(document).ready(function(){					
				changePass();
			});	
		</script>
</body>
</html>

