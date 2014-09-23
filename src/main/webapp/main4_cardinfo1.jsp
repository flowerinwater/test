<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">

<%
String path1 = "信息登记";
String path2 = "卡信息登记";
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
								
								
								
<!----------------------------------->

											<div class=" row-fluid position-relative" id="">
														
															<form class="form-horizontal" id="fmCardInfo"  method="post" contentType="application/json">
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="id">ID</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="id" id="id" readOnly class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="name">名称*:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="name" id="name" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>

																<div class="space-2"></div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="gender">性别*:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="gender" id="gender" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="identityCard">身份证*:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="identityCard" id="identityCard" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="academe">服务处所(院系所)*:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="academe" id="academe" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="job">职业(卡类型)*:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="job" id="job" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="address">本市(县)其他住址*:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="address" id="address" class="col-xs-12 col-sm-4" />
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
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="cardOwner">户主或与户主关系:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="cardOwner" id="cardOwner" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="oldName">曾用名:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="oldName" id="oldName" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>


																<div class="space-2"></div>

																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="birthPlace">出生地:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="birthPlace" id="birthPlace" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="nation">民族:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="nation" id="nation" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="nativePlace">籍贯:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="nativePlace" id="nativePlace" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="birthDay">出生日期:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="birthDay" id="birthDay" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="belief">宗教信仰:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="belief" id="belief" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="height">身高:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="height" id="height" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="bloodType">血型:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="bloodType" id="bloodType" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="educationInfo">文化程度:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="educationInfo" id="educationInfo" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="marriageInfo">婚姻情况:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="marriageInfo" id="marriageInfo" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="militarySituation">兵役情况:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="militarySituation" id="militarySituation" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="originStudent">生源地:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="originStudent" id="originStudent" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="family">家属情况:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="family" id="family" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="whenWhereToThisAddress">何时由何地迁来本址:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="whenWhereToThisAddress" id="whenWhereToThisAddress" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="status">状态:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="status" id="status" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="memo">备注:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" name="memo" id="memo" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="creatorName">创建人:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text"  readonly="" name="creatorName" id="creatorName" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="createDate">创建日期:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text"  readonly="" name="createDate" id="createDate" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="updaterName">最后修改人:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text"  readonly="" name="updaterName" id="updaterName" class="col-xs-12 col-sm-4" />
																		</div>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="updaterDate">最后修改日期:</label>

																	<div class="col-xs-12 col-sm-9">
																		<div class="clearfix">
																			<input type="text" readonly="" name="updaterDate" id="updaterDate" class="col-xs-12 col-sm-4"/>
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
		
				function saveCardInfo(){
					var frmDataObj = $('#fmCardInfo').serializeObject();
					//frmDataObj.birthDay = frmDataObj.birthDay + " 00:00:00";
					//frmDataObj.createDate = frmDataObj.createDate + " 00:00:00";
					//frmDataObj.updaterDate = frmDataObj.updaterDate + " 00:00:00";
					alert(JSON.stringify(frmDataObj));
			alert(1 + ":" + frmDataObj.status)
				
			//alert(1 + ":" + $('#status').combobox('getValue'));
//					frmDataObj.status = $('#status').combobox('getValue');
//					frmDataObj.gender = $('#gender').combobox('getValue');
//					frmDataObj.bloodType = $('#bloodType').combobox('getValue');
					//frmDataObj.cardType = $('#cardType').combobox('getValue');
			
//					frmDataObj.educationInfo = $('#educationInfo').combobox('getValue');
//					frmDataObj.marriageInfo = $('#marriageInfo').combobox('getValue');
//					frmDataObj.militarySituation  = $('#militarySituation').combobox('getValue');
//					frmDataObj.job = $('#job').combobox('getValue');
			
					var urlcardInfo = '${ctx}/jsonSaveCardInfoxx1';  
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
									bootbox.dialog({
												message: "卡片【" + $("#name").val() + "】保存成功。", 
												buttons: {
													"success" : {
														"label" : "OK",
														"className" : "btn-sm btn-primary"
													}
												}
											});

             
	//							$('#dlg').dialog('close');      // close the dialog  
	//							$('#ttt').datagrid('reload');    // reload the cardInfo data                  
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
		
		
			jQuery(function($) {
			
				
				$(".select2").css('width','200px').select2({allowClear:true})
				.on('change', function(){
					$(this).closest('form').validate().element($(this));
				}); 
			
			
				var $validation = false;
							
				//documentation : http://docs.jquery.com/Plugins/Validation/validate
		
			
				$('#fmCardInfo').validate({
					errorElement: 'div',
					errorClass: 'help-block',
					focusInvalid: false,
					rules:{ 
						name: {
							required: true,
						},
						gender: {
							required: true,
						},
						identityCard: {
							required: true,
						},
						job: {
							required: true,
						},
						address: {
							required: true,
						},
						academe: {
							required: true,
						}						
					},
			
					messages: {
						name: {
							required: "请输入名称.",
						},
						gender: {
							required: "请输入性别.",
						},
						identityCard: {
							required: "请输入身份证号.",
						},
						job: {
							required: "请输入职业(卡类型).",
						},
						address: {
							required: "请输入本市(县)其他住址.",
						},
						academe: {
							required: "请输入服务处所(院系所).",
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
						saveCardInfo();
					},
					invalidHandler: function (form) {
					}
				});
			
			})
			
			$(document).ready(function(){			
			});	
		</script>
</body>
</html>

