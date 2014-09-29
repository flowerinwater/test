<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">

<%
String path1 = "我的首页";
String path2 = "";
%>
<%@ include  file="header.jsp"%>

	


<!-- ---------------------------------------------->
				

				<div class="main-content">
					
					<div id="xx"></div>

					<div class="page-content">
						<div class="page-header">
							<h1>
								<%=path1%>
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<%if(hasAlert){%>
								<div class="alert alert-block alert-success">

									<i class="icon-ok red"></i>

									<strong class="green">
										当前有<%=l.size()%>户口借出已经超出期限(10天)。
									</strong>
								</div>
								<%}%>


								<div class="row">
									<div class="space-6"></div>

									<div class="col-sm-6 infobox-container">
										<div class="infobox infobox-green  ">
											<div class="infobox-icon">
												<i class=""><img src="assets/images/people_vista_011.png"/></i>
											</div>

											<div class="infobox-data">
												<span class="infobox-data-number"><%=cardInfoService.getCountCardInfoByJob("1") + cardInfoService.getCountCardInfoByJob("2") + cardInfoService.getCountCardInfoByJob("3")%></span>
												<div class="infobox-content">学生</div>
											</div>
											<div class="badge badge-success"><%=(double)(cardInfoService.getCountCardInfoByJob("1")+cardInfoService.getCountCardInfoByJob("2")+cardInfoService.getCountCardInfoByJob("3"))/(double)(cardInfoService.getCountAll())*100%>%</div>
										</div>

										<div class="infobox infobox-blue  ">
											<div class="infobox-icon">
												<i class=""><img src="assets/images/people_vista_014.png"/></i>
											</div>

											<div class="infobox-data">
												<span class="infobox-data-number"><%=cardInfoService.getCountCardInfoByJob("4")%></span>
												<div class="infobox-content">教职工</div>
											</div>

											<div class="badge badge-success">
												<%=(double)(cardInfoService.getCountCardInfoByJob("4"))/(double)(cardInfoService.getCountAll())*100%>%
											</div>
										</div>

										<div class="infobox infobox-pink  ">
											<div class="infobox-icon">
												<i class=""><img src="assets/images/people_vista_008.png"/></i>
											</div>

											<div class="infobox-data">
												<span class="infobox-data-number"><%=cardInfoService.getCountCardInfoByJob("5")%></span>
												<div class="infobox-content">家属</div>
											</div>
											<div class="badge badge-success"><%=(double)(cardInfoService.getCountCardInfoByJob("5"))/(double)(cardInfoService.getCountAll())*100%>%</div>
										</div>
										
										<div class="infobox infobox-pink  ">
											<div class="infobox-icon">
												<i class=""><img src="assets/images/people_vista_012.png"/></i>
											</div>

											<div class="infobox-data">
												<span class="infobox-data-number"><%=cardInfoService.getCountCardInfoByJob("6")%></span>
												<div class="infobox-content">其他</div>
											</div>
											<div class="badge badge-success"><%=(double)cardInfoService.getCountCardInfoByJob("6")/(double)(cardInfoService.getCountAll())*100%>%</div>
										</div>

										<div class="infobox infobox-red  ">
											<div class="infobox-icon">
												<i class="icon-beaker"></i>
											</div>

											<div class="infobox-data">
												<span class="infobox-data-number"><%=cardInfoService.getCountCardInfoByStatus(com.bnu.card.util.DefaultValue.DETAINED)%></span>
												<div class="infobox-content">滞留</div>
											</div>
											<div class="badge badge-success"><%=(double)(cardInfoService.getCountCardInfoByStatus(com.bnu.card.util.DefaultValue.DETAINED))/(double)(cardInfoService.getCountAll())*100%>%</div>
										</div>

										<div class="infobox infobox-orange2  ">
											<div class="infobox-icon">
												<i class="icon-beaker"></i>
											</div>
											<div class="infobox-data">
												<span class="infobox-data-number"><%=cardInfoService.getCountCardInfoByStatus(com.bnu.card.util.DefaultValue.LEND)%></span>
												<div class="infobox-content">借出</div>
											</div>

											<div class="badge badge-success"><%=(double)(cardInfoService.getCountCardInfoByStatus(com.bnu.card.util.DefaultValue.LEND))/(double)(cardInfoService.getCountAll())*100%>%</div>
										</div>

									</div>

									<div class="vspace-sm"></div>

									<div class="col-sm-6">
										<div class="widget-box">
											<div class="widget-header widget-header-flat widget-header-small">
												<h5>
													<i class="icon-signal"></i>
													学生分布
												</h5>

												<div class="widget-toolbar no-border">
													
												</div>
											</div>

											<div class="widget-body">
												<div class="widget-main">
													<div id="piechart-placeholder"></div>
													
													<div class="hr hr8 hr-double"></div>

													<div class="clearfix">
														<div class="grid3">
															<span class="grey">
																<i class="icon-2x blue"><img src="assets/images/master.png"/></i>
																&nbsp; 本科生
															</span>
															<h4 class="bigger pull-right"><%=cardInfoService.getCountCardInfoByJob("1")%></h4>
														</div>

														<div class="grid3">
															<span class="grey">
																<i class="icon-2x purple"><img src="assets/images/bachelor.png"></i>
																&nbsp; 研究生
															</span>
															<h4 class="bigger pull-right"><%=cardInfoService.getCountCardInfoByJob("2")%></h4>
														</div>

														<div class="grid3">
															<span class="grey">
																<i class="icon-2x red"><img src="assets/images/doctor.png"></i>
																&nbsp; 博士生
															</span>
															<h4 class="bigger pull-right"><%=cardInfoService.getCountCardInfoByJob("3")%></h4>
														</div>
													</div>
													
												</div><!-- /widget-main -->
											</div><!-- /widget-body -->
										</div><!-- /widget-box -->
									</div><!-- /span -->
								</div><!-- /row -->

								<div class="hr hr32 hr-dotted"></div>

								<div class="row">
									<div class="col-sm-6">
										<div class="widget-box">
											<div class="widget-header widget-header-flat widget-header-small">
												<h5>
													<i class="icon-signal"></i>
													历年借出折线图
												</h5>

												<div class="widget-toolbar no-border">													
												</div>
											</div>


											<div class="widget-body">
												<div class="widget-main">
													<div id="linechart-placeholder1"></div>

													
													
												</div><!-- /widget-main -->
											</div><!-- /widget-body -->
										</div><!-- /widget-box -->
									</div>

									<div class="col-sm-6">
										<div class="widget-box">
											<div class="widget-header widget-header-flat widget-header-small">
												<h5>
													<i class="icon-signal"></i>
													历年滞留情况
												</h5>

												<div class="widget-toolbar no-border">
													
												</div>
											</div>

											<div class="widget-body">
												<div class="widget-main">
													<div id="linechart-placeholder2"></div>

													
												</div><!-- /widget-main -->
											</div><!-- /widget-body -->
										</div><!-- /widget-box -->
									</div>
								</div>

								<div class="hr hr32 hr-dotted"></div>



								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
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

		<!--[if lte IE 8]>
		  <script src="${ctx}/assets/js/excanvas.min.js"></script>
		<![endif]-->

		<script src="${ctx}/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="${ctx}/assets/js/jquery.ui.touch-punch.min.js"></script>
		<script src="${ctx}/assets/js/jquery.slimscroll.min.js"></script>
		<script src="${ctx}/assets/js/jquery.easy-pie-chart.min.js"></script>
		<script src="${ctx}/assets/js/jquery.sparkline.min.js"></script>
		<script src="${ctx}/assets/js/flot/jquery.flot.min.js"></script>
		<script src="${ctx}/assets/js/flot/jquery.flot.pie.min.js"></script>
		<script src="${ctx}/assets/js/flot/jquery.flot.resize.min.js"></script>

		<!-- ace scripts -->

		<script src="${ctx}/assets/js/ace-elements.min.js"></script>
		<script src="${ctx}/assets/js/ace.min.js"></script>

		<!-- inline scripts related to this page -->

		<script type="text/javascript">
			jQuery(function($) {
				$('.easy-pie-chart.percentage').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
					var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
					var size = parseInt($(this).data('size')) || 50;
					$(this).easyPieChart({
						barColor: barColor,
						trackColor: trackColor,
						scaleColor: false,
						lineCap: 'butt',
						lineWidth: parseInt(size/10),
						animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
						size: size
					});
				})
			
				$('.sparkline').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
					$(this).sparkline('html', {tagValuesAttribute:'data-values', type: 'bar', barColor: barColor , chartRangeMin:$(this).data('min') || 0} );
				});
			
			
			
			
			  var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'150px'});
			  var data = [
				{ label: "本科生",  data: <%=cardInfoService.getCountCardInfoByJob("1")%>, color: "#68BC31"},
				{ label: "研究生",  data: <%=cardInfoService.getCountCardInfoByJob("2")%>, color: "#2091CF"},
				{ label: "博士生",  data: <%=cardInfoService.getCountCardInfoByJob("3")%>, color: "#AF4E96"},
			  ]
			  function drawPieChart(placeholder, data, position) {
			 	  $.plot(placeholder, data, {
					series: {
						pie: {
							show: true,
							tilt:0.8,
							highlight: {
								opacity: 0.25
							},
							stroke: {
								color: '#fff',
								width: 2
							},
							startAngle: 2
						}
					},
					legend: {
						show: true,
						position: position || "ne", 
						labelBoxBorderColor: null,
						margin:[-30,15]
					}
					,
					grid: {
						hoverable: true,
						clickable: true
					}
				 })
			 }
			 drawPieChart(placeholder, data);
			
			 /**
			 we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
			 so that's not needed actually.
			 */
			 placeholder.data('chart', data);
			 placeholder.data('draw', drawPieChart);
			
			
			
			  var $tooltip = $("<div class='tooltip top in'><div class='tooltip-inner'></div></div>").hide().appendTo('body');
			  var previousPoint = null;
			
			  placeholder.on('plothover', function (event, pos, item) {
				if(item) {
					if (previousPoint != item.seriesIndex) {
						previousPoint = item.seriesIndex;
						var tip = item.series['label'] + " : " + item.series['percent']+'%';
						$tooltip.show().children(0).text(tip);
					}
					$tooltip.css({top:pos.pageY + 10, left:pos.pageX + 10});
				} else {
					$tooltip.hide();
					previousPoint = null;
				}
				
			 });
			
			
			 ///////////////////////////////////////////////
			 //-------------------------------------------

				var d11 = [];
				var ticks1 = [];
				<%
				System.out.println(11);
				int max = 5;
				List<Object[]> r = cardInfoService.findByLendExpireGradeGroup(10);
				for(int i=0;i<r.size();i++){
					out.println("d11.push([" + r.get(i)[0] + "," + r.get(i)[1] + "]);");
					out.println("ticks1.push(" + r.get(i)[0] + ");");
					
					java.math.BigInteger x = (java.math.BigInteger)(r.get(i)[1]);
					int v = x.intValue();
					if(v > max)
						max = v;
				}
				%>
				var linechart = $('#linechart-placeholder1').css({'width':'100%' , 'height':'220px'});
				$.plot("#linechart-placeholder1", [
					{ label: "借出未归还", data: d11 },
				], {
					//hoverable: true,
					multiplebars:true,
					shadowSize: 0,
					series: {
						lines: { show: true },
						points: { show: true },
						/*bars: { show: true ,
							 	align: "center",
								horizontal: false,
								lineWidth: 1,
								fill: true,
								barWidth: 0.1,
								zero:false,
								fillColor: { colors: [ { opacity: 0.8 }, { opacity: 0.1 } ] }
						}*/
					},
					xaxis: {
						ticks:ticks1,
						tickLength: 5,
						tickDecimals: 0,
					},
					yaxis: {
						min: 0,
						max: <%=max%>,
						tickDecimals: 0,
						tickSize:5,

					},
					grid: {
						backgroundColor: { colors: [ "#fff", "#fff" ] },
						borderWidth: 1,
						borderColor:'#555'
					}
				});
			 ///////////////////////////////////////////////
			
		//	12121212
			
			///////////////////////////////////////////////
			 //-------------------------------------------
				var d11 = [];
				var ticks1 = [];
				<%
				max = 5;
				r = cardInfoService.findByDetainedGradeGroup1("%");
				System.out.println("----------------" + r.size());
				
				for(int i=0;i<r.size();i++){
					out.println("d11.push([" + r.get(i)[0] + "," + r.get(i)[1] + "]);");
					out.println("ticks1.push(" + r.get(i)[0] + ");");
					
					java.math.BigInteger x = (java.math.BigInteger)(r.get(i)[1]);
					int v = x.intValue();
					if(v > max)
						max = v;
				}
				%>
				var linechart2 = $('#linechart-placeholder2').css({'width':'100%' , 'height':'220px'});
				$.plot("#linechart-placeholder2", [
					{ label: "滞留学生", data: d11 },
				], {
					
					multiplebars:true,
					shadowSize: 0,
					series: {
						lines: { show: true },
						points: { show: true },
						/*bars: { show: true ,
							 	align: "center",
								horizontal: false,
								lineWidth: 1,
								fill: true,
								barWidth: 0.1,
								zero:false,
								fillColor: { colors: [ { opacity: 0.8 }, { opacity: 0.1 } ] }
						}*/
					},
					xaxis: {
						ticks:ticks1,
						tickLength: 5,
						tickDecimals: 0,
					},
					yaxis: {
						min: 0,
						max: <%=max%>,
						tickDecimals: 0,
						tickSize:5,

					},
					grid: {
						backgroundColor: { colors: [ "#fff", "#fff" ] },
						borderWidth: 1,
						borderColor:'#555',
						hoverable: true,
					}
				});
			 ///////////////////////////////////////////////
			  function showTooltip(x, y, contents) {//浮动块信息  
		        $('<div id="tooltip">' + contents + '</div>').css( {  
		            position: 'absolute',  
		            display: 'none',  
		            top: y + 5,  
		            left: x + 5,  
		            border: '1px solid #fdd',  
		            padding: '2px',  
		            'background-color': '#fee',  
		            opacity: 0.80  
		        }).appendTo("body").fadeIn(200);  
		    }  
			  
			  
			  $("#linechart-placeholder2").bind("plothover", function (event, pos, item) {
			  	 if(item)
			  	 	showTooltip(item.pageX, item.pageY,item.datapoint[1]);  
			  });  
				
				
				
				
					
				$('#recent-box [data-rel="tooltip"]').tooltip({placement: tooltip_placement});
				function tooltip_placement(context, source) {
					var $source = $(source);
					var $parent = $source.closest('.tab-content')
					var off1 = $parent.offset();
					var w1 = $parent.width();
			
					var off2 = $source.offset();
					var w2 = $source.width();
			
					if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
					return 'left';
				}
			
			
				$('.dialogs,.comments').slimScroll({
					height: '300px'
			    });
				
				
				//Android's default browser somehow is confused when tapping on label which will lead to dragging the task
				//so disable dragging when clicking on label
				var agent = navigator.userAgent.toLowerCase();
				if("ontouchstart" in document && /applewebkit/.test(agent) && /android/.test(agent))
				  $('#tasks').on('touchstart', function(e){
					var li = $(e.target).closest('#tasks li');
					if(li.length == 0)return;
					var label = li.find('label.inline').get(0);
					if(label == e.target || $.contains(label, e.target)) e.stopImmediatePropagation() ;
				});
			
				$('#tasks').sortable({
					opacity:0.8,
					revert:true,
					forceHelperSize:true,
					placeholder: 'draggable-placeholder',
					forcePlaceholderSize:true,
					tolerance:'pointer',
					stop: function( event, ui ) {//just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved
						$(ui.item).css('z-index', 'auto');
					}
					}
				);
				$('#tasks').disableSelection();
				$('#tasks input:checkbox').removeAttr('checked').on('click', function(){
					if(this.checked) $(this).closest('li').addClass('selected');
					else $(this).closest('li').removeClass('selected');
				});
				
			
			})
		</script>
</body>
</html>

