<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">

<%
String path1 = "系统管理";
String path2 = "导入数据";
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
														<div class="controls">  
														    <div id="queue"></div>  
														    <input id="file" name="file" type="file" />
															<div id="res"></div>
														</div>  
															
														
																													  
														  <button class="btn btn-info" type="button" onclick="up()">
																<i class="icon-ok bigger-110"></i>
																上传
															</button>
															
															<button class="btn btn-info" type="button">
																<i class="icon-download bigger-110"></i>
																<a href="${ctx}/template/stu_import_template_short.xls" target="_blank">下载导入数据模板</a>
															</button>
																												
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


		<script src="${ctx}/static/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>  

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

		<script src="${ctx}/static/uploadify/jquery.min.js" type="text/javascript"></script> 
		<script src="${ctx}/static/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>  
		
		
		
		<script type="text/javascript">  


jQuery(document).ready(function(){ 
	$("#file").uploadify({  
        method   : 'post',  
        swf           : '${ctx}/static/uploadify/uploadify.swf',  // uploadify.swf在项目中的路径  
        uploader      : '${ctx}/uploadcards4shortinfo',  // 后台UploadController处理上传的方法  
        fileObjName     : 'file',         // The name of the file object to use in your server-side script  
        fileSizeLimit   : 0,                  // The maximum size of an uploadable file in KB (Accepts units B KB MB GB if string, 0 for no limit)  
        successTimeout  : 30,                 // The number of seconds to wait for Flash to detect the server's response after the file has finished uploading  
        removeCompleted : true,              // Remove queue items from the queue when they are done uploading  
        fileSizeLimit : '10MB',  
        buttonText      : '请选择数据文件',  
				auto			: false,
        height        : 30,  
        width         : 120,
				onUploadSuccess : function(file,data,response) {//上传完成时触发（每个文件触发一次）
			　　var o = $.parseJSON(data);
					//alert(o.msg);
					$("#res").html(o.msg);
				} 
    });
}); 


function up(){
	$('#file').uploadify('upload');
}

function upcancel(){
	$('#file').uploadify('cancel');
}

</script>

</body>
</html>

