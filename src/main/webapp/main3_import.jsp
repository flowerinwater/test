<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<script src="${ctx}/static/uploadify/jquery.min.js" type="text/javascript"></script> 
	<script src="${ctx}/static/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>  
	<link rel="stylesheet" type="text/css" href="${ctx}/static/uploadify/uploadify.css"> 
</head>
<body style="margin:2px;padding:1px" >
<script type="text/javascript">  

$(function() {  
    $("#file").uploadify({  
        method   : 'post',  
        swf           : '${ctx}/static/uploadify/uploadify.swf',  // uploadify.swf在项目中的路径  
        uploader      : '${ctx}/uploadcards',  // 后台UploadController处理上传的方法  
        fileObjName     : 'file',         // The name of the file object to use in your server-side script  
        fileSizeLimit   : 0,                  // The maximum size of an uploadable file in KB (Accepts units B KB MB GB if string, 0 for no limit)  
        successTimeout  : 30,                 // The number of seconds to wait for Flash to detect the server's response after the file has finished uploading  
        removeCompleted : true,              // Remove queue items from the queue when they are done uploading  
        fileSizeLimit : '10MB',  
        buttonText      : '选择文件',  
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
<h1>上传文件</h1>  
<div class="controls">  
    <div id="queue"></div>  
    <input id="file" name="file" type="file" />
	<div id="res"></div>
</div>  

	<p>   
	  <a href="#" onclick="up()">上传</a>
    </p>
</body>
</html>