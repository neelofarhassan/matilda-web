<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html>
<html>
	<head>	    
	    <title>Matilda</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://d2h9b02ioca40d.cloudfront.net/v7.0/uom.css"  />
		<link rel="icon" href="https://cms.unimelb.edu.au/__data/assets/image/0006/1456044/favicon.gif" type="image/gif" sizes="16x16">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="csrf-param" content="authenticity_token" />
		<meta name="csrf-token" content="i3gewcvuhVJ1CKiuk1QH0uLG+KANW2YyZ7wXx+sovNIATo3BCKWcOToBRYWMxQ/cir/jzDBB3MAgLOsan3s/aA==" />
		<style>.lazy {display:inline;max-width:123px !important;height:auto !important;width:auto !important;}</style>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>
<script language = "JavaScript">
 $.get('${pageContext.request.contextPath}/resources/graphcsvs/example.csv', function(data) {

	// Split the lines
	var lines = data.split('\n');
	var items = new Array();
	var colors = new Array();
	$.each(lines, function(lineNo, line) {
// 		alert(lineNo+':  '+line);
		var dataline = line.split(',');
		items[lineNo]= new Array(parseFloat(dataline[0]), parseFloat(dataline[1]), 14);
		colors[lineNo]=parseFloat(dataline[2]);			
	});

 var chart = {
 type: 'bubble',
 zoomType: 'xy'
};
var title = {
 text: 'Possible Item Fix Proportion'   
};   
var series = [{ 
// 	name: 'Female',
     color: 'rgba(223, 83, 83, .15)',
// color: colors,
	data: items
}];
// series.push("data": items);
var xAxis= {
        title: {
            text: 'Z1'
        }
    }

var yAxis= {
        title: {
            text: 'Z2'
        }
    }

var plotOptions = {
    bubble: {
        minSize: 3,
        maxSize: 6
    }
}

var json = {};   
json.chart = chart; 
json.title = title;     
json.series = series;  
json.plotOptions = plotOptions;
json.xAxis = xAxis;
json.yAxis = yAxis;
$('#highchartcontainer').highcharts(json);
});
</script>

<script src="https://d2h9b02ioca40d.cloudfront.net/v7.0/uom.js"></script>
 <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-119301545-2', 'auto');
    ga('send', 'pageview');
</script>
</head>


<body>
	<div class="uomcontent">
			<c:url var="home" value="/" />
			<noscript><h1>WARNING: It appears that your browser does not have javascript enabled.  Please enable javascript for this site to work correctly</h1></noscript>
			
		    <div class="page-inner">
				<ol class="page-local-history" itemscope="" itemtype="http://schema.org/BreadcrumbList"><li class="root" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem">
				    <a href="${home}" title="Home" itemprop="item"><span itemprop="name"> Matilda  </span></a>
				    <meta content="1" itemprop="position" />
				  </li></ol>
			</div>
	
			<div class='main' id='main-content' role='main'>
				<header class='image' style='background-image: url(${home}/resources/images/banner.png);min-height:100px!important;height:300px!important;'>
				  <div class='center-align blurred'>
				    <h1 style="text-shadow:rgba(0,0,0,0.6) 0px 0px 10px;max-width:100%;width:100%;text-align:center;">MATILDA - Melbourne Algorithm Test Instance </br>Library & Data Archive</h1>
				  </div>
				</header>
			
				<div class="lead">
					<p>
					Access our  collection of high-resolution images of herbarium specimens.
					</p>
				</div>
			
				<div class="container">
			        <h3 id="form_header" class="text-warning" align="center">Login Application</h3>
			        <div> </div>
			
			        <!-- User input form to validate a user -->
			        <c:url var="validateUrl" value="/user/validate" />
			        <form id="user_form" action="${validateUrl}" method="POST">
			            <div class="form-group">
			                <label for="name">Username:</label>
			                <input type="text" class="form-control" id="name" placeholder="Enter username" name="username">
			            </div>
			            <div class="form-group">
			                <label for="pwd">Password:</label>
			                <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password">
			            </div>
			            <button id="confirm_user" type="submit" class="btn btn-primary">Confirm Indentity</button>
			        </form>
			        <div id="highchartcontainer" style="width: 600px; height: 400px; margin: 0 auto"></div> 
				</div>
		   </div>
	   <%@include file="/footer.jsp" %>
	   <%@include file="/menu.jsp" %>
	   
	</div>
</body>
</html>