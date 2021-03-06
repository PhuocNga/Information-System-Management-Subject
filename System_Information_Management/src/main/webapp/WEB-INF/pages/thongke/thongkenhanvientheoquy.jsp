<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lợi nhuận theo quý</title>
	    <!-- Bootstrap -->
    <link href="<c:url value="/resources/vendors/bootstrap/dist/css/bootstrap.min.css"/>" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="<c:url value="/resources/vendors/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet">
    <!-- NProgress -->
    <link href="<c:url value="/resources/vendors/nprogress/nprogress.css"/>" rel="stylesheet">
    <!-- iCheck -->
    <link href="<c:url value="/resources/vendors/iCheck/skins/flat/green.css"/>" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="<c:url value="/resources/build/css/custom.min.css"/>" rel="stylesheet">

    <!-- Datatables -->
    <link href="<c:url value="/resources/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"/>" rel="stylesheet">

	<script type="text/javascript">
		window.onload = function(){
			document.getElementById('sel1').onchange = function(){
				document.getElementById('formnam').submit();
			}
		}
	</script>
    <style>
        #columchart,
        #piechart {
            width: 100%;
            height: 500px;
        }
    </style>
    <script src="<c:url value="/resources/build/js/abc.js"/>"></script>
    <script src="https://www.amcharts.com/lib/3/serial.js"></script>
    <script src="<c:url value="/resources/build/js/export.min.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/resources/build/css/amchart.css"/>" type="text/css" media="all" />
    <script src="<c:url value="/resources/build/js/light.js"/>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/amcharts/3.21.12/plugins/export/libs/fabric.js/fabric.min.js"></script>
    <script type="text/javascript" src="http://amcharts.com/lib/3/plugins/export/libs/FileSaver.js/FileSaver.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/amcharts/3.21.12/plugins/export/libs/pdfmake/pdfmake.js"></script>
    <!--Pie chart-->
    <script src="https://www.amcharts.com/lib/3/pie.js"></script>
