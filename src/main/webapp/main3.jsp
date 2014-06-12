<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.apache.shiro.subject.Subject"%>
<%@ page import="javax.servlet.ServletContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.bnu.card.service.LendCardService"%>
<%@ page import="com.bnu.card.service.SysUserService"%>
<%@ page import="com.bnu.card.entity.SysUser"%>
<%@ page import="com.bnu.card.service.ShiroDbRealm.ShiroUser"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<%
	ServletContext sc = pageContext.getServletContext();
	ApplicationContext ac1 = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
	LendCardService lendCardService = (LendCardService)ac1.getBean("lendCardService");
	List l = lendCardService.getLendCardExpireAlert(10);
	boolean hasAlert = l.size()>0;	
	
	Subject subject = SecurityUtils.getSubject();
	ShiroUser user = (ShiroUser)subject.getPrincipal();
	SysUserService sysUserService = (SysUserService)ac1.getBean("sysUserService");
	SysUser su = sysUserService.findOneSysUserByLoginName(user.loginName);

	String role = "";
	try{
		subject.checkRole("AD");
		role = "AD";
	}catch(Exception e){
	}

	if(role.equals("")){
		try{
			subject.checkRole("L1");
			role = "L1";
		}catch(Exception e){
		}
	}

	if(role.equals("")){
		try{
			subject.checkRole("L2");
			role = "L2";
		}catch(Exception e){
		}
	}

	System.out.println("---------------------:" + role);
