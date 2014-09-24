<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">

<%
String path1 = "统计查询";
String path2 = "教工年龄区间统计";
%>
<%@ include  file="header.jsp"%>

	


<!-- ---------------------------------------------->
				

				<div class="main-content">
					
					<div id="xx"></div>

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
									var url = "${ctx}/exportExcel?type=AcademeAge&s_age1_low="+$('#s_age1_low').val()+"&s_age1_top="+$('#s_age1_top').val();
									url = url + "&s_age2_low="+$('#s_age2_low').val()+"&s_age2_top="+$('#s_age2_top').val();
									url = url + "&s_age3_low="+$('#s_age3_low').val()+"&s_age3_top="+$('#s_age3_top').val();
									url = url + "&s_age4_low="+$('#s_age4_low').val()+"&s_age4_top="+$('#s_age4_top').val();
									url = url + "&s_age5_low="+$('#s_age5_low').val()+"&s_age5_top="+$('#s_age5_top').val();
									url = url + "&s_age6_low="+$('#s_age6_low').val()+"&s_age6_top="+$('#s_age6_top').val();
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
										<h4 class="lighter">
											<i class="icon-hand-right icon-animated-hand-pointer blue"></i>
											<a href="#modal-wizard" data-toggle="modal" class="pink"> 请输入年龄区间(>=下限，<上限) </a>
										</h4>

										<div class="form-group">											
	
											<div>    
												<!--院系 <input style="width:120px"  id="s_academe">-->
												<h4 class="lighter">年龄段</h4>
												
												
												
												<div class="row">
													<div class="form-group">
														<label class=" inline" for="s_age1_low">1</label>
														<input type="text"   id="s_age1_low" value="0"> 
														<label class=" inline" for="s_age1_top"> to </label> 
														<input type="text"   id="s_age1_top"  value="29" >
													</div>
												</div>
												
												<div class="row">
													<div class="form-group">
														<label class=" inline" for="s_age2_low">2</label>
														<input type="text"   id="s_age2_low" value="30">
														<label class=" inline" for="s_age2_top"> to </label>
														<input type="text"   id="s_age2_top" value="39">
													</div>
												</div>
												
												<div class="row">
													<div class="form-group">
														<label class=" inline" for="s_age3_low">3</label>
														<input type="text"   id="s_age3_low" value="40">
														<label class=" inline" for="s_age3_top"> to </label>
														<input type="text"   id="s_age3_top" value="49">
													</div>
												</div>
												
												<div class="row">
													<div class="form-group">
														<label class=" inline" for="s_age4_low">4</label>
														<input type="text"   id="s_age4_low" value="50">
														<label class=" inline" for="s_age4_top"> to </label>
														<input type="text"   id="s_age4_top" value="59">
													</div>
												</div>
												
												<div class="row">
													<div class="form-group">
														<label class=" inline" for="s_age5_low">5</label>
														<input type="text"   id="s_age5_low" value="60">
														<label class=" inline" for="s_age5_top"> to </label>
														<input type="text"   id="s_age5_top" value="100">
													</div>
												</div>
												
												
													<div class="col-md-offset-1 col-md-9">
														<button class="btn btn-info" type="button"  onClick="exportxls()">
															<i class="icon-export bigger-110"></i>
															导出
														</button>
													</div>
											</div>
										</div>

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
		<script src="assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
		
		<!-- ace scripts -->

		<script src="${ctx}/assets/js/ace-elements.min.js"></script>
		<script src="${ctx}/assets/js/ace.min.js"></script>

		<!-- inline scripts related to this page -->

</body>
</html>

