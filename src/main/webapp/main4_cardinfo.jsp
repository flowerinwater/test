<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">

<%
String path1 = "系统管理";
String path2 = "学生情况查询";
%>
<%@ include  file="header.jsp"%>

	


<!-- ---------------------------------------------->
				

				<div class="main-content">
					<!----------------------------------->
							<div id="addDlg" class="modal fade in">
								<div class="modal-dialog"><div class="modal-content">


								
									<div class="modal-header">
									<a class="close" data-dismiss="modal">×</a>
									<h3>新增卡片</h3>
									</div>
									
									<div class="modal-body">
												<form class="form-horizontal" id="fmCardInfo"  method="post" contentType="application/json">
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="id">ID</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="id" id="id" readOnly class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>

														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="name">名称*:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="name" id="name" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>

														<div class="space-2"></div>

														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="gender">性别*:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="gender" id="gender" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="identityCard">身份证*:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="identityCard" id="identityCard" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="academe">服务处所(院系所)*:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="academe" id="academe" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="job">职业(卡类型)*:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="job" id="job" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="address">本市(县)其他住址*:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="address" id="address" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														
														<div class="space-2"></div>
														<div class="form-group">
														<div class="col-xs-12 col-sm-12">
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
															<div class=" col-xs-12 col-sm-12">
																<div class="alert alert-info">
																	<button type="button" class="close" data-dismiss="alert">
																		<i class="icon-remove"></i>
																	</button>
																	<strong>提交成功</strong>
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
																		注意！
																	</strong>
																	<span>
																	输入信息有误，请调整后提交。
																	</span>
																	<br />
																</div>
															</div>
														</div>
														
														
														
														<div class="space-2"></div>
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="cardOwner">户主或与户主关系:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="cardOwner" id="cardOwner" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="oldName">曾用名:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="oldName" id="oldName" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>


														<div class="space-2"></div>

														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="birthPlace">出生地:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="birthPlace" id="birthPlace" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="nation">民族:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="nation" id="nation" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="nativePlace">籍贯:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="nativePlace" id="nativePlace" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="birthDay">出生日期:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="birthDay" id="birthDay" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="belief">宗教信仰:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="belief" id="belief" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="height">身高:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="height" id="height" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="bloodType">血型:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="bloodType" id="bloodType" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="educationInfo">文化程度:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="educationInfo" id="educationInfo" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="marriageInfo">婚姻情况:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="marriageInfo" id="marriageInfo" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="militarySituation">兵役情况:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="militarySituation" id="militarySituation" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="originStudent">生源地:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="originStudent" id="originStudent" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="family">家属情况:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="family" id="family" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="whenWhereToThisAddress">何时由何地迁来本址:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="whenWhereToThisAddress" id="whenWhereToThisAddress" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="status">状态:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="status" id="status" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="memo">备注:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" name="memo" id="memo" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="creatorName">创建人:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text"  readonly="" name="creatorName" id="creatorName" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="createDate">创建日期:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text"  readonly="" name="createDate" id="createDate" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														<div class="form-group">
															<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="updaterName">最后修改人:</label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text"  readonly="" name="updaterName" id="updaterName" class="col-xs-12 col-sm-9" />
																</div>
															</div>
														</div>
														
														
														
														<div class="space-2"></div>
														<div class="form-group">
															<div class="col-xs-12 col-sm-12">
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
							<div class="nav-search" id="nav-search">
							<script>
								function exportxls(){
									var url = "${ctx}/exportExcel?type=StuList";
									window.open(url);   
								}
							</script>
							<button class="btn btn-info" onClick="exportxls()">导出</button>
						</div><!-- #nav-search -->
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
		
		<!-- ace scripts -->

		<script src="${ctx}/assets/js/ace-elements.min.js"></script>
		<script src="${ctx}/assets/js/ace.min.js"></script>
		<script src="${ctx}/assets/js/select2.min.js"></script>
		<script src="assets/js/jquery.validate.min.js"></script>
		<script src="assets/js/bootbox.min.js"></script>

		<!-- inline scripts related to this page -->

		
		<script type="text/javascript">
			function fillForm(obj){
				for(var attr in obj){
            
          if(typeof(obj[attr])=='function'){                    
            continue;
          }
          var $input = $("#fmCardInfo    :input[name='"+attr+"']");
          var type = $input.attr("type");                
          if(type=="checkbox" ||type=="radio"){
                
              var avalues = obj[attr].split(",");
                
              for(var v=0; v<avalues.length;v++){
                $input.each(function(i,n){
                    var value = $(n).val();                        
                    if(value == avalues[v]){                        
                      $(n).attr("checked","checked");
                    }
                });
            }
          }else{
            $input.val(obj[attr]);
          }
            
        }     
			}
			
			function addDlgShow(){
				$("#fmCardInfo").find(':input').each(  
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
				 
				 
				 
				$("#name").val('');
				$("#addDlg").modal();
			}

			function editDlgShow(id){
					$("#fmCardInfo").find(':input').each(  
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
				
					$.ajax({
						type:'POST',
						async:false,
						url:'${ctx}/jsonfindcardInfobyid?id='+id,
						data:'',
						dataType: 'json',
						contentType : 'application/json',
						success: function(result){  
							//alert(result);
							//var result = eval('('+result+')');  
							if (!result.success){  
								bootbox.dialog({
										message: "获取数据失败【" + id + "】：" + result.msg , 
										buttons: {
											"success" : {
												"label" : "OK",
												"className" : "btn-sm btn-primary"
											}
										}
									});
							} else {  
								row= result.obj;
		
								if (row){
									//$('#fmCardInfo').form('load',row);
									fillForm(row);
									$("#addDlg").modal();
									//jQuery("#grid-table").jqGrid("setGridParam",jQuery("#grid-table").jqGrid("getGridParam","url")).trigger("reloadGrid");
									jQuery("#grid-table").jqGrid().trigger("reloadGrid");
								}else{
									bootbox.dialog({
										message: "请选择一行记录", 
										buttons: {
											"success" : {
												"label" : "OK",
												"className" : "btn-sm btn-primary"
											}
										}
									});
								} 
							}
						}  
					});
			}
			
			jQuery(function($) {
				function saveCardInfo(){
					var frmDataObj = $('#fmCardInfo').serializeObject();
					//frmDataObj.birthDay = frmDataObj.birthDay + " 00:00:00";
					//frmDataObj.createDate = frmDataObj.createDate + " 00:00:00";
					//frmDataObj.updaterDate = frmDataObj.updaterDate + " 00:00:00";
					//alert(JSON.stringify(frmDataObj));
			//alert(1 + ":" + frmDataObj.status)
				
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
								//alert(1)  
								$('.alert-danger span').val(result.msg);
								//alert(2)
								$('.alert-danger').show();
								/*
								$.messager.show({  
									title: 'Error',  
									msg: result.msg  
								});*/  
							} else {
								$("#addDlg").modal("hide");   
								bootbox.dialog({
										message: "卡片【" + $("#name").val() + "】保存成功。", 
										buttons: {
											"success" : {
												"label" : "OK",
												"className" : "btn-sm btn-primary"
											}
										}
									});									                 
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
				
				
				$('.alert-danger').hide();
				$('.alert-info').hide();
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
			
				////////////////////////////////////	
				var grid_selector = "#grid-table";
				var pager_selector = "#grid-pager";
			
				jQuery(grid_selector).jqGrid({
					
					//url:"${ctx}/jsonfindallsysuserpage",
					url:"${ctx}/jsonfindallcardInfopage4",
					contentType:'application/json;charset=UTF-8',
					datatype: "json",
					mtype:"post",
					
					height: 350,
					colNames:['id', '状态','名称','性别', '民族', '籍贯','身份证','住址','出生地','生源地','备注','编辑'],
					colModel:[
						{name:'id',index:'id',width:20, sorttype:"int", editable: false},  
			      {name:'status',index:'status',width:30,editable:false},  
			      {name:'name',index:'name',width:80,editable:false},  
			      {name:'gender',index:'gender',width:20,editable:false},  
			      {name:'nation',index:'nation',width:20,editable:false},  
			      {name:'native_place',index:'native_place',width:100,editable:false},  
			      {name:'identityCard',index:'identityCard',width:100,editable:false},  
			      {name:'address',index:'address',width:100,editable:false},  
			      {name:'birthPlace',index:'birthPlace',width:100,editable:false},  
			      {name:'originStudent',index:'originStudent',width:100,editable:false},  
			      {name:'memo',index:'memo',width:100,editable:false},  			  
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
			
					caption: "学生情况查询",
			
					autowidth: true
			
				});
			
			
				
				
				
				function rowfun(cellvalue, options, rowdata){
					return 	"<button onclick='addDlgShow(" + rowdata.id + ")'>增加</button>" + 
									"<button onclick='editDlgShow(" + rowdata.id + ")'>修改</button>" + 
									"<button onclick=\'alert(1)\'>迁移</button>" + 
									"<button onclick=\'alert(1)\'>外借</button>" + 
									"<button onclick=\'alert(1)\'>归还</button>";
									
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
						edit: false,
						editicon : 'icon-pencil blue',
						add: false,
						addicon : 'icon-plus-sign purple',
						del: false,
						delicon : 'icon-trash red',
						search: true,
						searchicon : 'icon-search orange',
						refresh: true,
						refreshicon : 'icon-refresh green',
						//view: true,
						//viewicon : 'icon-zoom-in grey',
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
							alert("11edit:" + JSON.stringify(postdata));
							delete postdata.oper;
							alert("111edit:" + JSON.stringify(postdata));
							
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
							alert(11);
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