</head>
<body class="nav-md">
<%List<Object[]>listObject=(List<Object[]>)session.getAttribute("columchart_quarter");
DecimalFormat df = new DecimalFormat("###,###"+" đ");
%>
    <div class="container body">
        <div class="main_container">
            <c:import url="../menu.jsp"/>

	
            <!-- page content -->
            <div class="right_col" role="main">
                <div class="">

                    <div class="x-panel">
                        <div class="x_title">
                            <h2>Thống kê doanh số bán hàng của nhân viên theo quý</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="#">Settings 1</a>
                                        </li>
                                        <li><a href="#">Settings 2</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a class="close-link"><i class="fa fa-close"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <c:set var="listYear" value="${sessionScope.year}"/>
                        <c:set var="listQuarter" value="${sessionScope.quarter}"/>
                         <form action="<c:url value="/thongke/thongkenhanvientheoquy"/>">
                        <div class="x_content">
                            <div class="btn-group">
                                <p><strong>Chọn năm</strong></p>
                                
                                <select class="form-control" id="sel1" name="year">
                                <c:forEach  items="${listYear}" var="year">
                              <option value="${year}" ><c:out value="${year}"/></option>
                                </c:forEach>
                              </select>
                         
                            </div>
                            <div class="btn-group">
                                <p><strong>Chọn quý</strong></p>
                                <select class="form-control" id="sel1" name="quarter">
                                <c:forEach items="${listQuarter}" var="quarter" >
                                <option value="${quarter}"><c:out value="${quarter}"/></option>
                                </c:forEach>
                              </select>
                            </div>

                            <div class="btn-group">
                                <p><strong>Thao tác</strong></p>
                                <button class="btn btn-primary">Thống kê</button>
                            </div>
                        </div>
						</form>

                        <div class="row">

                            <!-- bar chart -->
                            <div id="bieudocot">
                            <div class="col-md-12 col-sm-12 col-xs-12">

                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Doanh số bán hàng của nhân viên trong quý: <c:out value="${sessionScope.quarterRequest }"/> >> năm <c:out value="${sessionScope.yearRequest }"/></h2>
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                            </li>
                                            <li class="dropdown">
                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li><a href="#">Settings 1</a>
                                                    </li>
                                                    <li><a href="#">Settings 2</a>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                                            </li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <div id="columchart"></div>
                                    </div>
                                </div>
                            </div>
							</div>

                        </div>


                        <div class="clearfix"></div>
                        <div class="row">

                            <!-- bar chart -->
                            <div class="col-md-12 col-sm-12 col-xs-12">

                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Số lượng sản phẩm bán được của nhân viên trong quý: <c:out value="${sessionScope.quarterRequest }"/> >> năm <c:out value="${sessionScope.yearRequest }"/></h2>
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                            </li>
                                            <li class="dropdown">
                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li><a href="#">Settings 1</a>
                                                    </li>
                                                    <li><a href="#">Settings 2</a>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                                            </li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <div id="piechart"></div>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="clearfix"></div>
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Biểu đồ dạng table mô tả doanh thu nhân viên đem lại trong quý: <c:out value="${sessionScope.quarterRequest }"/> >> năm <c:out value="${sessionScope.yearRequest }"/></h2>
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                            </li>
                                            <li class="dropdown">
                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li><a href="#">Settings 1</a>
                                                    </li>
                                                    <li><a href="#">Settings 2</a>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                                            </li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <table id="datatable-buttons" class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Tên nhân viên</th>
                                                    <th>Tổng sốlượng bán được</th>
                                                    <th>Tổng lợi nhuận</th>
                                                </tr>
                                            </thead>


                                            <tbody>
                                            
                                            	<%for(int i=0;i<listObject.size();i++){ 
                                            	
                                            	%>
                                                <tr>
                                                    <td><%out.print(String.valueOf(listObject.get(i)[0]));%></td>
                                                    <td><%=(int)Double.parseDouble(listObject.get(i)[1]+"")%></td>
                                                    <td><%out.print(df.format(Double.parseDouble(listObject.get(i)[2]+"")));%></td>
													
                                                </tr>
                                                <%} %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /page content -->
					
					
        </div>
    </div>

    <!-- jQuery -->
    <script src="<c:url value="/resources/vendors/jquery/dist/jquery.min.js"/>"></script>
    <!-- Bootstrap -->
    <script src="<c:url value="/resources/vendors/bootstrap/dist/js/bootstrap.min.js"/>"></script>
    <!-- FastClick -->
    <script src="<c:url value="/resources/vendors/fastclick/lib/fastclick.js"/>"></script>
    <!-- NProgress -->
    <script src="<c:url value="/resources/vendors/nprogress/nprogress.js"/>"></script>
    <!-- morris.js -->
    <script src="<c:url value="/resources/vendors/raphael/raphael.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/morris.js/morris.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/Chart.js/dist/Chart.min.js"/>"></script>
    <!-- Custom Theme Scripts -->
    <script src="<c:url value="/resources/build/js/custom.min.js"/>"></script>
    <!--table jquery-->
    <script src="<c:url value="/resources/vendors/jquery_table/jquery.dynatable.js"/>"></script>
    <!---->
    <!-- Datatables -->
    <script src="<c:url value="/resources/vendors/datatables.net/js/jquery.dataTables.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-buttons/js/buttons.flash.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-buttons/js/buttons.html5.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-buttons/js/buttons.print.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"/>"></script>
    <script src="<c:url value="/resources/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/jszip/dist/jszip.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/pdfmake/build/pdfmake.min.js"/>"></script>
    <script src="<c:url value="/resources/vendors/pdfmake/build/vfs_fonts.js"/>"></script>
	
	
	
	
    <!--chart-->
    <script>
    var chart = AmCharts.makeChart("columchart", {
        "theme": "light",
        "type": "serial",
        "startDuration": 2,
        "dataProvider": [
        <%for(int i=0;i<listObject.size();i++){%>
         {
            "country": "<%=String.valueOf(listObject.get(i)[0]).trim()%>",
            "visits": <%=Double.parseDouble(listObject.get(i)[2]+"")%>,
            "color": "#FF0F00"
               }, <%}%>],
        "valueAxes": [{
            "position": "left",
            "title": "Tổng lợi nhuận"
               }],
        "graphs": [{
            "balloonText": "[[category]]: <b>[[value]]</b>",
            "fillColorsField": "color",
            "fillAlphas": 1,
            "lineAlpha": 0.1,
            "type": "column",
            "valueField": "visits"
               }],
        "depth3D": 20,
        "angle": 30,
        "chartCursor": {
            "categoryBalloonEnabled": false,
            "cursorAlpha": 0,
            "zoomable": false
        },
        "categoryField": "country",
        "categoryAxis": {
            "gridPosition": "start",
            "labelRotation": 90
        },
        "export": {
            "enabled": true
        }

    });
    var chart = AmCharts.makeChart("piechart", {
        "type": "pie",
        "theme": "light",
        "dataProvider": [
        <%for(int i=0;i<listObject.size();i++){%>
        {
            "country": "<%=String.valueOf(listObject.get(i)[0])%>",
            "value": <%=(int)Double.parseDouble(listObject.get(i)[1]+"")%>
     },<%}%>

     ],
        "valueField": "value",
        "titleField": "country",
        "outlineAlpha": 0.4,
        "depth3D": 15,
        "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
        "angle": 30,
        "export": {
            "enabled": true
        }
    });
    </script>

</body>
</html>