%>

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
			<%if(role.equals("L1")){%>					
			  $('#tt').tree({					
						data: [{
							id : 'item11',							
							text: '卡信息登记',
							attributes:{  
			            		url:'${ctx}/main3_cardinfo.jsp'
			        		}
						},{
							id : 'item12',
							text: '历史查询',
							attributes:{  
			            		url:'${ctx}/main3_history.jsp'
			        		}
						},{
							id : 'item14',
							text: '预警信息',
							<%if(hasAlert){%>
							checked:true, 
							<%}%>
							attributes:{  
			            		url:'${ctx}/main3_alert.jsp'
			        		}
						}],
					
					onClick: function(node){
						var s = '<iframe name="mainFrame" scrolling="no" frameborder="0"  src="' + node.attributes['url'] + '" style="width:100%;height:100%;"></iframe>';
							 $("#dg").empty().append($(s));
					}
				});
				<%if(hasAlert){%>
					var node = $('#tt').tree('find','item14');
					$('#tt').tree('select',node.target);

					var s = '<iframe name="mainFrame" scrolling="no" frameborder="0"  src="' + node.attributes['url'] + '" style="width:100%;height:100%;"></iframe>';
					$("#dg").empty().append($(s));
				<%}%>
				
			<%}%>

			<%if(role.equals("L1")||role.equals("L2")){%>					
				$('#tt2').tree({					
						data: [
							/*{
								id : 'item21',
								text: 'hightcharts(sub page)',
								attributes:{  
									url : '${ctx}/main3_highchart.jsp',
				        		}
							},*/
							{
								id : 'item22',
								text: '民族性别',
								attributes:{  
									url:'${ctx}/main3_report_s_nation.jsp'
								}
							},{
								id : 'item23',
								text: '按滞留情况统计',
								attributes:{  
									url:'${ctx}/main3_report_s_detained.jsp'
								}
							},{
								id : 'item24',
								text: '按年级统计学生情况',
								attributes:{  
									url:'${ctx}/main3_report_s_grade.jsp'
								}
							},{
								id : 'item25',
								text: '按生源地统计学生情况',
								attributes:{  
									url:'${ctx}/main3_report_s_origin.jsp'
								}
							},{
								id : 'item26',
								text: '学生情况查询',
								attributes:{  
									url:'${ctx}/main3_report_s_cardinfo.jsp'
								}
							},{
								id : 'item27',
								text: '院系教职工家属儿童情况统计',
								attributes:{  
									url:'${ctx}/main3_report_t_academe.jsp'
								}
							},{
								id : 'item28',
								text: '学校教职工家属儿童情况统计',
								attributes:{  
									url:'${ctx}/main3_report_t_family.jsp'
								}
							},{
								id : 'item29',
								text: '教工年龄区间统计',
								attributes:{  
									url:'${ctx}/main3_report_t_academe_nation_age.jsp'
								}
							},{
								id : 'item30',
								text: '借出/归还信息统计',
								attributes:{  
									url:'${ctx}/main3_report_t_return_lend.jsp'
								}
							}],
					
					onClick: function(node){
						var s = '<iframe name="mainFrame" scrolling="no" frameborder="0"  src="' + node.attributes['url'] + '" style="width:100%;height:100%;"></iframe>';
							 $("#dg").empty().append($(s));
					}
				});
				<%}%>
				
				$('#tt3').tree({					
						data: [
					<%if(role.equals("AD")){%>
						{
							id : 'item31',
							text: '用户管理',
							attributes:{  
			            		url:'${ctx}/main3_user.jsp'
			        		}
						},{
							id : 'item32',
							text: '代码管理',
							attributes:{  
			            		url:'${ctx}/main3_syscode.jsp'
			        		}
						},{
							id : 'item33',							
							text: '角色管理',
							attributes:{  
			            		url:'${ctx}/main3_userrole.jsp'
			        		}
						},{
							id : 'item34',							
							text: '导入数据',
							attributes:{  
			            		url:'${ctx}/main3_import.jsp'
			        		}
						},
					<%}%>	
						{
							id : 'item34',							
							text: '修改密码',
							attributes:{  
			            		url:'${ctx}/main3_changepass.jsp'
			        		}
						}],
					
					onClick: function(node){
						var s = '<iframe name="mainFrame" scrolling="no" frameborder="0"  src="' + node.attributes['url'] + '" style="width:100%;height:100%;"></iframe>';
							 $("#dg").empty().append($(s));
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
	

		<div data-options="region:'north',split:true" style="height:60px;">
			<div style="float:left"><p style="vertical-align:middle">&nbsp;&nbsp;<img height="24px" width="24px" src="${ctx}/static/images/bnu.jpg"/>&nbsp;&nbsp;&nbsp;&nbsp;<b style="text-valign:middle;font-size:28px">户籍管理系统</b> </p></div>
			<div style="float:right">
				<p style="height:24px;width:280px;text-align:center;"><span style="text-valign:middle;font-size:28px">当前用户：<%=su.getName()%>[<%=su.getLoginName()%>]</span>&nbsp;&nbsp;
				<a href="${ctx}/logout"><img alt="退出" size="50" src="${ctx}/static/images/exit.png"/></a>&nbsp;&nbsp;</p></div>
		</div>  
		
    <div id="leftmenu" data-options="region:'west',title:'功能列表',split:true" style="width:150px;">
    	
    		
    		<div id="menugroup" class="easyui-accordion"  data-options="fit:true">  				    
				    <%if(role.equals("L1")){%>
					<div title="信息登记" data-options="iconCls:'icon-reload',selected:true" style="">  
				        <ul id="tt" >  								    
								</ul>  
				    </div>
					<%}%>
					<%if(role.equals("L1")||role.equals("L2")){%>
					<div title="统计查询">  
				        <ul id="tt2" >  								    
								</ul>  
				    </div>
					<%}%>
				    <div title="系统管理">  
				        <ul id="tt3" >  								    
								</ul>  
				    </div>  
				</div>
				
				 
    </div>  
    <div id="rightcontent" data-options="region:'center',title:'功能区'" style="padding:1px;background:#eee;">
    		<div id="dg"  style="height:100%;width:100%">
				</div>				
    </div>  
    
    <div data-options="region:'south',split:true" style="height:50px;">
    	<p style="text-align:center;text-valign:middle"><b></b></p> 
    </div>  


</body>  
</html>