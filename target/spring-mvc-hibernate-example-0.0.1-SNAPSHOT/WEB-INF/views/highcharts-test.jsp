<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <meta content="IE=edge" http-equiv="X-UA-Compatible" />
  <title> Matilda </title>
  <link rel="stylesheet" href="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.css">
  <link rel="stylesheet" href="<c:url value="/resources/css/matilda.css" /> ">
  <script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/heatmap.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>

<script type="text/javascript">
	var dataArray = new Array();
	console.log('Array In beginning:  '+ JSON.stringify(dataArray));

// 		var path = '<c:url value="/usersdata/" />' + userName + '/' + problemName + '/coordinates.csv';
var path = '<c:url value="/usersdata/neelofar/gcp/coordinates.csv" />';
		
		 $.get(path, function(data) {
		     var lines = data.split('\n');
		     $.each(lines, function(lineNo, line) {
		    	 if(line){
		    		 var dataCounter = lineNo -1;
			    	 if(lineNo == 0){
			    		 
			    	 }else{
				         var items = line.split(',');
//	 			         console.log('items elements: ' + items[0] + ' second: ' + items[1] + " third: " +items[2] + " forth: " + items[3] );
				      		 var color;
				      		 if(parseFloat(items[3]) < 0.3){
				      			 color = 'red';
				      		 }else if((items[3]) < 0.6){
				      			 color = 'orange';
				      		 }else{
				      			 color = 'yellow';
				      		 }
							dataArray[dataCounter]={'x': parseFloat(items[1]), 'y': parseFloat(items[2]), 'color': color};
							console.log('data array ' + dataCounter + ' : '+ JSON.stringify(dataArray[dataCounter]));
							console.log('Array upto now:  '+ JSON.stringify(dataArray));
			    	 }
		    	 }
		     });
			 	console.log('final array:  '+ JSON.stringify(dataArray));
				console.log('path for csv file for generating graph: ' + path);
				  $('#container').highcharts({
				        chart: {
				            type: 'scatter',
				            zoomType: 'xy'
				        },
				        colors: [
				            'yellow',
				            'orange',
				            'red'
				        ],
				        colorAxis: {
// 				            min: 0,
// 				            max: 100,
// 				            minColor: 'yellow',
// 				            maxColor: 'red'             
				            dataClassColor: 'category',
				                    dataClasses: [{
				                        to: 0.3
				                    }, {
				                        from: 0.4,
				                        to: 0.6
				                    }, {
				                        from: 0.7,
				                        to: 1
				                    }]
				        },
				        series: [{
				            showInLegend: false,
				            color: 'red',
				            data: dataArray
				            
				        }]
				    });

		 });
		 

		  

function showDemoGraph(userName, problemName){

// 	 var dataRaw = [
// 	        [0, 0, 10],
// 	        [0, 1, 19],
// 	        [0, 2, 8],
// 	        [0, 3, 24],
// 	        [0, 4, 67],
// 	        [1, 0, 92],
// 	        [1, 1, 58],
// 	        [1, 2, 78],
// 	        [1, 3, 117],
// 	        [1, 4, 48],
// 	        [2, 0, 35],
// 	        [2, 1, 15],
// 	        [2, 2, 123],
// 	        [2, 3, 64],
// 	        [2, 4, 52],
// 	        [3, 0, 72],
// 	        [3, 1, 132],
// 	        [3, 2, 114],
// 	        [3, 3, 19],
// 	        [3, 4, 16],
// 	        [4, 0, 38],
// 	        [4, 1, 5],
// 	        [4, 2, 8],
// 	        [4, 3, 117],
// 	        [4, 4, 115],
// 	        [5, 0, 88],
// 	        [5, 1, 32],
// 	        [5, 2, 12],
// 	        [5, 3, 6],
// 	        [5, 4, 120],
// 	        [6, 0, 13],
// 	        [6, 1, 44],
// 	        [6, 2, 88],
// 	        [6, 3, 98],
// 	        [6, 4, 96],
// 	        [7, 0, 31],
// 	        [7, 1, 1],
// 	        [7, 2, 82],
// 	        [7, 3, 32],
// 	        [7, 4, 30],
// 	        [8, 0, 85],
// 	        [8, 1, 97],
// 	        [8, 2, 123],
// 	        [8, 3, 64],
// 	        [8, 4, 84],
// 	        [9, 0, 47],
// 	        [9, 1, 114],
// 	        [9, 2, 31],
// 	        [9, 3, 48],
// 	        [9, 4, 91]
// 	    ],
// 	        dataArray = [];
// 	    for (var i = 0; i < dataRaw.length; i++) {
// 	        var color;
// 	        if (dataRaw[i][2] > 30) {
// 	            if (dataRaw[i][2] > 60) {
// 	                color = 'red';
// 	            } else {
// 	                color = 'orange';
// 	            }
// 	        } else {
// 	            color = 'yellow';
// 	        }
// 	        dataArray[i] = {
// 	            'x': dataRaw[i][0],
// 	            'value': dataRaw[i][2],
// 	                'y': dataRaw[i][1],
// 	                'color': color
// 	        };
// 	    }
}
</script>
  
  <style>
  	#main_container {
  	padding-top:50px;
  	padding-bottom:50px;
  	}
  </style>
</head>
<body>
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	  <%@include file="authheader.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		<div id="container"></div>
		</div>
      </div>
    </div>
</body>
</html>
