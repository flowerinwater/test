<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-easyui-1.3.2/demo/demo.css">
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

	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
	
	<script type="text/javascript">
		
	</script>
	
	
</head>
<body style="margin:2px;padding:1px" class="easyui-layout" id="main">	
	
<script>
		$(document).ready(function(){
			  $('#tt').tree({					
						data: [{
							id : 'item1',
							text: 'Item1',
							state: 'closed',
							children: [{
								id : 'item11',
								text: 'user(sub page)',
								attributes:{  
				            		url:'${ctx}/main2_user.jsp'
				        		}
							},{
								id : 'item12',
								text: 'hightcharts(sub page)',
								attributes:{  
									url : '${ctx}/main2_highchart.jsp',
				        		}
							}]
						},{
							id : 'item2',
							text: 'syscode',
							attributes:{  
			            		url:'${ctx}/main2_syscode.jsp'
			        		}
						},{
							id : 'item3',							
							text: 'userrole',
							attributes:{  
			            		url:'${ctx}/main2_userrole.jsp'
			        		}
						},{
							id : 'item4',							
							text: 'customer',
							attributes:{  
			            		url:'${ctx}/main2_customer.jsp'
			        		}
						},{
							id : 'item5',							
							text: 'product',
							attributes:{  
			            		url:'${ctx}/main2_product.jsp'
			        		}
						},{
							id : 'item5',							
							text: 'bill',
							attributes:{  
			            		url:'${ctx}/main2_bill.jsp'
			        		}
						}],
					
					onClick: function(node){
						var s = '<iframe name="mainFrame" scrolling="no" frameborder="0"  src="' + node.attributes['url'] + '" style="width:100%;height:100%;"></iframe>';
							 $("#dg").empty().append($(s));
					}
				});
				
				$('#tt3').tree({					
						data: [{
							id : 'item32',
							text: 'User32',
							attributes:{  
			            		url:'${ctx}/main2user.jsp'
			        		}
						},{
							id : 'item33',							
							text: 'hightcharts'
						}],
					
					onClick: function(node){
						alert(node.text);  // alert node text property when clicked
						alert(node.attributes['url'])
						if(node.attributes['url']){
							//clickUser();
							clickSubpage(node.attributes['url']);
						}						
					}
				});
		});		
		
		
		function clickSubpage(url){
			alert(":" + url);
			$.ajax({
					  url: url,
					  type:'GET',
					  dataType: 'text',
					  contentType : 'application/html',
					  cache: false,
					  success: function(html){
					    $("#dg").empty();
					    $("#dg").append(html);
					    //clickUser();
					    //$(html).appendTo("body");
					    //clickUser();
					  }
					});
		}
</script>
	

		<div data-options="region:'north',split:true" style="height:50px;">
			<p style="text-align:center">header</p>
		</div>  
		
    <div id="leftmenu" data-options="region:'west',title:'Menu Tree',split:true" style="width:150px;">
    	
    		
    		<div id="menugroup" class="easyui-accordion"  data-options="fit:true">  
				    <div title="Title1" data-options="iconCls:'icon-save'" style="overflow:auto">  
				        <h3 style="color:#0099FF;">Accordion for jQuery</h3>  
				        <p>Accordion is a part of easyui framework for jQuery.   
				        It lets you define your accordion component on web page more easily.</p>  
				    </div>  
				    <div title="Title2" data-options="iconCls:'icon-reload',selected:true" style="">  
				        <ul id="tt" >  								    
								</ul>  
				    </div>  
				    <div title="Title3">  
				        <ul id="tt3" >  								    
								</ul>  
				    </div>  
				</div>
				
				 
    </div>  
    <div id="rightcontent" data-options="region:'center',title:'Content Panel'" style="padding:1px;background:#eee;">
    		<div id="dg"  style="height:100%;width:100%">
				</div>				
    </div>  
    
    <div data-options="region:'south',split:true" style="height:50px;">
    	<p style="text-align:center;text-valign:middle">footer</p> 
    </div>  


</body>  
</html>